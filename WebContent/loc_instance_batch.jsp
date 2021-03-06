<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/instance" />

<c:set var="rewrittenQuery" value="${fn:replace(param.query,'(', ' ')}"/>
<c:set var="rewrittenQuery" value="${fn:replace(rewrittenQuery,')', ' ')}"/>
<c:set var="rewrittenQuery" value="${fn:replace(rewrittenQuery,'-', ' ')}"/>

<c:set var="offset" value="0"/>
<c:set var="exact_match" value=""/>
<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/loc_works_instances/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<sparql:query var="result" endpoint="${ld4l}" resultType="literal">
	SELECT ?s WHERE {
		?s rdfs:label ?o .
		?s rdf:type <http://id.loc.gov/ontologies/bibframe/Instance> .
	}
	<sparql:parameter var="o" value="${param.query}" type="literal" />
 </sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
	<c:set var="offset" value="${offset + 1}"/>
	<c:set var="exact_match" value="${row.s}"/>
<${row.s}>   <http://vivoweb.org/ontology/core#rank>   "${offset}" .
        <c:if test="${empty param.context}">
            <jsp:include page="loc_instance_lookup.jsp">
                <jsp:param value="${row.s}" name="uri"/>
            </jsp:include>
        </c:if>
        <c:if test="${not empty param.context}">
            <jsp:include page="loc_instance_context.jsp">
                <jsp:param value="${row.s}" name="uri"/>
            </jsp:include>
        </c:if>
</c:forEach>

<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="ld4l" useConjunctionByDefault="true" queryString="${rewrittenQuery}" >
<http://ld4l.org/ld4l_services/cache> <http://vivoweb.org/ontology/core#count> "<lucene:count/>" .
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test="${uri != exact_match}">
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
        <c:if test="${empty param.context}">
<${uri}> <http://www.w3.org/2000/01/rdf-schema#label> "<lucene:hit label="name" />" .
        </c:if>
        <c:if test="${not empty param.context}">
<lucene:hit label="payload" />
        </c:if>
        </c:if>
	</lucene:searchIterator>
</lucene:search>
