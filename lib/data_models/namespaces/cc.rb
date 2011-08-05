module EasyData 
  module RDF
   class CC < Namespaces
     @@uri = "xmlns:cc=http://creativecommons.org/ns#"
     @@properties= {"attributionName" => "<cc:attributionName>%value%</cc:attributionName>",
                    "attributionURL" => "",
                    "deprecatedOn" => "",
                    "jurisdiction" => "",
                    "legalcode" => "",
                    "license" => "",
                    "morePermissions" => "",
                    "permits" => "",
                    "prohibits" => "",
                    "requires" => "" 
                   }

     # Return Namespace URI
     def self.uri
       @@uri
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
