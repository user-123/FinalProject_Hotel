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
	<h1>showAllRoom</h1>
	<div class="container">
		<form action="<c:url value="/public/roombean/ShowType" />" method="get">
			<select name="type">
				<option value="">請選擇房型</option>
				<option value="雙人房">雙人房</option>
				<option value="四人房">四人房</option>
				<option value="六人房">六人房</option>
			</select> <input type="submit" class="btn btn-outline-info btn-sm" value="搜尋">
		</form>
		<c:forEach items="${room}" var="msg">
			<form action="<c:url value="/public/roombean/show" />" method="get">
				<input type="hidden" name="Id" value="${msg.id}" /> <input
					type="submit" class="btn btn-outline-info btn-sm"
					value="${msg.roomId}">
			</form>
		</c:forEach>
	</div>
</body>
</html>
