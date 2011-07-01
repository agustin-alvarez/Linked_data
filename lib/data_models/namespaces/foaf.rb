module RDF

   class FOAF
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
