module EasyData
  module RDF
   class WOT < Namespaces

     @@uri = "http://www.xmlns.com/wot/0.1/" 
     @@properties= {"assurance" => "",
                    "encryptedTo" => "",
                    "encrypter" => "",
                    "fingerprint" => "",
                    "hasKey" => "",
                    "hex_id" => "",
                    "identity" => "",
                    "length" => "",
                    "pubkeyAddress" => "",
                    "sigdate" => "",
                    "signed" => "",
                    "signer" => "",
                    "sigtime" => ""   
                    }
       
     # Return Namespace URI
     def self.get_uri
       @@uri
     end

      # Return tag to rdf doc
     def self.to_s(property,uri,value)
        @@properties[property].gsub("%uri%",uri).gsub('%value%',value)
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
