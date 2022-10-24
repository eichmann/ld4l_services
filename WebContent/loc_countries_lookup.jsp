<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/loc_countries/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
    <sparql:prefix prefix="skos" baseURI="http://www.w3.org/2004/02/skos/core#"/>
</sparql:setEndpoint>

 <sparql:construct var="graph" endpoint="${ld4l}">
     CONSTRUCT { ?s ?p ?o . ?o skos:prefLabel ?r . ?o2 skos:prefLabel ?r2 . ?o3 skos:prefLabel ?r3 .
     			?o4 mads:citation-source ?r4 . ?o5 mads:citation-status ?r5 . ?o6 rdfs:label ?r6 } WHERE { 
      ?s ?p ?o . 
      OPTIONAL { 
      	?s skos:narrower ?o . 
        ?o skos:prefLabel ?r . 
      } 
      OPTIONAL { 
      	?s skos:broader ?o2 . 
        ?o2 skos:prefLabel ?r2 . 
      } 
      OPTIONAL { 
      	?s skos:related ?o3 . 
        ?o3 skos:prefLabel ?r3 . 
      } 
      OPTIONAL { 
      	?s mads:hasSource ?o4 . 
        ?o4 mads:citation-source ?r4 . 
      } 
      OPTIONAL { 
      	?s mads:hasSource ?o5 . 
        ?o5 mads:citation-status ?r5 . 
      } 
      OPTIONAL { 
      	?s skos:inScheme ?o6 . 
        ?o6 rdfs:label ?r6 . 
      } 
    } 
	<sparql:parameter var="s" value="${param.uri}" type="IRI" />
 </sparql:construct>

<%@ include file="emit_graph.jsp" %>
