<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/loc_names/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s ?p ?o . ?o <http://www.loc.gov/mads/rdf/v1#variantLabel> ?r . ?rws ?rwp ?rwo . ?rwo $rp ?rs } WHERE {
	    {
	      ?s ?p ?o .
	      ?s <http://www.w3.org/1999/02/22-rdf-syntax-ns#type> <http://www.loc.gov/mads/rdf/v1#PersonalName> .
	      OPTIONAL {
	        ?o <http://www.loc.gov/mads/rdf/v1#variantLabel> ?r
	        FILTER (isBlank(?o))
	      }
	      OPTIONAL {
	      	?s mads:identifiesRWO ?rws.
	      	?rws ?rwp ?rwo.
	      }
	      OPTIONAL {
	        ?rwo ?rp ?rs
	        <c:if test="${not empty param.lang}">FILTER(!isLiteral(?rs) || lang(?rs) = "" || langMatches(lang(?rs), "${param.lang}"))</c:if>
	      }
	      <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
	    }
    UNION
    	{
		  ?s ?p ?o .
		  OPTIONAL {
            ?s mads:identifiesRWO ?rws.
            ?rws ?rwp ?rwo.
          }
          OPTIONAL {
            ?o ?q ?r
            FILTER (isBlank(?o))
            <c:if test="${not empty param.lang}">FILTER(!isLiteral(?r) || lang(?r) = "" || langMatches(lang(?r), "${param.lang}"))</c:if>
          }
          <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
    	}
    }
    <sparql:parameter var="s" value="${param.uri}" type="IRI" />
</sparql:construct>

<sparql:query var="result" graph="${graph}" resultType="triple">
    SELECT ?s ?p ?o WHERE {
      ?s ?p ?o .
    } ORDER BY ?s ?p
</sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
${row.s} ${row.p} ${row.o} .
</c:forEach>
