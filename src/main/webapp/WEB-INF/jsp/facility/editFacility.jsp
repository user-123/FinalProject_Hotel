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
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>

<style>
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button, input::-webkit-inner-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

/* Firefox */
input[type=number] {
	-moz-appearance: textfield;
}

/* 圖片大小 */
img {
	max-width: 300px;
	max-height: 150px;
	object-fit: contain;
	max-height: 150px;
}

.form-comments {
	margin-top: 100px
}
</style>

<script>
	window.onload = function() {
		let Id = document.getElementById("id");
		$("#name").on("input", function() {
			let name = document.getElementById("name");
			if (name.value == "") {
				$('.nameerror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.nameerror').html("")
			}

			$.ajax({
				method : 'get',
				data : {
					'Id' : Id.value,
					'name' : name.value
				},
				url : 'updataCheckNamne',

				success : function(result) {
					$('.nameerror').html(result).css({
						"color" : "red",
						"font-size" : "10%"
					})
					if (result != "")
						$('#submittest').prop('disabled', true)

					else
						$('#submittest').prop('disabled', false)
				}

			})
		})

		$("#introduce").on("input", function() {
			let introduce = document.getElementById("introduce");
			if (introduce.value == "") {
				$('.introduceerror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.introduceerror').html("")
			}
		})

		$("#service").on("input", function() {
			let service = document.getElementById("service");
			if (service.value == "") {
				$('.serviceerror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.serviceerror').html("")
			}
		})

		let input = document.querySelectorAll(".input");

		$('#submit').on("click", function(event) {
			for (let i = 0; i < input.length; i++) {
				if (input[i].value == "") {
					$(input[i]).closest("div").find(".err").html("必填").css({
						"color" : "red",
						"font-size" : "10%"
					})
				}

			}

		})

		$('#submitShow').on('click', function(event) {
			if (!$("#submittest").prop('disabled'))
				$('#submittest').click()
		})
		$('#submittest').on('click', function(event) {
			if (!$("#submit").prop('disabled'))
				$('#submit').click()
		})

		$('#room-photos').on('change', function(event) {
			var previewImages = $('#preview-images');
			previewImages.empty();

			var files = this.files;
			var isAllImages = true;

			for (var i = 0; i < files.length; i++) {
				var file = files[i];
				var fileType = file.type;
				var maxSizeInBytes = 5e+6; // 5MB
				var fileSizeInBytes = file.size;

				if (fileType.indexOf('image') === -1) {
					isAllImages = false;
					break;
				}
			}

			if (!isAllImages) {
				Swal.fire('格式錯誤!', '請上傳正確的圖片格式', 'error');
				this.value = '';
			} else if (fileSizeInBytes > maxSizeInBytes) {
				Swal.fire('檔案過大!', '請選擇小於5MB的圖片檔案', 'error');
				this.value = '';
			} else {

				for (var i = 0; i < files.length; i++) {
					var file = files[i];
					var reader = new FileReader();

					reader.onload = function(event) {
						var img = $('<img>').attr('src', event.target.result);
						previewImages.append(img);
					}

					reader.readAsDataURL(file);
				}
			}
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

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" role="button"
						data-bs-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">訂單管理</a>

						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/findall' />">訂單一覽</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byuserid' />">用會員名稱查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byorderid' />">用訂單編號查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byorderdate' />">用下訂日期查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byroomid' />">用房型查詢</a></li>
						</ul></li>



					<li class="nav-item"><a class="nav-link "
						href="<c:url value="/admin/room/backstage"/>">房型管理</a></li>


					<li class="nav-item"><a class="nav-link active"
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
		<section class="intro-single">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="title-single-box">
							<h1 class="title-single">編輯設施</h1>
							<div class="form-comments">
								<form:form method="PUT"
									action="${contextRoot}/admin/facility/update"
									modelAttribute="facilityBean" enctype="multipart/form-data"
									id="facility">
									<div class="row">
										<form:input type="hidden" path="id" id="id" />
										<div class="">
											<div class="form-group">
												<form:label path="name">
													<h5>設施名稱:</h5>
												</form:label>
												<br>
												<form:input path="name" id="name" class="input"
													required="true" />
												<span class="nameerror err"></span>
											</div>
										</div>
										<div class="">
											<div class="form-group">
												<form:label path="introduce">
													<h5>簡介:</h5>
												</form:label>
												<br>
												<form:textarea path="introduce" id="introduce" class="input"
													rows="10" cols="80" maxlength="170" required="true" />
												<span class="introduceerror err"></span>
											</div>
										</div>
										<div class="">
											<div class="form-group">
												<form:label path="service">
													<h5>服務:</h5>
												</form:label>
												<br>
												<form:textarea path="service" id="service" class="input"
													rows="10" cols="80" required="true" />
												<span class="serviceerror err"></span>
											</div>
										</div>
										<div class="">
											<div class="form-group">
												<label for="room-photos"><h5>圖片:</h5></label> <input
													type="file" id="room-photos" name="files" accept="image/*"
													multiple><br> <span
													class="room-photoserror err"></span>
												<div id="preview-images">
													<div id="preview-images">
														<c:forEach items="${facilityBean.facilityPhotoBeans}"
															var="photo">
															<img id="img" name="img"
																src="<c:url value='/roomId/${photo.photoFile}'/>">
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div style="text-align: right">
										<a class="btn btn-primary"
											href="${contextRoot}
															/admin/facility/showBacksatge">取消</a><input
											style="display: none" type="submit" value="Submit"
											id="submit" /> <input style="display: none" type="button"
											value="submittest" id="submittest" /> <input type="button"
											value="儲存" id="submitShow" class="btn btn-danger" />
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