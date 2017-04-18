<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<sparql:setEndpoint var="ld4l" sparqlURL="${param.catalog}">
    <sparql:prefix prefix="foaf" baseURI="http://xmlns.com/foaf/0.1/"/>
    <sparql:prefix prefix="bibo" baseURI="http://purl.org/ontology/bibo/"/>
    <sparql:prefix prefix="rdf"  baseURI="http://www.w3.org/1999/02/22-rdf-syntax-ns#"/>
    <sparql:prefix prefix="rdfs" baseURI="http://www.w3.org/2000/01/rdf-schema#"/>
    <sparql:prefix prefix="vivo" baseURI="http://vivoweb.org/ontology/core#"/>
    <sparql:prefix prefix="mads" baseURI="http://www.loc.gov/mads/rdf/v1#"/>    
</sparql:setEndpoint>

<%-- <sparql:query var="result" endpoint="${ld4l}" resultType="triple">
    SELECT DISTINCT ?work ?title WHERE {
    	{
			?work rdf:type bib:Work . 
			?work bib:hasTitle ?x . 
			?x rdfs:label ?name . 
		}
    UNION
            {
            ?s ?p ?o .
            ?s rdf:type ?x.
            ?x <http://xmlns.com/foaf/0.1/name> ?name@en .
        }
    UNION
        {
            ?s ?p ?o .
            ?s rdf:type ?x.
            ?x <http://schema.org/name> ?name@en .
        }
    } ORDER BY ?s ?p ?o
 
    <sparql:parameter var="name" value="${param.work}"/>
 </sparql:query> --%>


<sparql:query var="result" endpoint="${ld4l}" resultType="${mode}">
	SELECT DISTINCT ?o ?p WHERE {
			?uri rdf:type mads:Authority .
		    ?uri rdfs:label ?name. 
			?uri mads:isIdentifiedByAuthority ?o.
			?o mads:authoritativeLabel ?p
		} 
    
    <sparql:parameter var="name" value="${param.work}"/>
 </sparql:query>
<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
${row.p} ${row.o} .
</c:forEach>
