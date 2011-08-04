require "yaml"


class ModelRdf 
    
   #######################################################################
   # Attributes declarations
   #######################################################################
   @@privacy = ["Hidden","Public","Authenticated"]
   
   attr_accessor :model_rdf


   #######################################################################
   # Query methods
   #######################################################################   

   #Read the document of attributes relations with rdf properties 
   def initialize
     @model_rdf = YAML::load(File.open("#{RAILS_ROOT}/config/easy_data/rdf_info.yaml"))
   end

   # Return datas storeds in the configuration's yaml file
   def get_models
      self.model_rdf
   end

   #Return attributes of model stored in the configuration yaml file
   def get_attributes_model(model)
      self.model_rdf[model]
   end

   # update attributes with rdf properties.
   def update_attributes_model(model,attribute,param,value)
      self.model_rdf[model][attribute][param.to_sym] = value
   end
   
   # Return privacy of a attribute 
   def privacy(index)
     @@privacy[index]
   end
   
   # Save changes in rdf_info.yaml (configuration's yaml file)
   def save
     file = File.open("#{RAILS_ROOT}/config/easy_data/rdf_info.yaml",'w')
     file.puts YAML::dump(self.model_rdf)
     file.close
   end

   #######################################################################
   # Building RDF                           
   #######################################################################

   def get_model_rdf(query,host)

     query.each do |element|
       request[:body][element.id]['description'] = "<rdf:Description about='#{host}/#{element.class.to_s}/#id:#{element.id}'" 
       request[:body][element.id]['attributes'] = get_properties_tags(element)
       model = element.class.to_s
     end     

     request[:header] = get_header(get_attributes_model(model))
     
     ParserRdf.to_rdf(rdf_mod)                        #Generating of rdf variable
   end

   def get_header(attributes)
      headers = []
      attributes.each do |att,properties|
        headers << (eval "RDF::#{properties[:namespace].upcase}.uri")
      end         
      headers
   end

   def get_properties_tag(element)
      attributes = get_attributes_model(element.class.to_s)
      properties = []
      if element.respond_to? :each  
       element.attributes.each do |att|
         properties << get_property_tag(attributes[att.first][:namespace],attributes[att.first][:property],att.second)
       end  
      end
      properties
   end

   def get_property_tag(namespace,property,value)
     eval "RDF::#{namespace.upcase}.to_s(#{property},#{value})"
   end 
end
