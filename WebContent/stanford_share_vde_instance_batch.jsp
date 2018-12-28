<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/stanford_share_vde/instance" />

<c:set var="rewrittenQuery" value="${fn:replace(param.query,'(', ' ')}"/>
<c:set var="rewrittenQuery" value="${fn:replace(rewrittenQuery,')', ' ')}"/>
<c:set var="rewrittenQuery" value="${fn:replace(rewrittenQuery,'-', ' ')}"/>

<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="boolean" useConjunctionByDefault="true" queryString="${rewrittenQuery}">
	<lucene:searchIterator limitCriteria="${param.maxRecords}" startCriteria="${param.startRecord}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
        <c:if test="${empty param.context}">
            <jsp:include page="stanford_share_vde_instance_lookup.jsp">
                <jsp:param value="${uri}" name="uri"/>
            </jsp:include>
        </c:if>
        <c:if test="${not empty param.context}">
            <jsp:include page="stanford_share_vde_instance_context.jsp">
                <jsp:param value="${uri}" name="uri"/>
            </jsp:include>
        </c:if>
	</lucene:searchIterator>
</lucene:search>
