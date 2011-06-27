require "action_controller"

ActionController::Routing::Routes.add_route "foaf/:model/:id.:format", :controller => "easy_datas", :action => "show"

#ActionController::Routing::Routes.reload
