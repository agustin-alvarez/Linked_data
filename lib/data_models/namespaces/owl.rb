module RDF

   class OWL
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


     def self.to_s(property,resource,value)
        "<owl:#{property} rdf:resource"
     end

     def self.list
     end 
   end

end
