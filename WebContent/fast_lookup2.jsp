<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/fast/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="triple">
	SELECT ?uri ?p ?o WHERE {
		?s ?p ?o .
		bind( ?s as ?uri)
	}
    <sparql:parameter var="s" value="${param.uri}" type="IRI" />
 </sparql:query>
	<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
	${row.uri} ${row.p} ${row.o} .
	</c:forEach>

<sparql:query var="result" endpoint="${ld4l}" resultType="triple">
	SELECT ?o ?q ?r WHERE {
		?s ?p ?o .
		?o ?q ?r .
        <c:if test="${not empty param.lang}">FILTER(!isLiteral(?r) || lang(?r) = "" || langMatches(lang(?r), "${param.lang}"))</c:if>	}
    <sparql:parameter var="s" value="${param.uri}" type="IRI" />
 </sparql:query>
 	<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
	${row.o} ${row.q} ${row.r} .
	</c:forEach>
 
 <sparql:query var="result" endpoint="${ld4l}" resultType="triple">
	SELECT ?uri ?pref ?label WHERE {
		?s rdfs:label ?label .
		bind( ?s as ?uri)
		bind( <http://www.w3.org/2004/02/skos/core#prefLabel> as ?pref)
	}
    <sparql:parameter var="s" value="${param.uri}" type="IRI" />
 </sparql:query>
 	<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
	${row.uri} ${row.pref} ${row.label} .
	</c:forEach>
 