<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<c:choose>
	<c:when test="${param.entity == 'Work'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/share_vde/${param.site}/work" />
	</c:when>
	<c:when test="${param.entity == 'SuperWork'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/share_vde/${param.site}/superwork" />
	</c:when>
	<c:when test="${param.entity == 'Instance'}">
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/share_vde/${param.site}/instance" />
	</c:when>
	<c:otherwise>
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/share_vde/${param.site}/work" />
	</c:otherwise>
</c:choose>

<c:set var="offset" value="0"/>
<c:set var="exact_match" value=""/>
<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/share_vde_${param.site}/sparql">
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="literal">
	SELECT ?s WHERE {
		?s <http://id.loc.gov/ontologies/bibframe/title> ?o .
		?o <http://www.w3.org/2000/01/rdf-schema#label> ?title .
	}
	<sparql:parameter var="title" value="${param.query}" type="literal" />
 </sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
	<c:set var="offset" value="${offset + 1}"/>
	<c:set var="exact_match" value="${row.s}"/>
<${row.s}>   <http://vivoweb.org/ontology/core#rank>   "${offset}" .
	<jsp:include page="lookup.jsp">
		<jsp:param value="${row.s}" name="uri"/>
	</jsp:include>
</c:forEach>

<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="boolean" queryString="${param.query}" useConjunctionByDefault="true" useDateHack="true" >
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test="${uri != exact_match}">
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
	   		<jsp:include page="lookup.jsp">
	     		<jsp:param value="${uri}" name="uri"/>
	   		</jsp:include>
	   </c:if>
	</lucene:searchIterator>
</lucene:search>

<jsp:include page="emit.jsp"/>
