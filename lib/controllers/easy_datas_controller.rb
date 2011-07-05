require "action_controller"
require "action_view"
require "builder"

class EasyDatasController < ActionController::Base
  
  layout 'easy_data_layout'

  def show
    
   # begin
      model = eval params[:model].to_s
      conditions = parser_params(params[:params]||nil)
      rdf = ModelRdf.new      

      unless conditions.empty?
        @reply = model.find :all, :conditions => conditions
      else
        @reply = model.find :all
      end
      @host="http://"+request.env["HTTP_HOST"]          
      
      @rdf_model = rdf.get_model_rdf(@reply,params[:model],"http://"+request.env["HTTP_HOST"])
      
      @xml = Builder::XmlMarkup.new
      respond_to do |format|
        format.html
        format.xml # render :template => "/rdf/request.xml.builder"   
      end
       #render :file => "/rdf/request",:content_type => "application/xml",:locals => {:rdf_model => @rdf_model}
   # rescue
   #   raise ActionController::RoutingError.new('Not Found')    
   # end
  
  end

  def describe_api
      models = DataModels.load_models
      list = {}
      models.each do |mod|
       list[mod.gsub("::","_")] = "#{mod.gsub("::","_")}"
      end

      render :xml => list
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

  def load_properties

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
  end
  
  def custom_attributes

     rdf = ModelRdf.new
     @model = params[:model]

     params["rdf_type_attributes"].each do |att,value|
       if params["attributes_property"][att] != "" && value != ""
        rdf.update_attributes_model(params[:model],att,'namespace',value)
        rdf.update_attributes_model(params[:model],att,'property',params["attributes_property"][att])
        rdf.update_attributes_model(params[:model],att,'privacy',rdf.privacy(params[:privacy][att].to_i))
       end
     end
    
     params["rdf_type_associations"].each do |assoc,value|
       if value != "" && params["associations_property"][assoc] != ""
        rdf.update_associations_model(params[:model],assoc,'namespace',value)
        rdf.update_associations_model(params[:model],assoc,'property',params["associations_property"][assoc])
        rdf.update_associations_model(params[:model],assoc,'privacy',rdf.privacy(params[:privacy][assoc].to_i))
       end
     end

     rdf.save

     @model_attributes = rdf.get_attributes_model(@model)
     
     render :partial => "model_attributes",:layout => nil
  end

  private 

  def parser_params (params = nil)
     
     conditions = {}

     if params.nil? || params == 'ALL'
       return conditions
     else
       params = params.split("$")
       params.each do |p|
         p = p.split(':')
         conditions[p[0].downcase.to_sym] = p[1]   
       end
       return conditions
     end
  end

end
