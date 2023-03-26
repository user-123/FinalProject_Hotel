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

		<title>貝殼窩-管理系統</title>
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
		<link href="<c:url value='/assets/css/style2.css'/>" rel="stylesheet">

		<!-- Custom By D.C., need to replace with non-CDN -->
		<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
		<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js" ></script>
		<link href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css" rel="stylesheet" />
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/animejs@3.2.1/lib/anime.min.js"></script>
		<script src="https://unpkg.com/scrollreveal@4"></script>
		<!-- D.C. Never End, Ya~Ya~Ya~ -->

	</head>

	<body>
		<!-- ======= Header/Navbar ======= -->
		<nav class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">
			<div class="container">
				<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarDefault" aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
					<span></span> <span></span> <span></span>
				</button>
				<a class="navbar-brand text-brand" href="<c:url value='/admin/background' />">貝殼窩<span class="color-b">管理系統</span></a>

				<div class="navbar-collapse collapse justify-content-center" id="navbarDefault">
					<ul class="navbar-nav">



						<li class="nav-item"><a class="nav-link" href="${contextRoot}/admin/backstage">基本管理</a></li>

						<li class="nav-item"><a class="nav-link " href="<c:url value='/admin/backstage/member' />">會員管理</a></li>

						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">訂單管理</a>

							<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/findall' />">訂單一覽</a></li>
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/byemail' />">用Email查詢</a></li>
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/byorderid' />">用訂單編號查詢</a></li>
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/byorderdate' />">用下訂日期查詢</a></li>
								<li><a class="dropdown-item" href="<c:url value='/admin/orders/byroomid' />">用房型查詢</a></li>
							</ul></li>



						<li class="nav-item"><a class="nav-link " href="<c:url value="/admin/room/backstage"/>">房型管理</a></li>

						<li class="nav-item"><a class="nav-link " href="<c:url value='/admin/facility/showBacksatge'/>">設施管理</a></li>

						<li class="nav-item"><a class="nav-link " href="${contextRoot}/admin/attraction/list">周邊管理</a></li>

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
			<div style="display: flex;justify-content: center;">
				<div class="justify-content-around" style="display: flex;">
					<div id="dayRoomBookingRateDiv" style="width: 400px; height: 400px;display: flex;justify-content: center;align-items: center;">
						<canvas id="dayRoomBookingRateChart" style="position: absolute;"></canvas>
						<div id="dayRoomBookingRateCounter" style="font-size: 3em;"></div>
					</div>
					<div id="datePicker">
						<input id="selDate" type="date" />
					</div>
					<div id="monthRoomBookingRateDiv" style="width: 400px; height: 400px;display: flex;justify-content: center;align-items: center;">
						<canvas id="monthRoomBookingRateChart" style="position: absolute;"></canvas>
						<div id="monthRoomBookingRateCounter" style="position: absolute;font-size: 3em;"></div>
					</div>
				</div>
			</div>

			<script>
				window.onload=function() {
					getAndSetNowDate();
					document.getElementById("selDate").addEventListener("change", (event) => {
						//let insertDate = document.getElementById("selDate").value;
						//console.log(`\${insertDate}`);
						//console.log(`\${new Date(insertDate)}`);
						//console.log(`\${event.target.value}`);
						//console.log(`\${new Date(event.target.value)}`);
						getOccupancyRateChartOfDay(new Date(event.target.value));
						getOccupancyRateChartOfMonth(new Date(event.target.value));
					});
					getOccupancyRateChartOfDay(new Date(nowDate));
					getOccupancyRateChartOfMonth(new Date(nowDate));
				}

				let nowDate;
				let nowYear;
				let nowMonth;
				let nowDay;
				function getAndSetNowDate() {
					nowYear=new Date().getFullYear();
					nowMonth=new Date().getMonth()+1;
					nowDay=new Date().getDate();
					nowDate=`\${nowYear}-\${nowMonth.toString().padStart(2, "0")}-\${nowDay.toString().padStart(2, "0")}`;
					console.log(`現在日期：\${nowYear}/\${nowMonth}/\${nowDay}`);
					console.log(nowDate);
					document.getElementById("selDate").value = nowDate;
				}
				function getOccupancyRateChartOfDay(date) {
					$.ajax({
						method : "get",
						data : {"date": date},
						url : "controlpanel/getOccupancyRateOfDay"
					}).done(function(response) {
						console.log("occupancyRateChartOfDay: ", response);
						occupancyRateChartOfDayShow(response.bookedRooms, response.notBookedRooms);
						occupancyRateCounterOfDayShow(response.percent);

					});
				}
				function occupancyRateChartOfDayShow(dayBooked, dayNotBooked) {
					document.getElementById("dayRoomBookingRateDiv").innerHTML = `<canvas id="dayRoomBookingRateChart" style="position: absolute;"></canvas><div id="dayRoomBookingRateCounter" style="position: absolute;font-size: 3em;transform: translate(0, 50%);opacity: 0;transition-property: opacity;transition-duration: 3s;"></div>`;
					let ctx = document.getElementById("dayRoomBookingRateChart").getContext("2d");
					let myChart = new Chart(ctx, {
						type: "doughnut",
						data: {
							labels: ["預定", "空房"],
							datasets: [{
								data: [dayBooked, dayNotBooked],
								backgroundColor: ["rgba(252, 110, 55, 1)", "rgba(201, 203, 207, 1)"],
								borderColor: ["rgba(252, 110, 55, 1)", "rgba(201, 203, 207, 1)"],
								borderWidth: 0
							}]
						},
						options: {
							responsive: true,
						    plugins: {
						    	legend: {position: "top", },
								title: {display: true, text: "當日訂房率"}
						    }
						}
					});

				}
				function occupancyRateCounterOfDayShow(occPercent) {
					let counter = document.getElementById("dayRoomBookingRateCounter");
					counter.style.opacity = "1";
					anime({
						targets: counter,
						innerHTML: [0, `\${occPercent}%`],
						easing: "easeInQuad",	//原本設為linear
						round: 100,
						duration: 1000,
						delay: 500
					});
				}

				function getOccupancyRateChartOfMonth(date) {
					$.ajax({
						method : "get",
						data : {"date": date},
						url : "controlpanel/getOccupancyRateOfMonth"
					}).done(function(response) {
						console.log("occupancyRateChartOfMonth: ", response);
						occupancyRateChartOfMonthShow(response.bookedRooms, response.notBookedRooms);
						occupancyRateCounterOfMonthShow(response.percent);
					});
				}
				function occupancyRateChartOfMonthShow(monthBooked, monthNotBooked) {
					document.getElementById("monthRoomBookingRateDiv").innerHTML = `<canvas id="monthRoomBookingRateChart" style="position: absolute;"></canvas><div id="monthRoomBookingRateCounter" style="position: absolute;font-size: 3em;transform: translate(0, 50%);opacity: 0;transition-property: opacity;transition-duration: 3s;"></div>`;
					let ctx = document.getElementById("monthRoomBookingRateChart").getContext("2d");
					let myChart = new Chart(ctx, {
						type: "doughnut",
						data: {
							labels: ["預定", "空房"],
							datasets: [{
								data: [monthBooked, monthNotBooked],
								backgroundColor: ["rgba(252, 110, 55, 1)", "rgba(201, 203, 207, 1)"],
								borderColor: ["rgba(252, 110, 55, 1)", "rgba(201, 203, 207, 1)"],
								//backgroundColor: ["rgba(255, 99, 132, 1)", "rgba(54, 162, 235, 1)"],
								//borderColor: ["rgba(255, 99, 132, 1)", "rgba(54, 162, 235, 1)"],
								borderWidth: 0
								//borderWidth: 1
							}]
						},
						options: {
							responsive: true,
						    plugins: {
						    	legend: {position: "top", },
								title: {display: true, text: "當月訂房率"}
						    }
						}
					});
					//ScrollReveal({duration: 3000});
					//ScrollReveal().reveal("#monthRoomBookingRateCounter");

				}
				function occupancyRateCounterOfMonthShow(occPercent) {
					let counter = document.getElementById("monthRoomBookingRateCounter");
					counter.style.opacity = "1";
					anime({
						targets: counter,
						innerHTML: [0, `\${occPercent}%`],
						easing: "easeInQuad",	//原本設為linear
						round: 100,
						duration: 1000,
						delay: 500
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