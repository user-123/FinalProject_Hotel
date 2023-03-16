<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
		<title>BackHome 貝殼窩</title>
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

		<!-- Custom By D.C., need to replace with non-CDN -->
		<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
		<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js" ></script>
		<link href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css" rel="stylesheet" />
		<!-- D.C. Never End, Ya~Ya~Ya~ -->
	</head>
	<body>
		<!-- ======= Header/Navbar ======= -->
		<nav class="navbar navbar-default navbar-trans navbar-expand-lg fixed-top">
			<div class="container">
				<button class="navbar-toggler collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#navbarDefault" aria-controls="navbarDefault" aria-expanded="false" aria-label="Toggle navigation">
					<span></span>	<span></span>	<span></span>
				</button>
				<a class="navbar-brand text-brand" href="<c:url value='/'/>">BackHome<span class="color-b">貝殼窩</span></a>
				<div class="navbar-collapse collapse justify-content-center" id="navbarDefault">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link" href="<c:url value='/'/>">首頁</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value='/public/about' />">關於XXX</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value='/public/room/allShow' />">房型</a></li>
						<li class="nav-item"><a class="nav-link" href="<c:url value='/public/room/orderAllShow' />">訂房</a></li>
						<li class="nav-item"><a class="nav-link" href="#">休閒設施</a></li>
						<li class="nav-item"><a class="nav-link active" href="#">周邊景點</a></li>
						<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="<c:url value='#'/>" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">會員</a>
							<c:choose>
								<c:when test="${sessionScope.login==true}">
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
										<li><a class="dropdown-item" href="<c:url value='/addinfo' />">填寫及修改基本資料</a></li>
										<li><a class="dropdown-item" href="<c:url value='/searchinfo' />">查詢資料</a></li>
										<li><a class="dropdown-item" href="<c:url value='/orders/history' />?accountId=${sessionScope.id}">歷史訂單</a></li>
										<sec:authorize access="hasAuthority('admin')">
											<li><a class="dropdown-item" href="<c:url value="/admin/backstage"/>">後台</a></li>
										</sec:authorize>
										<li><a class="dropdown-item" href="<c:url value='/logout'/>"> <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />登出</a></li>
									</ul>
								</c:when>
								<c:otherwise>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
										<li><a class="dropdown-item" href="<c:url value='/public/loginpage' />">登入</a></li>
										<li><a class="dropdown-item" href="<c:url value='/public/register' />">註冊</a></li>
									</ul>
								</c:otherwise>
							</c:choose>
						</li>
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
								<h1 class="title-single">周邊景點</h1>
							</div>
						</div>
						<div class="col-md-12 col-lg-4">
							<nav aria-label="breadcrumb"
								class="breadcrumb-box d-flex justify-content-lg-end">
								<ol class="breadcrumb">
									<li class="breadcrumb-item"><a href="<c:url value='/'/>">首頁</a></li>
									<li class="breadcrumb-item active" aria-current="page">周邊景點</li>
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
								<form action="<c:url value="/public/attraction/findByCategory" />"
									method="get">
									<select name="category">
										<option value="">全部</option>
										<option value="food">美食</option>
										<option value="spot">景點</option>
									</select>
									<input type="submit" class="btn btn-dark btn-sm" value="搜尋">
								</form>
							</div>
						</div>
						<div class="container" id="attractionPage">
							<div class="row justify-content-between">

								<c:forEach items="${attraction}" var="info" varStatus="status">
									<div class="col-6 col-sm-6">
									<br />
										${status.index+1}.
										<div class="justify-content-center">
											<img src="<c:url value='/uploadDir/a0.jpg'/>" width='500' class='m-1 border rounded ' />
										</div>
										<!--
										<div class="zoomImage" style="background-image:url(<c:url value='/uploadDir/a0.jpg' />)">${status.index+1}.</div>
										 -->
										<div class="row justify-content-start">
											<div class="col-10 col-sm-10">
												${info.attractionName}<br />
												${info.attractionAddress}
											</div>
												<div class="col-2 col-sm-2">
												<!--
												<form action="<c:url value="/public/XXXX" />" method="get">
													<input type="hidden" id="${info.attractionId}" name="Id" value="${info.attractionId}" />
													<input type="submit" id="checkout" class="btn btn-outline-dark btn-sm" value="${XXXXX}檢視">
												</form>
												 -->
												<button class="checkoutBtn btn btn-outline-dark btn-sm" onclick="showDetail(${info.attractionId})">檢視</button>
											</div>
										</div>
									</div>
								</c:forEach>
								<script>

									function showDetail(id) {
										$.ajax({
											method : "get",
											data : {"id": id},
											url : "checkoutAttractionDetail"
										}).done(function(response) {
											console.log("Success:", response);
											let attractionDetail = response;
											let message = "<div>";
											/*
											$.each(attractionDetail, function(i) {
												console.log(`\${i}:\${attractionDetail[i]}`);
												message += `\${i}:\${attractionDetail[i]}<br />`;
												});
											*/
											message += `
												名稱：\${attractionDetail.attractionName}<br />
												分類：\${attractionDetail.attractionCategory}<br />
												地址：\${attractionDetail.attractionAddress}<br />
												距離：\${attractionDetail.attractionDistance}<br />
												介紹：\${attractionDetail.attractionIntroduction}<br />
												照片：\${attractionDetail.attractionPhotoPath}<br />`;
											message += `</div>`;
											console.log(message);
											let modal = $(message).dialog({
							                    width: 600, modal: true, autoOpen: true,
							                    buttons: [{text: "關閉", click: function() {$(this).remove();}}]
							                });
											$(".ui-dialog-titlebar").hide();
											$(".ui-dialog-buttonset button:nth-child(1)").addClass("closeBtn btn btn-outline-secondary btn-sm");
										})
									}


								</script>


							</div>
						</div>
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
							Modified 　　by <a href="">　　　　D.C.</a>
						</div>
						<div class="credits">
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