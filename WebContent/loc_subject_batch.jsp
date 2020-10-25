<%@ page language="java" contentType="application/n-triples; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/subjects" />

<jsp:include page="lucene_search.jsp">
    <jsp:param value="${LuceneIndex}" name="LuceneIndex"/>
    <jsp:param value="true" name="stemming"/>
</jsp:include>
