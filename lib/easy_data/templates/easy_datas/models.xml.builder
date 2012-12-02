xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.rdf :RDF, {"xmlns:rdf"=>"http://www.w3.org/1999/02/22-rdf-syntax-ns#"} do
 unless @list.empty?
   xml.list_model do 
    @list.each do |model|
      xml.model '',{:url => @host+'/s/'+model.pluralize,:model_name => model.pluralize}
    end
   end   
  end
end
