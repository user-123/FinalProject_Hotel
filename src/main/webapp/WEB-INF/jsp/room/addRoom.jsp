<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
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

					<li class="nav-item"><a class="nav-link " href="#">房型管理</a></li>

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
		<section class="intro-single">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="title-single-box">
							<h1 class="title-single">新增房型</h1>
							<div class="form-comments">
								<form:form method="POST" action="${contextRoot}/admin/room/add"
									modelAttribute="roomBean" enctype="multipart/form-data">
									<div class="row">
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="roomId">房號:</form:label>
												<br>
												<form:input path="roomId" />
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="name">房名:</form:label>
												<br>
												<form:input path="name" />
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="type">
              房型:</form:label>
												<br>
												<form:select path="type">
													<option value="">請選擇房型</option>
													<option value="雙人房">雙人房</option>
													<option value="四人房">四人房</option>
													<option value="六人房">六人房</option>
												</form:select>

											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="price">
              價錢:</form:label>
												<br>
												<form:input path="price" />
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="roomNameIntroduction">
              房型介紹:</form:label>
												<br>
												<form:textarea path="roomNameIntroduction" rows="6"
													cols="45" />
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="introduce">
              簡介:</form:label>
												<br>
												<form:textarea path="introduce" rows="6" cols="45" />
											</div>
										</div>

										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="equipment">
              設備:</form:label>
												<br>
												<form:textarea path="equipment" rows="6" cols="45" />
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="service">
              服務:</form:label>
												<br>
												<form:textarea path="service" rows="6" cols="45" />
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="remark">
              備註:</form:label>
												<br>
												<form:textarea path="remark" rows="6" cols="45" />
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<label for="room-photos">圖片:</label> <input type="file"
													id="room-photos" name="files" multiple>
											</div>
										</div>
									</div>
									<div style="text-align: right">
										<input type="submit" value="Submit" />
									</div>
									<div class="col-md-6 mb-3">
										<div class="form-group">
											<a class="btn btn-danger"
												href="<c:url value="/admin/room/backstage"/>">上一頁</a>
										</div>
									</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>





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