<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/Ligatus/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="skos" baseURI="http://www.w3.org/2004/02/skos/core#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s ?p ?o . ?broader skos:prefLabel ?broader_label . ?narrower skos:prefLabel ?narrower_label } WHERE {
	    {
	      ?s ?p ?o .
	      ?s rdf:type skos:Concept .
	    }
    UNION
    	{
          ?s skos:broader ?broader .
	      ?broader skos:prefLabel ?broader_label .
    	}
    UNION
        {
          ?s skos:narrower ?narrower .
	      ?narrower skos:prefLabel ?narrower_label .
        }
    }
	<sparql:parameter var="s" value="${param.uri}" type="IRI" />
</sparql:construct>
