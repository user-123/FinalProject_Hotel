<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="<c:url value='/favicon.ico' />">
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>貝殼窩BackHome</title>
<meta content="" name="description">
<meta content="" name="keywords">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<!-- Favicons -->

<link href="<c:url value='/assets/img/favicon.png' />" rel="icon">

<link href="<c:url value='/assets/img/apple-touch-icon.png' />"
	rel="apple-touch-icon">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet">

<!-- Vendor CSS Files -->

<link href="/assets/vendor/animate.css/animate.min.css" rel="stylesheet">

<link href="/assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<link
	href="<c:url value='/assets/vendor/bootstrap-icons/bootstrap-icons.css' />"
	rel="stylesheet">

<link
	href="<c:url value='/assets/vendor/swiper/swiper-bundle.min.css' />"
	rel="stylesheet">

<!-- Template Main CSS File -->

<link href="<c:url value='/assets/css/style.css' />" rel="stylesheet">

<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>"></script>



</head>
<body>
	<!-- ======= Header/Navbar ======= -->
	<nav
		class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">
		<div class="container">
			<button class="navbar-toggler collapsed" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarDefault"
				aria-controls="navbarDefault" aria-expanded="false"
				aria-label="Toggle navigation">
				<span></span> <span></span> <span></span>
			</button>
			<a class="navbar-brand text-brand" href="<c:url value='/'/>">貝殼窩<span
				class="color-b">BackHome</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">


					<li class="nav-item"><a class="nav-link active"
						href="${contextRoot}">首頁</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" role="button"
						data-bs-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">關於貝殼窩</a>

						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<li><a class="dropdown-item"
								href="<c:url value='/public/about' />">我們的理念</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/public/messages/all' />">評價&回饋</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/room/orderAllShow'/>">房型&訂房</a></li>
					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/facility/show'/>">休閒設施</a></li>

					<li class="nav-item"><a class="nav-link "
						href="${contextRoot}/public/attraction/list">周邊美食&景點</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/shop' />">商城</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="<c:url value='#'/>"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">會員</a> <sec:authorize
							access="hasAnyAuthority('admin','user')">
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<li><a class="dropdown-item"
									href="<c:url value='/addinfo' />">填寫及修改基本資料</a></li>
								<li><a class="dropdown-item"
									href="<c:url value='/searchinfo' />">查詢資料</a></li>
								<li><a class="dropdown-item"
									href="<c:url value='/orders/history' />?accountId=${sessionScope.id}">歷史訂單</a></li>
								<sec:authorize access="hasAuthority('admin')">
									<li><a class="dropdown-item"
										href="<c:url value="/admin/background"/>">後台</a></li>
								</sec:authorize>
								<li><a class="dropdown-item "
									href="<c:url value='/logout'/>"> <input type="hidden"
										name="${_csrf.parameterName}" value="${_csrf.token}" />登出
								</a></li>
							</ul>
						</sec:authorize> <sec:authorize access="hasAuthority('ROLE_ANONYMOUS')">
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<li><a class="dropdown-item"
									href="<c:url value='/public/loginpage' />">登入</a></li>
								<li><a class="dropdown-item"
									href="<c:url value='/public/register' />">註冊</a></li>
							</ul>
						</sec:authorize></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- End Header/Navbar -->
	<main id="main">
		<section class="intro-single">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="title-single-box">
							<h1 class="title-single">基本資料查詢</h1>
							<c:choose>
								<c:when test="${requestScope.noinfo==true}">
									<h1 style="color: #FFFFFF">這是空白文字</h1>
									<h1 style="color: #FFFFFF">這是空白文字</h1>
									<h3 style="margin-left: 50px">您尚未填寫基本資料</h3>
									<h1 style="color: #FFFFFF">這是空白文字</h1>
								</c:when>
								<c:otherwise>

									<div class="form-comments" style="display: flex">
										<div class="row">

											<div class="col-md-12 mb-3">
												<div class="form-group h3">姓名: ${mb.userName}</div>
											</div>
											<div class="col-md-12 mb-3">
												<div class="form-group h3">手機: ${mb.phone}</div>
											</div>
											<div class="col-md-12 mb-3">
												<div class="form-group h3">性別: ${mb.gender}</div>
											</div>
											<div class="col-md-12 mb-3">
												<div class="form-group h3">地址: ${mb.address}</div>
											</div>
											<div class="col-md-12 mb-3" style="width: 300px">
												<div class="form-group h3">生日: ${mb.birthDate}</div>
											</div>
										</div>
										<div class="col-md-12 mb-3" style="margin-left: 300px">
											<div class="form-group">${sessionScope.photo}
												${requestScope.message}</div>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- ======= Footer ======= -->

	<footer>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="copyright-footer">
						<p class="copyright color-text-a">
							&copy; Copyright <span class="color-a">EstateAgency</span> All
							Rights Reserved.
						</p>
					</div>
					<div class="credits">
						<!--
            All the links in the footer should remain intact.
            You can delete the links only if you purchased the pro version.
            Licensing information: https://bootstrapmade.com/license/
            Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=EstateAgency
          -->
						Designed by <a href="<c:url value='https://bootstrapmade.com/'/>">BootstrapMade</a>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- End  Footer -->

	<div id="preloader"></div>
	<a href="<c:url value='#'/>"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script
		src='<c:url value="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"/>'></script>
	<script
		src='<c:url value="/assets/vendor/swiper/swiper-bundle.min.js"/>'></script>
	<script
		src='<c:url value="/assets/vendor/php-email-form/validate.js"/>'></script>

	<!-- Template Main JS File -->
	<script src='<c:url value="/assets/js/main.js"/>'></script>
</body>
</html>
