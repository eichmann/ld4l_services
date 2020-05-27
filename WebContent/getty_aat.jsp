<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L Getty Services</title>
<style type="text/css" media="all">
    @import "/ld4l_services/resources/style.css";
</style>
</head>
<body>
	<div id="content">
	   <jsp:include page="/header.jsp" flush="true" />
	   <jsp:include page="/menu.jsp" flush="true">
			<jsp:param name="caller" value="research" />
		</jsp:include>
		<div id="centerCol">
			<h2>Getty AAT Faceted Search</h2>
			<div>
				<div id="searchTerms">
					<form method='POST' action='getty_aat.jsp'>
						<input name="query" value="${param.query}" size=40>
						<input type=submit name=submitButton value=Search><br>
						<fieldset>
							<legend>Result Format?</legend>
							<input type="radio" name="mode" value="triple" <c:if test="${param.mode == 'triple'}">checked</c:if>>Return	a list of triples&nbsp;&nbsp;&nbsp;
							<input type="radio"	name="mode" value="literal"	<c:if test="${param.mode != 'triple'}">checked</c:if>>Display as HTML table
						</fieldset>
						<fieldset>
							<legend>Facet?</legend>
							<sparql:setEndpoint var="ld4l" sparqlURL="http://services.ld4l.org/fuseki/getty_aat/sparql">
								<sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/" />
								<sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/" />
								<sparql:prefix prefix="rdf"	baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#" />
								<sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#" />
								<sparql:prefix prefix="schema" baseURI="http://schema.org/" />
								<sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#" />
							</sparql:setEndpoint>
							<sparql:query var="result" endpoint="${ld4l}" resultType="${mode}">
								select ?s ?sl ?si where {
								  ?s <http://www.w3.org/2004/02/skos/core#prefLabel> ?sl .
					              ?s <http://purl.org/dc/elements/1.1/identifier> ?si .
								  ?s <http://www.w3.org/1999/02/22-rdf-syntax-ns#type>	<http://vocab.getty.edu/ontology#Facet> .
								  FILTER (lang(?sl) = 'en')
								  FILTER NOT EXISTS { ?s <http://vocab.getty.edu/ontology#broader> ?o2 }
								} ORDER BY ?sl
							</sparql:query>
							<c:set var="id" value="${0+1}" />
							<c:forEach items="${result.rows}" var="row"	varStatus="rowCounter">
								<input type="radio" id="${id}" name="facet" value="${row.si}" <c:if test="${param.facet == row.si}">checked</c:if>>	<b>${row.sl}</b><br>
								<c:set var="id" value="${id + 1}" />
								<sparql:query var="result2" endpoint="${ld4l}" resultType="${mode}">
						            select ?m ?ml ?mi where {
						              ?f <http://www.w3.org/2004/02/skos/core#member> ?m .
						              ?m <http://www.w3.org/2004/02/skos/core#prefLabel> ?ml .
						              ?m <http://purl.org/dc/elements/1.1/identifier> ?mi .
						              FILTER (lang(?ml) = 'en')
						            } ORDER BY $ml
                                    <sparql:parameter var="f" value="${row.s}" type="IRI" />
								</sparql:query>
								<c:forEach items="${result2.rows}" var="row2" varStatus="rowCounter2">
                                    &nbsp;&nbsp;&nbsp;<input type="radio" id="${id}" name="facet" value="${row2.mi}" <c:if test="${param.facet == row2.mi}">checked</c:if>>  ${row2.ml}<br>
									<c:set var="id" value="${id + 1}" />
								</c:forEach>
							</c:forEach>
						</fieldset>
					</form>
					ld4l operators include &amp; (and), | (or) and ! (not).
					Parentheses can be used to group terms.
				</div>
				<div id="searchResults">
					<c:if test="${not empty param.query}">
						<c:set var="filteredQuery" value="${param.query}"/>
						<c:if test="${not empty param.facet}">
                            <c:set var="filteredQuery" value="${param.query} AAT${param.facet}"/>
						</c:if>
                        <h3>Search Results: <c:out value="${filteredQuery}" /></h3>
						<lucene:search
							lucenePath="/usr/local/RAID/LD4L/lucene/getty/aat_facets"
							label="content" queryParserName="ld4l"
							useConjunctionByDefault="true"
							queryString="${filteredQuery}">
							<p>
								Result Count: <lucene:count />
							</p>
							<ol class="bulletedList">
								<lucene:searchIterator>
									<c:choose>
										<c:when test="${param.mode == 'triple'}">
											<li><a href="getty_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="title" />"><lucene:hit label="title" /></a></li>
										</c:when>
										<c:otherwise>
											<li><a href="getty_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="title" />"><lucene:hit label="title" /></a></li>
										</c:otherwise>
									</c:choose>
								</lucene:searchIterator>
							</ol>
						</lucene:search>
					</c:if>
				</div>
			</div>
			<div id="footerDiv">
				<jsp:include page="/footer.jsp" flush="true" />
			</div>
		</div>
	</div>
</body>
</html>

