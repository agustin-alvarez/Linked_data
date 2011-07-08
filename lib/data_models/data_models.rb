module DataModels
  
  def self.load_models

     models = []
     models_valids = []
     mod = nil

     Dir["#{RAILS_ROOT}/app/models/**/*.rb"].each do |file|
       models << file.gsub(RAILS_ROOT+'/app/models/',"").gsub('.rb','').classify
     end
     
     models.each do |model|
       begin
         mod = eval model
       rescue
         begin
           mod = eval model.pluralize
         rescue
           mod = nil
         end
       end
       if mod
         models_valids << mod.to_s
       end
     end
   
     models_valids
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
