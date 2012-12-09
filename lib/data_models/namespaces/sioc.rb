module EasyData
  module RDF
   class SIOC < Namespaces

     @@uri = "http://rdfs.org/sioc/ns#"

     @@properties= {"about" => "",
    "account_of" => "",
    "administrator_of" => "",
    "attachment" => "",
    "avatar" => "",
    "container_of" => "",
    "content" => "",
    "content_encoded" => "",    # @deprecated
    "created_at" => "",         # @deprecated
    "creator_of" => "",
    "description" => "",        # @deprecated
    "earlier_version" => "",
    "email" => "",
    "email_sha1" => "",
    "feed" => "",
    "first_name" => "",         # @deprecated
    "follows" => "",
    "function_of" => "",
    "group_of" => "",           # @deprecated
    "has_administrator" => "",
    "has_container" => "",
    "has_creator" => "",
    "has_discussion" => "",
    "has_function" => "",
    "has_group" => "",          # @deprecated
    "has_host" => "",
    "has_member" => "",
    "has_moderator" => "",
    "has_modifier" => "",
    "has_owner" => "",
    "has_parent" => "",
    "has_part" => "",           # @deprecated
    "has_reply" => "",
    "has_scope" => "",
    "has_space" => "",
    "has_subscriber" => "",
    "has_usergroup" => "",
    "host_of" => "",
    "id" => "",
    "ip_address" => "",
    "last_activity_date" => "",
    "last_item_date" => "",
    "last_name" => "",          # @deprecated
    "last_reply_date" => "",
    "later_version" => "",
    "latest_version" => "",
    "link" => "",
    "links_to" => "",
    "member_of" => "",
    "moderator_of" => "",
    "modified_at" => "",        # @deprecated
    "modifier_of" => "",
    "name" => "",
    "next_by_date" => "",
    "next_version" => "",
    "note" => "",
    "num_authors" => "",
    "num_items" => "",
    "num_replies" => "",
    "num_threads" => "",
    "num_views" => "",
    "owner_of" => "",
    "parent_of" => "",
    "part_of" => "",            # @deprecated
    "previous_by_date" => "",
    "previous_version" => "",
    "reference" => "",          # @deprecated
    "related_to" => "",
    "reply_of" => "",
    "scope_of" => "",
    "sibling" => "",
    "space_of" => "",
    "subject" => "",            # @deprecated
    "subscriber_of" => "",
    "title" => "",             # @deprecated
    "topic" => "", 
    "usergroup_of" => "" 
     }

     @@classes = {"Community" => "",
                  "Container" => "",
                  "Forum" => "",
                  "Item" => "",
                  "Post" => "", 
                  "Role" => "",
                  "Space" => "",
                  "Site" => "",
                  "Thread" => "",
                  "UserAccount" => "",
                  "Usergrupo" => "",
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

     #Return a list of Namespace's classes
     def self.classes
        @@classes.keys
     end

     def self.classes_form 
       list = {}
       @@classes.keys.each do |c|
         list[c] = c
       end
       list
     end

   end
  end
end
