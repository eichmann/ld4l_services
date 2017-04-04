<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L VIAF Reconciliation Services</title>
<style type="text/css" media="all">    @import "/ld4l_services/resources/style.css";</style>
</head>
<body>
<div id="content"><jsp:include page="/header.jsp" flush="true" />
<jsp:include page="/menu.jsp" flush="true">
    <jsp:param name="caller" value="research" />
</jsp:include>
<div id="centerCol">
<h2>VIAF Search by Entity Name</h2>

<script type="text/javascript">
	function OnSubmitForm() {
		if (document.queryForm.mode[0].checked == true) {
			document.queryForm.action = "viaf_entity_lookup.jsp";
		} else if (document.queryForm.mode[1].checked == true) {
			document.queryForm.action = "viaf_entity_browse.jsp";
		}
		return true;
	}
</script>

<form name="queryForm" method='GET' onsubmit="return OnSubmitForm();">
    <table border="0">
        <tr>
            <td>
                <fieldset><legend>Result Format?</legend>
                    <input type="radio" name="mode" value="triple" >Return a list of triples&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="mode" value="literal" checked>Display as HTML table
               </fieldset>
            </td>         
            <td>
                <fieldset><legend>Ontology class? (fully qualified)</legend>
                    <select name="entity">
                        <option value="http://schema.org/Person">Person</option>
                        <option value="http://schema.org/Organization">Organization</option>
					    <option value="http://schema.org/CreativeWork">Creative Work</option>
                        <option value="http://schema.org/Place">Place</option>
                    </select>
                </fieldset>
            </td>
        </tr>
        <tr>
            <td colspan=2>
                <fieldset><legend>Name of Entity?</legend>
                <input name="name" size=50> <input type=submit name=submitButton value=Search>
                </fieldset>
            </td>
        </tr>
    </table>
</form>

<h2>Search Logic</h2>
The SPARQL query wrapped by this interface currently makes a number of assumptions, particularly that a fully qualified IRI is used for the entity and that
the instance asserts a name predicate that can be used to identify the instance's URI:
<pre>
    PREFIX foaf:  <c:out value="<"/>http://xmlns.com/foaf/0.1/<c:out value=">"/>
    PREFIX rdf:   <c:out value="<"/>http://www.w3.org/1999/02/22-rdf-syntax-ns#<c:out value=">"/>
    PREFIX rdfs:  <c:out value="<"/>http://www.w3.org/2000/01/rdf-schema#<c:out value=">"/>

    SELECT ?s ?p ?o WHERE {
        ?s ?p ?o .
        ?s rdf:type ?entity.
        ?s &lt;http://xmlns.com/foaf/0.1/name&gt; ?name@en .
    }
</pre>

<h2>Service Request Syntax</h2>
To make a programmatic request to this service, use the following syntax:<br>
<code><a href="/viaf_entity_lookup.jsp?entity=Entity&name=Name"><util:applicationRoot/>/viaf_entity_lookup.jsp?entity=<i>Entity</i>&name=<i>Name</i></a></code><br>
Where name is properly escaped to handle things like contained spaces.

<jsp:include page="/footer.jsp" flush="true" />
</div>
</div>
</body>
</html>

