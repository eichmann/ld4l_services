<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L DBpedia Reconciliation Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>DBpedia Entity ${param.entity}: ${param.name}</h2>

<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/dbpedia/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="vivo" baseURI="http://vivoweb.org/ontology/core#"/>
</sparql:setEndpoint>

<sparql:query var="person" endpoint="${ld4l}" resultType="${mode}">
    SELECT ?s ?p ?o WHERE {
        ?s ?p ?o .
        ?s rdf:type ?entity.
        ?s <http://xmlns.com/foaf/0.1/name> ?name@en .
    }
    <sparql:parameter var="entity" value="http://xmlns.com/foaf/0.1/${param.entity}" type="iri"/>
    <sparql:parameter var="name" value="${param.name}"/>
 </sparql:query>

        <table border=1>
        <thead><tr><td>Subject</td><td>Predicate</td><td>Object</td></tr></thead>
        <tbody>
        <c:forEach items="${person.rows}" var="row" varStatus="rowCounter">
            <tr><td>${row.s}</td><td>${row.p}</td><td>${row.o}</td></tr>
        </c:forEach>
        </tbody>
        </table>

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

