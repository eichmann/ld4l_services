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
<li><a href="<util:applicationRoot/>/loc_genre.jsp">By Genre</a>
<li><a href="<util:applicationRoot/>/loc_name.jsp">By Name</a>
<li><a href="<util:applicationRoot/>/loc_rwo_name.jsp">By RWO Name</a>
<li><a href="<util:applicationRoot/>/loc_subject.jsp">By Subject</a>
<li><a href="<util:applicationRoot/>/loc_demographics.jsp">By Demographics</a>
<li><a href="<util:applicationRoot/>/loc_performance.jsp">By Performance</a>
<li><a href="<util:applicationRoot/>/loc_work.jsp">Work</a>
<li><a href="<util:applicationRoot/>/loc_instance.jsp">Instance</a>
</ul>
<h3>SHARE VDE</h3>
<ul>
<li><a href="<util:applicationRoot/>/cornell_share_vde_work.jsp">Cornell Work</a>
<li><a href="<util:applicationRoot/>/cornell_share_vde_instance.jsp">Cornell Instance</a>
<li><a href="<util:applicationRoot/>/stanford_share_vde_work.jsp">Stanford Work</a>
<li><a href="<util:applicationRoot/>/stanford_share_vde_instance.jsp">Stanford Instance</a>
<li><a href="<util:applicationRoot/>/ucsd_share_vde_work.jsp">UCSD Work</a>
<li><a href="<util:applicationRoot/>/ucsd_share_vde_instance.jsp">UCSD Instance</a>
</ul>
<h3>VIAF</h3>
<ul>
<li><a href="<util:applicationRoot/>/viaf_entity.jsp">By Entity</a>
<li><a href="<util:applicationRoot/>/viaf_person.jsp">By Person</a>
</ul>
<h3>FAST</h3>
<ul>
<li><a href="<util:applicationRoot/>/fast.jsp">By Entity</a>
</ul>
<h3>GeoNames</h3>
<ul>
<li><a href="<util:applicationRoot/>/geonames.jsp">By Feature Class</a>
</ul>
<h3>Getty</h3>
<ul>
<li><a href="<util:applicationRoot/>/getty.jsp">By Entity</a>
<li><a href="<util:applicationRoot/>/getty_aat.jsp">AAT Faceted Search</a>
</ul>
<h3>NALT</h3>
<ul>
<li><a href="<util:applicationRoot/>/nalt.jsp">By Concept</a>
</ul>
<h3>Agrovoc</h3>
<ul>
<li><a href="<util:applicationRoot/>/agrovoc.jsp">By Concept</a>
</ul>
<h3>MeSH</h3>
<ul>
<li><a href="<util:applicationRoot/>/mesh.jsp">By Concept</a>
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
