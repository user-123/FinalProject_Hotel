<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta content="width=device-width, initial-scale=1.0" name="viewport">

		<title>貝殼窩飯店管理系統</title>
		<meta content="" name="description">
		<meta content="" name="keywords">

		<!-- Favicons -->
		<link href="<c:url value='/assets/img/favicon.png'/>" rel="icon">
		<link href="<c:url value='/assets/img/apple-touch-icon.png'/>" rel="apple-touch-icon">

		<!-- Google Fonts -->
		<link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700" rel="stylesheet">

		<!-- Vendor CSS Files -->
		<link href="<c:url value='/assets/vendor/animate.css/animate.min.css'/>" rel="stylesheet">
		<link href="<c:url value='/assets/vendor/bootstrap/css/bootstrap.min.css'/>" rel="stylesheet">
		<link href="<c:url value='/assets/vendor/bootstrap-icons/bootstrap-icons.css'/>" rel="stylesheet">
		<link href="<c:url value='/assets/vendor/swiper/swiper-bundle.min.css'/>" rel="stylesheet">

		<!-- Template Main CSS File -->
		<link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">

		<!-- =======================================================
		  * Template Name: EstateAgency - v4.10.0
		  * Template URL: https://bootstrapmade.com/real-estate-agency-bootstrap-template/
		  * Author: BootstrapMade.com
		  * License: https://bootstrapmade.com/license/
		  ======================================================== -->
		<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>

	</head>

	<body>
		<!-- ======= Header/Navbar ======= -->
		<nav class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">
			<div class="container">
				<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarDefault" aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
					<span></span> <span></span> <span></span>
				</button>
				<a class="navbar-brand text-brand" href="<c:url value='/admin/backstage' />">貝殼窩<span class="color-b">飯店管理系統</span></a>

				<div class="navbar-collapse collapse justify-content-center" id="navbarDefault">
					<ul class="navbar-nav">



						<li class="nav-item"><a class="nav-link active" href="${contextRoot}/admin/backstage">基本管理</a></li>

						<li class="nav-item"><a class="nav-link " href="<c:url value='/admin/backstage/member' />">會員管理</a></li>

						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">訂單管理</a>

							<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/findall' />">訂單一覽</a></li>
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/byuserid' />">用會員名稱查詢</a></li>
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/byorderid' />">用訂單編號查詢</a></li>
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/byorderdate' />">用下訂日期查詢</a></li>
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/byroomid' />">用房型查詢</a></li>
							</ul></li>



						<li class="nav-item"><a class="nav-link " href="<c:url value="/admin/room/backstage"/>">房型管理</a></li>


						<li class="nav-item"><a class="nav-link " href="<c:url value='/admin/facility/showBacksatge'/>">設施管理</a></li>

						<li class="nav-item"><a class="nav-link " href="${contextRoot}/admin/attraction/list">景點管理</a></li>

						<li class="nav-item"><a class="nav-link" href="<c:url value='/admin/messages/backendall' />">評價管理</a></li>

						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="<c:url value='#'/>" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">會員</a>
							<c:choose>
								<c:when test="${sessionScope.login==true}">
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
										<li><a class="dropdown-item" href="<c:url value='/'/>">前台</a></li>
										<li><a class="dropdown-item " href="<c:url value='/logout'/>"> <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />登出
										</a></li>
									</ul>
								</c:when>
								<c:otherwise>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
										<li><a class="dropdown-item" href="<c:url value='/public/loginpage' />">登入</a></li>
										<li><a class="dropdown-item" href="<c:url value='/public/register' />">註冊</a></li>
									</ul>
								</c:otherwise>
							</c:choose></li>
					</ul>
				</div>

			</div>
		</nav>
		<!-- End Header/Navbar -->

		<main id="main">





			<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
			<div style="height: 200px;"></div>
			<div style="display: flex;">
				<div style="width: 400px; height: 400px;">
					<canvas id="todayRoomBookingRate"></canvas>
				</div>
				<div style="width: 400px; height: 400px;">
					<canvas id="thisMonthRoomBookingRate"></canvas>
				</div>
			</div>

			<script>
				window.onload=function() {
					todayRoomBookingRateDoughnutShow();
					thisMonthRoomBookingRateDoughnutShow();
				}
				function todayRoomBookingRateDoughnutShow() {
					let ctx = document.getElementById("todayRoomBookingRate").getContext("2d");
					let myChart = new Chart(ctx, {
						type: "doughnut",
						data: {
							labels: ["預定", "空房"],
							datasets: [{
								data: [5, 25],	//[\${todayBooked}, \${todayNotBooked}]
								backgroundColor: ["rgba(46, 202, 106, 1)", "rgba(201, 203, 207, 1)"],
								borderColor: ["rgba(255, 99, 132, 1)", "rgba(54, 162, 235, 1)"],
								borderWidth: 0
							}]
						},
						options: {
							responsive: true,
						    plugins: {
						    	legend: {position: "top", },
								title: {display: true, text: "本日訂房率"}
						    }
						}
					});

				}

				function thisMonthRoomBookingRateDoughnutShow() {
					let ctx = document.getElementById("thisMonthRoomBookingRate").getContext("2d");
					let myChart = new Chart(ctx, {
						type: "doughnut",
						data: {
							labels: ["預定", "空房"],
							datasets: [{
								data: [5, 25],	//[\${thisMonthBooked}, \${thisMonthNotBooked}]
								backgroundColor: ["rgba(255, 99, 132, 1)", "rgba(54, 162, 235, 1)"],
								borderColor: ["rgba(255, 99, 132, 1)", "rgba(54, 162, 235, 1)"],
								borderWidth: 1
							}]
						},
						options: {
							responsive: true,
						    plugins: {
						    	legend: {position: "top", },
								title: {display: true, text: "本月訂房率"}
						    }
						}
					});

				}



			</script>










		</main>

		<!-- End #main -->



		<div id="preloader"></div>
		<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

		<!-- Vendor JS Files -->
		<script src="<c:url value='/assets/vendor/bootstrap/js/bootstrap.bundle.min.js' />"></script>
		<script src="<c:url value='/assets/vendor/swiper/swiper-bundle.min.js' />"></script>
		<script src="<c:url value='/assets/vendor/php-email-form/validate.js' />"></script>

		<!-- Template Main JS File -->
		<script src="<c:url value='/assets/js/main.js' />"></script>


	</body>

</html>