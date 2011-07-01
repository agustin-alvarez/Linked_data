module EasyData
  module RDF
   class HTTP < Namespaces
     @@properties= {"abs_path" => "",
                    "absoluteURI" => "",
                    "authority" => "",
                    "body" => "",
                    "connectionAuthority" => "",
                    "elementName" => "",
                    "elementValue" => "",
                    "fieldName" => "",
                    "fieldValue" => "",
                    "header" => "",
                    "param" => "",
                    "paramName" => "",
                    "paramValue" => "",
                    "request" => "",
                    "requestURI" => "",
                    "response" => "",
                    "responseCode" => "",
                    "version" => "" 
                   }

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
