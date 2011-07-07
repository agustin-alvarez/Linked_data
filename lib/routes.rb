require "action_controller"

module EasyDataRouting 
    def self.routes(map)
       
       map.with_options :controller => 'easy_datas' do |ed_routes|
         ed_routes.with_options :conditions => {:method => :get} do |ed_views|
           ed_views.connect 'linked_data.:format', :action => 'info_linked_data'
           ed_views.connect 'easy_datas/custom_rdf', :action=> "custom_rdf"
           ed_views.connect 'easy_data', :action => "custom_rdf"
           ed_views.connect 'easy_datas/authenticate_user', :action => "authenticate_user"
          
           ed_views.connect 'easy_datas/logout', :action => 'logout'
           DataModels.load_models.each do |model|
             ed_views.connect "#{model.gsub("::","_")}/:params", :controller => "easy_datas", 
                                                                 :action => 'show',
                                                                 :model => model,
                                                                 :format => 'xml'
           end
         end
         ed_routes.with_options :conditions => {:method => :post} do |ed_actions|
           ed_actions.connect 'easy_datas/model_attributes/:model', :action => 'model_attributes'
           ed_actions.connect 'easy_datas/model_attributes_edit/:model', :action => 'model_attributes_edit'
           ed_actions.connect 'easy_datas/load_properties/:block/:attribute', :action => 'load_properties'
           ed_actions.connect 'easy_datas/login', :action => 'login'
           ed_actions.connect 'easy_datas/custom_attributes/:model', :action => 'custom_attributes'
         end

       #Ajax routes:
      # map.resources :easy_datas,:member => {:load_properties => :post}
     end
   end
end

