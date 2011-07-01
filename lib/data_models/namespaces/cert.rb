module RDF

   class CERT
     @@properties= {"decimal" => "",
                    "hex" => "",
                    "identity" => "",
                    "public_key" => "", 
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
