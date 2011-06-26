#require 'lib/routing/route'
#require 'action_controller/routing'

#ActionController::Routing::RouteSet::Mapper.send :include,
#  LinkedData::Routing::Routes::MapperExtensions

ActionController::Routing::Routes.draw do |map|
   map.resource ":namespace/:model/:id.:format", :controller => "", 
                                                 :action => "foaf",
                                                 :conditions => {:method => :get
                                                                 :namespace => ["foaf","owl","doap"]
                                                                },
                                                 :only => [:show]
end
