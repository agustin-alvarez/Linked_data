module EasyData  
  module RDF
    class Namespaces
      

      @@namespaces=['cc','cert','dc','dc11','doap','exif','foaf','geo','http','owl','rdfs','rsa','rss','sioc','skos','wot','xhtml','xsd'] 
     
      def self.list
        @@namespaces
      end

      def self.list_form
        list = {}

        @@namespaces.each do |namespace|
           list[namespace] = namespace
        end

        list
      end

      def self.get_tag(attribute,namespace,property,value)
         
      end

    end
  end
end
