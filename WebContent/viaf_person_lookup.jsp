<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/viaf/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="triple">
    <c:choose>
    <c:when test="${ not empty param.givenname and empty param.familyname }">
	    SELECT DISTINCT ?s ?p ?o WHERE {
	       {
	           ?s ?p ?o .
	           ?s rdf:type schema:Person .
	           ?s schema:givenName ?givenname .
               <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
	       }
	    UNION
	       {
               ?s ?p ?o .
               ?s rdf:type schema:Person .
               ?s schema:givenName ?givenname@en .
               <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
	       }
	    }
        <sparql:parameter var="givenname" value="${param.givenname}"/>
    </c:when>
    <c:when test="${ empty param.givenname and not empty param.familyname }">
        SELECT DISTINCT ?s ?p ?o WHERE {
           {
                ?s ?p ?o .
                ?s rdf:type schema:Person.
                ?s schema:familyName ?familyName .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
           }
        UNION
           {
                ?s ?p ?o .
                ?s rdf:type schema:Person.
                ?s schema:familyName ?familyName@en .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
           }
        }
        <sparql:parameter var="familyName" value="${param.familyname}"/>
    </c:when>
    <c:when test="${ not empty param.givenname and not empty param.familyname }">
        SELECT DISTINCT ?s ?p ?o WHERE {
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:name ?name .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            }
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:name ?name@en .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            }
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:name ?sortname .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            } 
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:name ?sortname@en .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            } 
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:givenName ?givenname .
                ?s schema:familyName ?familyName .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            }
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:givenName ?givenname@en .
                ?s schema:familyName ?familyName@en .
            }
<c:if test="${ not empty param.alternatename }">
       UNION
             {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:alternateName ?name .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            }
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:alternateName ?name@en .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            }
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:alternateName ?sortname .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            } 
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:alternateName ?sortname@en .
                <c:if test="${not empty param.lang}">FILTER(!isLiteral(?o) || lang(?o) = "" || langMatches(lang(?o), "${param.lang}"))</c:if>
            } 
</c:if>
        }
        <sparql:parameter var="givenname" value="${param.givenname}"/>
        <sparql:parameter var="familyName" value="${param.familyname}"/>
        <sparql:parameter var="name" value="${param.givenname} ${param.familyname}"/>
        <sparql:parameter var="sortname" value="${param.familyname}, ${param.givenname}"/>
    </c:when>
    </c:choose>
 </sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
${row.s} ${row.p} ${row.o} .
</c:forEach>
