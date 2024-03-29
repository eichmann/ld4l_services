<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/Homosaurus/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="skos" baseURI="http://www.w3.org/2004/02/skos/core#"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s ?p ?o . ?o ?q ?r .
    			?b <http://www.w3.org/2004/02/skos/core#prefLabel> ?bl .
 		        ?t <http://www.w3.org/2004/02/skos/core#prefLabel> ?yl .
 				?rt <http://www.w3.org/2004/02/skos/core#prefLabel> ?rtl .
    			?n <http://www.w3.org/2004/02/skos/core#prefLabel> ?nl } WHERE {
      ?s ?p ?o .
      OPTIONAL {
        ?o ?q ?r
        FILTER (isBlank(?o))
      }
      OPTIONAL {
        ?s <http://www.w3.org/2004/02/skos/core#broader> ?b .
        ?b <http://www.w3.org/2004/02/skos/core#prefLabel> ?bl
      }
      OPTIONAL {
        ?s <http://www.w3.org/2004/02/skos/core#narrower> ?n .
        ?n <http://www.w3.org/2004/02/skos/core#prefLabel> ?nl
      }
      OPTIONAL {
        ?s <http://www.w3.org/2004/02/skos/core#hasTopConcept> ?t .
        ?t <http://www.w3.org/2004/02/skos/core#prefLabel> ?tl
      }
      OPTIONAL {
        ?s <http://www.w3.org/2004/02/skos/core#related> ?rt .
        ?rt <http://www.w3.org/2004/02/skos/core#prefLabel> ?rtl
      }
    }
    <sparql:parameter var="s" value="${param.uri}" type="IRI" />
</sparql:construct>

<jsp:include page="emit_graph.jsp"/>
