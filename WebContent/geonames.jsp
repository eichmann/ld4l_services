<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L GeoNames Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>GeoNames Search</h2>
            <form method='POST' action='geonames.jsp'>
                <input name="query" value="${param.query}" size=50> <input
                    type=submit name=submitButton value=Search><br>
                <fieldset><legend>Result Format?</legend>
                    <input type="radio" name="mode" value="triple" <c:if test="${param.mode == 'triple'}">checked</c:if>>Return a list of triples&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="mode" value="literal" <c:if test="${param.mode != 'triple'}">checked</c:if>>Display as HTML table
               </fieldset>
                <fieldset><legend>Feature Class?</legend>
                <input type="radio" id="1" name="entity" value="A" <c:if test="${param.entity == 'A'}">checked</c:if>>  A - country, state, region, ...
                <input type="radio" id="2" name="entity" value="H" <c:if test="${param.entity == 'H'}">checked</c:if>>  H - stream, lake, ...
                <input type="radio" id="3" name="entity" value="L" <c:if test="${param.entity == 'L'}">checked</c:if>>  L - park, area, ...
                <input type="radio" id="4" name="entity" value="AP" <c:if test="${param.entity == 'AP'}">checked</c:if>>  AP - both A and P data
                <input type="radio" id="5" name="entity" value="all" <c:if test="${param.entity == 'all' or empty param.mode}">checked</c:if>>  All GeoNames data
               </fieldset>
            </form>
            Boolean operators include &amp; (and), | (or) and ! (not).
            Parentheses can be used to group terms.
            <p><hr><p>
            <c:if test="${not empty param.query}">
                <h3>
                    Search Results:
                    <c:out value="${param.query}" />
                </h3>
                <c:set var="index" value="/usr/local/RAID/LD4L/lucene/geonames"/>
                <c:choose>
                    <c:when test="${param.entity == 'A'}">
                        <lucene:search lucenePath="${index}/A"
                            label="content" queryParserName="boolean"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                   <c:choose>
                                        <c:when test="${param.mode == 'triple'}">
                                            <li><a href="geonames_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="geonames_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </lucene:searchIterator>
                            </ol>
                        </lucene:search>
                    </c:when>
                    <c:when test="${param.entity == 'H'}">
                        <lucene:search lucenePath="${index}/H"
                            label="content" queryParserName="boolean"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                   <c:choose>
                                        <c:when test="${param.mode == 'triple'}">
                                            <li><a href="geonames_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="geonames_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </lucene:searchIterator>
                            </ol>
                        </lucene:search>
                    </c:when>
                    <c:when test="${param.entity == 'L'}">
                        <lucene:search lucenePath="${index}/L"
                            label="content" queryParserName="boolean"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                   <c:choose>
                                        <c:when test="${param.mode == 'triple'}">
                                            <li><a href="geonames_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="geonames_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </lucene:searchIterator>
                            </ol>
                        </lucene:search>
                    </c:when>
                    <c:when test="${param.entity == 'AP'}">
                        <lucene:search lucenePath="${index}/AP"
                            label="content" queryParserName="boolean"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                   <c:choose>
                                        <c:when test="${param.mode == 'triple'}">
                                            <li><a href="geonames_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="geonames_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:otherwise>
                                    </c:choose>
                                </lucene:searchIterator>
                            </ol>
                        </lucene:search>
                    </c:when>
                     <c:when test="${param.entity == 'all'}">
                        <lucene:search lucenePath="${index}/feature"
                            label="content" queryParserName="boolean"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                   <c:choose>
                                        <c:when test="${param.mode == 'triple'}">
                                            <li><a href="geonames_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:when>
                                        <c:otherwise>
                                            <li><a href="geonames_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                        </c:otherwise>
                                    </c:choose>
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

