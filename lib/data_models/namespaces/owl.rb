module EasyData
  module RDF
   class OWL < Namespaces
     @@uri= "http://www.w3.org/2002/07/owl#"

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
      
     @@classes = {"AllDifferent" => "",
                  "AllDisjointClasses" => "",
                  "AllDisjointProperties" => "",
                  "Annotation" => "",
                  "AnnotationProperty" => "",
                  "AsymmetricProperty" => "",
                  "Axiom" => "",
                  "Class" => "",
                  "DataRange" => "",
                  "DatatypeProperty" => "",
                  "DeprecatedClass" => "",
                  "DeprecatedProperty" => "",
                  "FunctionalProperty" => "",
                  "InverseFunctionalProperty" => "",
                  "IrreflexiveProperty" => "",
                  "NamedIndividual" => "",
                  "NegativePropertyAssertion" => "",
                  "Nothing" => "",
                  "ObjectProperty" => "",
                  "Ontology" => "",
                  "OntologyProperty" => "",
                  "ReflexiveProperty" => "",
                  "Restriction" => "",
                  "SymmetricProperty" => "",
                  "Thing" => "",
                  "TransitiveProperty" => ""
     }

     # Return Namespace URI
     def self.get_uri
       @@uri
     end

      # Return tag to rdf doc
     def self.to_s(property,uri,value)
        @@properties[property].gsub("%uri%",uri).gsub('%value%',value)
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

     #Return a list of Namespace's classes
     def self.classes
        @@classes.keys
     end

     def self.classes_form 
       list = {}
       @@classes.keys.each do |c|
         list[c] = c
       end
       list
     end

   end
 end
end
