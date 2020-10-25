<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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

<jsp:include page="lucene_search.jsp">
    <jsp:param value="${LuceneIndex}" name="LuceneIndex"/>
    <jsp:param value="false" name="stemming"/>
</jsp:include>
