<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<c:choose>
	<c:when test="${param.entity == 'Person Organization'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/ulan" />
	</c:when>
	<c:when test="${param.entity == 'Person'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/ulan_person" />
	</c:when>
	<c:when test="${param.entity == 'Organization'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/ulan_organization" />
	</c:when>
	<c:when test="${param.entity == 'Place'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/tgn" />
	</c:when>
	<c:when test="${param.entity == 'Concept'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/aat" />
	</c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/getty/ulan_person" />
	</c:otherwise>
</c:choose>

<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="boolean" queryString="${param.query}">
	<lucene:searchIterator limitCriteria="${param.maxRecords}" startCriteria="${param.startRecord}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
	   <jsp:include page="getty_lookup.jsp">
	       <jsp:param value="${uri}" name="uri"/>
	   </jsp:include>
	</lucene:searchIterator>
</lucene:search>
