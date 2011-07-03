module EasyData
  module RDF
   class GEO < Namespaces
     @@uri = "http://www.w3.org/2003/01/geo/wgs84_pos#"
     @@properties= { "lat" => "",
                     "location" => "",
                     "long" => "",
                     "lat_long" => ""   
                   }
       
     # Return Namespace URI
     def self.uri
       @@uri
     end

     # Return tag to rdf doc
     def self.to_s(property,resource,value)
        @@properties[property].gsub('%%',resource).gsub('$$',value)
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
