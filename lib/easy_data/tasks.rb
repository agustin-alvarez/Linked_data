require "ftools"
require 'rake'
require 'easy_data'
require 'active_record'


namespace :easy_data do
  

  desc <<-END_DESC
          "Generating yml file with asociate info rdf to model's attributes"
          END_DESC
  task :generate_info_rdf => :environment do

   models = DataModels.load_models

   easy_data_dir = "#{RAILS_ROOT}/config/easy_data"

   unless File.exist? easy_data_dir
     File.makedirs easy_data_dir
   end

   file = File.open("#{easy_data_dir}/rdf_info.yml","w")
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

   puts "Rdf Information Model, was generated in #{easy_data_dir}/rdf_info.yml"

  end

end
