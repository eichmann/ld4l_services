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
<h2>DBpedia Person: ${param.doi}</h2>

<sparql:setEndpoint var="ld4l" sparqlURL="http://guardian.slis.uiowa.edu:3030/dbpedia/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="vivo" baseURI="http://vivoweb.org/ontology/core#"/>
    <sparql:prefix prefix="dbp" baseURI="http://dbpedia.org/property/"/>
    <sparql:prefix prefix="dbo" baseURI="http://dbpedia.org/ontology/"/>
    
    
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="${mode}">
    <c:choose>
    <c:when test="${ not empty param.doi }">
    
	    SELECT ?book ?name ?date ?au
			WHERE {
			  ?book rdf:type dbo:Book .
			  ?book dbp:releaseDate ?date.
			  ?book dbp:author ?doi.
			  ?doi foaf:name ?au.
			  ?book dbp:name ?name.
			} ORDER by ?name
	    <sparql:parameter var="doi" value="${param.doi}" type='iri'/>
    </c:when>

    </c:choose>
 </sparql:query>

        <table border=1>
        <thead><tr><td>Author</td><td>Book</td><td>Publication Date</td></tr></thead>
        <tbody>
        <c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
            <tr><td>${row.au}</td><td><a href="${row.book}">${row.name}</a></td><td>${row.date}</td></tr>
        </c:forEach>
        </tbody>
        </table>

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

