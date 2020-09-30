<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<c:choose>
	<c:when test="${param.entity == 'Person Organization'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/getty_ulan" />
	</c:when>
	<c:when test="${param.entity == 'Person'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/getty_ulan_person" />
	</c:when>
	<c:when test="${param.entity == 'Organization'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/getty_ulan_organization" />
	</c:when>
	<c:when test="${param.entity == 'Place'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/getty_tgn" />
	</c:when>
	<c:when test="${param.entity == 'Concept'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/getty_aat" />
	</c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/getty" />
	</c:otherwise>
</c:choose>

<c:set var="real_query" value="${param.query}"/>
<c:if test="${not empty param.facet}">
	<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/aat_facets" />
	<c:set var="real_query" value="${param.query} AAT${param.facet}" />
</c:if>

<c:set var="offset" value="0"/>
<c:set var="exact_match" value=""/>
<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/getty_all/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="literal">
	SELECT ?s WHERE {
		?s <http://www.w3.org/2004/02/skos/core#prefLabel> ?o@en .
		?s rdf:type <http://vocab.getty.edu/ontology#Subject> .
	}
	<sparql:parameter var="o" value="${param.query}" type="literal" />
 </sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
	<c:set var="offset" value="${offset + 1}"/>
	<c:set var="exact_match" value="${row.s}"/>
<${row.s}>   <http://vivoweb.org/ontology/core#rank>   "${offset}" .
	   <jsp:include page="getty_lookup.jsp">
	       <jsp:param value="${row.s}" name="uri"/>
	   </jsp:include>
</c:forEach>

<lucene:search
    lucenePath="${LuceneIndex}"
    useConjunctionByDefault="true"
    label="content"
    queryParserName="ld4l"
    queryString="${real_query}">
<http://ld4l.org/ld4l_services/cache> <http://vivoweb.org/ontology/core#count> "<lucene:count/>" .
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test="${uri != exact_match}">
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
<lucene:hit label="payload" />
        </c:if>
	</lucene:searchIterator>
</lucene:search>
