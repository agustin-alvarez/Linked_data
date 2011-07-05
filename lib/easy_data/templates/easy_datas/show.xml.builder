xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"

xml.rdf :RDF, @rdf_model[:header] do 
  @rdf_model[:body].each do |element,prop|
    xml.rdf :Description, {:about => prop["description"]} do
      prop["attributes"].each do |att,value|
        xml.tag!(att,value)
      end    
    end
  end
end
