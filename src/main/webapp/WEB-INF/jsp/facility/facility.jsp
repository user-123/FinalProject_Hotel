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
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

	<title>貝殼窩BackHome</title>
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
<!-- 引入 jQuery 库 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 引入 jQuery UI 库 -->
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">

<style>
.slideshow {
	position: relative;
	overflow: hidden;
	width: 900px;
	height: 450px;
	z-index: 2;
	float: left;
	margin-bottom: 200px;
	overflow: hidden;
}

.slideshow .slides {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

.slideshow .slides img {
	display: none;
	width: 100%;
	height: 100%;
}

.slideshow .slides img.active {
	display: block;
}

.Txt {
	position: relative;
	z-index: 1;
	float: right;
	width: calc(100% - 900px);
	height: 450px;
	padding: 60px;
	box-shadow: 0 22px 50px rgba(54, 53, 53, 0.09);
	box-sizing: border-box;
	margin-top: 100px;
}

.Txt:before {
	content: '';
	position: absolute;
	z-index: -1;
	left: -100px;
	top: 0;
	width: calc(100% + 100px);
	height: 100%;
	background-color: #e5dcd3;
}

.Txt h3 {
	color: #8e7614;
	margin-bottom: 60px;
}

.Txt .btn {
	float: right;
}

.dataDiv {
	overflow: hidden;
	max-height: 4.5em;
	/* 顯示3行 */
}
</style>

<script>
	$(document)
			.ready(
					function() {
						$('.slideshow')
								.each(
										function() {
											var slides = $(this).find(
													'.slides img');
											var currentIndex = 0;
											slides.eq(currentIndex).addClass(
													'active');

											function showNextSlide() {
												slides.eq(currentIndex)
														.removeClass('active');
												currentIndex = (currentIndex + 1)
														% slides.length;
												slides.eq(currentIndex)
														.addClass('active');
											}

											function showPrevSlide() {
												slides.eq(currentIndex)
														.removeClass('active');
												currentIndex = (currentIndex - 1 + slides.length)
														% slides.length;
												slides.eq(currentIndex)
														.addClass('active');
											}

											$(this).find('.slides img').click(
													showPrevSlide);

											setInterval(showNextSlide, 2000);
										});
						$('.row')
								.each(
										function() {
											$(this)
													.find(".btn")
													.on(
															"click",
															function() {
																var data = $(
																		this)
																		.closest(
																				'.dtv')
																		.find(
																				'.dataDiv');
																var button = $(this);
																for (var i = 0; i < data.length; i++) {
																	if (data[i].style.maxHeight == "none") {
																		data[i].style.maxHeight = "4.5em";
																		button
																				.text("顯示更多");
																	} else {
																		data[i].style.maxHeight = "none";
																		button
																				.text("顯示更少");
																	}
																}
															})
										});
						$('.row')
								.each(
										function() {
											$(this)
													.find(".ted")
													.click(
															function() {
																var facility = $(
																		this)
																		.closest(
																				'.property-grid')
																		.data(
																				'facility');

																var dialog = $(
																		"<div class='myLi'></div>")
																		.html(
																				facility)
																		.dialog(
																				{
																					width : 1000,
																					modal : true,
																					autoOpen : false,
																					title : '服務項目',
																					buttons : [ {
																						text : '關閉',
																						click : function() {
																							$(
																									this)
																									.dialog(
																											'close');
																						}
																					} ]
																				});
																dialog
																		.dialog('open');
																$(".myLi")
																		.each(
																				function() {
																					var textElement = $(this);
																					var originalText = textElement
																							.html();
																					var formattedText = originalText
																							.split(
																									"***")
																							.join(
																									"<li>");
																					textElement
																							.html(formattedText);
																				})
																return false;
															});
										});
					});
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
			<a class="navbar-brand text-brand" href="<c:url value='/'/>">貝殼窩<span
				class="color-b">BackHome</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">


					<li class="nav-item"><a class="nav-link"
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
					<li class="nav-item"><a class="nav-link active"
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

		<!-- ======= Intro Single ======= -->
		<section class="intro-single">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="title-single-box">
							<h1 class="title-single">休閒設施</h1>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End Intro Single-->

		<!-- ======= Property Grid ======= -->
		<section class="property-grid grid">
			<div class="container">
				<div class="row">
					<c:forEach items="${facility}" var="msg">
						<section class="property-grid gridgd"
							data-facility="<li>${msg.service}</li>">
							<div class="grbad">
								<div class="slideshow">
									<div class="slides">
										<c:forEach items="${msg.facilityPhotoBeans}" var="photo">
											<img id="img"
												src="<c:url value='/roomId/${photo.photoFile}'/>">
										</c:forEach>
									</div>
								</div>
								<div class="dtv">
									<div class="Txt">
										<!--Txt-->
										<h3>
											<strong>${msg.name}</strong>
										</h3>
										<div class="dataDiv">
											<p class="ellipsis">${msg.introduce}</p>
										</div>
										<button class="btn">顯示更多</button>
										<button class="ted">備註</button>
									</div>
									<!--Txt end-->
								</div>
								<!-- item end -->
							</div>
						</section>
					</c:forEach>
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
							&copy; Copyright <span style="color:#41cff2">貝殼窩團隊</span> All
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