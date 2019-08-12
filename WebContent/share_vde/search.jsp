<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L LoC Services</title>
<style type="text/css" media="all">
@import "/ld4l_services/resources/style.css";
</style>
</head>
<body>
    <div id="content"><jsp:include page="/header.jsp" flush="true" />
        <jsp:include page="/menu.jsp" flush="true">
            <jsp:param name="caller" value="research" />
        </jsp:include>
        <div id="centerCol">
            <form method='POST' action='search.jsp'>
                <input name="query" value="${param.query}" size=50> <input
                    type=submit name=submitButton value=Search><br>
                <fieldset><legend>Site?</legend>
                    <select name="site">
                        <option value="alberta" <c:if test="${param.entity == 'alberta'}">selected</c:if>>Alberta</option>
                        <option value="duke" <c:if test="${param.entity == 'duke'}">selected</c:if>>Duke</option>
                        <option value="frick" <c:if test="${param.entity == 'frick'}">selected</c:if>>Frick</Instance>
                        <option value="colorado" <c:if test="${param.entity == 'colorado'}">selected</c:if>>Colorado</option>
                        <option value="cornell" <c:if test="${param.entity == 'cornell' or empty param.entity}">selected</c:if>>Cornell</option>
                    </select>
                </fieldset>
                <fieldset><legend>Ontology class?</legend>
                    <select name="entity">
                        <option value="Work" <c:if test="${param.entity == 'Work' or empty param.entity}">selected</c:if>>Work</option>
                        <option value="SuperWork" <c:if test="${param.entity == 'SuperWork'}">selected</c:if>>SuperWork</option>
                        <option value="Instance" <c:if test="${param.entity == 'Instance'}">selected</c:if>>Instance</Instance>
                    </select>
                </fieldset>
                <fieldset><legend>Result Format?</legend>
                    <input type="radio" name="mode" value="triple" <c:if test="${param.mode == 'triple'}">checked</c:if>>Return a list of triples&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="mode" value="literal" <c:if test="${param.mode != 'triple'}">checked</c:if>>Display as HTML table
               </fieldset>
            </form>
            <p><hr><p>
            <c:if test="${not empty param.query}">
                <h3>
                    Search Results:
                    <c:out value="${param.query}" />
                </h3>
                <c:choose>
                    <c:when test="${param.entity == 'Work'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/share_vde/${param.site}/work"/>
                    </c:when>
                    <c:when test="${param.entity == 'SuperWork'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/share_vde/${param.site}/superwork"/>
                    </c:when>
                    <c:when test="${param.entity == 'Instance'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/share_vde/${param.site}/instance"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/share_vde/${param.site}/work"/>
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
                                   <li><a href="lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
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
                                    <li><a href="browse.jsp?site=${param.site}&uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
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

            