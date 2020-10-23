<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<c:choose>
	<c:when test="${param.entity == 'Person'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/person" />
		<c:set var="page" value="cerl_person_lookup.jsp" />
	</c:when>
	<c:when test="${param.entity == 'Corporate'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/corporate" />
		<c:set var="page" value="cerl_corporate_lookup.jsp" />
	</c:when>
    <c:when test="${param.entity == 'Imprint'}">
        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/imprint" />
		<c:set var="page" value="cerl_imprint_lookup.jsp" />
    </c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/merged" />
		<c:set var="page" value="cerl_lookup.jsp" />
	</c:otherwise>
</c:choose>

<jsp:include page="lucene_search.jsp">
	<jsp:param value="${LuceneIndex}" name="LuceneIndex"/>
</jsp:include>
