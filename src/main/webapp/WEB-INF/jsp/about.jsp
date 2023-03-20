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

<title>貝殼窩飯店</title>
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
			<a class="navbar-brand text-brand" href="<c:url value='/'/>">貝殼窩<span
				class="color-b">飯店</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/'/>">首頁</a></li>

					<li class="nav-item"><a class="nav-link active" href="#">關於貝殼窩</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/room/allShow'/>">房型</a></li>

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
							<h5 class="title-single">關於XXX</h5>
						</div>
					</div>
					<div class="col-md-12 col-lg-4">
						<nav aria-label="breadcrumb"
							class="breadcrumb-box d-flex justify-content-lg-end">
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="<c:url value='/'/>">首頁</a></li>
								<li class="breadcrumb-item active" aria-current="page">
									關於XXX</li>
							</ol>
						</nav>
					</div>
				</div>
			</div>
		</section>
		<!-- End Intro Single-->

		<!-- ======= About Section ======= -->
		<section class="section-about">
			<div class="container">
				<div class="row">
					<div class="col-sm-12 position-relative">
						<div class="about-img-box">
							<img src="<c:url value='/assets/img/slide-about-1.jpg'/>" alt=""
								class="img-fluid">
						</div>
					</div>
					<div class="col-md-12 section-t8 position-relative">
						<div class="row">
							<div class="col-md-6 col-lg-5">
								<img src="<c:url value='/assets/img/about-2.jpg'/>" alt=""
									class="img-fluid">
							</div>
							<div class="col-md-6 col-lg-5 section-md-t3">
								<div class="title-box-d">
									<h3 class="title-d">
										<span class="color-d">XXX</span>
									</h3>
								</div>
								<p class="color-text-a">在時尚、繁華、科技的台北市，和璞飯店秉持著『細心洞察客人需求的專業服務，恰到好處的巧思與用心，創造隨處可見的完善軟硬體設計』為理念，企圖成為引領旅店潮流之箇中翹楚。

									和璞飯店的專業團隊，將獨特的手感設計融入於空間的深刻規劃，營造出精品時尚的美學概念，打造出可以熱情、可以簡鍊、可以溫柔、可以深情，不受拘束的居住空間，萬種風情的客房讓人處處有驚喜，體貼地滿足每ㄧ位到訪旅客的需求。

									走進飯店，服務人員親切的與客人互動，熱情的招呼，溫馨的服務，誠摯的歡迎您的到來，正如『和璞』二字所傳達的內涵意義『親愛、協調、適中，真實的有如未經琢磨的珍貴璞玉』</p>
							</div>
						</div>
					</div>
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