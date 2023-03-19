<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>貝斯特飯店</title>
<meta content="" name="description">
<meta content="" name="keywords">

<!-- Favicons -->
<link href="<c:url value='/assets/img/favicon.png'/>" rel="icon">
<link href="<c:url value='/assets/img/apple-touch-icon.png'/>"
	rel="apple-touch-icon">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="<c:url value='/assets/vendor/animate.css/animate.min.css'/>"
	rel="stylesheet">
<link
	href="<c:url value='/assets/vendor/bootstrap/css/bootstrap.min.css'/>"
	rel="stylesheet">
<link
	href="<c:url value='/assets/vendor/bootstrap-icons/bootstrap-icons.css'/>"
	rel="stylesheet">
<link
	href="<c:url value='/assets/vendor/swiper/swiper-bundle.min.css'/>"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">

<!-- =======================================================
  * Template Name: EstateAgency - v4.10.0
  * Template URL: https://bootstrapmade.com/real-estate-agency-bootstrap-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
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
			<a class="navbar-brand text-brand" href="<c:url value='/'/>">貝斯特<span
				class="color-b">飯店</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/'/>">首頁</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/about'/>">關於貝斯特</a></li>

					<li class="nav-item"><a class="nav-link active" href="#">房型</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/room/orderAllShow'/>">訂房</a></li>

					<li class="nav-item"><a class="nav-link " href="#">休閒設施</a></li>

					<li class="nav-item"><a class="nav-link " href="#">周邊景點</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/messages/all'/>">評價&回饋</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="<c:url value='#'/>"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">會員</a> <c:choose>
							<c:when test="${sessionScope.login==true}">
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<li><a class="dropdown-item"
										href="<c:url value='/addinfo' />">填寫及修改基本資料</a></li>
									<li><a class="dropdown-item"
										href="<c:url value='/searchinfo' />">查詢資料</a></li>
									<li><a class="dropdown-item"
										href="<c:url value='/orders/history' />?accountId=${sessionScope.id}">歷史訂單</a></li>
									<sec:authorize access="hasAuthority('admin')">
										<li><a class="dropdown-item"
											href="<c:url value="/admin/backstage"/>">後台</a></li>
									</sec:authorize>
									<li><a class="dropdown-item "
										href="<c:url value='/logout'/>"> <input type="hidden"
											name="${_csrf.parameterName}" value="${_csrf.token}" />登出
									</a></li>
								</ul>
							</c:when>
							<c:otherwise>
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<li><a class="dropdown-item"
										href="<c:url value='/public/loginpage' />">登入</a></li>
									<li><a class="dropdown-item"
										href="<c:url value='/public/register' />">註冊</a></li>
								</ul>
							</c:otherwise>
						</c:choose></li>

				</ul>
			</div>

		</div>
	</nav>
	<!-- End Header/Navbar -->



	<main id="main">

		<!-- ======= Intro Single ======= -->
		<section class="intro-single">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="title-single-box">
							<h1 class="title-single">房型介紹</h1>
						</div>
					</div>
					<div class="col-md-12 col-lg-4">
						<nav aria-label="breadcrumb"
							class="breadcrumb-box d-flex justify-content-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="<c:url value='/'/>">首頁</a></li>
								<li class="breadcrumb-item active" aria-current="page">房型</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</section>
		<!-- End Intro Single-->

		<!-- ======= Property Grid ======= -->
		<section class="property-grid grid">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<div class="grid-option">
							<form action="<c:url value="/public/room/ShowType" />"
								method="get">
								<select name="type">
									<option value="">請選擇房型</option>
									<option value="雙人房">雙人房</option>
									<option value="四人房">四人房</option>
									<option value="六人房">六人房</option>
								</select> <input type="submit" class="btn btn-outline-info btn-sm"
									value="搜尋">
							</form>
						</div>
					</div>
					<c:forEach items="${room}" var="msg">
						<form action="<c:url value="/public/room/show" />" method="get">
							<input type="hidden" name="Id" value="${msg.id}" /> <input
								type="submit" class="btn btn-outline-info btn-sm"
								value="${msg.roomId}">
						</form>
					</c:forEach>
					<!-- 					   				---圖片---				                     -->
					<!-- 					<div class="col-md-4"> -->
					<!-- 						<div class="card-box-a card-shadow"> -->
					<!-- 							<div class="img-box-a"> -->
					<!-- 								<img src="assets/img/property-1.jpg" alt="" -->
					<!-- 									class="img-a img-fluid"> -->
					<!-- 							</div> -->
					<!-- 						</div> -->
					<!-- 					</div> -->
				</div>
			</div>
		</section>
		<!-- End Property Grid Single-->

	</main>
	<!-- End #main -->

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
						Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- End  Footer -->

	<div id="preloader"></div>
	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script
		src="<c:url value='/assets/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>
	<script
		src="<c:url value='/assets/vendor/swiper/swiper-bundle.min.js' />"></script>
	<script
		src="<c:url value='/assets/vendor/php-email-form/validate.js' />"></script>

	<!-- Template Main JS File -->
	<script src="<c:url value='/assets/js/main.js' />"></script>

</body>

</html>