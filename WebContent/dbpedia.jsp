<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L DBpedia Reconciliation Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>DBpedia Search by foaf Entity</h2>

<form method='POST' action='dbpedia.jsp'>
    <table border="0">
        <tr>
            <td>
                <fieldset><legend>Result Format?</legend>
                    <input type="radio" name="mode" value="triple">Return a list of triples&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="mode" value="literal" checked>Display as HTML table
               </fieldset>
            </td>
            <td>
                <fieldset><legend>Ontology class?</legend>
                    <input type="radio" name="entity" value="Person" <c:if test="${param.entity == 'Person' or empty param.entity}">checked</c:if>>Person&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="entity" value="Organization" <c:if test="${param.entity == 'Organization'}">checked</c:if>>Organization&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="entity" value="Work" <c:if test="${param.entity == 'Work'}">checked</c:if>>Work&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="entity" value="Place" <c:if test="${param.entity == 'Place'}">checked</c:if>>Place
                </fieldset>
            </td>
        </tr>
        <tr>
            <td colspan=2>
                <fieldset><legend>Name of Entity?</legend>
                <input name="query" value="${param.query}" size=50> <input type=submit name=submitButton value=Search>
                </fieldset>
            </td>
        </tr>
    </table>
</form>
            <p><hr><p>
            <c:if test="${not empty param.query}">
                <h3>
                    Search Results:
                    <c:out value="${param.query}" />
                </h3>
                <c:choose>
                    <c:when test="${param.entity == 'Person'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/dbpedia/person"/>
                    </c:when>
                    <c:when test="${param.entity == 'Organization'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/dbpedia/organization"/>
                    </c:when>
                    <c:when test="${param.entity == 'Work'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/dbpedia/work"/>
                    </c:when>
                    <c:when test="${param.entity == 'Place'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/dbpedia/place"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/dbpedia/person"/>
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${param.mode == 'triple'}">
                        <lucene:search lucenePath="${LuceneIndex}"
                            label="content" queryParserName="boolean"
                            queryString="${param.query}" useConjunctionByDefault="true" useDateHack="true" >
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                   <li><a href="dbpedia_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                </lucene:searchIterator>
                            </ol>
                        </lucene:search>
                    </c:when>
                    <c:when test="${param.mode == 'literal' or empty param.mode}">
                        <lucene:search lucenePath="${LuceneIndex}"
                            label="content" queryParserName="boolean"
                            queryString="${param.query}" useConjunctionByDefault="true" useDateHack="true" >
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                    <li><a href="dbpedia_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                </lucene:searchIterator>
                            </ol>
                        </lucene:search>
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>
            </c:if>
<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

