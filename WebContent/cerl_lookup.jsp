<%@ page language="java" contentType="application/n-triples; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sparql" uri="http://slis.uiowa.edu/SPARQL"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:choose>
	<c:when test="${fn:contains(param.uri, '/cnp')}">
		<%@ include file="cerl_person_query.jsp" %>
	</c:when>
	<c:when test="${fn:contains(param.uri, '/cnc')}">
		<%@ include file="cerl_corporate_query.jsp" %>
	</c:when>
	<c:when test="${fn:contains(param.uri, '/cni')}">
		<%@ include file="cerl_imprint_query.jsp" %>
	</c:when>
	<c:otherwise>
		<%@ include file="cerl_person_query.jsp" %>
	</c:otherwise>
</c:choose>

<jsp:include page="emit_graph.jsp"/>
