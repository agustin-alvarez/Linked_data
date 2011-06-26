#require 'lib/routing/route'
#require 'action_controller/routing'

#ActionController::Routing::RouteSet::Mapper.send :include,
#EasyData::Routing::Routes::MapperExtensions

class << ActionController::Routing::Routes;self;end.class_eval do
  define_method :clear!, lambda {}
end

ActionController::Routing::Routes.draw do |map|
  map.connect "foaf/:model/:id.:format", :controller => "", 
                                         :action => "foaf",
                                         :conditions => {:method => :get},
                                         :only => [:show]
end
