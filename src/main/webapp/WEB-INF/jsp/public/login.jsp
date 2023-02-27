<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="<c:url value='/favicon.ico' />">
<meta charset="UTF-8" />
<title>登入表單</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>"></script>
<script>
	// 			window.onload = function() {
	// 				$('#loginForm').on("submit",function(event){
	// 					event.preventDefault()
	// 					$.ajax({
	// 						method:'post',
	// 						data : {
	// 							"email" : $('#email').val(),
	// 							"password" : $('#password').val()
	// 						},
	// 						url:"userlogin/login",
	// 						success:function(data){
	// 			                $('#fail').html(data);
	// 						}

	// 					})
	// 				})
	// 			}
</script>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="offset-sm-3 col-sm-6 my-5 p-5 border shadow">
				<h3 class="text-center">登入表單</h3>
				<form:form id="loginForm" method="post" modelAttribute="loginBean">
					<div class="mb-3">
						<label for="email" class="form-label">Email</label>
						<form:input class="form-control" type="text" name="email"
							id="email" path="email" placeholder="請輸入使用者帳號" />
					</div>
					<div class="mb-3">
						<label for="password" class="form-label">密碼</label>
						<form:input class="form-control" type="password" name="password"
							id="password" path="password" placeholder="請輸入密碼" />
					</div>
					<div class="mb-3 form-check">
						<input class="form-check-input" type="checkbox" id="auto-login"
							name="auto-login" /> <label class="form-check-label"
							for="auto-login">自動登入(Remember Me)</label>
					</div>

					<button type="submit" class="btn btn-primary">登入</button>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form:form>
				<c:if test="${not empty param.error}">
					<p class="error-message">登入失敗,請重新確認</p>
				</c:if>
			</div>
		</div>
	</div>
</body>
</html>
