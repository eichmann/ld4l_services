<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

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
<h2>DBpedia Person Search</h2>

<script type="text/javascript">
	function OnSubmitForm() {
		if (document.queryForm.mode[0].checked == true) {
			document.queryForm.action = "dbpedia_person_lookup.jsp";
		} else if (document.queryForm.mode[1].checked == true) {
			document.queryForm.action = "dbpedia_person_browse.jsp";
		}
		return true;
	}
</script>

<form name="queryForm" method='GET' onsubmit="return OnSubmitForm();">
    <table border="0">
        <tr>
            <td>
                <fieldset><legend>Result Format?</legend>
                    <input type="radio" name="mode" value="triple" checked>Return a list of triples&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="mode" value="literal">Display as HTML table
               </fieldset>
            </td>
        </tr>
        <tr>
            <td >
                <fieldset><legend>Given Name of Person?</legend>
                <input name="givenname" size=25>
                </fieldset>
            </td>
            <td>
                <fieldset><legend>Surname of Person?</legend>
               <input name="surname" size=25> <input type=submit name=submitButton value=Search>
                 </fieldset>
            </td>
        </tr>
    </table>
</form>

<h2>Search Logic</h2>
The SPARQL query wrapped by this interface currently comes in three variations
<dl>
<dt>Only givenname is specified
<dd>the query only specifies foaf:giveName
<dt>Only surname is specified
<dd>the query only specifies foaf:surname
<dt>Both givenname and surname specified
<dd>the query specifies three conjunctive alternatives
<ul>
    <li> foaf:name = "givenName surname"
    <li> foaf:name = "surname, givenName"
    <li> foaf:givenName = "givenName" and foaf:surname = "surname"
</ul>
</dl>

<h2>Service Request Syntax</h2>
To make a programmatic request to this service, use the following syntax:<br>
<code><a href="/dbpedia_person_lookup.jsp?givenname=GivenName&surname=Surname"><util:applicationRoot/>/dbpedia_person_lookup.jsp?givenname=<i>GivenName</i>&surname=<i>Surname</i></a></code><br>
Where GivenName and Surname are properly escaped to handle things like contained spaces.

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

