<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

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

<lucene:search lucenePath="${lucenePath}" label="content" queryParserName="boolean" queryString="${param.query}">
	<lucene:searchIterator limitCriteria="${param.maxRecords}" startCriteria="${param.startRecord}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
	   <jsp:include page="geonames_lookup.jsp">
	       <jsp:param value="${uri}" name="uri"/>
	   </jsp:include>
	</lucene:searchIterator>
</lucene:search>
