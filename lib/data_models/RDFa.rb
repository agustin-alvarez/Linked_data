require "data_models/model_rdf" 
class RDFa 

   def self.model(model)
     
   end

   def self.attribute(model,attributes)
      
   end

   ####################################
   # HTML Tags
   ####################################

   def self.div(model,value,attribute=nil,options=nil)
      html_code('div',model,value,attribute,options)
   end

   def self.span(model,value,attribute=nil,options=nil)
      html_code('span',model,value,attribute,options)
   end
   
   def self.li(model,value,attribute=nil,options=nil)
      html_code('li',model,value,attribute,options)
   end
   
   def self.td(model,value,attribute=nil,options=nil)
      html_code('td',model,value,attribute,options)
   end

   def self.th(model,value,attribute=nil,options=nil)
      html_code('th',model,value,attribute,options)
   end
   
   def self.p(model,value,attribute=nil,options=nil)
      html_code('p',model,value,attribute,options)
   end
   
   def self.img(model,src,attribute=nil,options=nil)
      html_code('img',model,nil,attribute,"src='#{src}' "+options.to_s)
   end 

   #######################################
   # Generate html code with RDFa info
   #######################################
   
   private
   def self.html_code(tag,model,value,attribute,options = "")
    rdf_info = ModelRdf.new    

    if attribute.nil? #prefix + type_of
      options = (options || "") + rdf_info.get_prefix(model)
      options = options + rdf_info.model(model)
    else  #property
      options = (options||"") + rdf_info.attribute(model,attribute)
    end
    
    unless value.nil?
     "<#{tag} #{options}>#{value}</#{tag}>"
    else
     "<#{tag} #{options}/>"
    end
   end

end
