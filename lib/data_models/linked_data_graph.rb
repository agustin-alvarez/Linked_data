class LinkedDataGraph

   def self.build(models)
      
      graph = {:models => {},:assoc => {}}
      
      graph[:models] = get_attributes_ponderations(models)
      graph[:assoc] = get_associations(models)

      generate_graph(graph)
 
   end

   private

   def self.get_attributes_ponderations(models)
     associations = {}
     
     models.each do |model|
      model = eval model
      if model.respond_to?:reflections
       associations[model.to_s.gsub("::","_")] = model.reflections.count
      else
       associations[model.to_s.gsub("::","_")] = 0 
      end
     end
     associations
   end

   def self.get_associations(models)
     assoc = {}
     
     models.each do |model|
       model = eval model
       if model.respond_to?:reflections
         model.reflections.each do |name,info|
           mod_assoc = info.name.to_s.camelize
           debugger if model=="Wiki"
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
             assoc[name] = "#{model.to_s.gsub("::","_")} -> #{mod_assoc}"
           end
         end
       end
     end
     assoc
   end

   def self.generate_graph(graph_info)
      
      file = File.open("#{RAILS_ROOT}/public/images/linked_data_graph.dot",'w')
      
      file.puts "digraph G {"
      #file.puts 'size="15,15";'
      file.puts "rankdir = LR;"
     
      #Draw nodes

      #graph_info[:models].each do |model,assoc|
      #   file.puts '"'+model+'" [width='+(assoc+0.5).to_s+'] ;'
      #end


      #Draw associations between nodes
      graph_info[:assoc].each do |assoc,nodes|
        file.puts nodes+' [dir=none];'
      end      
     
      file.puts "}"

      file.close

      system "dot -Tpng #{RAILS_ROOT}/public/images/linked_data_graph.dot -o #{RAILS_ROOT}/public/images/linked_data_graph.png"

   end
end
