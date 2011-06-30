module RDF

   class OWL
     property :allValuesFrom
     property :annotatedProperty
     property :annotatedSource
     property :annotatedTarget
     property :assertionProperty
     property :backwardCompatibleWith
     property :bottomDataProperty
     property :bottomObjectProperty
     property :cardinality
     property :complementOf
     property :datatypeComplementOf
     property :deprecated
     property :differentFrom
     property :disjointUnionOf
     property :disjointWith
     property :distinctMembers
     property :equivalentClass
     property :equivalentProperty
     property :hasKey
     property :hasSelf
     property :hasValue
     property :imports
     property :incompatibleWith
     property :intersectionOf
     property :inverseOf
     property :maxCardinality
     property :maxQualifiedCardinality
     property :members
     property :minCardinality
     property :minQualifiedCardinality
     property :onClass
     property :onDataRange
     property :onDatatype
     property :onProperties
     property :onProperty
     property :oneOf
     property :priorVersion
     property :propertyChainAxiom
     property :propertyDisjointWith
     property :qualifiedCardinality
     property :sameAs
     property :someValuesFrom
     property :sourceIndividual
     property :targetIndividual
     property :targetValue
     property :topDataProperty
     property :topObjectProperty
     property :unionOf
     property :versionIRI
     property :versionInfo
     property :withRestrictions   


     def self.to_s(property,resource,value)
        "<owl:#{property} rdf:resource"
     end

     def self.list
     end 
   end

end
