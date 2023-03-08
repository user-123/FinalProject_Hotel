<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<title>XXX飯店管理系統</title>
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
			<a class="navbar-brand text-brand" href="<c:url value='#'/>"><span
				class="color-b">XXX飯店管理系統</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">

					<li class="nav-item"><a class="nav-link " href="#">會員管理</a></li>

					<li class="nav-item"><a class="nav-link " href="#">訂單管理</a></li>

					<li class="nav-item"><a class="nav-link active" href="#">房型管理</a></li>

					<li class="nav-item"><a class="nav-link " href="#">設施管理</a></li>

					<li class="nav-item"><a class="nav-link " href="#">景點管理</a></li>


					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="<c:url value='#'/>"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">會員</a> <c:choose>
							<c:when test="${sessionScope.login==true}">
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<li><a class="dropdown-item" href="<c:url value='/'/>">前台</a></li>
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
							<h1 class="title-single">管理房型</h1>
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
							<form action="<c:url value="/admin/room/backstageShowType" />"
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
				</div>
				<input type="button" value="新增" class="btn btn-primary"
					onclick="location.href='<c:url value='/admin/room/create'/>'">

				<table
					class="table table-striped table-bordered table-hover text-center">
					<tr>
						<th>房號</th>
						<th>房名</th>
						<th>房型</th>
						<th>價錢</th>
						<th>房型介紹</th>
						<th>簡介</th>
						<th>設備</th>
						<th>服務</th>
						<th>備註</th>
						<th>修改</th>
					</tr>
					<c:forEach items="${room}" var="msg">

						<tr>
							<td>${msg.roomId}</td>
							<td>${msg.name}</td>
							<td>${msg.type}</td>
							<td>${msg.price}</td>
							<td>${msg.roomNameIntroduction}</td>
							<td>${msg.introduce}</td>
							<td>${msg.equipment}</td>
							<td>${msg.service}</td>
							<td>${msg.remark}</td>

							<td>
								<form action="<c:url value="/admin/room/edit" />" method="get">
									<input type="hidden" name="id1" value="${msg.id}" /><input
										type="submit" class="btn btn-outline-danger btn-sm"
										value="編輯資料">
								</form>
								<form action="<c:url value="/admin/room/delete" />"
									method="post">
									<input type="hidden" name="id" value="${msg.id}" /> <input
										type="hidden" name="_method" value="delete" /> <input
										type="submit" class="btn btn-outline-danger btn-sm" value="刪除">
								</form>
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</section>
	</main>
	<!-- End #main -->



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