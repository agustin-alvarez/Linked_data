require "action_controller"

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
     
     render :partial => "model_attributes",:layout => nil
  
  end
end
