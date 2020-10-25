<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${param.entity == 'Subject'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/mesh/subject" />
	</c:when>
	<c:when test="${param.entity == 'FormOfWork'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/mesh/form" />
	</c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/mesh/mesh" />
	</c:otherwise>
</c:choose>

<jsp:include page="lucene_search.jsp">
    <jsp:param value="${LuceneIndex}" name="LuceneIndex"/>
    <jsp:param value="true" name="stemming"/>
</jsp:include>
