module DataModels
  # This method reads all models that the project hash.
  # @return [Array] The proyect models list. 
  def self.load_models

     models = []   #All models will be in this list.
     models_valids = [] #This list is only to models with database table associated.
     mod = nil

     #Get all models in Model's folder
     Dir["#{RAILS_ROOT}/app/models/**/*.rb"].each do |file|
       models << file.gsub(RAILS_ROOT+'/app/models/',"").gsub('.rb','').classify
     end
     
     # Here, get the correct model's name: Singular or Plural
     models.each do |model|
       begin
         mod = eval model
         mod.columns
       rescue
         begin
           mod = eval model.pluralize
           mod.columns
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

  # This method return all model's attributes.
  # @param [String] model's name
  # @return [Array] model's attribute list.
  def self.model_attributes(model)      
      model.columns.map{|att| att.name}.join(", ")
  end

  # This method return all model's relations
  # @param [String] model's name
  # @return [Hash] hash with all relations and relations type
  def self.model_relations(model)

    relations = {}
    
    #Build the hash with relation name and relation's type.	
    model.reflections.each do |relation,values|  
      relations[relation] = {"model" => values.class_name,"type" => values.macro.to_s} 
    end   	
   
    relations
  end

  # Return all RDF information stored in yaml file.
  # @return [Hash] hash with all information stored in yaml file.
  def self.build_models_yaml_file
    self.models
  end

  # Return data model.
  # @param [String] model's name
  # @return [Hash] data model's information.
  def self.get_model_data(model)
    begin 
      eval model 
    rescue 
      eval model.pluralize 
    end
  end
end
