<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="${param.catalog}">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="vivo" baseURI="http://vivoweb.org/ontology/core#"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="triple">
    SELECT DISTINCT ?s ?p ?o WHERE {
        {
            ?s ?p ?o .
            ?s rdf:type ?entity.
            ?s <http://xmlns.com/foaf/0.1/name> ?name@en .
        }
    UNION
        {
            ?s ?p ?o .
            ?s rdf:type ?entity.
            ?s <http://schema.org/name> ?name@en .
        }
    } ORDER BY ?s ?p ?o
    <sparql:parameter var="entity" value="${param.entity}" type="iri"/>
    <sparql:parameter var="name" value="${param.name}"/>
 </sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
${row.s} ${row.p} ${row.o} .
</c:forEach>
