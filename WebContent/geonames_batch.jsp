<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
		<c:set var="lucenePath" value="${index}/geonames_A" />
	</c:when>
	<c:when test="${param.entity == 'H'}">
		<c:set var="lucenePath" value="${index}/geonames_H" />
	</c:when>
	<c:when test="${param.entity == 'L'}">
		<c:set var="lucenePath" value="${index}/geonames_L" />
	</c:when>
	<c:when test="${param.entity == 'P'}">
		<c:set var="lucenePath" value="${index}/geonames_P" />
	</c:when>
	<c:when test="${param.entity == 'R'}">
		<c:set var="lucenePath" value="${index}/geonames_R" />
	</c:when>
	<c:when test="${param.entity == 'S'}">
		<c:set var="lucenePath" value="${index}/geonames_S" />
	</c:when>
	<c:when test="${param.entity == 'T'}">
		<c:set var="lucenePath" value="${index}/geonames_T" />
	</c:when>
	<c:when test="${param.entity == 'U'}">
		<c:set var="lucenePath" value="${index}/geonames_U" />
	</c:when>
	<c:when test="${param.entity == 'V'}">
		<c:set var="lucenePath" value="${index}/geonames_V" />
	</c:when>
	<c:when test="${param.entity == 'AP'}">
		<c:set var="lucenePath" value="${index}/geonames_AP" />
	</c:when>
	<c:when test="${param.entity == 'all'}">
		<c:set var="lucenePath" value="${index}/geonames" />
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>

<jsp:include page="lucene_search.jsp">
    <jsp:param value="${lucenePath}" name="LuceneIndex"/>
    <jsp:param value="true" name="stemming"/>
</jsp:include>
