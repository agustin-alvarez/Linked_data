require "yaml"

class ModelRdf 

   @@privacy = ["Hidden","Public","Authenticated"]

   def initialize
      @model_rdf = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/rdf_info.yaml"))
   end

   def get_models
      @model_rdf
   end

   def get_attributes_model(model)
      @model_rdf[model]
   end

   def update_attributes_model(model,attribute,param,value)
      @model_rdf[model][attribute][param] = value
   end

   def privacy(index)
     @@privacy[index]
   end

end
