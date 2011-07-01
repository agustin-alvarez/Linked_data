module RDF

   class XSD
     @@properties= {"NOTATION" => "",
    "QName" => "",
    "anyURI" => "",
    "base64Binary" => "",
    "boolean" => "",
    "date" => "",
    "dateTime" => "",
    "decimal" => "",
    "double" => "",
    "duration" => "",
    "float" => "",
    "gDay" => "",
    "gMonth" => "",
    "gMonthDay" => "",
    "gYear" => "",
    "gYearMonth" => "",
    "hexBinary" => "",
    "string" => "",
    "time" => "",
    "ENTITIES" => "",                      # XML Schema built-in derived types
    "ENTITY" => "",                      # @see http://www.w3.org/TR/xmlschema-2/#built-in-derived
    "ID" => "",
    "IDREF" => "",
    "IDREFS" => "",
    "NCName" => "",
    "NMTOKEN" => "",
    "NMTOKENS" => "",
    "Name" => "",
    "byte" => "",
    "int" => "",
    "integer" => "",
    "language" => "",
    "long" => "",
    "negativeInteger" => "",
    "nonNegativeInteger" => "",
    "nonPositiveInteger" => "",
    "normalizedString" => "",
    "positiveInteger" => "",
    "short" => "",
    "token" => "",
    "unsignedByte" => "",
    "unsignedInt" => "",
    "unsignedLong" => "",
    "unsignedShort" => "" 
     }

     # Return tag to rdf doc
     def self.to_s(property,resource,value)
        @@properties[property].gsub('%%',resource).gsub('$$',value)
     end
     
     #Return a list of Namespace's properties
     def self.list
        @@properties.keys
     end 
   end

end
