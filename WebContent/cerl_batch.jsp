<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:choose>
	<c:when test="${param.entity == 'Person'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/cerl_person" />
	</c:when>
	<c:when test="${param.entity == 'Corporate'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/cerl_corporate" />
	</c:when>
    <c:when test="${param.entity == 'Imprint'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/cerl_imprint" />
    </c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/cerl" />
	</c:otherwise>
</c:choose>

<jsp:include page="lucene_search.jsp">
	<jsp:param value="${LuceneIndex}" name="LuceneIndex"/>
    <jsp:param value="false" name="stemming"/>
</jsp:include>
