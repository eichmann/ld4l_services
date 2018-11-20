<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/geonames/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
    <sparql:prefix prefix="gn" baseURI="http://www.geonames.org/ontology#"/>
</sparql:setEndpoint>

<sparql:construct var="graph" endpoint="${ld4l}">
    CONSTRUCT { ?s ?p ?o . ?o ?q ?r . ?t gn:name ?u . ?v gn:name ?w . ?x gn:name ?y} WHERE {
      ?s ?p ?o .
      OPTIONAL {
        ?o ?q ?r
        FILTER (isBlank(?o))
        <c:if test="${not empty param.lang}">FILTER(!isLiteral(?r) || lang(?r) = "" || langMatches(lang(?r), "${param.lang}"))</c:if>
      }
      OPTIONAL {
      	?s  gn:parentCountry ?t .
		?t gn:name ?u
	  }
      OPTIONAL {
      	?s  gn:parentADM1 ?v .
		?v gn:name ?w
	  }
      OPTIONAL {
      	?s  gn:parentADM2 ?x .
		?x gn:name ?y
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
<${param.uri}> ${row.p} ${row.o} .
</c:forEach>
