<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="<c:url value='/favicon.ico' />">
<meta charset="UTF-8">
<title>首頁</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="<c:url value="/"/>">首頁</a>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="<c:url value="/public/roombean/allShow"/>">展示房型</a></li>


					<sec:authorize access="hasAuthority('admin')">
						<li class="nav-item"><a class="nav-link"
							href="<c:url value="/admin/roombean/backstage"/>">後台-房型</a></li>
					</sec:authorize>

				</ul>
			</div>





			<div class='center'>
				<div class="dropdown">
					<a class="btn btn-secondary dropdown-toggle" href="#" role="button"
						id="dropdownMenuLink" data-bs-toggle="dropdown"
						aria-expanded="false"> 會員 </a>
					<c:choose>
						<c:when test="${sessionScope.login==true}">
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<li><a class="dropdown-item"
									href="<c:url value='/addinfo' />">填寫及修改基本資料</a></li>
								<li><a class="dropdown-item"
									href="<c:url value='/searchinfo' />">查詢資料</a></li>
							</ul>
						</c:when>
						<c:otherwise>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<li><a class="dropdown-item"
									href="<c:url value='/public/loginpage' />">登入</a></li>
								<li><a class="dropdown-item"
									href="<c:url value='/public/register' />">註冊</a></li>
								<li><a class="dropdown-item" href="#">管理員</a></li>
							</ul>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</nav>



	<form action="<c:url value='/orders/add' />" method="get">
		<input type="hidden" name="Id" value="2" /> <input type="hidden"
			name="文彥的id傳過來的名字" value="${sessionScope.id}" /> <input
			type="submit" class="btn btn-outline-info btn-sm" value="訂房">
	</form>

	<form action="<c:url value='/orders/history' />" method="get">
		<input type="hidden" name="文彥的id傳過來的名字" value="${sessionScope.id}" />
		<input type="submit" class="btn btn-outline-info btn-sm" value="歷史">
	</form>




</body>
</html>
