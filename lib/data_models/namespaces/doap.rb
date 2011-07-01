module EasyData
  module RDF
   class DOAP < Namespaces
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
     def self.properties
        @@properties.keys
     end

     def self.properties_form 
       list = {}
       @@properties.keys.each do |property|
         list[property] = property
       end
       list
     end   end
  end
end
