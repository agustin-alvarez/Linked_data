module RDF

   class DC11
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
     def self.list
        @@properties.keys
     end 
   end

end
