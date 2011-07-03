module EasyData
  module RDF
   class OWL < Namespaces
     @@owl= "http://www.w3.org/2002/07/owl#"

     @@properties = {"allValuesFrom" => "",
     "annotatedProperty" => "",
     "annotatedSource" => "",
     "annotatedTarget" => "",
     "assertionProperty" => "",
     "backwardCompatibleWith" => "",
     "bottomDataProperty" => "",
     "bottomObjectProperty" => "",
     "cardinality" => "",
     "complementOf" => "",
     "datatypeComplementOf" => "",
     "deprecated" => "",
     "differentFrom" => "",
     "disjointUnionOf" => "",
     "disjointWith" => "",
     "distinctMembers" => "",
     "equivalentClass" => "",
     "equivalentProperty" => "",
     "hasKey" => "",
     "hasSelf" => "",
     "hasValue" => "",
     "imports" => "",
     "incompatibleWith" => "",
     "intersectionOf" => "",
     "inverseOf" => "",
     "maxCardinality" => "",
     "maxQualifiedCardinality" => "",
     "members" => "",
     "minCardinality" => "",
     "minQualifiedCardinality" => "",
     "onClass" => "",
     "onDataRange" => "",
     "onDatatype" => "",
     "onProperties" => "",
     "onProperty" => "",
     "oneOf" => "",
     "priorVersion" => "",
     "propertyChainAxiom" => "",
     "propertyDisjointWith" => "",
     "qualifiedCardinality" => "",
     "sameAs" => "",
     "someValuesFrom" => "",
     "sourceIndividual" => "",
     "targetIndividual" => "",
     "targetValue" => "",
     "topDataProperty" => "",
     "topObjectProperty" => "",
     "unionOf" => "",
     "versionIRI" => "",
     "versionInfo" => "",
     "withRestrictions" => ""
     } 
       
     # Return Namespace URI
     def self.uri
       @@uri
     end

     def self.to_s(property,resource,value)
        "<owl:#{property} rdf:resource"
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
