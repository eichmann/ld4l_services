<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L Catalog Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>Catalog Person: ${param.givenname} ${param.familyname}</h2>

<sparql:setEndpoint var="ld4l" sparqlURL="${param.catalog}">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="${mode}">
    <c:choose>
     <c:when test="${ not empty param.givenname and empty param.surname }">
         SELECT DISTINCT ?s ?p WHERE {
			?s rdf:type foaf:Person.
			?s rdfs:label ?givenname.
			?s mads:isIdentifiedByAuthority ?object.
			?object mads:authoritativeLabel ?p
        }
        <sparql:parameter var="givenname" value="${param.givenname}"/>
    </c:when>
    <c:when test="${ empty param.givenname and not empty param.surname }">
         SELECT DISTINCT ?s ?p WHERE {
			?s rdf:type foaf:Person.
			?s rdfs:label ?surname.
			?s mads:isIdentifiedByAuthority ?object.
			?object mads:authoritativeLabel ?p
        }
        <sparql:parameter var="surname" value="${param.surname}"/>
    </c:when>
    
    <c:when test="${ not empty param.givenname and not empty param.familyname }">
        SELECT DISTINCT ?s ?p WHERE {
	        {
				?s rdf:type foaf:Person.
				?s rdfs:label ?name.
				?s mads:isIdentifiedByAuthority ?object.
				?object mads:authoritativeLabel ?p
	        }
        UNION 
	        {
				?s rdf:type foaf:Person.
				?s rdfs:label ?sortname.
				?s mads:isIdentifiedByAuthority ?object.
				?object mads:authoritativeLabel ?p
	        }
        }
        <sparql:parameter var="givenname" value="${param.givenname}"/>
        <sparql:parameter var="familyName" value="${param.familyname}"/>
        <sparql:parameter var="name" value="${param.givenname} ${param.familyname}"/>
        <sparql:parameter var="sortname" value="${param.familyname}, ${param.givenname}"/>
    </c:when>
    </c:choose>
 </sparql:query>

        <table border=1>
        <thead><tr><td>Person</td><td>URI</td></tr></thead>
        <tbody>
        <c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
            <tr><td>${row.p}</td><td>${row.s}</td></tr>
        </c:forEach>
        </tbody>
        </table>

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

