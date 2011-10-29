require "action_controller"

module EasyDataRouting 
    def self.routes(map)
       map.with_options :controller => 'easy_datas' do |ed_routes|
         ed_routes.with_options :conditions => {:method => :get} do |ed_views|
           ed_views.connect 'easy_datas/custom_rdf', :action=> "custom_rdf"
           ed_views.connect 'easy_data', :action => "custom_rdf"
           ed_views.connect 'easy_datas/authenticate_user', :action => "authenticate_user"
           ed_views.connect 's/data_publications', :action => 'info_easy_data'
           ed_views.connect 'easy_datas/info_easy_data', :action => 'info_easy_data'
           ed_views.connect 'easy_datas/linked_data', :action => 'linked_data'
           ed_views.connect 'easy_datas/access_to_data', :action => 'access_to_data'
           ed_views.connect 'easy_datas/faq', :action => 'faq'
           ed_views.connect 'easy_datas/logout', :action => 'logout'
           DataModels.load_models.each do |model|
             ed_views.connect "s/#{model.gsub("::","_")}", :controller => "easy_datas", 
                                                               :action => 'show',
                                                               :model => model,
                                                               :format => 'xml'
             ed_views.connect "s/#{model.gsub("::","_").pluralize}", :controller => "easy_datas", 
                                                                          :action => 'show_all',
                                                                          :model => model,
                                                                          :format => 'xml'
           end
         end
         ed_routes.with_options :conditions => {:method => :post} do |ed_actions|
           ed_actions.connect 'easy_datas/model_attributes_info', :action => "model_attributes_info"
           ed_actions.connect 'easy_datas/load_linked_data_graph', :action => "load_linked_data_graph"
           ed_actions.connect 'easy_datas/model_attributes/:model', :action => 'model_attributes'
           ed_actions.connect 'easy_datas/model_attributes_edit/:model', :action => 'model_attributes_edit'
           ed_actions.connect 'easy_datas/load_properties/:block/:attribute', :action => 'load_properties'
           ed_actions.connect 'easy_datas/login', :action => 'login'
           ed_actions.connect 'easy_datas/custom_attributes/:model', :action => 'custom_attributes'
           ed_actions.connect 'easy_datas/settings', :action => 'settings'
           ed_actions.connect 'easy_datas/custom_settings', :action => 'custom_settings'
           ed_actions.connect 'easy_datas/view_settings', :action => 'view_settings'
         end
     end
   end
end

