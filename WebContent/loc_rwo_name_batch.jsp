<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<c:choose>
	<c:when test="${param.entity == 'Person'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/locRWO/persons" />
	</c:when>
	<c:when test="${param.entity == 'Organization'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/locRWO/organizations" />
	</c:when>
	<c:when test="${param.entity == 'Work'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/locRWO/titles" />
	</c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/locRWO/names" />
	</c:otherwise>
</c:choose>

<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="boolean" queryString="${param.query}" useConjunctionByDefault="true" useDateHack="true" >
	<lucene:searchIterator limitCriteria="${param.maxRecords}" startCriteria="${param.startRecord}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
	   <jsp:include page="loc_rwo_name_lookup.jsp">
	       <jsp:param value="${uri}" name="uri"/>
	   </jsp:include>
	</lucene:searchIterator>
</lucene:search>
