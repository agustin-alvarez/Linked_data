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
              eval mod_assoc.pluralize
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
      file = File.open("#{Rails.root}/public/images/linked_data_graphs/linked_data_#{model}.dot",'w')
      
      file.puts "digraph G {"
      #file.puts 'size="15,15";'
      file.puts 'graph [rotate=0, rankdir="LR"]'
      file.puts 'node [color="#333333", style=filled,shape=box, fontname="Trebuchet MS"]'
      file.puts 'edge [color="#666666", arrowhead="open", fontname="Trebuchet MS", fontsize="11"]'
      file.puts model.to_s+'  [fillcolor="#116611", fontcolor="white"]'

      #Draw nodes

      graph_info[:assoc].each do |assoc|
         file.puts assoc.to_s+' [fillcolor="#294b76", fontcolor="white"]'
         file.puts '"'+model+'" -> "'+assoc.to_s+'"[dir=none];'
      end


      file.puts "}"

      file.close

      system "dot -Tpng #{Rails.root}/public/images/linked_data_graphs/linked_data_#{model}.dot -o #{Rails.root}/public/images/linked_data_graphs/linked_data_#{model}.png"
      system "rm #{Rails.root}/public/images/linked_data_graphs/linked_data_#{model}.dot"
   end
end
