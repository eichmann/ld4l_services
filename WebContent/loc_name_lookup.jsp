<%@ page language="java" contentType="text/html; charset=UTF-8" %>
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
    CONSTRUCT { ?s ?p ?o . ?o ?q ?r } WHERE {
      ?s ?p ?o .
      OPTIONAL {
        ?o ?q ?r
        FILTER (isBlank(?o))
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
