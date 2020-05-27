<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L Getty Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>Getty Search</h2>
            <form method='POST' action='getty.jsp'>
                <input name="query" value="${param.query}" size=50> <input
                    type=submit name=submitButton value=Search><br>
                <fieldset><legend>Result Format?</legend>
                    <input type="radio" name="mode" value="triple" <c:if test="${param.mode == 'triple'}">checked</c:if>>Return a list of triples&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="mode" value="literal" <c:if test="${param.mode != 'triple'}">checked</c:if>>Display as HTML table
               </fieldset>
                <fieldset><legend>Entity?</legend>
                <input type="radio" id="1" name="entity" value="concept" <c:if test="${param.entity == 'concept'}">checked</c:if>>  Concept (AAT)
                <input type="radio" id="2" name="entity" value="organization" <c:if test="${param.entity == 'organization'}">checked</c:if>>  Organization (ULAN)
                <input type="radio" id="3" name="entity" value="person" <c:if test="${param.entity == 'person' or empty param.mode}">checked</c:if>> Person (ULAN)
                <input type="radio" id="4" name="entity" value="place" <c:if test="${param.entity == 'place'}">checked</c:if>>  Place (TGN)
               </fieldset>
            </form>
            ld4l operators include &amp; (and), | (or) and ! (not).
            Parentheses can be used to group terms.
            <p><hr><p>
            <c:if test="${not empty param.query}">
                <h3>
                    Search Results:
                    <c:out value="${param.query}" />
                </h3>
                <c:set var="index" value="/usr/local/RAID/LD4L/lucene/getty"/>
                <c:choose>
                    <c:when test="${param.entity == 'concept'}">
                        <lucene:search lucenePath="${index}/aat"
                            label="content" queryParserName="ld4l"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
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
                    </c:when>
                     <c:when test="${param.entity == 'organization'}">
                        <lucene:search lucenePath="${index}/ulan_organization"
                            label="content" queryParserName="ld4l"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
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
                    </c:when>
                    <c:when test="${param.entity == 'place'}">
                        <lucene:search lucenePath="${index}/tgn"
                            label="content" queryParserName="ld4l"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
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
                    </c:when>
                    <c:when test="${param.entity == 'person' or empty param.entity}">
                        <lucene:search lucenePath="${index}/ulan_person"
                            label="content" queryParserName="ld4l"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
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

