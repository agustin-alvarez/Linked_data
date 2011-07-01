module RDF

   class DOAP
     @@properties= {"'anon-root'" => "",
    "audience" => "",
    "blog" => "",
    "browse" => "",
    "'bug-database'" => "",
    "category" => "",
    "created" => "",
    "description" => "",
    "developer" => "",
    "documenter" => "",
    "'download-mirror'" => "",
    "'download-page'" => "",
    "'file-release'" => "",
    "helper" => "",
    "homepage" => "",
    "implements" => "",
    "language" => "",
    "license" => "",
    "location" => "",
    "'mailing-list'" => "",
    "maintainer" => "",
    "module" => "",
    "name" => "",
    "'old-homepage'" => "",
    "os" => "",
    "platform" => "",
    "'programming-language'" => "",
    "release" => "",
    "repository" => "",
    "revision" => "",
    "screenshots" => "",
    "'service-endpoint'" => "",
    "shortdesc" => "",
    "tester" => "",
    "translator" => "",
    "vendor" => "",
    "wiki" => ""   
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
