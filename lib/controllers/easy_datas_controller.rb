require "action_controller"
require "action_view"
require "builder"

class EasyDatasController < ActionController::Base
  
  layout 'easy_data_layout'
  
  before_filter :authenticated, :only => [:custom_rdf]

  def show
       
      model = eval params[:model].to_s
      
      conditions = parser_params(params)
     
      rdf = ModelRdf.new      
      
      unless conditions.empty?
        @reply = model.find :all, :conditions => conditions || nil
      end

      @host="http://"+request.env["HTTP_HOST"]          
      
      @rdf_model = rdf.get_model_rdf(@reply,params[:model],"http://"+request.env["HTTP_HOST"])
      
      @xml = Builder::XmlMarkup.new
      
      respond_to do |format|
        format.html
        format.xml # render :template => "/rdf/request.xml.builder"   
      end
      
  end

  def show_all
      model = eval params[:model].to_s
      
      rdf = ModelRdf.new      
      
      @reply = model.find :all
      
      @host="http://"+request.env["HTTP_HOST"]          
      
      @rdf_model = rdf.get_model_rdf(@reply,params[:model],"http://"+request.env["HTTP_HOST"])
      
      @xml = Builder::XmlMarkup.new
      
      respond_to do |format|
        format.html
        format.xml # render :template => "/rdf/request.xml.builder"   
      end
  end

  # Show information about data publications
  # 
  #
  def info_easy_data
      models = DataModels.load_models
      @list = []
      
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

  def custom_rdf
    @models = DataModels.load_models
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
       
       if params[:attribute]!=params[:model]
         render :inline => "<span>Property:</span><%= select type+'_property',attribute,properties,{:prompt => 'Select a property...'} -%><span class='rdf_info'>(Current value: <%= current_value%>)</span>",
                          :locals => {:properties => properties,
                                      :type => params[:type],
                                      :attribute => params[:attribute],
                                      :current_value => @model_attributes[params[:type]][params[:attribute]][:property]}
       else
         render :inline => "<span>Property:</span><%= select 'property',attribute,properties,{:prompt => 'Select a property...'} -%><span class='rdf_info'>(Current value: <%= current_value%>)</span><br />",
                          :locals => {:properties => properties,
                                      :attribute => params[:model],
                                      :current_value => @model_attributes[:property]}

       end
     else
       render :inline => ""
     end
  end
  
  def load_linked_data_graph
     if params[:model]
      @model = params[:model]
      render :partial => "linked_data_model"
     else
      models = DataModels.load_models
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
     unless params["attributes_property"].nil?
      params["rdf_type_attributes"].each do |att,value|
        if params["attributes_property"][att] != "" && value != ""
         rdf.update_attributes_model(params[:model],att,'namespace',value)
         rdf.update_attributes_model(params[:model],att,'property',params["attributes_property"][att])
         rdf.update_attributes_model(params[:model],att,'privacy',rdf.privacy(params[:privacy][att].to_i))
        end
      end
     end
     unless params["associations_property"].nil?
      params["rdf_type_associations"].each do |assoc,value|
        if value != "" && params["associations_property"][assoc] != ""
         rdf.update_associations_model(params[:model],assoc,'namespace',value)
         rdf.update_associations_model(params[:model],assoc,'property',params["associations_property"][assoc])
         rdf.update_associations_model(params[:model],assoc,'privacy',rdf.privacy(params[:privacy][assoc].to_i))
        end
      end
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

  def authenticate_user
  end

  def login
     
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

  def parser_params (parameters = nil)
     
     conditions = {}
    
     if !parameters.empty?
       parameters.each do |key,value|
         unless ["controller","action","method","format","model"].include?key
           conditions[key.to_sym] = value
         end   
       end
     end

     return conditions
     
  end

  def authenticated
    @admin = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/setting.yaml"))

    if @admin["access"]["ip"].nil? || @admin["access"]["ip"].to_s == request.ip.to_s
     if session[:easy_data_session].nil?
       redirect_to :action => "authenticate_user"
     end
    else
      render_404
    end
  end

end
