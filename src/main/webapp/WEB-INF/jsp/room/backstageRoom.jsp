<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link href="<c:url value='/assets/css/style2.css'/>" rel="stylesheet">

<!-- =======================================================
  * Template Name: EstateAgency - v4.10.0
  * Template URL: https://bootstrapmade.com/real-estate-agency-bootstrap-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->
<style>
.table {
	margin-top: 50px
}
</style>
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
			<a class="navbar-brand text-brand"
				href="<c:url value='/admin/background' />">貝殼窩<span
				class="color-b">管理系統</span></a>

   <div class="navbar-collapse collapse justify-content-center"
    id="navbarDefault">
    <ul class="navbar-nav">



					<li class="nav-item"><a class="nav-link "
						href="${contextRoot}/admin/backstage">基本管理</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/admin/backstage/member' />">會員管理</a></li>

					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">訂單管理</a>

						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/findall' />">訂單一覽</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byemail' />">用Email查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byorderid' />">用訂單編號查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byorderdate' />">用下訂日期查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byroomid' />">用房型查詢</a></li>
						</ul></li>



					<li class="nav-item"><a class="nav-link active"
						href="<c:url value="/admin/room/backstage"/>">房型管理</a></li>


					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/admin/facility/showBacksatge'/>">設施管理</a></li>

					<li class="nav-item"><a class="nav-link "
						href="${contextRoot}/admin/attraction/list">周邊管理</a></li>

					<li class="nav-item"><a class="nav-link"
						href="<c:url value='/admin/messages/backendall' />">評價管理</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="<c:url value='#'/>"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">會員</a> <sec:authorize
							access="hasAnyAuthority('admin','user')">
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<li><a class="dropdown-item" href="<c:url value='/'/>">前台</a></li>
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
							<h1 class="title-single">房型管理</h1>
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
				<input type="button" value="新增" class="btn btn-outline-primary"
					onclick="location.href='<c:url value='/admin/room/create'/>'">

				<table
					class="table table-dark table-striped table-bordered table-hover text-center">
					<tr>
						<th>房號</th>
						<th>房名</th>
						<th>房型</th>
						<th>價錢</th>
						<th>圖片</th>
						<th>修改</th>
					</tr>
					<c:forEach items="${room}" var="msg">

						<tr>
							<td>${msg.roomId}</td>
							<td>${msg.name}</td>
							<td>${msg.type}</td>
							<td>$${msg.price}</td>
							<td><div id="slideshow">
									<div class="slides">
										<c:forEach items="${msg.roomPhotoBeans}" var="photo">
											<img id="img"
												src="<c:url value='/roomId/${photo.photoFile}'/>"
												width="150px" height="100px">
										</c:forEach>
									</div>
								</div></td>

							<td>
								<form action="<c:url value="/admin/room/edit" />" method="get">
									<input type="hidden" name="id1" value="${msg.id}" /><input
										type="submit" class="btn btn-outline-warning" value="編輯">
								</form>
								<form action="<c:url value="/admin/room/delete" />"
									method="post">
									<input type="hidden" name="id" value="${msg.id}" /> <input
										type="hidden" name="_method" value="delete" /> <input
										type="submit" class="btn btn-outline-danger" value="刪除">
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