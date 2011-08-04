module EasyData  
  module RDF
   class RSS < Namespaces

     @@uri = "http://purl.org/rss/1.0/"
     @@properties = {"description" => "",
                     "items" => "",
                     "link" => "",
                     "name" => "",
                     "title" => "",
                     "url" => "" 
                    }
       
     # Return Namespace URI
     def self.uri
       @@uri
     end

      # Return tag to rdf doc
     def self.to_s(property,uri,value)
        @@properties[property].gsub("%uri%",uri).gsub('%value%',value)
     end
     
     #Return a list of Namespace's properties
     def self.properties
        @@properties.keys
     end

     def self.properties_form 
       list = {}
       @@properties.keys.each do |property|
         list[property] = property
       end
       list
     end
   end
 end
end
