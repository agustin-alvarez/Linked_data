require "linked_data/version"
require "data_models/data_models"

module LinkedData
  
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
