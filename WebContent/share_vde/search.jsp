<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

            <form method='POST' action='${param.site}.jsp'>
                <input name="query" value="${param.query}" size=50> <input
                    type=submit name=submitButton value=Search><br>
                <fieldset><legend>Ontology class?</legend>
                    <select name="entity">
                        <option value="Work" <c:if test="${param.entity == 'Work'}">selected</c:if>>Work</option>
                        <option value="SuperWork" <c:if test="${param.entity == 'SuperWork'}">selected</c:if>>SuperWork</option>
                        <option value="Instance" <c:if test="${param.entity == 'Instance'}">selected</c:if>>Title</Instance>
                        <option value="all" <c:if test="${param.entity == 'all' or empty param.entity}">selected</c:if>>all</option>
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
