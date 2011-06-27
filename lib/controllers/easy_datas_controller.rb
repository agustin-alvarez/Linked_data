require "action_controller"


class EasyDatasController < ActionController::Base

  def show
    begin
      model = eval params[:model].to_s
       
      if params[:id]
        @request = model.find params[:id]
      else
        @request={}
        relations = {}
        @request["model"] = params[:model].to_s
        @request["attributes"] = model.columns.map{|att| att.name}.join(", ")
        
        model.reflections.each do |relation,values|  
           relations[relation] = {"model" => values.class_name,"type" => values.macro.to_s} 
        end 
        @request["relations"] = relations

      end

      render :xml => @request
    rescue
      raise ActionController::RoutingError.new('Not Found')    
    end
  end

  def describe_api
      models = DataModels.load_models
      list = {}
      models.each do |mod|
       list[mod] = "foaf/#{mod}"
      end

      render :xml => list
  end
end
