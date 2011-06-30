class ParserRdf

   def to_rdf(model)
      rdf_info = ModelRdf.new
      
      model_rdf = {}

      rdf_info.get_attributes_model(model).each do |att|
         model_rdf << parser_attribute(att)
      end      
      
      model_rdf

   end


   private

   def parser_attribute(att,info_rdf)
      {info_rdf => att}
   end
end
