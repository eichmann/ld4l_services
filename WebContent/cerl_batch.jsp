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
		<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/cerl/person" />
		<c:set var="page" value="cerl_person_lookup.jsp" />
	</c:otherwise>
</c:choose>

<c:set var="offset" value="0"/>
<c:set var="exact_match" value=""/>
<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/CERL/sparql">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="schema" baseURI="http://schema.org/"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>
</sparql:setEndpoint>

<c:choose>
	<c:when test="${param.entity == 'Person'}">
		<sparql:query var="result" endpoint="${ld4l}" resultType="literal">
			SELECT ?s WHERE {
				?s <http://rdvocab.info/ElementsGr2/nameOfThePerson> ?o
			}
			<sparql:parameter var="o" value="${param.query}" type="literal" />
 		</sparql:query>
	</c:when>
	<c:when test="${param.entity == 'Corporate'}">
		<sparql:query var="result" endpoint="${ld4l}" resultType="literal">
			SELECT ?s WHERE {
				?s <http://rdvocab.info/ElementsGr2/nameOfTheCorporateBody> ?o
			}
			<sparql:parameter var="o" value="${param.query}" type="literal" />
 		</sparql:query>
	</c:when>
    <c:when test="${param.entity == 'Imprint'}">
		<sparql:query var="result" endpoint="${ld4l}" resultType="literal">
			SELECT ?s WHERE {
				?s <http://www.cerl.org/namespaces/thesaurus/imprintName> ?o
			}
			<sparql:parameter var="o" value="${param.query}" type="literal" />
 		</sparql:query>
    </c:when>
	<c:otherwise>
		<sparql:query var="result" endpoint="${ld4l}" resultType="literal">
			SELECT ?s WHERE {
				?s <http://rdvocab.info/ElementsGr2/nameOfThePerson> ?o
			}
			<sparql:parameter var="o" value="${param.query}" type="literal" />
 		</sparql:query>
	</c:otherwise>
</c:choose>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
	<c:set var="offset" value="${offset + 1}"/>
	<c:set var="exact_match" value="${row.s}"/>
<${row.s}>   <http://vivoweb.org/ontology/core#rank>   "${offset}" .
	<jsp:include page="${page}">
		<jsp:param value="${row.s}" name="uri"/>
	</jsp:include>
</c:forEach>

<lucene:search lucenePath="${LuceneIndex}" label="content" queryParserName="boolean" queryString="${param.query}">
<http://ld4l.org/ld4l_services/cache> <http://vivoweb.org/ontology/core#count> "<lucene:count/>" .
	<lucene:searchIterator limitCriteria="${param.maxRecords - offset}" startCriteria="${param.startRecord}" rankOffset="${offset}">
       <c:set var="uri"><lucene:hit label="uri" /></c:set>
		<c:if test="${uri != exact_match}">
<${uri}> <http://vivoweb.org/ontology/core#rank> "<lucene:hitRank/>" .
	   <jsp:include page="${page}">
	       <jsp:param value="${uri}" name="uri"/>
	   </jsp:include>
	   </c:if>
	</lucene:searchIterator>
</lucene:search>
