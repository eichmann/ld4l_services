<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<c:set var="offset" value="0"/>
<util:hashTable cacheName="matches">

<lucene:search lucenePath="${param.LuceneIndex}" label="name" queryParserName="ld4l" useExactMatch="true" queryString="${param.query}">
    <lucene:searchIterator limitCriteria="1">
        <c:set var="offset" value="${offset + 1}"/>
        <c:set var="exact_match"><lucene:hit label="uri" /></c:set>
        <util:hashEntry key="${exact_match}"/>
<<lucene:hit label="uri" />> <http://vivoweb.org/ontology/core#rank> "${offset}" .
<lucene:hit label="payload" />
    </lucene:searchIterator>
</lucene:search>

<lucene:search lucenePath="${param.LuceneIndex}" label="name_lower" queryParserName="ld4l" useExactMatch="true" caseSensitive="false" queryString="${param.query}">
    <lucene:searchIterator limitCriteria="1">
        <c:set var="exact_match"><lucene:hit label="uri" /></c:set>
		<c:if test='${!util:keyExists(pageContext, "matches", uri)}'>
	        <c:set var="offset" value="${offset + 1}"/>
    	    <util:hashEntry key="${exact_match}"/>
<<lucene:hit label="uri" />> <http://vivoweb.org/ontology/core#rank> "${offset}" .
<lucene:hit label="payload" />
		</c:if>
    </lucene:searchIterator>
</lucene:search>

<lucene:search lucenePath="${param.LuceneIndex}" label="prefcontent" queryParserName="ld4l" useStemming="${param.stemming}" queryString="${param.query}">
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test='${!util:keyExists(pageContext, "matches", uri)}'>
	        <c:set var="offset" value="${offset + 1}"/>
	        <util:hashEntry key="${uri}"/>
<${uri}> <http://vivoweb.org/ontology/core#rank> "${offset}" .
<lucene:hit label="payload" />
        </c:if>
	</lucene:searchIterator>
</lucene:search>

<lucene:search lucenePath="${param.LuceneIndex}" label="content" queryParserName="ld4l" useStemming="${param.stemming}" queryString="${param.query}">
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test='${!util:keyExists(pageContext, "matches", uri)}'>
	        <c:set var="offset" value="${offset + 1}"/>
	        <util:hashEntry key="${uri}"/>
<${uri}> <http://vivoweb.org/ontology/core#rank> "${offset}" .
<lucene:hit label="payload" />
        </c:if>
	</lucene:searchIterator>
</lucene:search>

<lucene:search lucenePath="${param.LuceneIndex}" label="content" queryParserName="ld4l" useStemming="${param.stemming}" defaultOperator="OR" queryString="${param.query}">
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test='${!util:keyExists(pageContext, "matches", uri)}'>
	        <c:set var="offset" value="${offset + 1}"/>
<${uri}> <http://vivoweb.org/ontology/core#rank> "${offset}" .
<lucene:hit label="payload" />
        </c:if>
	</lucene:searchIterator>
</lucene:search>

<http://ld4l.org/ld4l_services/cache> <http://vivoweb.org/ontology/core#count> "${offset}" .
</util:hashTable>
