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
   
   def public?()
      self.model_rdf[model][:privacy] == "Public"
   end
   
   def private?()
      self.model_rdf[model][:privacy] == "Private"
   end

   def hidden?()
      self.model_rdf[model][:privacy] == "Hidden"
   end

   def get_rdf_info_model(model)
      {:namespace => self.model_rdf[model][:namespace],:property => self.model_rdf[model][:property]}
   end
   #Return attributes of model stored in the configuration yaml file
   def get_attributes_model(model)
      self.model_rdf[model] 
   end
   
   # RDFa: Return attributes of model RDF info
   def model(model)
     info = get_rdf_info_model(model)
     if info[:property] && info[:property]!= "not defined"
      " typeof='#{info[:namespace]}:#{info[:property]}'"
     else
      " "
     end
   end
  
   # update model rdf info
   def update_model(model,param,value)
      self.model_rdf[model][param.to_sym] = value
   end

   # update attributes with rdf properties.
   def update_attributes_model(model,attribute,param,value)
      self.model_rdf[model]['attributes'][attribute][param.to_sym] = value
   end
   
   # RDFa: Return attribute rdf info
   def attribute(model,attribute)
      att_rdf = self.model_rdf[model]['attributes'][attribute]
      " property='#{att_rdf[:namespace]}:#{att_rdf[:property]}'"
   end

   def update_associations_model(model,association,param,value)
      self.model_rdf[model]['associations'][association][param.to_sym] = value
   end

   # RDFa: return a string with all prefix used to describes attributes
   def get_prefix(model)
      prefix = []
      data_model = get_attributes_model(model)
      data_model["attributes"].each do |att,info|
       if info[:namespace] && info[:namespace] != 'not defined'
        puts info[:namespace]
        prefix << "#{info[:namespace]}:#{(eval "EasyData::RDF::#{info[:namespace].upcase}.get_uri")} "
       end
      end
      data_model["associations"].each do |assoc,info|
       if info[:namespace] && info[:namespace] != 'not defined'
        prefix << "#{info[:namespace]}:#{(eval "EasyData::RDF::#{info[:namespace].upcase}.get_uri")} "
       end
      end

      if data_model[:namespace] && data_model[:namespace] != 'not defined'
        prefix << "#{data_model[:namespace]}:#{(eval "EasyData::RDF::#{data_model[:namespace].upcase}.get_uri")}"       
      end

      prefix.uniq.join(" ")
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

   def get_model_rdf(query,model,host)
      if public?model.to_sym
       request = {:body => "",:header => {"xmlns:rdf"=>"http://www.w3.org/1999/02/22-rdf-syntax-ns#"}}
       elements = {}
       models = []
       query.each do |element|
          elements[element.id] = {'description' => "#{host}/#{element.class.to_s}/#id:#{element.id}",
                                  'attributes' => get_properties_tag(element),
                                  'associations' => get_associations_tag(element)
                                 }
       
          models << element.class.to_s
       end     
    
       attributes = {}
       request[:body] = elements
       models.each do |mod|
         attributes = get_attributes_model(mod) || get_attributes_model((eval mod).base_class.to_s)
         request[:header].merge!(get_header(attributes))
       end
       request
      else
       {}
      end
   end

   def get_header(attributes)
      headers = {}
      
      (attributes["attributes"].merge(attributes["associations"])).each do |att,properties|
        if properties != "no publication" && properties[:namespace] != 'not defined'
          headers["xmlns:#{properties[:namespace]}"] = (eval "EasyData::RDF::#{properties[:namespace].upcase}.get_uri") #EasyData.get_uri_namespace(properties[:namespace])
        end
      end         
      headers
   end

   def get_properties_tag(element)

      attributes = get_attributes_model(element.class.to_s)

      # If element's class is a polimorphic class, we used base class.
      if attributes.nil?
        attributes = get_attributes_model(element.class.base_class.to_s)
      end 

      properties = {}
      if element.attributes.respond_to? :each 
       element.attributes.each do |att|
         #conditions to methods to check if can be show
         if can_see?(attributes["attributes"][att.first][:privacy]) && exist_info_att(attributes["attributes"][att.first],att.second)
           properties["#{attributes['attributes'][att.first][:namespace]}:#{attributes["attributes"][att.first][:property]}"] = att.second
         end
       end  
      end
      
      properties
   
    end

    def get_associations_tag(element)
       
       associations = get_attributes_model(element.class.to_s)
       class_element = element.class
       if associations.nil?
         associations = get_attributes_model(element.class.base_class.to_s)
         class_element = element.class.base_class
       end
       properties = {}       
      
       class_element.reflections.each do |ref,value|
         rel = eval "element.#{ref}" 
         if exist_info_assoc(rel.to_a,associations["associations"][ref.to_s]) && can_see?(associations["associations"][ref.to_s][:privacy]) && !rel.empty?
           
           properties.merge!({"#{associations['associations'][ref.to_s][:namespace]}:#{associations['associations'][ref.to_s][:property]}" => {:model => rel.first.class ,
                                                                                                                                                 :id => rel.collect{|obj| obj.id}}
                             })
         end
       end       
       properties
    end


    private
    ########################################################################
    ##  FUNCTIONS FOR CHECK IF SHOW oR NoT THE CURRENT ITEM               ##
    ########################################################################

    def can_see?(privacy)
      privacy=="Public" || (privacy=="Private" && !@current_user.nil?)
    end

    def exist_info_att(attributes,value)
       attributes[:namespace] != "not defined" && 
       attributes[:property] !="not defined" &&
       !value.nil?     
    end

    def exist_info_assoc(rels,rdf_info)
       !rels.nil? && !rels.empty? && 
        rdf_info[:namespace] != "not defined" && 
        rdf_info[:property] != "not defined"

    end
end
