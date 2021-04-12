<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${param.entity == 'Person'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_Person" />
	</c:when>
	<c:when test="${param.entity == 'Organization'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_Organization" />
	</c:when>
    <c:when test="${param.entity == 'Intangible'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_Intangible" />
    </c:when>
    <c:when test="${param.entity == 'Place'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_Place" />
    </c:when>
    <c:when test="${param.entity == 'Work'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_CreativeWork" />
    </c:when>
    <c:when test="${param.entity == 'GeoCoordinates'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_GeoCoordinates" />
    </c:when>
    <c:when test="${param.entity == 'Concept'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_facet-Topical" />
    </c:when>
    <c:when test="${param.entity == 'Genre'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_facet-FormGenre" />
    </c:when>
    <c:when test="${param.entity == 'Event'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_event_meeting" />
    </c:when>
    <c:when test="${param.entity == 'Meeting'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast_event_meeting" />
    </c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/fast/fast" />
	</c:otherwise>
</c:choose>

<jsp:include page="lucene_search.jsp">
    <jsp:param value="${LuceneIndex}" name="LuceneIndex"/>
    <jsp:param value="true" name="stemming"/>
</jsp:include>
