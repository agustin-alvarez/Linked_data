#require 'lib/routing/route'
require 'action_controller/routing'
require 'lib/easy_data'

ActionController::Routing::RouteSet::Mapper.send :include, EasyData::Routing::MapperExtensions
#ActionController::Routing::RouteSet::Mapper.send :include,
#EasyData::Routing::Routes::MapperExtensions

#ActionController::Routing::Routes.add_route "foaf/:model/:id.:format", :controller => "easy_datas", 
#                                            :action => 'show',
#                                            :conditions => {:method => :get},
#                                            :only => [:show]

