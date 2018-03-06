<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<c:choose>
	<c:when test="${param.entity == 'A'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/geonames/A" />
	</c:when>
	<c:when test="${param.entity == 'H'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/geonames/H" />
	</c:when>
	<c:when test="${param.entity == 'L'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/geonames/L" />
	</c:when>
	<c:when test="${param.entity == 'AP'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/geonames/AP" />
	</c:when>
    <c:when test="${param.entity == 'all'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/geonames/feature" />
    </c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/geonames/feature" />
	</c:otherwise>
</c:choose>


<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="boolean" queryString="${param.query}">
	<lucene:searchIterator limitCriteria="${param.maxRecords}" startCriteria="${param.startRecord}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
	   <jsp:include page="geonames_lookup.jsp">
	       <jsp:param value="${uri}" name="uri"/>
	   </jsp:include>
	</lucene:searchIterator>
</lucene:search>
