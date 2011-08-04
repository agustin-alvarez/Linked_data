module DataModels
  
   def self.load_models
     models = []
 
     Dir["#{RAILS_ROOT}/app/models/**/*.rb"].each do |file|
       models << file.gsub(RAILS_ROOT+'/app/models/',"").gsub('.rb','').classify
     end
 
     models
  end

  def self.model_attributes(model)      
      model.columns.map{|att| att.name}.join(", ")
  end

  def self.model_relations(model)

    relations = {}
	
    model.reflections.each do |relation,values|  
      relations[relation] = {"model" => values.class_name,"type" => values.macro.to_s} 
    end   	
   
    relations
  end

  def self.build_models_yaml_file
    self.models
  end

  def self.get_model_data(model)
    begin 
      eval model 
    rescue 
      eval model.pluralize 
    end
  end
end
