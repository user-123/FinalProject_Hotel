<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>room</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="navbar.jsp"></jsp:include>
	<h1>房型介紹</h1>


	<h5>房號: ${room.roomId}</h5>
	<h5>房名: ${room.name}</h5>
	<h5>房型: ${room.type}</h5>
	<h5>價錢: ${room.price}</h5>
	<h5>房型介紹: ${room.roomNameIntroduction}</h5>
	<h5>簡介: ${room.introduce}</h5>
	<h5>設備: ${room.equipment}</h5>
	<h5>服務: ${room.service}</h5>
	<h5>備註: ${room.remark}</h5>
	<br>
	<br>
	<img width='300px' src="http://localhost:8081/my-house/roombean/show">



<!-- 這裡是要接去訂房的contoller(貝卡那邊首頁訂房的按鈕換成這個)(路徑再把它貼過來這邊) -->
	<form action="<c:url value='' />" method="get">  
		<input type="hidden" name="Id" value="${room.id}" /> <input
			type="submit" class="btn btn-outline-info btn-sm" value="訂房">
	</form>
</body>
</html>