<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>XXX大飯店</title>
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
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
#slideshow {
	position: relative;
	overflow: hidden;
	width: 1400px;
	height: 700px;
}

#slideshow .slides {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

#slideshow .slides img {
	display: none;
	width: 100%;
	height: 100%;
}

#slideshow .slides img.active {
	display: block;
}
</style>
<script>
	window.onload = function() {
		$(function() {
			var slides = $('.slides img');
			var currentIndex = 0;
			slides.eq(currentIndex).addClass('active');

// 			function showNextSlide() {
// 				slides.eq(currentIndex).removeClass('active');
// 				currentIndex = (currentIndex + 1) % slides.length;
// 				slides.eq(currentIndex).addClass('active');
// 			}

			function showPrevSlide() {
				slides.eq(currentIndex).removeClass('active');
				currentIndex = (currentIndex - 1 + slides.length)
						% slides.length;
				slides.eq(currentIndex).addClass('active');
			}

// 			$('.controls .prev').click(showNextSlide);
			$('.slides #img').click(showPrevSlide);

			setInterval(showNextSlide, 3000);
		});
	}
</script>

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
			<a class="navbar-brand text-brand" href="<c:url value='/'/>">XXX<span
				class="color-b">大飯店</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/'/>">首頁</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/about'/>">關於XXX</a></li>

					<li class="nav-item"><a class="nav-link active"
						href="<c:url value='/public/room/allShow'/>">房型</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/room/orderAllShow'/>">訂房</a></li>

					<li class="nav-item"><a class="nav-link " href="#">休閒設施</a></li>

					<li class="nav-item"><a class="nav-link " href="#">周邊景點</a></li>

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
										href="<c:url value='/orders/history' />?文彥的id傳過來的名字=${sessionScope.id}">歷史訂單</a>
									</li>
									<sec:authorize access="hasAuthority('admin')">
										<li><a class="dropdown-item"
											href="<c:url value="
															/admin/room/backstage" />">後台</a></li>
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
							<h1 class="title-single">${room.name}</h1>
						</div>
					</div>
					<div class="col-md-12 col-lg-4">
						<nav aria-label="breadcrumb"
							class="breadcrumb-box d-flex justify-content-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="<c:url value='/'/>">首頁</a></li>
								<li class="breadcrumb-item"><a
									href="<c:url value='/public/room/allShow'/>">房型</a></li>
								<li class="breadcrumb-item active" aria-current="page">XXX</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</section>
		<!-- End Intro Single-->
		<section class="property-grid grid">
			<div class="container">
				<div class="row">
					<div id="slideshow">
						<div class="slides">
							<c:forEach items="${room.roomPhotoBeans}" var="photo">
								<img id="img" src="<c:url value='/roomId/${photo.photoFile}'/>">
							</c:forEach>
						</div>
					</div>

					<h5>房型: ${room.type}</h5>
					<h5>價錢: ${room.price}</h5>
					<h5>房型介紹: ${room.roomNameIntroduction}</h5>
					<h5>簡介: ${room.introduce}</h5>
					<h5>設備: ${room.equipment}</h5>
					<h5>服務: ${room.service}</h5>
					<h5>備註: ${room.remark}</h5>
				</div>
			</div>
		</section>

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