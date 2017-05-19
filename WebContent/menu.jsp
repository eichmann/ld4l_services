<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<div id=leftCol>
<br>
<h3><a href="<util:applicationRoot/>/index.jsp">Home</a></h3>
<h3>DBpedia</h3>
<ul>
<li><a href="<util:applicationRoot/>/dbpedia.jsp">By Name</a>
<li><a href="<util:applicationRoot/>/dbpedia_entity.jsp">By Entity</a>
<li><a href="<util:applicationRoot/>/dbpedia_person.jsp">By Person</a>
</ul>
<h3>Library of Congress</h3>
<ul>
<li><a href="<util:applicationRoot/>/loc_name.jsp">By Name</a>
<li><a href="<util:applicationRoot/>/loc_subject.jsp">By Subject</a>
</ul>
<h3>VIAF</h3>
<ul>
<li><a href="<util:applicationRoot/>/viaf_entity.jsp">By Entity</a>
<li><a href="<util:applicationRoot/>/viaf_person.jsp">By Person</a>
</ul>
<h3>Catalog</h3>
<ul>
<li><a href="<util:applicationRoot/>/catalog_work.jsp">By Work</a>
<li><a href="<util:applicationRoot/>/catalog_person.jsp">By Person</a>
</ul>
<c:catch var="exception">
    <jsp:include page="local_menu_end.jsp"/>
</c:catch>
</div>
