ActionController::Routing::Routes.add_route "foaf/:model/:id.:format", :controller => "easy_datas", 
                                            :action => 'show',
                                            :conditions => {:method => :get},
                                            :only => [:show]

