<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<c:choose>
	<c:when test="${param.entity == 'Person'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/rwo_persons" />
	</c:when>
	<c:when test="${param.entity == 'Organization'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/rwo_organizations" />
	</c:when>
	<c:when test="${param.entity == 'Work'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/rwo_titles" />
	</c:when>
	<c:when test="${param.entity == 'Family'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/rwo_family" />
	</c:when>
	<c:when test="${param.entity == 'Geographic'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/rwo_geographic" />
	</c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/rwo" />
	</c:otherwise>
</c:choose>

<c:set var="offset" value="0"/>
<c:set var="exact_match" value=""/>

<lucene:search lucenePath="${LuceneIndex}" label="name" queryParserName="ld4l" useExactMatch="true" queryString="${param.query}">
    <lucene:searchIterator limitCriteria="1">
        <c:set var="offset" value="${offset + 1}"/>
        <c:set var="exact_match"><lucene:hit label="uri" /></c:set>
<<lucene:hit label="uri" />> <http://vivoweb.org/ontology/core#rank> "${offset}" .
<lucene:hit label="payload" />
    </lucene:searchIterator>
</lucene:search>

<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="ld4l" queryString="${param.query}" >
<http://ld4l.org/ld4l_services/cache> <http://vivoweb.org/ontology/core#count> "<lucene:count/>" .
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
		<c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test="${uri != exact_match}">
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank />" .
<lucene:hit label="payload" />
		</c:if>
	</lucene:searchIterator>
</lucene:search>
