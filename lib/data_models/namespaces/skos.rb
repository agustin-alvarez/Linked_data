module EasyData
  module RDF
   class SKOS < Namespaces
     @@properties= {"altLabel" => "",
    "broadMatch" => "",
    "broader" => "",
    "broaderTransitive" => "",
    "changeNote" => "",
    "closeMatch" => "",
    "definition" => "",
    "editorialNote" => "",
    "exactMatch" => "",
    "example" => "",
    "hasTopConcept" => "",
    "hiddenLabel" => "",
    "historyNote" => "",
    "inScheme" => "",
    "mappingRelation" => "",
    "member" => "",
    "memberList" => "",
    "narrowMatch" => "",
    "narrower" => "",
    "narrowerTransitive" => "",
    "notation" => "",
    "note" => "",
    "prefLabel" => "",
    "related" => "",
    "relatedMatch" => "",
    "scopeNote" => "",
    "semanticRelation" => "",
    "topConceptOf" => ""   
     }

     # Return tag to rdf doc
     def self.to_s(property,resource,value)
        @@properties[property].gsub('%%',resource).gsub('$$',value)
     end
     
     #Return a list of Namespace's properties
     def self.properties
        @@properties.keys
     end

     def self.properties_form 
       list = {}
       @@properties.keys.each do |property|
         list[property] = property
       end
       list
     end
   end
 end
end
