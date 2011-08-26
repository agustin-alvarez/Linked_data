xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
unless @rdf_model.empty?
 xml.rdf :RDF, @rdf_model[:header] do 
   @rdf_model[:body].each do |element,prop|
     xml.rdf :Description, {:about => prop["description"]} do
       prop["attributes"].each do |att,value|
         xml.tag!(att,value)
       end    
       prop["associations"].each do |assoc,value|
         value[:id].each do |id|
           xml.tag!(assoc,nil,{"rdf:resource"=>"#{@host}/#{value[:model]}?id=#{id}"})
         end
       end
     end
   end
  end
end

