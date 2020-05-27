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
                <table>
                	<tr>
 		                <td><input type="radio" id="1" name="entity" value="A" <c:if test="${param.entity == 'A'}">checked</c:if>>  A - country, state, region, ...</td>
		                <td><input type="radio" id="2" name="entity" value="H" <c:if test="${param.entity == 'H'}">checked</c:if>>  H - stream, lake, ...</td>
		                <td><input type="radio" id="3" name="entity" value="L" <c:if test="${param.entity == 'L'}">checked</c:if>>  L - park, area, ...</td>
		                <td><input type="radio" id="4" name="entity" value="P" <c:if test="${param.entity == 'P'}">checked</c:if>>  P - city, village, ...</td>
		                <td><input type="radio" id="5" name="entity" value="R" <c:if test="${param.entity == 'R'}">checked</c:if>>  R - road, railroad</td>
                	</tr>
                	<tr>
		                <td><input type="radio" id="6" name="entity" value="S" <c:if test="${param.entity == 'S'}">checked</c:if>>  S - spot, building, farm</td>
		                <td><input type="radio" id="7" name="entity" value="T" <c:if test="${param.entity == 'T'}">checked</c:if>>  T - mountain, hill, rock, ...</td>
		                <td><input type="radio" id="8" name="entity" value="U" <c:if test="${param.entity == 'U'}">checked</c:if>>  U - undersea</td>
		                <td><input type="radio" id="9" name="entity" value="V" <c:if test="${param.entity == 'V'}">checked</c:if>>  V - forest, heath, ...</td>
		                <td><input type="radio" id="10" name="entity" value="AP" <c:if test="${param.entity == 'AP' or empty param.mode}">checked</c:if>>  AP - both A and P data</td>
                	</tr>
                	<tr>
		                <td><input type="radio" id="11" name="entity" value="all" <c:if test="${param.entity == 'all'}">checked</c:if>>  All GeoNames data</td>
                	</tr>
                </table>
               </fieldset>
               <fieldset><legend>Indexing?</legend>
                    <input type="radio" name="index" value="strict" <c:if test="${param.index == 'strict'}">checked</c:if>>Strict (only terms directly associated with the entity)&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="index" value="extended" <c:if test="${param.index != 'strict'}">checked</c:if>>Extended (include terms associated with the entity's parent(s))
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
                <c:set var="index" value="/usr/local/RAID/LD4L/lucene/geonames"/>
                <c:choose>
                    <c:when test="${param.index == 'strict'}">
		                <c:set var="index" value="/usr/local/RAID/LD4L/lucene/geonames_strict"/>
                    </c:when>
                    <c:when test="${param.index == 'extended'}">
		                <c:set var="index" value="/usr/local/RAID/LD4L/lucene/geonames"/>
                    </c:when>
                </c:choose>
                <c:choose>
                    <c:when test="${param.entity == 'A'}">
                     	<c:set var="lucenePath" value="${index}/A"/>
                    </c:when>
                    <c:when test="${param.entity == 'H'}">
                     	<c:set var="lucenePath" value="${index}/H"/>
                    </c:when>
                    <c:when test="${param.entity == 'L'}">
                     	<c:set var="lucenePath" value="${index}/L"/>
                    </c:when>
                    <c:when test="${param.entity == 'P'}">
                     	<c:set var="lucenePath" value="${index}/P"/>
                    </c:when>
                    <c:when test="${param.entity == 'R'}">
                     	<c:set var="lucenePath" value="${index}/R"/>
                    </c:when>
                    <c:when test="${param.entity == 'S'}">
                     	<c:set var="lucenePath" value="${index}/S"/>
                    </c:when>
                    <c:when test="${param.entity == 'T'}">
                     	<c:set var="lucenePath" value="${index}/T"/>
                    </c:when>
                    <c:when test="${param.entity == 'U'}">
                     	<c:set var="lucenePath" value="${index}/U"/>
                    </c:when>
                    <c:when test="${param.entity == 'V'}">
                     	<c:set var="lucenePath" value="${index}/V"/>
                    </c:when>
                    <c:when test="${param.entity == 'AP'}">
                     	<c:set var="lucenePath" value="${index}/AP"/>
                    </c:when>
                     <c:when test="${param.entity == 'all'}">
                     	<c:set var="lucenePath" value="${index}/feature"/>
                    </c:when>
                    <c:otherwise>
                    </c:otherwise>
                </c:choose>
            </c:if>

			<lucene:search lucenePath="${lucenePath}" label="content" queryParserName="ld4l" queryString="${param.query}">
            	<p>Result Count: <lucene:count /></p>
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

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

