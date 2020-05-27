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
<h2>LoC Search by Name of Real World Object (RWO)</h2>
<!-- http://guardian.slis.uiowa.edu:8080/ld4l_services/loc_name_search.jsp?q=twain&maximumRecords=3&language=en -->
<!-- http://guardian.slis.uiowa.edu:8080/ld4l_services/loc_name_search.jsp?q=twain&maximumRecords=3&language=en&type=personalName -->
<!--  
 "http://id.loc.gov/ontologies/RecordInfo#RecordInfo" , "14245250" ,
 "http://www.loc.gov/mads/rdf/v1#Authority" , "12136388" ,
 "http://www.loc.gov/mads/rdf/v1#PersonalName" , "9508186" ,
 "http://www.w3.org/2004/02/skos/core#Concept" , "9453032" ,
 "http://www.loc.gov/mads/rdf/v1#Source" , "8143133" ,
 "http://www.loc.gov/mads/rdf/v1#Variant" , "3741203" ,
 "http://www.loc.gov/mads/rdf/v1#CorporateName" , "2582024" ,
 "http://www.loc.gov/mads/rdf/v1#Title" , "2072287" ,
 "http://www.loc.gov/mads/rdf/v1#TitleElement" , "1483160" ,
 "http://www.loc.gov/mads/rdf/v1#FullNameElement" , "1303255" ,
 "http://www.loc.gov/mads/rdf/v1#NameTitle" , "1158456" ,
 "http://www.loc.gov/mads/rdf/v1#DateNameElement" , "799896" ,
 "http://www.loc.gov/mads/rdf/v1#LanguageElement" , "356030" ,
 "http://www.loc.gov/mads/rdf/v1#ConferenceName" , "303710" ,
 "http://www.loc.gov/mads/rdf/v1#Geographic" , "250059" ,
 "http://www.loc.gov/mads/rdf/v1#GenreFormElement" , "168142" ,
 "http://www.loc.gov/mads/rdf/v1#NameElement" , "99497" ,
 "http://www.loc.gov/mads/rdf/v1#PartNumberElement" , "57566" ,
 "http://www.loc.gov/mads/rdf/v1#PartNameElement" , "53880" ,
 "http://www.loc.gov/mads/rdf/v1#TermsOfAddressNameElement" , "41994" ,
 "http://www.loc.gov/mads/rdf/v1#TemporalElement" , "28164" ,
 "http://www.loc.gov/mads/rdf/v1#GeographicElement" , "7851" ,
 "http://www.loc.gov/mads/rdf/v1#DeprecatedAuthority" , "3178" ,
 "http://www.loc.gov/mads/rdf/v1#NamePartElement" , "632" ,
 "http://www.loc.gov/mads/rdf/v1#Topic" , "32" ,
 "http://www.loc.gov/mads/rdf/v1#ComplexSubject" , "27" ,
 "http://www.loc.gov/mads/rdf/v1#TopicElement" , "24" ,
 "http://www.loc.gov/mads/rdf/v1#FamilyName" , "23" ,
 "http://www.loc.gov/mads/rdf/v1#GenreForm" , "10" ,
 "http://www.loc.gov/mads/rdf/v1#RWO" , "3" ,
 "http://xmlns.com/foaf/0.1/Person" , "3" ,
 "http://www.loc.gov/mads/rdf/v1#MainTitleElement" , "1" ,
-->
			<form method='POST' action='loc_rwo_name.jsp'>
				<input name="query" value="${param.query}" size=50> <input
					type=submit name=submitButton value=Search><br>
                <fieldset><legend>Ontology class?</legend>
                    <select name="entity">
                        <option value="PersonalName" <c:if test="${param.entity == 'PersonalName'}">selected</c:if>>PersonalName</option>
                        <option value="CorporateName" <c:if test="${param.entity == 'CorporateName'}">selected</c:if>>CorporateName</option>
                        <option value="Title" <c:if test="${param.entity == 'Title'}">selected</c:if>>Title</option>
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
				    <c:when test="${param.entity == 'PersonalName'}">
				        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/locRWO/persons"/>
				    </c:when>
                    <c:when test="${param.entity == 'CorporateName'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/locRWO/organizations"/>
                    </c:when>
                    <c:when test="${param.entity == 'Title'}">
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/locRWO/titles"/>
                    </c:when>
				    <c:otherwise>
                        <c:set var="LuceneIndex" value="/usr/local/RAID/LD4L/lucene/locRWO/names"/>
				    </c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${param.mode == 'triple'}">
						<lucene:search lucenePath="${LuceneIndex}"
							label="content" queryParserName="ld4l"
							queryString="${param.query}" useConjunctionByDefault="true" useDateHack="true" >
							<p>
								Result Count:
								<lucene:count />
							</p>
							<ol class="bulletedList">
								<lucene:searchIterator>
                                   <li><a href="loc_rwo_name_lookup.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
 								</lucene:searchIterator>
							</ol>
						</lucene:search>
					</c:when>
					<c:when test="${param.mode == 'literal' or empty param.mode}">
                        <lucene:search lucenePath="${LuceneIndex}"
                            label="content" queryParserName="ld4l"
                            queryString="${param.query}" useConjunctionByDefault="true" useDateHack="true" >
                            <p>
                                Result Count:
                                <lucene:count />
                            </p>
                            <ol class="bulletedList">
                                <lucene:searchIterator>
                                    <li><a href="loc_rwo_name_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
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

