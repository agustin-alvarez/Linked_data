require "easy_data/version"
require "data_models/data_models"
require "action_controller"
require "controllers/easy_datas_controller"
require "data_models/model_rdf"
require "routes"
require 'ftools'
require 'ruby-debug'


module EasyData
  
  module RDF
     
     autoload :Namespaces, 'data_models/namespaces'
     
     NAMESPACES = Dir.glob(File.join(File.dirname(__FILE__),'data_models','namespaces','*.rb')).map{ |f| File.basename(f).gsub('.rb','').to_sym } rescue []
     NAMESPACES.each { |v| autoload v.to_s.upcase.to_sym, "data_models/namespaces/#{v}" unless v == :namespaces }

  end

  def show_linked_data
    models = LinkedData.find :all
  end
  
  # Changes model's attributes with ajax call
  def update_linked_data_model
     
     model = LinkedData.find_by_model params[:model]  
     
     attributes = model["attributes"].to_hash
     attributes[params[:attribute]] = !attributes[params[:attribute]]

     model["query"] = generate_query(params[:model],attributes)
     model["attributes"] = attributes.to_set

     if model.valid?
       model.save
     else 
       false
     end
  end
 
  def self.yaml_description_model(model_data)

    attributes = {}
    associations = {}

    model_data.columns.each do |att|
  
     if att.primary
       attributes[att.name] = {:privacy => 'private',:namespace => 'not defined',:property => 'not defined'}
     elsif att.name =~ /_id$/
       attributes[att.name] = "no publication"
     else
       attributes[att.name] = {:privacy => 'public',:namespace => 'not defined',:property => 'not defined'}
     end

    end  
       
    model_data.reflections.keys.each do |ref|
      associations[ref.to_s] = {:privacy => 'public',:namespace => 'not defined',:property => 'not defined'}
    end

    {"attributes" => attributes,"associations" => associations}
  end

  def self.get_view_path
    File.join(File.dirname(__FILE__), 'easy_data/templates')
  end
  
  def self.get_style_path
    File.join(File.dirname(__FILE__), 'easy_data/templates/stylesheets/easy_data_style.css')
  end

  def self.get_uri_namespace(namespace)
     eval "RDF::#{namespace.upcase}.get_uri"
  end
 
  private
 
  def generate_query(model,params)
     query = "Select #{params.key.join(", ")}
              FROM #{model};"
  end

    
end

