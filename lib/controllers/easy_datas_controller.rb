require "action_controller"
require "action_view"
require "builder"

class EasyDatasController < ActionController::Base
  
  layout 'easy_data_layout'
  
  before_filter :authenticated, :only => [:custom_rdf]

  def show
    
      if params[:id].nil? && params[:model] == params[:model].pluralize   #Because, the model's name is the sames in pluralize format, example: News
         redirect_to :action => "show_all",:locals => {:model => params[:model]}
      end 
      begin
        model = eval params[:model].to_s
      
        conditions = parser_params(params)
     
        rdf = ModelRdf.new      

        @model_info = rdf.get_attributes_model params[:model]
       
        no_valid = lambda{|c| c.nil?||c.empty?}
       
        @reply = model.find :all, :conditions => {:id => params[:id]}
            
        unless @reply.nil?
          @host="http://"+request.env["HTTP_HOST"]+request.env["SCRIPT_NAME"]
          
          @rdf_model = rdf.get_model_rdf(@reply,params[:model],@host)
        end
       
        @xml = Builder::XmlMarkup.new
      
        if no_valid.call(@rdf_model[:header]) || @reply.nil?  # If the URI not available or data no publicated
           render :nothing => true, :status => 400
        else  
           respond_to do |format|
             format.html
             format.xml                     # render :template => "/rdf/request.xml.builder"   
           end
        end
      rescue
          render :nothing => true, :status => 404
      end
  end

  def show_all
      begin
        model = eval params[:model].to_s
      
        rdf = ModelRdf.new      
      
        @model_info = rdf.get_attributes_model params[:model]

        no_valid = lambda{|c| c.nil?||c.empty?}

        @reply = model.find :all || nil
     
        @host="http://"+request.env["SERVER_NAME"]          
      
        @rdf_model = rdf.get_model_rdf(@reply,params[:model],"http://"+request.env["SERVER_NAME"])
      
        @xml = Builder::XmlMarkup.new
      
        if no_valid.call(@rdf_model[:header]) || @reply.nil?  # If the URI not available or data no publicated
          render :nothing => true, :status => 404
        else
          respond_to do |format|
            format.html
            format.xml # render :template => "/rdf/request.xml.builder"   
          end
        end
      rescue
         render :nothing => true, :status => 404
      end
  end

  # Show information about data publications
  # 
  #
  def info_easy_data
      rdf = ModelRdf.new
      models = rdf.get_not_hidden_models
      @list = []
      @settings ||= YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
      
      models.each do |mod|
       @list << "#{mod.gsub("::","_")}"
      end
    
      respond_to do |format|
        format.html
        format.xml
      end
  end

  # Information about access to publicated data
  def access_to_data 
  end

  # Generate Linked Data Graph
  def linked_data
  end
  
  # FAQ 
  def faq
  end

  # Access to list of model of Data Model
  def models 
    @xml = Builder::XmlMarkup.new
    rdf = ModelRdf.new
    @list = rdf.get_not_hidden_models
    @host="http://"+request.env["SERVER_NAME"]     
    
    respond_to do |format|
      format.html
      format.xml                     # render :template => "/rdf/request.xml.builder"   
    end
 
  end

  def custom_rdf
    @models = DataModels.load_models
    @settings ||= YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
  end

  def model_attributes
    
    rdf = ModelRdf.new
    @model_attributes = rdf.get_attributes_model(params[:model])
    @model = params[:model]

    render :partial => "model_attributes",:layout => nil
  end

  def model_attributes_edit

     rdf = ModelRdf.new

     @model_attributes = rdf.get_attributes_model(params[:model])
     @model = params[:model]
     @namespaces = EasyData::RDF::Namespaces.list_form
     
     render :partial => "model_attributes_edit",:layout => nil
  
  end

  def model_attributes_info
    rdf = ModelRdf.new
    
    @model_attributes = rdf.get_attributes_model(params[:model])
    @model = params[:model]

    render :partial => "model_attributes_info",:layout => nil
  end

  def load_properties
  
     unless params[:id] == ""
       namespace = "EasyData::RDF::#{params[:id].upcase}"

       rdf = ModelRdf.new    
 
       @namespace = params[:id]
       @model_attributes = rdf.get_attributes_model(params[:model])
       
       properties = (eval namespace).properties_form
   
       render :inline => "<span>Property:</span><%= select type+'_property',attribute,properties,{:prompt => 'Select a property...'} -%><span class='rdf_info'>(Current value: <%= current_value%>)</span>",
              :locals => {:properties => properties,
                          :type => params[:type],
                          :attribute => params[:attribute],
                          :current_value => @model_attributes[params[:type]][params[:attribute]][:property]}
     else
       render :inline => ""
     end
  end
 
  def load_classes
  
     unless params[:id] == ""
       namespace = "EasyData::RDF::#{params[:id].upcase}"

       rdf = ModelRdf.new    
 
       @namespace = params[:id]
       @model_attributes = rdf.get_attributes_model(params[:model])
       
       classes = (eval namespace).classes_form
       
       render :inline => "<span>Class:</span><%= select 'property',attribute,properties,{:prompt => 'Select a class...'} -%><span class='rdf_info'>(Current value: <%= current_value%>)</span><br />",
              :locals => {:properties => classes,
                          :attribute => params[:model],
                          :current_value => @model_attributes[:property]}
     else
       render :inline => ""
     end
  end

  def load_linked_data_graph
     if params[:model]
      @model = params[:model]
      @associations = ModelRdf.new.get_associations_model(@model) 
      @host = "http://"+request.env["HTTP_HOST"]
      render :partial => "linked_data_model"
     else
      rdf = ModelRdf.new
      models = []
      DataModels.load_models.each do |mod|
        unless rdf.hidden?(mod) 
          models << mod
        end
      end
      @list = []
      models.each do |mod|
       @list << "#{mod.gsub("::","_")}"
      end

      render :partial => "linked_datas",:layout => nil
     end
  end

  def custom_attributes

     rdf = ModelRdf.new
     @model = params[:model]

     params["rdf_type_attributes"].each do |att,value|
        rdf.update_attributes_model(params[:model],att,'namespace',value) if value != ""
        if params["attributes_property"] && !params["attributes_property"][att].nil?
         rdf.update_attributes_model(params[:model],att,'property',params["attributes_property"][att])  
        end
        rdf.update_attributes_model(params[:model],att,'privacy',params[:privacy][att])
     end
     
     
     params["rdf_type_associations"].each do |assoc,value|
        
        if value != ""
         rdf.update_associations_model(params[:model],assoc,'namespace',value)
        end
        if params["associations_property"] && params["associations_property"][assoc]
         rdf.update_associations_model(params[:model],assoc,'property',params["associations_property"][assoc])
        end
         rdf.update_associations_model(params[:model],assoc,'privacy',params[:privacy][assoc])
        
     end
     
     
     rdf.update_model(params[:model],"privacy",params[:privacy][params[:model]]) if params[:privacy][params[:model]]

     if params[:property]
       rdf.update_model(params[:model],"namespace",params[:namespace][params[:model]])
       rdf.update_model(params[:model],"property",params[:property][params[:model]]) 
     end
    
     rdf.save

     @model_attributes = rdf.get_attributes_model(@model)
     
     render :partial => "model_attributes",:layout => nil
  end
  
  def view_settings
    @settings ||= YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
    render :template => "easy_datas/view_settings", :layout => false
  end

  def settings
     @settings ||= YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
     @images = Dir["#{RAILS_ROOT}/public/images/*"].map{|img| [img.gsub("#{RAILS_ROOT}/public/images/",""),img.gsub("#{RAILS_ROOT}/public/images/","")]}
     render :partial => "settings",:layout => nil
  end

  def custom_settings
     @settings = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
     
     if !params["project"]["project"].empty? && params["project"]["project"]!=@settings["project"]["name"]
       @settings["project"]["name"] = params["project"]["project"]
     end

     if !params["project"]["logo"].empty? && params["project"]["logo"]!=@settings["project"]["logo"]
       @settings["project"]["logo"] = params["project"]["logo"]
     end

     if !params["project"]["description"].empty? && params["project"]["description"]!=@settings["project"]["description"]
       @settings["project"]["description"] = params["project"]["description"]
     end

     if !params["project"]["email"].empty? && params["project"]["email"]!=@settings["project"]["contact_email"]
       @settings["project"]["contact_email"] = params["project"]["email"]
     end
     
     if !params["user_admin"]["user"].empty? && !params["user_admin"]["pass"].empty?
       (@settings["user_admin"]["user"] = params["user_admin"]["user"]) if @settings["user_admin"]["user"]!=params["user_admin"]["user"]
       (@settings["user_admin"]["pass"] = params["user_admin"]["pass"]) if @settings["user_admin"]["pass"]!=params["user_admin"]["pass"]
     end

     (@settings["access"]["ip"] = params["access"]["ip"]) if params["access"]["ip"]!=@settings["access"]["ip"] && params["access"]["ip"]!= ""
     
     save_settings(@settings)

     render :template => "easy_datas/view_settings",:layout => false
  end
  
  def refresh_information
     EasyData.refresh_information
     redirect_to :action => "custom_rdf"
  end

  def authenticate_user
  end

  def login
    @admin = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))

    if @admin["user_admin"]["user"] == params[:nick] && @admin["user_admin"]["password"] == params[:pass]
      @current_user = params[:nick]
      session[:easy_data_session] = params[:nick]
      redirect_to :action => "custom_rdf"
    else
      redirect_to :authenticate_user
    end
  end

  def logout
    @current_user = nil
    session[:easy_data_session]=nil if !session[:easy_data_session].nil?
    redirect_to :action => "authenticate_user"
  end

  private 

  # Extract all parameters to build the query.
  # @param [Hash] request's parameters 
  # @return [Hahs] Conditions hash
  def parser_params (parameters = nil)
     
     conditions = {}
    
     if !parameters.empty?
       parameters.each do |key,value| #Delete all elements that aren't need to query
         unless ["controller","action","method","format","model"].include?key
           conditions[key.to_sym] = value
         end   
       end
     end

     return conditions
     
  end

  def authenticated
    admin = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))
    
    if admin["access"]["ip"].nil? || admin["access"]["ip"].to_s == request.ip.to_s
     if session[:easy_data_session].nil?
       redirect_to :action => "authenticate_user"
     end
    else
      render :nothing => true, :status => 404
    end
  end

  def save_settings(settings)
     file = File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml",'w')
     file.puts YAML::dump(settings)
     file.close
  end

end
