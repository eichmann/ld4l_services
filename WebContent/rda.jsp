<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L RDA Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>RDA Search</h2>
            <form method='POST' action='rda.jsp'>
                <input name="query" value="${param.query}" size=50> <input
                    type=submit name=submitButton value=Search><br>
                <fieldset><legend>RDA category?</legend>
                    <select name="entity">
                        <option value="AspectRatio" <c:if test="${param.entity == 'AspectRatio' or empty param.entity}">selected</c:if>>AspectRatio</option>
                        <option value="CollTitle" <c:if test="${param.entity == 'CollTitle'}">selected</c:if>>CollTitle</option>
                        <option value="IllusContent" <c:if test="${param.entity == 'IllusContent'}">selected</c:if>>IllusContent</option>
                        <option value="ModeIssue" <c:if test="${param.entity == 'ModeIssue'}">selected</c:if>>ModeIssue</option>
                        <option value="MusNotation" <c:if test="${param.entity == 'MusNotation'}">selected</c:if>>MusNotation</option>
                        <option value="RDACarrierEU" <c:if test="${param.entity == 'RDACarrierEU'}">selected</c:if>>RDACarrierEU</option>
                        <option value="RDACarrierType" <c:if test="${param.entity == 'RDACarrierType'}">selected</c:if>>RDACarrierType</option>
                        <option value="RDACartoDT" <c:if test="${param.entity == 'RDACartoDT'}">selected</c:if>>RDACartoDT</option>
                        <option value="RDAColourContent" <c:if test="${param.entity == 'RDAColourContent'}">selected</c:if>>RDAColourContent</option>
                        <option value="RDAContentType" <c:if test="${param.entity == 'RDAContentType'}">selected</c:if>>RDAContentType</option>
                        <option value="RDAGeneration" <c:if test="${param.entity == 'RDAGeneration'}">selected</c:if>>RDAGeneration</option>
                        <option value="RDAMaterial" <c:if test="${param.entity == 'RDAMaterial'}">selected</c:if>>RDAMaterial</option>
                        <option value="RDAMediaType" <c:if test="${param.entity == 'RDAMediaType'}">selected</c:if>>RDAMediaType</option>
                        <option value="RDAPolarity" <c:if test="${param.entity == 'RDAPolarity'}">selected</c:if>>RDAPolarity</option>
                        <option value="RDARecordingSources" <c:if test="${param.entity == 'RDARecordingSources'}">selected</c:if>>RDARecordingSources</option>
                        <option value="RDAReductionRatio" <c:if test="${param.entity == 'RDAReductionRatio'}">selected</c:if>>RDAReductionRatio</option>
                        <option value="RDARegionalEncoding" <c:if test="${param.entity == 'RDARegionalEncoding'}">selected</c:if>>RDARegionalEncoding</option>
                        <option value="RDATerms" <c:if test="${param.entity == 'RDATerms'}">selected</c:if>>RDATerms</option>
                        <option value="RDATypeOfBinding" <c:if test="${param.entity == 'RDATypeOfBinding'}">selected</c:if>>RDATypeOfBinding</option>
                        <option value="RDAbaseMaterial" <c:if test="${param.entity == 'RDAbaseMaterial'}">selected</c:if>>RDAbaseMaterial</option>
                        <option value="RDAproductionMethod" <c:if test="${param.entity == 'RDAproductionMethod'}">selected</c:if>>RDAproductionMethod</option>
                        <option value="TacNotation" <c:if test="${param.entity == 'TacNotation'}">selected</c:if>>TacNotation</option>
                        <option value="bookFormat" <c:if test="${param.entity == 'bookFormat'}">selected</c:if>>bookFormat</option>
                        <option value="broadcastStand" <c:if test="${param.entity == 'broadcastStand'}">selected</c:if>>broadcastStand</option>
                        <option value="configPlayback" <c:if test="${param.entity == 'configPlayback'}">selected</c:if>>configPlayback</option>
                        <option value="fileType" <c:if test="${param.entity == 'fileType'}">selected</c:if>>fileType</option>
                        <option value="fontSize" <c:if test="${param.entity == 'fontSize'}">selected</c:if>>fontSize</option>
                        <option value="formatNoteMus" <c:if test="${param.entity == 'formatNoteMus'}">selected</c:if>>formatNoteMus</option>
                        <option value="frequency" <c:if test="${param.entity == 'frequency'}">selected</c:if>>frequency</option>
                        <option value="gender" <c:if test="${param.entity == 'gender'}">selected</c:if>>gender</option>
                        <option value="groovePitch" <c:if test="${param.entity == 'groovePitch'}">selected</c:if>>groovePitch</option>
                        <option value="grooveWidth" <c:if test="${param.entity == 'grooveWidth'}">selected</c:if>>grooveWidth</option>
                        <option value="layout" <c:if test="${param.entity == 'layout'}">selected</c:if>>layout</option>
                        <option value="noteMove" <c:if test="${param.entity == 'noteMove'}">selected</c:if>>noteMove</option>
                        <option value="presFormat" <c:if test="${param.entity == 'presFormat'}">selected</c:if>>presFormat</option>
                        <option value="prodTactile" <c:if test="${param.entity == 'prodTactile'}">selected</c:if>>prodTactile</option>
                        <option value="recMedium" <c:if test="${param.entity == 'recMedium'}">selected</c:if>>recMedium</option>
                        <option value="rofch" <c:if test="${param.entity == 'rofch'}">selected</c:if>>rofch</option>
                        <option value="rofchrda" <c:if test="${param.entity == 'rofchrda'}">selected</c:if>>rofchrda</option>
                        <option value="rofem" <c:if test="${param.entity == 'rofem'}">selected</c:if>>rofem</option>
                        <option value="rofer" <c:if test="${param.entity == 'rofer'}">selected</c:if>>rofer</option>
                        <option value="rofet" <c:if test="${param.entity == 'rofet'}">selected</c:if>>rofet</option>
                        <option value="roffgrda" <c:if test="${param.entity == 'roffgrda'}">selected</c:if>>roffgrda</option>
                        <option value="rofhf" <c:if test="${param.entity == 'rofhf'}">selected</c:if>>rofhf</option>
                        <option value="rofid" <c:if test="${param.entity == 'rofid'}">selected</c:if>>rofid</option>
                        <option value="rofim" <c:if test="${param.entity == 'rofim'}">selected</c:if>>rofim</option>
                        <option value="rofin" <c:if test="${param.entity == 'rofin'}">selected</c:if>>rofin</option>
                        <option value="rofit" <c:if test="${param.entity == 'rofit'}">selected</c:if>>rofit</option>
                        <option value="rofitrda" <c:if test="${param.entity == 'rofitrda'}">selected</c:if>>rofitrda</option>
                        <option value="rofrm" <c:if test="${param.entity == 'rofrm'}">selected</c:if>>rofrm</option>
                        <option value="rofrr" <c:if test="${param.entity == 'rofrr'}">selected</c:if>>rofrr</option>
                        <option value="rofrt" <c:if test="${param.entity == 'rofrt'}">selected</c:if>>rofrt</option>
                        <option value="rofsf" <c:if test="${param.entity == 'rofsf'}">selected</c:if>>rofsf</option>
                        <option value="rofsfrda" <c:if test="${param.entity == 'rofsfrda'}">selected</c:if>>rofsfrda</option>
                        <option value="rofsm" <c:if test="${param.entity == 'rofsm'}">selected</c:if>>rofsm</option>
                        <option value="scale" <c:if test="${param.entity == 'scale'}">selected</c:if>>scale</option>
                        <option value="soundCont" <c:if test="${param.entity == 'soundCont'}">selected</c:if>>soundCont</option>
                        <option value="specPlayback" <c:if test="${param.entity == 'specPlayback'}">selected</c:if>>specPlayback</option>
                        <option value="statIdentification" <c:if test="${param.entity == 'statIdentification'}">selected</c:if>>statIdentification</option>
                        <option value="trackConfig" <c:if test="${param.entity == 'trackConfig'}">selected</c:if>>trackConfig</option>
                        <option value="typeRec" <c:if test="${param.entity == 'typeRec'}">selected</c:if>>typeRec</option>
                        <option value="videoFormat" <c:if test="${param.entity == 'videoFormat'}">selected</c:if>>videoFormat</option>
                    </select>
                </fieldset>
                <fieldset><legend>Result Format?</legend>
                    <input type="radio" name="mode" value="triple" <c:if test="${param.mode == 'triple'}">checked</c:if>>Return a list of triples&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="mode" value="literal" <c:if test="${param.mode != 'triple'}">checked</c:if>>Display as HTML table
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
                <lucene:search lucenePath="/usr/local/RAID/LD4L/lucene/rda/${param.entity}"
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
                                    <li><a href="rda_lookup.jsp?uri=<lucene:hit label="uri" />&query=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                </c:when>
                                <c:otherwise>
                                    <li><a href="rda_browse.jsp?uri=<lucene:hit label="uri" />&name=<lucene:hit label="name" />"><lucene:hit label="name" /></a></li>
                                </c:otherwise>
                            </c:choose>
                        </lucene:searchIterator>
                    </ol>
                </lucene:search>
            </c:if>

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

