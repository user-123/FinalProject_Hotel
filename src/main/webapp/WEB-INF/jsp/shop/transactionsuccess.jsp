<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>" ></script>
<script src="<c:url value='/javascript/jquery-ui.min.js'/>" ></script> 
</head>
<body>
<img src="${contextRoot}/images/check.jpg" width="80" class='m-1 border rounded' />
<h1>我們已收到您的訂單,歡迎再次光臨</h1>
<a href="${contextRoot}"><button class="btn-primary">回首頁</button></a>
<a href="${contextRoot}/public/shop"><button class="btn-danger">繼續逛商城</button></a>
</body>
</html>