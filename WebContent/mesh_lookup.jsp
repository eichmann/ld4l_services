<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/mesh/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="skos" baseURI="http://www.w3.org/2004/02/skos/core#"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s ?p ?o .
    			?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c1 . ?c1 <http://www.w3.org/2000/01/rdf-schema#label> ?cl1 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c2 . ?c2 <http://www.w3.org/2000/01/rdf-schema#label> ?cl2 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c3 . ?c3 <http://id.nlm.nih.gov/mesh/vocab#broaderConcept> ?bc3 . ?bc3 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl3 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c4 . ?c4 <http://id.nlm.nih.gov/mesh/vocab#broaderConcept> ?bc4 . ?bc4 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl4 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c5 . ?c5 <http://id.nlm.nih.gov/mesh/vocab#narrowerConcept> ?bc5 . ?bc5 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl5 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c6 . ?c6 <http://id.nlm.nih.gov/mesh/vocab#narrowerConcept> ?bc6 . ?bc6 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl6 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c7 . ?c7 <http://id.nlm.nih.gov/mesh/vocab#relatedConcept> ?bc7 . ?bc7 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl7 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c8 . ?c8 <http://id.nlm.nih.gov/mesh/vocab#relatedConcept> ?bc8 . ?bc8 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl8 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#useInstead> ?c9 . ?c9 <http://www.w3.org/2000/01/rdf-schema#label> ?cl9 .
    			?c10 <http://id.nlm.nih.gov/mesh/vocab#mappedTo> ?s . ?c10 <http://www.w3.org/2000/01/rdf-schema#label> ?cl10 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#broaderDescriptor> ?c11 . ?c11 <http://www.w3.org/2000/01/rdf-schema#label> ?cl11 .
    			?c12 <http://id.nlm.nih.gov/mesh/vocab#broaderDescriptor> ?s . ?c12 <http://www.w3.org/2000/01/rdf-schema#label> ?cl12 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#pharmacologicalAction> ?c13 . ?c13 <http://www.w3.org/2000/01/rdf-schema#label> ?cl13 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#seeAlso> ?c14 . ?c14 <http://www.w3.org/2000/01/rdf-schema#label> ?cl14 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c15 . ?c15 <http://id.nlm.nih.gov/mesh/vocab#scopeNote> ?cl15 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c16 . ?c16 <http://id.nlm.nih.gov/mesh/vocab#scopeNote> ?cl16 .
    			?c17 <http://id.nlm.nih.gov/mesh/vocab#hasDescriptor> ?s . ?c17 <http://www.w3.org/2000/01/rdf-schema#label> ?cl17 .
    			?s <http://id.nlm.nih.gov/mesh/vocab#hasDescriptor> ?c18 . ?c18 <http://www.w3.org/2000/01/rdf-schema#label> ?cl18 .
    			} WHERE {
	    {
	      ?s ?p ?o .
	      ?s <http://id.nlm.nih.gov/mesh/vocab#active> true .
	    }
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c1 .
	      ?c1 <http://www.w3.org/2000/01/rdf-schema#label> ?cl1 .
	      ?c1 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c2 .
	      ?c2 <http://www.w3.org/2000/01/rdf-schema#label> ?cl2 .
	      ?c2 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c3 .
          ?c3 <http://id.nlm.nih.gov/mesh/vocab#broaderConcept> ?bc3 .
	      ?bc3 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl3 .
	      ?bc3 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c4 .
          ?c4 <http://id.nlm.nih.gov/mesh/vocab#broaderConcept> ?bc4 .
	      ?bc4 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl4 .
	      ?bc4 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c5 .
          ?c5 <http://id.nlm.nih.gov/mesh/vocab#narrowerConcept> ?bc5 .
	      ?bc5 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl5 .
	      ?bc5 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c6 .
          ?c6 <http://id.nlm.nih.gov/mesh/vocab#narrowerConcept> ?bc6 .
	      ?bc6 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl6 .
	      ?bc6 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c7 .
          ?c7 <http://id.nlm.nih.gov/mesh/vocab#relatedConcept> ?bc7 .
	      ?bc7 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl7 .
	      ?bc7 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c8 .
          ?c8 <http://id.nlm.nih.gov/mesh/vocab#relatedConcept> ?bc8 .
	      ?bc8 <http://www.w3.org/2000/01/rdf-schema#label> ?bcl8.
	      ?bc8 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#useInstead> ?c9 .
	      ?c9 <http://www.w3.org/2000/01/rdf-schema#label> ?cl9 .
	      ?c9 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?c10 <http://id.nlm.nih.gov/mesh/vocab#mappedTo> ?s .
	      ?c10 <http://www.w3.org/2000/01/rdf-schema#label> ?cl10 .
	      ?c10 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#broaderDescriptor> ?c11 .
	      ?c11 <http://www.w3.org/2000/01/rdf-schema#label> ?cl11 .
	      ?c11 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?c12 <http://id.nlm.nih.gov/mesh/vocab#broaderDescriptor> ?s .
	      ?c12 <http://www.w3.org/2000/01/rdf-schema#label> ?cl12 .
	      ?c12 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#pharmacologicalAction> ?c13 .
	      ?c13 <http://www.w3.org/2000/01/rdf-schema#label> ?cl13 .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#seeAlso> ?c14 .
	      ?c14 <http://www.w3.org/2000/01/rdf-schema#label> ?cl14 .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#concept> ?c15 .
	      ?c15 <http://id.nlm.nih.gov/mesh/vocab#scopeNote> ?cl15 .
	      ?c15 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#preferredConcept> ?c16 .
	      ?c16 <http://id.nlm.nih.gov/mesh/vocab#scopeNote> ?cl16 .
	      ?c16 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?c17 <http://id.nlm.nih.gov/mesh/vocab#hasDescriptor> ?s .
	      ?c17 <http://www.w3.org/2000/01/rdf-schema#label> ?cl17 .
	      ?c17 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    UNION
    	{
          ?s <http://id.nlm.nih.gov/mesh/vocab#hasDescriptor> ?c18 .
	      ?c18 <http://www.w3.org/2000/01/rdf-schema#label> ?cl18 .
	      ?c18 <http://id.nlm.nih.gov/mesh/vocab#active> true .
    	}
    }
	<sparql:parameter var="s" value="${param.uri}" type="IRI" />
</sparql:construct>

<jsp:include page="emit_graph.jsp"/>
