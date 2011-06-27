require "easy_data/version"
require "data_models/data_models"
require "action_controller"


module EasyData

  module Routing 
    module MapperExtensions
      def easy_datas
        @set.add_route "foaf/:model/:id.:format", :controller => "easy_datas", 
                                                  :action => 'show',
                                                  :conditions => {:method => :get},
                                                  :only => [:show]

     end
    end
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
  
  private
 
  def generate_query(model,params)
     query = "Select #{params.key.join(", ")}
              FROM #{model};"
  end
 
end

class EasyDatasController < ActionController::Base

  def show
    begin
      model = eval params[:model].to_s
       
      if params[:id]
        @request = model.find params[:id]
      else
        @request = model.all
      end

      render :xml => @request
    rescue
      redirect_to :action => :describe_api
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
