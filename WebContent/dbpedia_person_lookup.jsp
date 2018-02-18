<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/dbpedia/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="vivo" baseURI="http://vivoweb.org/ontology/core#"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="triple">
    <c:choose>
    <c:when test="${ not empty param.givenname and empty param.surname }">
	    SELECT ?s ?p ?o WHERE {
	        ?s ?p ?o .
	        ?s rdf:type foaf:Person.
	        ?s foaf:givenName ?givenname@en .
            <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
	    }
        <sparql:parameter var="givenname" value="${param.givenname}"/>
    </c:when>
    <c:when test="${ empty param.givenname and not empty param.surname }">
        SELECT ?s ?p ?o WHERE {
            ?s ?p ?o .
            ?s rdf:type foaf:Person.
            ?s foaf:surname ?surname@en .
            <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
        }
        <sparql:parameter var="surname" value="${param.surname}"/>
    </c:when>
    <c:when test="${ not empty param.givenname and not empty param.surname }">
        SELECT DISTINCT ?s ?p ?o WHERE {
            {
                ?s ?p ?o .
                ?s rdf:type foaf:Person .
                ?s foaf:name ?name@en .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            }
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type foaf:Person .
                ?s foaf:name ?sortname@en .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            } 
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type foaf:Person .
                ?s foaf:givenName ?givenname@en .
                ?s foaf:surname ?surname@en .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            }
        }
        <sparql:parameter var="givenname" value="${param.givenname}"/>
        <sparql:parameter var="surname" value="${param.surname}"/>
        <sparql:parameter var="name" value="${param.givenname} ${param.surname}"/>
        <sparql:parameter var="sortname" value="${param.surname}, ${param.givenname}"/>
    </c:when>
    </c:choose>
 </sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
${row.s} ${row.p} ${row.o} .
</c:forEach>
