require "action_controller"

module EasyDataRouting 
    def self.routes(map)
       map.connect "foaf/:model/:id.:format", :controller => "easy_datas", 
                                              :action => 'show',
                                              :conditions => {:method => :get}

       map.connect "list_models.:format", :controller => "easy_datas", 
                                          :action => 'describe_api'
    end
end

