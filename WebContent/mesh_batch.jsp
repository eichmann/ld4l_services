<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<lucene:search lucenePath="/usr/local/RAID/LD4L/lucene/mesh" label="content" queryParserName="boolean" queryString="${param.query}">
	<lucene:searchIterator limitCriteria="${param.maxRecords}" startCriteria="${param.startRecord}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
	   <jsp:include page="mesh_lookup.jsp">
	       <jsp:param value="${uri}" name="uri"/>
	   </jsp:include>
	</lucene:searchIterator>
</lucene:search>
