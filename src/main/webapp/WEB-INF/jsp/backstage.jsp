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
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>
<style>
/* 圖片大小 */
img {
	max-width: 300px;
	max-height: 150px;
	object-fit: contain;
}
</style>

<script>
	window.onload = function() {
		$("#about").on("input", function() {
			let type = document.getElementById("about");
			if (type.value == "") {
				$('.abouterror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.abouterror').html("")
			}
		})
		$('#aboutPhotoOne').on('change', function(event) {
			var previewImages = $('#preview-images1');
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
						console.log(event.target.result)
						var img = $('<img>').attr('src', event.target.result);
						previewImages.append(img);
					}

					reader.readAsDataURL(file);
				}
			}
		});
		$('#aboutPhotoTwo').on('change', function(event) {
			var previewImages = $('#preview-images2');
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
						console.log(event.target.result)
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
			<a class="navbar-brand text-brand" href="<c:url value='#'/>"><span
				class="color-b">XXX飯店管理系統</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">

					<li class="nav-item"><a class="nav-link active" href="#">基本管理</a></li>

					<li class="nav-item"><a class="nav-link " href="#">會員管理</a></li>

					<li class="nav-item"><a class="nav-link " href="#">訂單管理</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value="/admin/room/backstage"/>">房型管理</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/admin/facility/showBacksatge'/>">設施管理</a></li>

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
							<h1 class="title-single">基本管理</h1>
							<div class="form-comments">
								<form:form method="PUT" action="${contextRoot}/admin/edit"
									modelAttribute="homeBean" enctype="multipart/form-data"
									id="facility">
									<div class="row">
										<form:input type="hidden" path="id" id="id" />

										<div class="">
											<div class="form-group">
												<form:label path="about">
																	關於:</form:label>
												<br>
												<form:textarea path="about" id="about" class="input"
													rows="10" cols="80" maxlength="250" required="true" />
												<span class="abouterror err"></span>
											</div>
										</div>
										<div class="">
											<div class="form-group">
												<label for="aboutPhotoOne">關於圖片(上):</label> <input
													type="file" id="aboutPhotoOne" name="aboutPhotoOne"
													accept="image/*"><br> <span
													class="aboutPhoto1-photoserror err"></span> <br>

												<div id="preview-images1">
													<img id="img" name="img"
														src="<c:url value='/roomId/${homeBean.aboutPhoto1}'/>">
												</div>
											</div>
										</div>
										<br> <br> <br> <br> <br> <br> <br>
										<br> <br> <br> <br>
										<div class="">
											<div class="form-group">
												<label for="aboutPhotoTwo">關於圖片(下):</label> <input
													type="file" id="aboutPhotoTwo" name="aboutPhotoTwo"
													accept="image/*"><br> <span
													class="aboutPhoto2-photoserror err"></span> <br>

												<div id="preview-images2">
													<img id="img" name="img"
														src="<c:url value='/roomId/${homeBean.aboutPhoto2}'/>">
												</div>
											</div>
										</div>
										<!-- 										<br> <br> <br> -->
										<!-- 										<div class=""> -->
										<!-- 											<div class="form-group"> -->
										<!-- 												<label for="photos">首頁圖片:</label> <input type="file" -->
										<!-- 													id="photos" name="home" accept="image/*" multiple><br> -->
										<!-- 												<span class="home-photoserror err"></span> -->
										<!-- 												<div id="preview-images"> -->
										<!-- 													<div id="preview-images"> -->
										<%-- 														<c:forEach items="" var="photo"> --%>
										<!-- 															<img id="img" name="img" src="'/>"> -->
										<%-- 														</c:forEach> --%>
										<!-- 													</div> -->
										<!-- 												</div> -->
										<!-- 											</div> -->
										<!-- 										</div> -->
									</div>
									<div style="text-align: right">
										<input type="submit" value="Submit" id="submit" />
									</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
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