require "easy_data/version"
require "data_models/data_models"
require "action_controller"
require "controllers/easy_datas_controller"
require "data_models/model_rdf"
require "data_models/linked_data_graph"
require "data_models/RDFa"
require 'fileutils'
require 'ruby-debug'


module EasyData
  
  module RDF
     
     autoload :Namespaces, 'data_models/namespaces'
     
     NAMESPACES = Dir.glob(File.join(File.dirname(__FILE__),'data_models','namespaces','*.rb')).map{ |f| File.basename(f).gsub('.rb','').to_sym } rescue []
     NAMESPACES.each { |v| autoload v.to_s.upcase.to_sym, "data_models/namespaces/#{v}" unless v == :namespaces }

  end

  def self.yaml_description_model(model_data)

    attributes = {}
    associations = {}

    model_data.columns.each do |att|
  
     if att.primary
       attributes[att.name] = {:privacy => 'Private',:namespace => 'not defined',:property => 'not defined'}
     elsif att.name =~ /_id$/
       attributes[att.name] = "no publication"
     else
       attributes[att.name] = {:privacy => 'Public',:namespace => 'not defined',:property => 'not defined'}
     end

    end  
       
    model_data.reflections.keys.each do |ref|
      associations[ref.to_s] = {:privacy => 'Public',:namespace => 'not defined',:property => 'not defined'}
    end

    {:privacy => "Private",:namespace => "not defined",:property => "not defined","attributes" => attributes,"associations" => associations}
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

  #######################################################################
  # Building Linked Data Graph
  #######################################################################
  def self.build_linked_data_graph
    LinkedDataGraph.build(DataModels.load_models) 
  end
  

  def self.refresh_information
     rdf = ModelRdf.new
     models = DataModels.load_models

     unless self.info_update?(models,rdf)
       rdf_models = rdf.get_models.keys

       #Add the new models to rdf's information file
       models.each do |model|
        unless rdf_models.keys.include? model
         model_data = DataModels.get_model_data(model)
         if model_data.respond_to?:columns 
           rdf.add_model(model,EasyData.yaml_description_model(eval model))
         end
        end
       end

       #Delete the models how they had deleted
       rdf_models.each do |model|
        unless models.include?model
          rdf.delete_model model
        end
       end

       rdf.save       
     end
  end 

  private
 
  def generate_query(model,params)
     query = "Select #{params.key.join(", ")}
              FROM #{model};"
  end

  def self.info_update?(models,rdf)
     ((models | rdf.get_models.keys)-(models & rdf.get_models.keys)).empty?
  end
end

