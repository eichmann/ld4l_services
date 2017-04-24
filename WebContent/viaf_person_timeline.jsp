<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L VIAF Reconciliation Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>VIAF Person: ${param.givenname} ${param.familyname}</h2>

<sparql:setEndpoint var="ld4l" sparqlURL="http://guardian.slis.uiowa.edu:3030/viaf/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="${mode}">
    <c:choose>
    <c:when test="${ not empty param.givenname and empty param.familyname }">
	    SELECT DISTINCT ?s ?n ?b ?d ?as ?ae WHERE {
	       {
	           ?s rdf:type schema:Person .
	           ?s schema:name ?n .
               ?s schema:givenName ?givenname .
               FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
       			FILTER (langMatches(lang(?givenname), "en") || LANG(?givenname="")).
               OPTIONAL { ?s schema:birthDate ?b } .
               OPTIONAL { ?s schema:deathDate ?d } .
               OPTIONAL { ?s schema:activeYearsStartYear ?as } .
               OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
          
	       }
	    UNION
	       {
               ?s rdf:type schema:Person .
               ?s schema:name ?n .
               ?s schema:givenName ?givenname@en .
               OPTIONAL { ?s schema:birthDate ?b } .
               OPTIONAL { ?s schema:deathDate ?d } .
               OPTIONAL { ?s schema:activeYearsStartYear ?as } .
               OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
               FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
               FILTER (langMatches(lang(?givenname), "en") || LANG(?givenname="")).
	       }
	    } group by ?s
        <sparql:parameter var="givenname" value="${param.givenname}"/>
    </c:when>
    <c:when test="${ empty param.givenname and not empty param.familyname }">
        SELECT DISTINCT ?s ?n ?b ?d ?as ?ae WHERE {
           {
               ?s rdf:type schema:Person.
               ?s schema:name ?n .
               ?s schema:familyName ?familyName .
               OPTIONAL { ?s schema:birthDate ?b } .
               OPTIONAL { ?s schema:deathDate ?d } .
               OPTIONAL { ?s schema:activeYearsStartYear ?as } .
               OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
               FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
               FILTER (langMatches(lang(?familyName), "en") || LANG(?familyName="")).
           }
        UNION
           {
               ?s rdf:type schema:Person.
               ?s schema:name ?n .
               ?s schema:familyName ?familyName@en .
               OPTIONAL { ?s schema:birthDate ?b } .
               OPTIONAL { ?s schema:deathDate ?d } .
               OPTIONAL { ?s schema:activeYearsStartYear ?as } .
               OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
           }
           
        }
        <sparql:parameter var="familyName" value="${param.familyname}"/>
    </c:when>
    <c:when test="${ not empty param.givenname and not empty param.familyname }">
        SELECT DISTINCT ?s ?authname ?b ?d ?as ?ae WHERE {
            {
                ?s rdf:type schema:Person .
               ?s schema:name ?n .
                ?s schema:name ?name .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
                FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
               	FILTER (langMatches(lang(?givenname), "en") || LANG(?givenname="")).
               	FILTER (langMatches(lang(?familyName), "en") || LANG(?familyName="")).
               	BIND(STR(?n) AS ?authname).
               
            }
        UNION
            {
                ?s rdf:type schema:Person .
               ?s schema:name ?n .
                ?s schema:name ?name@en .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
                FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
                BIND(STR(?n) AS ?authname).
               
            }
        UNION
            {
                ?s rdf:type schema:Person .
               ?s schema:name ?n .
                ?s schema:name ?sortname .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
                FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
               	FILTER (langMatches(lang(?sortname), "en") || LANG(?sortname="")).
               	BIND(STR(?n) AS ?authname).
               	
            } 
        UNION
            {
                ?s rdf:type schema:Person .
               ?s schema:name ?n .
                ?s schema:name ?sortname@en .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
                FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
                BIND(STR(?n) AS ?authname).
               	
            } 
        UNION
            {
                ?s rdf:type schema:Person .
                ?s schema:name ?n .
                ?s schema:givenName ?givenname .
                ?s schema:familyName ?familyName .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
                FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
               	FILTER (langMatches(lang(?givenname), "en") || LANG(?givenname="")).
               	FILTER (langMatches(lang(?familyName), "en") || LANG(?familyName="")).
               	BIND(STR(?n) AS ?authname).
               	
            }
        UNION
            {
                ?s rdf:type schema:Person .
                ?s schema:name ?n .
                ?s schema:givenName ?givenname@en .
                ?s schema:familyName ?familyName@en .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
                FILTER (langMatches(lang(?n), "en") || LANG(?n="")).
                BIND(STR(?n) AS ?authname).
               
            }
<c:if test="${ not empty param.alternatename }">
       UNION
             {
                ?s rdf:type schema:Person .
                ?s schema:name ?n .
                ?s schema:alternateName ?name .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
            }
        UNION
            {
                ?s rdf:type schema:Person .
                ?s schema:name ?n .
                ?s schema:alternateName ?name@en .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
            }
        UNION
            {
                ?s rdf:type schema:Person .
               ?s schema:name ?n .
                ?s schema:alternateName ?sortname .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
            } 
        UNION
            {
                ?s rdf:type schema:Person .
               ?s schema:name ?n .
                ?s schema:alternateName ?sortname@en .
                OPTIONAL { ?s schema:birthDate ?b } .
                OPTIONAL { ?s schema:deathDate ?d } .
                OPTIONAL { ?s schema:activeYearsStartYear ?as } .
                OPTIONAL { ?s schema:activeYearsEndYear ?ae } .
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

        <table border=1>
        <thead><tr><td>Subject</td><td>Name</td><td>Birth Date</td><td>Death Date</td><td>Active Start</td><td>Active End</td></tr></thead>
        <tbody>
        <c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
            <tr><td><a href="/ld4l_services/viaf_person_doi_browse.jsp?doi=${row.s}&order=altname+?date">${row.s}</a></td><td>${row.authname}</td><td>${row.b}</td><td>${row.d}</td><td>${row.as}</td><td>${row.ae}</td></tr>
        </c:forEach>
        </tbody>
        </table>

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

