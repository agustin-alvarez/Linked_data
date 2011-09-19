class RDFa

   :before_filter => 

   def self.model(model)
     
   end

   def self.attribute(model,attributes)
      
   end

   ####################################
   # HTML Tags
   ####################################

   def self.div(model,value,attribute=nil,options=nil)
      html_code.call('div',model,value,attribute,options)
   end

   def self.span(model,value,attribute=nil,options=nil)
      html_code.call('span',model,value,attribute,options)
   end
   
   def self.li(model,value,attribute=nil,options=nil)
      html_code.call('li',model,value,attribute,options)
   end
   
   def self.td(model,value,attribute=nil,options=nil)
      html_code.call('td',model,value,attribute,options)
   end

   def self.th(model,value,attribute=nil,options=nil)
      html_code.call('th',model,value,attribute,options)
   end
   
   def self.p(model,value,attribute=nil,options=nil)
      html_code.call('p',model,value,attribute,options)
   end
   
   def self.img(model,src,attribute=nil,options=nil)
      html_code.call('img',model,value,attribute,src+options.to_s)
   end 
   #######################################
   #
   #######################################
   private

   def html_code(tag,model,value,attribute,options)
    rdf_info = ModelRdf.new    

    if attribute #prefix + type_of
      options += rdf_info.get_prefix(model)
      options += rdf_info.model(model)
    else  #property
      options += rdf_info.attribute(model,attribute)
    end
    
    unless value.nil?
     "<#{tag} #{options}>#{value}</#{tag}>"
    else
     "<#{tag} #{options}/>"
    end
   end
end
