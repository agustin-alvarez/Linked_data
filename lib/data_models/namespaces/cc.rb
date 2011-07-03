module EasyData 
  module RDF
   class CC < Namespaces
     @@uri = "http://creativecommons.org/ns#"
     @@properties= {"attributionName" => "",
                    "attributionURL" => "",
                    "deprecatedOn" => "",
                    "jurisdiction" => "",
                    "legalcode" => "",
                    "license" => "",
                    "morePermissions" => "",
                    "permits" => "",
                    "prohibits" => "",
                    "requires" => "", 
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
