<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="${param.catalog}">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="triple">
    <c:choose>

    <c:when test="${ not empty param.givenname and not empty param.familyname }">
        SELECT DISTINCT ?s ?p ?o WHERE {
			{ 
			?s rdf:type mads:Authority .
			?s mads:identifiesRWO ?p . 
			?s mads:authoritativeLabel ?p . 
			?s rdf:type foaf:Person .
			    ?s mads:authoritativeLabel ?name. 
        }
 
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:name ?name@en .
            }
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:name ?sortname .
            } 
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:name ?sortname@en .
            } 
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:givenName ?givenname .
                ?s schema:familyName ?familyName .
            }
        UNION
            {
                ?s ?p ?o .
                ?s rdf:type schema:Person .
                ?s schema:givenName ?givenname@en .
                ?s schema:familyName ?familyName@en .
            }

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
