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
<h2>LoC Search by Subject</h2>

			<form method='POST' action='loc_subject.jsp'>
				<input name="query" value="${param.query}" size=50> <input
					type=submit name=submitButton value=Search><br>
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
					<c:when test="${param.mode == 'triple'}">
						<lucene:search lucenePath="/usr/local/RAID/LD4L/lucene/loc/subjects"
							label="content" queryParserName="ld4l"
							queryString="${param.query}">
							<p>
								Result Count:
								<lucene:count />
							</p>
							<ol class="bulletedList">
								<lucene:searchIterator>
                                   <li><a href="loc_subject_lookup.jsp?uri=<lucene:hit label="uri" />&subject=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
 								</lucene:searchIterator>
							</ol>
						</lucene:search>
					</c:when>
					<c:when test="${param.mode == 'literal' or empty param.mode}">
                        <lucene:search lucenePath="/usr/local/RAID/LD4L/lucene/loc/subjects"
                            label="content" queryParserName="ld4l"
                            queryString="${param.query}">
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                    <li><a href="loc_subject_browse.jsp?uri=<lucene:hit label="uri" />&subject=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
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

