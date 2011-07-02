require "action_controller"

module EasyDataRouting 
    def self.routes(map)
     # DataModels.load_models.each do |model|
     #  map.connect "#{model.gsub("::","_")}/:id.:format", :controller => "easy_datas", 
     #                                      :action => 'show',
     #                                      :model => model,
    #                                       :conditions => {:method => :get}
     # end
     #  map.connect "list_models.:format", :controller => "easy_datas", 
     #                                     :action => 'describe_api'
#
#       map.connect "custom_rdf", :controller => "easy_datas",
#                                 :action => "custom_rdf"
      
  #     map.resources :easy_datas,:member => {:load_properties => :get
      #                                       :model_attributes => :post,
      #                                       :show => :get,
      #                                       :describe_api => :get
   #                                         } 
       map.with_options :controller => 'easy_datas' do |ed_routes|
         ed_routes.with_options :conditions => {:method => :get} do |ed_views|
           ed_views.connect 'list_models.:format', :action => 'describe_api'
           ed_views.connect 'custom_rdf', :action=> "custom_rdf"
           DataModels.load_models.each do |model|
             ed_views.connect "#{model.gsub("::","_")}/:id.:format", :controller => "easy_datas", 
                                                                :action => 'show',
                                                                :model => model
           end
         end
         ed_routes.with_options :conditions => {:method => :post} do |ed_actions|
           ed_actions.connect 'easy_datas/model_attributes/:model', :action => 'model_attributes'
           ed_actions.connect 'easy_datas/model_attributes_edit/:model', :action => 'model_attributes_edit'
           ed_actions.connect 'easy_datas/load_properties/:block/:attribute', :action => 'load_properties'
           ed_actions.connect 'easy_datas/custom_attributes/:model', :action => 'custom_attributes'
         end

       #Ajax routes:
      # map.resources :easy_datas,:member => {:load_properties => :post}
     end
   end
end

