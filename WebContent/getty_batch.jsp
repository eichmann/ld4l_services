<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<jsp:include page="lucene_search.jsp">
    <jsp:param value="${LuceneIndex}" name="LuceneIndex"/>
    <jsp:param value="true" name="stemming"/>
</jsp:include>
