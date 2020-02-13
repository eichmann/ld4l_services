<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/CERL/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s ?p ?o . ?s <http://www.cerl.org/namespaces/thesaurus/signOrDevice> ?sign . ?sign <http://www.cerl.org/namespaces/thesaurus/hasDescription> ?desc . ?s <http://www.cerl.org/namespaces/thesaurus/locationOfActivity> ?loc . ?loc <http://www.cerl.org/namespaces/thesaurus/hasPlace> ?addr . ?addr <http://rdvocab.info/ElementsGr3/nameOfThePlace> ?name } WHERE {
	    {
	      ?s ?p ?o .
	      ?s <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.cerl.org/namespaces/thesaurus/ImprintName> .
	    }
    UNION
    	{
          ?s <http://www.cerl.org/namespaces/thesaurus/signOrDevice> ?sign .
	      ?sign <http://www.cerl.org/namespaces/thesaurus/hasDescription> ?desc .
    	}
    UNION
        {
          ?s <http://www.cerl.org/namespaces/thesaurus/locationOfActivity> ?loc .
	      ?loc <http://www.cerl.org/namespaces/thesaurus/hasPlace> ?addr .
	      ?addr <http://rdvocab.info/ElementsGr3/nameOfThePlace> ?name .
        }
    }
	<sparql:parameter var="s" value="${param.uri}" type="IRI" />
</sparql:construct>
