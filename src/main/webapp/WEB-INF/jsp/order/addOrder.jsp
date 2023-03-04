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
		<h1>訂房資訊</h1>
		<form:form action="${contextRoot}/orders/post"
			modelAttribute="information">
			<table>
				<tr>
					<td><form:label path="checkindate">入住日期</form:label></td>
					<td><form:input path="checkindate" /></td>
				</tr>
				<tr>
					<td><form:label path="checkoutdate">退房日期</form:label></td>
					<td><form:input path="checkoutdate" /></td>
				</tr>
				<tr>
					<td><form:label path="message">備註</form:label></td>
					<td><form:input path="message" placeholder="請輸入不超過30個字"
							maxlength="30" /></td>
				</tr>
				<tr style="display: none">
					<!-- 會員 -->
					<td>會員</td>
					<td><input name="文彥的id傳過來的名字" value="${sessionScope.id}" /></td>
				</tr>
				<tr style="display: none">
					<!-- 房號 -->
					<td>房間</td>
					<td><input name="rId" value="${Id}" /></td>
				</tr>
			</table>

			<button type="submit" class="btn btn-primary">送出</button>
		</form:form>

	</div>


</body>
</html>