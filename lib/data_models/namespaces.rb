module EasyData  
  module RDF
    class Namespaces
      
      # List of namespace availables to be used in RDF info models
      @@namespaces=['cc','cert','dc','dc11','doap','exif','foaf','geo','http','owl','rdfs','rsa','rss','sioc','skos','wot','xhtml','xsd'] 
      
      # Return List of namespaces
      # @return [Array] list of namespaces
      def self.list
        @@namespaces
      end

      # Return list of namespaces to be used in a form
      # @return [Hash] hash of namespace
      def self.list_form
        list = {}

        @@namespaces.each do |namespace|
           list[namespace] = namespace
        end

        list
      end

    end
  end
end
