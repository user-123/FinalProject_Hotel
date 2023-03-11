<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
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
	<h1>editRoom</h1>

	<div class="card-body">
		<form:form method="put" action="${contextRoot}/admin/room/update"
			modelAttribute="roomBean" enctype="multipart/form-data">
			<table>
				<tr>
					<td><form:input type="hidden" path="id" id="id" />
				</tr>
				<tr>
					<td><form:label path="roomId">roomId</form:label></td>
					<td><form:input path="roomId" /></td>
				</tr>
				<tr>
					<td><form:label path="name">name</form:label></td>
					<td><form:input path="name" /></td>
				</tr>
				<tr>
					<td><form:label path="type">
              type</form:label></td>
					<td><form:input path="type" /></td>
				</tr>
				<tr>
					<td><form:label path="price">
              price</form:label></td>
					<td><form:input path="price" /></td>
				</tr>
				<tr>
					<td><form:label path="roomNameIntroduction">
              roomNameIntroduction</form:label></td>
					<td><form:input path="roomNameIntroduction" /></td>
				</tr>
				<tr>
					<td><form:label path="introduce">
              introduce</form:label></td>
					<td><form:input path="introduce" /></td>
				</tr>
				<tr>
					<td><form:label path="equipment">
              equipment</form:label></td>
					<td><form:input path="equipment" /></td>
				</tr>
				<tr>
					<td><form:label path="service">
              service</form:label></td>
					<td><form:input path="service" /></td>
				</tr>
				<tr>
					<td><form:label path="remark">
              remark</form:label></td>
					<td><form:input path="remark" /></td>
				</tr>
				<tr>
					<td><label for="room-photos">Roon Photos</label> <input
						type="file" id="room-photos" name="files" multiple></td>
				</tr>
				<tr>
					<td><input type="submit" value="Submit" /></td>
				</tr>
				<tr>
					<td><a class="btn btn-danger"
						href="<c:url value="/admin/backstage"/>">上一頁</a></td>
				</tr>

			</table>
		</form:form>
	</div>
</body>
</html>