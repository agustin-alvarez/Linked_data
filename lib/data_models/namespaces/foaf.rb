module EasyData 
  module RDF
   class FOAF < Namespaces
     @@uri = "http://xmlns.com/foaf/0.1/"

     @@properties= {"account" => "",
    "accountName" => "",
    "accountServiceHomepage" => "",
    "age" => "",
    "aimChatID" => "",
    "based_near" => "",
    "birthday" => "",
    "currentProject" => "",
    "depiction" => "",
    "depicts" => "",
    "dnaChecksum" => "",
    "familyName" => "",
    "family_name" => "",
    "firstName" => "",
    "fundedBy" => "",
    "geekcode" => "",
    "gender" => "",
    "givenName" => "",
    "givenname" => "",
    "holdsAccount" => "",
    "homepage" => "",
    "icqChatID" => "",
    "img" => "",
    "interest" => "",
    "isPrimaryTopicOf" => "",
    "jabberID" => "",
    "knows" => "",
    "lastName" => "",
    "logo" => "",
    "made" => "",
    "maker" => "",
    "mbox" => "",
    "mbox_sha1sum" => "",
    "member" => "",
    "membershipClass" => "",
    "msnChatID" => "",
    "myersBriggs" => "",
    "name" => "",
    "nick" => "",
    "openid" => "",
    "page" => "",
    "pastProject" => "",
    "phone" => "",
    "plan" => "",
    "primaryTopic" => "",
    "publications" => "",
    "schoolHomepage" => "",
    "sha1" => "",
    "skypeID" => "",
    "status" => "",
    "surname" => "",
    "theme" => "",
    "thumbnail" => "",
    "tipjar" => "",
    "title" => "",
    "topic" => "",
    "topic_interest" => "",
    "weblog" => "",
    "workInfoHomepage" => "",
    "workplaceHomepage" => "",
    "yahooChatID" => ""
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
