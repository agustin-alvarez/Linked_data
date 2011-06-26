module DataModels
  
   def self.load_models
  
     models = []
     
      #To test executable /bin/linked_data
      #Dir["/home/jnillo/Documentos/Proyectos/redmine/app/models/**/*.rb"].each do |file|
      #   models << file.gsub('/home/jnillo/Documentos/Proyectos/redmine/app/models/',"").gsub('.rb','').gsub(":","")
      #end
 
     
       Dir["#{RAILS_ROOT}/app/models/**/*.rb"].each do |file|
         models << file.gsub(RAILS_ROOT+'/app/models/',"").gsub('.rb','').classify.gsub(":","")
       end
     
     models
  
  end

  def self.model_attributes(model)
  	
  	clase = eval model
  	
  	clase.columns.map{|att| [att.name,att.type]}
  	
  end

  def self.build_models_yaml_file

  	self.models
  end
end
