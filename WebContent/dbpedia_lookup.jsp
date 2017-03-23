<%@ page language="java" contentType="application/n-triples; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<sparql:setEndpoint var="ld4l" sparqlURL="http://guardian.slis.uiowa.edu:3030/dbpedia/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="vivo" baseURI="http://vivoweb.org/ontology/core#"/>
</sparql:setEndpoint>

<c:set var="mode" value="triple"/>
<c:if test="${ not empty param.mode }">
    <c:set var="mode" value="${param.mode}"/>
</c:if>

<sparql:query var="person" endpoint="${ld4l}" resultType="${mode}">
    SELECT ?s ?p ?o WHERE {
        ?s ?p ?o .
        ?s rdf:type ?entity.
        ?s <http://xmlns.com/foaf/0.1/name> ?name@en .
    }
    <sparql:parameter var="entity" value="http://xmlns.com/foaf/0.1/${param.entity}" type="iri"/>
    <sparql:parameter var="name" value="${param.name}"/>
 </sparql:query>

<c:choose>
    <c:when test="${mode == 'literal' }">
        <table border=1>
        <thead><tr><td>Subject</td><td>Predicate</td><td>Object</td></tr></thead>
        <tbody>
        <c:forEach items="${person.rows}" var="row" varStatus="rowCounter">
            <tr><td>${row.s}</td><td>${row.p}</td><td>${row.o}</td></tr>
        </c:forEach>
        </tbody>
        </table>
    </c:when>
    <c:otherwise>
        <c:forEach items="${person.rows}" var="row" varStatus="rowCounter">
            ${row.s} ${row.p} ${row.o} .
        </c:forEach>
    </c:otherwise>
</c:choose>
