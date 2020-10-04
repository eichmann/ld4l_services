<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<c:choose>
	<c:when test="${not empty param.entity}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/vocab/vocab_${param.entity}" />
	</c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/vocab/vocab" />
	</c:otherwise>
</c:choose>

<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="ld4l" queryString="${param.query}" useStemming="true" >
<http://ld4l.org/ld4l_services/cache> <http://vivoweb.org/ontology/core#count> "<lucene:count/>" .
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
<lucene:hit label="payload" />
	</lucene:searchIterator>
</lucene:search>
