require "action_controller"

module EasyDataRouting 
    def self.routes

       resources :easy_datas do 
           member do 
             #GET
             get '/custom_rdf', :to => "easy_datas#custom_rdf"
             get '/authenticate_user',:to => "easy_datas#authenticate_user"
             get '/s/data_publications', :to => 'easy_datas#info_easy_data'
             get '/info_easy_data', :to => 'easy_datas#info_easy_data'
             get '/linked_data', :to => 'easy_datas#linked_data'
             get '/access_to_data', :to => 'easy_datas#access_to_data'
             get '/faq', :to => 'easy_datas#faq'
             get '/logout', :to => 'easy_datas#logout' 
             #POST
             post '/model_attributes_info', :to => "easy_datas#model_attributes_info"
             post '/load_linked_data_graph', :to => "easy_datas#load_linked_data_graph"
             post '/model_attributes/:model', :to => 'easy_datas#model_attributes'
             post '/model_attributes_edit/:model', :to => 'easy_datas#model_attributes_edit'
             post '/load_properties/:block/:attribute', :to => 'easy_datas#load_properties'
             post '/login', :to => 'easy_datas#login'
             post '/custom_attributes/:model', :to => 'easy_datas#custom_attributes'
             post '/settings', :to => 'easy_datas#settings'
             post '/custom_settings', :to => 'easy_datas#custom_settings'
             post '/view_settings', :to => 'easy_datas#view_settings'
           end
       end
       DataModels.load_models.each do |model|
           match "/s/#{model.gsub("::","_")}.:format", :to => "easy_datas#show",
                                                       :about => "/s/#{model.gsub("::","_")}"
           match "/s/#{model.gsub("::","_").pluralize}.:format",:to => "easy_datas#show_all", 
                                                        :about => "/s/#{model.gsub("::","_").pluralize}"
       end

  
     
   end
end

