<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L LoC Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>LoC Search by Name</h2>
			<form method='POST' action='loc_name.jsp'>
				<input name="query" value="${param.query}" size=50> <input
					type=submit name=submitButton value=Search><br>
                <fieldset><legend>Ontology class?</legend>
                    <select name="entity">
                        <option value="Person" <c:if test="${param.entity == 'Person'}">selected</c:if>>Person</option>
                        <option value="Organization" <c:if test="${param.entity == 'Organization'}">selected</c:if>>Organization</option>
                        <option value="Work" <c:if test="${param.entity == 'Work'}">selected</c:if>>Work</option>
                       <option value="Family" <c:if test="${param.entity == 'Family'}">selected</c:if>>Family</option>
                       <option value="Geographic" <c:if test="${param.entity == 'Geographic'}">selected</c:if>>Geographic</option>
                       <option value="ConferenceName" <c:if test="${param.entity == 'ConferenceName'}">selected</c:if>>Conference Name</option>
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
					<c:when test="${param.entity == 'Person'}">
						<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/names_persons" />
					</c:when>
					<c:when test="${param.entity == 'Organization'}">
						<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/names_organizations" />
					</c:when>
					<c:when test="${param.entity == 'Work'}">
						<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/names_titles" />
					</c:when>
					<c:when test="${param.entity == 'Family'}">
						<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/names_family" />
					</c:when>
					<c:when test="${param.entity == 'Geographic'}">
						<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/names_geographic" />
					</c:when>
					<c:when test="${param.entity == 'ConferenceName'}">
						<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/names_conference" />
					</c:when>
					<c:otherwise>
						<c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/loc/names" />
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${param.mode == 'triple'}">
						<lucene:search lucenePath="${LuceneIndex}"
							label="content" queryParserName="ld4l"
							queryString="${param.query}">
							<p>
								Result Count:
								<lucene:count />
							</p>
							<ol class="bulletedList">
								<lucene:searchIterator>
                                   <li><a href="loc_name_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
 								</lucene:searchIterator>
							</ol>
						</lucene:search>
					</c:when>
					<c:when test="${param.mode == 'literal' or empty param.mode}">
                        <lucene:search lucenePath="${LuceneIndex}"
                            label="content" queryParserName="ld4l"
                            queryString="${param.query}" >
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                    <li><a href="loc_name_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
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

