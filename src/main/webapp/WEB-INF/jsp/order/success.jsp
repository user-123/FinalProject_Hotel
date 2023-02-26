<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>XX飯店</title>
</head>
<body>

	<div class="container">
		<h1>預訂成功</h1>
		<span>訂單成立時間: <fmt:formatDate
				pattern="yyyy-MM-dd ,a hh:mm:ss EEEE"
				value="${information.orderdate}" /></span>
		<div>訂單編號:${information.orderid}</div>
		<div>會員:${information.userid.accountName}</div>
		<div>房號:${information.roomid.roomId}</div>
		<div>入住日期:${information.checkindate}</div>
		<div>退房日期:${information.checkoutdate}</div>
		<div>備註:${information.message}</div>
	</div>

</body>
</html>