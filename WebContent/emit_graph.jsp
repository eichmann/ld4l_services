<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>

<sparql:query var="result" graph="${graph}" resultType="triple">
    SELECT ?s ?p ?o WHERE {
      ?s ?p ?o .
    } ORDER BY ?s ?p
</sparql:query>

<c:forEach items="${result.rows}" var="row" varStatus="rowCounter">
${row.s} ${row.p} ${row.o} .
</c:forEach>
