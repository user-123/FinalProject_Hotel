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
.form-comments {
	margin-top: 100px
}

.box-1 {
	margin-top: 50px
}

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

		$("#facility").submit(function(e) {
			e.preventDefault();
			var formData = new FormData(this);
			$.ajax({
				url : "${contextRoot}/admin/edit",
				type : "post",
				data : formData,
				enctype : 'multipart/form-data',
				processData : false,
				contentType : false,
				cache : false,
				beforeSend : function(xhr) {
					//headers: {"X-HTTP-Method-Override": "PUT"} 是加上一個自定義的HTTP Header，名稱為X-HTTP-Method-Override，值為PUT。這是一種比較常見的技巧，通常用在當前端瀏覽器不支援某些HTTP方法（如PUT、DELETE等）時，可以利用這種方法模擬這些方法的請求。在這種情況下，我們可以在AJAX請求中加上這個Header，然後在後端伺服器端判斷這個Header，來模擬PUT或DELETE請求。
					//PUT請求送不出去!! 所以添加X-HTTP-Method-Override頭部，用於指定PUT請求
					xhr.setRequestHeader('X-HTTP-Method-Override', 'PUT');
				},
				success : function(response) {
					// 成功時的處理
					Swal.fire('更新成功', '', 'success');
				}
			});
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



					<li class="nav-item"><a class="nav-link active"
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
								href="<c:url value='/admin/orders/byemail' />">用Email查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byorderid' />">用訂單編號查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byorderdate' />">用下訂日期查詢</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byroomid' />">用房型查詢</a></li>
						</ul></li>



					<li class="nav-item"><a class="nav-link "
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

										<div>
											<div class="form-group">
												<form:label path="about">
													<h5>貝殼窩的理念:</h5>
												</form:label>
												<br>
												<form:textarea path="about" id="about" class="input"
													rows="10" cols="80" maxlength="250" required="true" />
												<span class="abouterror err"></span>
											</div>
										</div>
										<div class="box-1">
											<div class="form-group">
												<label for="aboutPhotoOne"><h5>圖片(上):</h5></label> <input
													type="file" id="aboutPhotoOne" name="aboutPhotoOne"
													accept="image/*"><br> <span
													class="aboutPhoto1-photoserror err"></span> <br>

												<div id="preview-images1">
													<img id="img" name="img"
														src="<c:url value='/roomId/${homeBean.aboutPhoto1}'/>">
												</div>
											</div>
										</div>
										<div class="box-1">
											<div class="form-group">
												<label for="aboutPhotoTwo"><h5>圖片(下):</h5></label> <input
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
										<input type="submit" value="儲存" id="submit"
											class="btn btn-danger" />
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