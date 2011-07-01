module EasyData  
  module RDF
   class DC11 < Namespaces
     @@properties= {"contributor" => "",
                    "coverage" => "",
                    "creator" => "",
                    "date" => "",
                    "description" => "",
                    "format" => "",
                    "identifier" => "",
                    "language" => "",
                    "publisher" => "",
                    "relation" => "",
                    "rights" => "",
                    "source" => "",
                    "subject" => "",
                    "title" => "",
                    "type" => "",
                   }

     # Return tag to rdf doc
     def self.to_s(property,resource,value)
        @@properties[property].gsub("%%",resource).gsub("$$",value)
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
