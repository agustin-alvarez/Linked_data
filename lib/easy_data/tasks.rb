require "ftools"
require 'rake'
require 'easy_data'
require 'active_record'


namespace :easy_data do

  desc <<-END_DESC
          "This tasks install and initialize parameters for run gem."
          END_DESC
  task :install => [:generate_info_initialize,:generate_info_rdf,:copy_style_interface] do
     puts "*** Finish install Easy Data gem in this proyect  ***"
  end
 
  desc <<-END_DESC
          "Generate info initialize gem"
          END_DESC
  task :generate_info_initialize => :environment do
    
    easy_data_initialize_dir = "#{RAILS_ROOT}/config/initializers"  

    file = File.open("#{easy_data_initialize_dir}/load_easy_data.rb","w")
    
    puts "Generating info initialize gem"

    file.puts "#Load templates paths:"
    file.puts "ActionController::Base.view_paths << EasyData.get_view_path"   
    

    file.close
  end

  desc <<-END_DESC
          "Generating yml file with asociate info rdf to model's attributes"
          END_DESC
  task :generate_info_rdf => :environment do

   puts "Generating RDF informations "

   models = DataModels.load_models

   easy_data_dir = "#{RAILS_ROOT}/config/easy_data"  

   unless File.exist? easy_data_dir
     File.makedirs easy_data_dir
   end

   file = File.open("#{easy_data_dir}/rdf_info.yaml","w")
   rdf_info = {}

   file.puts "#This is a document about RDF descriptions"
 
   models.each do |model|

     model_data = DataModels.get_model_data(model)
   
     if model_data.respond_to?:columns 
       
      rdf_info[model] = EasyData.yaml_description_model(model_data)
      
     end

   end

    file.puts rdf_info.to_yaml
  

   file.close

   puts "Rdf Information Model, was generated in #{easy_data_dir}/rdf_info.yaml"

  end

  desc <<-END_DESC
          "Copy style for custom rdf interface"
          END_DESC
  task :copy_style_interface => :environment do

     file_style = EasyData.get_style_path
     #Copy file to public/stylesheets:
     puts "Copy Style File to this proyect"
     File.copy(File.join(File.dirname(__FILE__), 'templates/stylesheets/easy_data_style.css'),"#{RAILS_ROOT}/public/stylesheets/easy_data_style.css")
  end

  desc <<-END_DESC
          "Add admin user to configure Rdf Info"
          END_DESC
  task :add_user,:user,:pass, :needs=> :environment do |t,args|

    args.with_defaults(:user => "admin", :pass => "admin")

    easy_data_dir = "#{RAILS_ROOT}/config/easy_data"

    file = File.open("#{easy_data_dir}/setting.yaml","w")
    file.puts "#User admin:"
    
    admin = {"user_admin" =>{"user" => args.user,"pass" => args.pass}}
    file.puts admin.to_yaml

    file.close

    puts "User #{args.user} added"

  end

  desc <<-END_DESC
          "Build Linked Data Graph"
          END_DESC

  task :build_linked_data_graph, :needs => :environment do

    puts "Generating Linked Data graph..."
    EasyData.build_linked_data_graph
    puts "Ok"
  end

end
