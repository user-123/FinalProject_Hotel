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
	<h1>管理房型</h1>
	<div class="container">
		<form action="<c:url value="/admin/roombean/backstageShowType" />"
			method="get">
			<select name="type">
				<option value="">請選擇房型</option>
				<option value="雙人房">雙人房</option>
				<option value="四人房">四人房</option>
				<option value="六人房">六人房</option>
			</select> <input type="submit" class="btn btn-outline-info btn-sm" value="搜尋">
		</form>
	</div>
	<input type="button" value="新增" class="btn btn-primary"
		onclick="location.href='<c:url value='/admin/roombean/create'/>'">

	<table
		class="table table-striped table-bordered table-hover text-center">
		<tr>
			<th>房號</th>
			<th>房名</th>
			<th>房型</th>
			<th>價錢</th>
			<th>房型介紹</th>
			<th>簡介</th>
			<th>設備</th>
			<th>服務</th>
			<th>備註</th>
			<th>修改</th>
		</tr>
		<c:forEach items="${room}" var="msg">

			<tr>
				<td>${msg.roomId}</td>
				<td>${msg.name}</td>
				<td>${msg.type}</td>
				<td>${msg.price}</td>
				<td>${msg.roomNameIntroduction}</td>
				<td>${msg.introduce}</td>
				<td>${msg.equipment}</td>
				<td>${msg.service}</td>
				<td>${msg.remark}</td>

				<td>
					<form action="<c:url value="/admin/roombean/edit" />" method="get">
						<input type="hidden" name="id" value="${msg.id}" /><input
							type="submit" class="btn btn-outline-danger btn-sm" value="編輯資料">
					</form>
					<form action="<c:url value="/admin/roombean/delete" />" method="post">
						<input type="hidden" name="id" value="${msg.id}" /> <input
							type="hidden" name="_method" value="delete" /> <input
							type="submit" class="btn btn-outline-danger btn-sm" value="刪除">
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>