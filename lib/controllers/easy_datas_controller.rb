require "action_controller"
require "action_view"

class EasyDatasController < ActionController::Base
  
  layout 'easy_data_layout'

  def show
  #  unless params[:format].nil?
  #    render :template => "hola.html.erb",:layout => 'easy_data_layout'
  #  else
    begin
      model = eval params[:model].to_s
       
      if params[:id]
        @request = model.find params[:id]
      else
        @request={}
        relations = {}
        @request["model"] = params[:model].to_s
        @request["attributes"] = DataModels.model_attributes(model)
        @request["relations"] = DataModels.model_relations(model)

      end
             
      render :xml => @request
    rescue
      raise ActionController::RoutingError.new('Not Found')    
    end
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
     @namespaces = EasyData::RDF::Namespaces.list_form
     @properties = {}
     render :partial => "model_attributes",:layout => nil
  
  end

  def load_properties
     namespace = "EasyData::RDF::#{params[:id].upcase}"
     
     @namespace = params[:id]
     
     properties = (eval namespace).properties_form
   
     render :inline => "<span>Property:</span><%= select 'property',attribute,properties -%>",:locals => {:properties => properties,
                                                                                    :attribute => params[:attribute]}
   
  #   render :update  do |page|
  #     page.insert_html params[:block],:partial => html
  #   end
  
  end
  
  def custom_attributes

    debugger   

  end
end
