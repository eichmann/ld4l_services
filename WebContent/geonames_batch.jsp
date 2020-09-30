<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<c:set var="index" value="/usr/local/RAID/LD4L/lucene/geonames" />

<c:choose>
	<c:when test="${param.index == 'strict'}">
		<c:set var="index" value="/usr/local/RAID/LD4L/lucene/geonames_strict" />
	</c:when>
	<c:when test="${param.index == 'extended'}">
		<c:set var="index" value="/usr/local/RAID/LD4L/lucene/geonames" />
	</c:when>
</c:choose>

<c:choose>
	<c:when test="${param.entity == 'A'}">
		<c:set var="lucenePath" value="${index}/A" />
	</c:when>
	<c:when test="${param.entity == 'H'}">
		<c:set var="lucenePath" value="${index}/H" />
	</c:when>
	<c:when test="${param.entity == 'L'}">
		<c:set var="lucenePath" value="${index}/L" />
	</c:when>
	<c:when test="${param.entity == 'P'}">
		<c:set var="lucenePath" value="${index}/P" />
	</c:when>
	<c:when test="${param.entity == 'R'}">
		<c:set var="lucenePath" value="${index}/R" />
	</c:when>
	<c:when test="${param.entity == 'S'}">
		<c:set var="lucenePath" value="${index}/S" />
	</c:when>
	<c:when test="${param.entity == 'T'}">
		<c:set var="lucenePath" value="${index}/T" />
	</c:when>
	<c:when test="${param.entity == 'U'}">
		<c:set var="lucenePath" value="${index}/U" />
	</c:when>
	<c:when test="${param.entity == 'V'}">
		<c:set var="lucenePath" value="${index}/V" />
	</c:when>
	<c:when test="${param.entity == 'AP'}">
		<c:set var="lucenePath" value="${index}/AP" />
	</c:when>
	<c:when test="${param.entity == 'all'}">
		<c:set var="lucenePath" value="${index}/feature" />
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>

<c:set var="offset" value="0"/>
<c:set var="exact_match" value=""/>
<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/geonames/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="literal">
	SELECT ?s WHERE {
		?s rdfs:label ?o@en .
		?s rdf:type <http://www.geonames.org/ontology#Feature> .
	}
	<sparql:parameter var="o" value="${param.query}" type="literal" />
 </sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
	<c:set var="offset" value="${offset + 1}"/>
	<c:set var="exact_match" value="${row.s}"/>
<${row.s}>   <http://vivoweb.org/ontology/core#rank>   "${offset}" .
	   <jsp:include page="geonames_lookup.jsp">
	       <jsp:param value="${row.s}" name="uri"/>
	   </jsp:include>
</c:forEach>

<lucene:search lucenePath="${lucenePath}" label="content" queryParserName="ld4l" queryString="${param.query}">
<http://ld4l.org/ld4l_services/cache> <http://vivoweb.org/ontology/core#count> "<lucene:count/>" .
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test="${uri != exact_match}">
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
<lucene:hit label="payload" />
        </c:if>
	</lucene:searchIterator>
</lucene:search>
