class LinkedDataGraph

   def self.build(models)
      
    models.each do |model|
      graph = {}
      
      #graph[:models] = get_attributes_ponderations(models)
      graph[:assoc] = get_associations(model)
      
      generate_graph(graph,model) if !graph[:assoc].empty?
    end
   end

   private

   def self.get_attributes_ponderations(model)
     associations = {}
     
      model = eval model
      if model.respond_to?:reflections
       associations[model.to_s.gsub("::","_")] = model.reflections.count
      else
       associations[model.to_s.gsub("::","_")] = 0 
      end
     
   end

   def self.get_associations(model)
     assoc = []
     
     model = eval model
       if model.respond_to?:reflections
         model.reflections.each do |name,info|
           mod_assoc = info.name.to_s.camelize
           begin
              eval mod_assoc
           rescue
             begin
              eval (mod_assoc.pluralize)
              mod_assoc = (mod_assoc.pluralize)
             rescue
                 (mod_assoc = info.options[:source].to_s.camelize)if info.options[:source]
             end
           end
           if mod_assoc
             assoc << mod_assoc
           end
         end
       end
     assoc
   end

   def self.generate_graph(graph_info,model)
      model = model.gsub("::","_")
      file = File.open("#{RAILS_ROOT}/public/images/linked_data_graphs/linked_data_#{model}.dot",'w')
      
      file.puts "digraph G {"
      #file.puts 'size="15,15";'
      file.puts "rankdir = LR;"
      file.puts "model[color=#80e3ff]"
     
      #Draw nodes

      graph_info[:assoc].each do |assoc|
         file.puts "#{assoc} [color=#ffdc98]"
         file.puts '"'+model+'" -> "'+assoc.to_s+'"[dir=none];'
      end


      #Draw associations between nodes
     # graph_info[:assoc].each do |assoc,nodes|
     #   file.puts nodes+' [dir=none];'
     # end      
     
      file.puts "}"

      file.close

      system "dot -Tpng #{RAILS_ROOT}/public/images/linked_data_graphs/linked_data_#{model}.dot -o #{RAILS_ROOT}/public/images/linked_data_graphs/linked_data_#{model}.png"
      system "rm #{RAILS_ROOT}/public/images/linked_data_graphs/linked_data_#{model}.dot"
   end
end
