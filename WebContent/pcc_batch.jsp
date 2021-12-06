<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${param.entity == 'Work'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/pcc/pcc_Work" />
	</c:when>
	<c:when test="${param.entity == 'Opus'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/pcc/pcc_Opus" />
	</c:when>
	<c:when test="${param.entity == 'Instance'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/pcc/pcc_Instance" />
	</c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/pcc/pcc" />
	</c:otherwise>
</c:choose>

<jsp:include page="lucene_search.jsp">
    <jsp:param value="${LuceneIndex}" name="LuceneIndex"/>
    <jsp:param value="false" name="stemming"/>
</jsp:include>
