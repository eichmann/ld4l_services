<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="lucene" uri="http://icts.uiowa.edu/lucene"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LD4L LoC Services</title>
<style type="text/css" media="all">
@import "/ld4l_services/resources/style.css";
</style>
</head>
<body>
	<div id="content"><jsp:include page="/header.jsp" flush="true" />
		<jsp:include page="/menu.jsp" flush="true">
			<jsp:param name="caller" value="research" />
		</jsp:include>
		<div id="centerCol">
			<h2>Frick SHARE VDE Search</h2>
			<jsp:include page="search.jsp" flush="true">
				<jsp:param value="frick" name="site" />
			</jsp:include>

			<jsp:include page="/footer.jsp" flush="true" />
		</div>
	</div>
</body>
</html>

