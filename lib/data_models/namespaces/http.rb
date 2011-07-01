module RDF

   class HTTP
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
     def self.list
        @@properties.keys
     end 
   end

end
