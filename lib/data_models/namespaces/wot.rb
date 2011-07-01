module RDF

   class WOT
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
