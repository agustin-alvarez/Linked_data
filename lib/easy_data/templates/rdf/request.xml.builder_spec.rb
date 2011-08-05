<?xml version="1.0" encoding="utf-8"?>

<rdf:RDF
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    <% rdf_model[:header].each do |ns,uri| %>
     <%= puts "xmlns:#{ns}='#{uri}'" %>
    <%end%>
>
 
<% rdf_model[:body].each do |element|%>
   <%debugger%>
   <%= element["description"]%>
    <%element["attributes"].each do |att|%>
      <%=att%>
    <%end%> 
   </rdf:Description>
<% end %>


</rdf:RDF>
