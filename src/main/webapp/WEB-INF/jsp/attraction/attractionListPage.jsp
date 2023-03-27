<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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

<!-- Custom By D.C., need to replace with non-CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<link
	href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css"
	rel="stylesheet" />
<!-- D.C. Never End, Ya~Ya~Ya~ -->
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
					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/facility/show'/>">休閒設施</a></li>

					<li class="nav-item"><a class="nav-link active"
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
							<h1 class="title-single">周邊美食&景點</h1>
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
					<div class="col-sm-12">
						<div class="grid-option">
							<form
								action="<c:url value="/public/attraction/findByCategory" />"
								method="get">
								<select name="category">
									<option value="">全部</option>
									<option value="food">美食</option>
									<option value="spot">景點</option>
								</select> <input type="submit" class="btn btn-dark btn-sm" value="搜尋">
							</form>
						</div>
					</div>
					<div class="container" id="attractionPage">
						<div class="row justify-content-between">

							<c:forEach items="${attraction}" var="info" varStatus="status">
								<div class="col-6 col-sm-6">
									<br />
									<div style="font-weight: bold;">${status.index+1}.</div>
									<div class="justify-content-center"
										style="overflow: hidden; width: 512px; height: 384px;">
										<img
											src="<c:url value='/attractionPhoto/${info.attractionPhotoPath}'/>"
											style="width: 100%; height: 100%;" class="m-1 border rounded" />
									</div>
									<!--
										<div class="zoomImage" style="background-image:url(<c:url value='/uploadDir/a0.jpg' />)">${status.index+1}.</div>
										 -->
									<div class="row justify-content-start">
										<div style="margin-left: 10px;">
											<div style="display: flex">
												<div class="col-md-8">${info.attractionName}<br>
												地址:${info.attractionAddress}</div>
												<div style="margin-left: 30px">
													<button class="checkoutBtn btn btn-outline-dark"
														onclick="showDetail(${info.attractionId})">🔍</button>
												</div>
											</div>
												<!--
												<form action="<c:url value="/public/XXXX" />" method="get">
													<input type="hidden" id="${info.attractionId}" name="Id" value="${info.attractionId}" />
													<input type="submit" id="checkout" class="btn btn-outline-dark btn-sm" value="${XXXXX}檢視">
												</form>
												 -->
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
												照片：
												<div class="justify-content-center">
													<img src="<c:url value='/attractionPhoto/\${attractionDetail.attractionPhotoPath}'/>" width="768" class="m-1 border rounded" />
												</div><br />`;
											message += `</div>`;
											console.log(message);
											let modal = $(message).dialog({
							                    width: 896, modal: true, autoOpen: true,
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
							&copy; Copyright <span></span> All
							Rights Reserved.
						</p>
					</div>
					<div class="credits">
						　Modified　　　by　　　<a href="">　D.C.　</a>
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