<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>

<head>
<link rel="icon" href="<c:url value='/favicon.ico' />">
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>XX飯店</title>
<meta content="" name="description">
<meta content="" name="keywords">

<style>
.container {
	width: 900px;
	margin: 0 auto;
}

.container h1 {
	margin: 20px;
	text-align: center;
}

.container form {
	padding: 20px;
	background: #EBF0F4;
	border-radius: 10px;
}

.messages {
	margin: 10px 5px;
	color: #dc3545
}
</style>

<!-- Favicons -->
<link href="<c:url value='/assets/img/favicon.png'/>" rel="icon">
<link href="<c:url value='/assets/img/apple-touch-icon.png'/>"
	rel="apple-touch-icon">

<!-- Google Fonts -->
<link
	href='https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700'
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="<c:url value='/assets/vendor/animate.css/animate.min.css'/>"
	rel="stylesheet">
<link
	href="<c:url value='/assets/vendor/bootstrap/css/bootstrap.min.css'/>"
	rel="stylesheet">
<link
	href="<c:url value='/assets/vendor/bootstrap-icons/bootstrap-icons.css'/>"
	rel="stylesheet" type="text/css">
<link
	href="<c:url value='/assets/vendor/swiper/swiper-bundle.min.css'/>"
	rel="stylesheet">

<!-- Template Main CSS File -->
<link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<%-- 上面是CDN，下面是文硯地端資源 --%>
<%-- <script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>"></script> --%>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>"></script>

<script>
	window.onload = function() {
		let error;
		//  		$("#birthDate").on("input",function() {
		// 			let birthdate = document.getElementById("birthDate");
		// 			filter = /^\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$/;
		// 			if (!birthdate.value.match(filter)) {
		// 				if(birthdate.value=="")
		// 					$('.birthDateerror').html("")
		// 				else{
		// 					$('.birthDateerror').html("請輸入正確格式").css({
		// 						"color" : "red",
		// 						"font-size" : "10%"
		// 					})
		// 				}
		// 			}else{
		// 				$('.birthDateerror').html("")
		// 			}

		// 		});

		$("#phone").on("input", function() {
			let phone = document.getElementById("phone");
			filter = /^09\d{8}$/;
			if (!phone.value.match(filter)) {
				if (phone.value == "")
					$('.phoneerror').html("必填").css({
						"color" : "red",
						"font-size" : "10%"
					})
				else {
					$('.phoneerror').html("請輸入正確格式").css({
						"color" : "red",
						"font-size" : "10%"
					})
				}
			} else {
				$('.phoneerror').html("")
			}

		});

		$("#userName").on("input", function() {
			let username = document.getElementById("userName");
			if (username.value != "")
				$('.userNameerror').html("")
			else
				$('.userNameerror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})

		});

		//  		$("#phone").on("input",function() {
		// 			let phone = document.getElementById("phone");
		// 			if (phone.value!="")
		// 					$('.phoneerror').html("")
		// 			else
		// 				$('.phoneerror').html("必填")
		// 		});

		$('#uploadedFile').on(
				"change",
				function() {
					let filetype = this.files[0]['name'].split(".")
					let filesize = this.files[0]['size']
					let accepttype = [ "jpg", "png", "jpeg", "webp", "gif" ]
					if ((!accepttype.includes(filetype[filetype.length - 1]))
							|| (filesize > 8 * 1024)) {
						alert("請上傳圖片形式的檔案(檔案大小限制8kb)");
						this.value = ""
						$('#img-preview').attr('src',
								'<c:url value="/images/default2.jpg"/>')

					}

					let output = document.getElementById('img-preview');
					output.src = URL.createObjectURL(event.target.files[0]);
					console.log(event.target.files);
					output.onload = function() {
						URL.revokeObjectURL(output.src)
					}

				})
		// 		let email = document.getElementById("email");
		// 		let password = document.getElementById("password");
		// 		let confirm = document.getElementById("confirm");
		// 		let phone = document.getElementById("phone");
		let required = document.querySelectorAll(".need");
		let colerror = document.querySelectorAll(".error");
		// 		$("#email").on("input",function() {
		// 				filter = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
		// 				if (!email.value.match(filter)) {
		// 					$('.emailerror').html("請輸入正確格式").css({
		// 						"color" : "red",
		// 						"font-size" : "10%"
		// 					})
		// 				}else{
		// 					if(email!="")
		// 					$('.emailerror').html("")
		// 				}

		// 			});

		const birthDate = document.getElementById('birthDate');

		birthDate.addEventListener('blur', function() {
			const dateRegex = /^19[0-9]{2}|20[0-9]{2}-\d{2}-\d{2}$/;

			if (!dateRegex.test(birthDate.value)) {
				$('.birthDateerror').html("日期格式不正確，請輸入 YYYY-MM-DD 格式").css({
					"color" : "red",
					"font-size" : "10%"
				});
			} else {
				$('.birthDateerror').html("");
			}
		});

		birthDate.addEventListener('input', function() {
			const dateRegex = /^19[0-9]{2}|20[0-9]{2}-\d{2}-\d{2}$/;

			if (dateRegex.test(birthDate.value)) {
				$('.birthDateerror').html("").css({
					"color" : "red",
					"font-size" : "10%"
				});
			}
		});

		$('#checksubmit').on(
				"click",
				function(event) {
					error = "no"
					const dateRegex = /^19[0-9]{2}|20[0-9]{2}-\d{2}-\d{2}$/;
					if (!dateRegex.test(birthDate.value)) {
						$('.birthDateerror').html("日期格式不正確，請輸入 YYYY-MM-DD 格式")
								.css({
									"color" : "red",
									"font-size" : "10%"
								});
					}

					for (let i = 0; i < required.length; i++) {

						if (required[i].value == "") {
							error = "yes";
							$(required[i]).closest("div").find(".error").html(
									"必填").css({
								"color" : "red",
								"font-size" : "10%"
							})
						}

					}
					for (let i = 0; i < colerror.length; i++) {
						if ($(colerror[i]).html() != "") {
							error = "yes";
						}

					}
					if (error == "no") {
						$('#submit').click();
						$('#memberForm').find('button').prop('disabled', true);
						for (let i = 0; i < required.length; i++) {
							required[i].disabled = true;
						}
					}

				})

		$('#submit').on("click", function(event) {
			$('#memberForm').submit();
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
			<a class="navbar-brand text-brand" href="<c:url value='/'/>">XXX<span
				class="color-b">大飯店</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/'/>">首頁</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/about'/>">關於XXX</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/room/allShow'/>">房型</a></li>

					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/room/orderAllShow'/>">訂房</a></li>

					<li class="nav-item"><a class="nav-link " href="#">休閒設施</a></li>

					<li class="nav-item"><a class="nav-link " href="#">周邊景點</a></li>

					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="<c:url value='#'/>"
						id="navbarDropdown" role="button" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">會員</a> <c:choose>
							<c:when test="${sessionScope.login==true}">
								<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<li><a class="dropdown-item"
										href="<c:url value='/addinfo' />">填寫及修改基本資料</a></li>
									<li><a class="dropdown-item"
										href="<c:url value='/searchinfo' />">查詢資料</a></li>
									<li><a class="dropdown-item"
										href="<c:url value='/orders/history' />?accountId=${sessionScope.id}">歷史訂單</a></li>
									<sec:authorize access="hasAuthority('admin')">
										<li><a class="dropdown-item"
											href="<c:url value="/admin/backstage"/>">後台</a></li>
									</sec:authorize>
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
	<c:choose>
		<c:when test="${requestScope.info==true}">
			<div class="container">
				<h1>修改會員資料</h1>
				<form:form id="memberForm" method="post" modelAttribute="memberBean"
					enctype="multipart/form-data">
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="userName">姓名</label>
							<form:input id="userName" class="form-control need" type="text"
								placeholder="姓名" name="userName" path="userName"
								value="${mb.userName}" />
							<span class="userNameerror error"></span>
						</div>



						<div class="form-group col-md-6">
							<label for="phone">手機</label>
							<form:input id="phone" class="form-control need" type="text"
								placeholder="手機" name="phone" path="phone" value="${mb.phone}" />
							<span class="phoneerror error"></span>
						</div>




						<div class="form-group col-md-6">
							<label for="gender">性別</label>
							<c:choose>
								<c:when test="${mb.gender == '男'}">
									<div>
										<label for="male"> 男 <form:radiobutton path="gender"
												name="male" value="男" class="need" checked="checked" />
										</label> <label for="female"> 女 <form:radiobutton
												path="gender" name="female" value="女" class="need" />
										</label>
									</div>
								</c:when>
								<c:otherwise>
									<div>
										<label for="male"> 男 <form:radiobutton path="gender"
												name="male" value="男" class="need" />
										</label> <label for="female"> 女 <form:radiobutton
												path="gender" name="female" value="女" class="need"
												checked="checked" />
										</label>
									</div>
								</c:otherwise>
							</c:choose>
							<span class="gendererror error"></span>
						</div>


						<div class="form-group col-md-6">
							<label for="birthDate">生日</label>
							<form:input id="birthDate" class="form-control" type="date"
								placeholder="生日" name="birthDate" path="birthDate"
								value="${mb.birthDate}" />
							<span class="birthDateerror error"></span> <span
								class="birthDateerrorhidden" style="visibility: hidden"></span>
						</div>



						<div class="mb-3">
							<div class="row">
								<div class="col-sm-9">
									<label for="uploadedFile" class="form-label">上傳照片</label> <input
										value="${mb.photoPath}" class="form-control" type="file"
										name="uploadedFile" id="uploadedFile" accept="image/*" />
									<!-- 要多張照片用multiple="multiple" -->
								</div>
								<div class="col-sm-3">
									<div class="form-control" style="height: 100px;">
										<c:choose>
											<c:when test="${mb.photoPath == ''}">
												<img src="<c:url value='/images/default2.jpg'/>"
													name="img-preview" id="img-preview" class="h-100 w-100" />
											</c:when>
											<c:otherwise>
												<img src="<c:url value='/uploadDir/${mb.photoPath}'/>"
													name="img-preview" id="img-preview" class="h-100 w-100" />
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div>

					</div>
					<button type="button" id="checksubmit" class="btn btn-primary">送出修改</button>
					<button style="visibility: hidden" type="submit" id="submit"
						class="btn btn-primary"></button>
				</form:form>
				<div class="text-danger"></div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="container">
				<h1>新增會員資料</h1>
				<form:form id="memberForm" method="post" modelAttribute="memberBean"
					enctype="multipart/form-data">
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="userName">姓名</label>
							<form:input id="userName" class="form-control need" type="text"
								placeholder="姓名" name="userName" path="userName" />
							<span class="userNameerror error"></span>
						</div>



						<div class="form-group col-md-6">
							<label for="phone">手機</label>
							<form:input id="phone" class="form-control need" type="text"
								placeholder="手機" name="phone" path="phone" />
							<span class="phoneerror error"></span>
						</div>

						<div class="form-group col-md-6">
							<label for="gender">性別</label>
							<div>
								<label for="male"> 男 <form:radiobutton path="gender"
										value="男" class="need" checked="true" />
								</label> <label for="female"> 女 <form:radiobutton path="gender"
										value="女" class="need" />
								</label>
							</div>
							<span class="gendererror error"></span>
						</div>


						<div class="form-group col-md-6">
							<label for="birthDate">生日</label>
							<form:input id="birthDate" class="form-control" type="date"
								placeholder="生日" name="birthDate" path="birthDate" />
							<span class="birthDateerror error"></span> <span
								class="birthDateerrorhidden" style="visibility: hidden"></span>
						</div>






						<div class="mb-3">
							<div class="row">
								<div class="col-sm-9">
									<label for="uploadedFile" class="form-label">上傳照片</label> <input
										class="form-control" type="file" name="uploadedFile"
										id="uploadedFile" accept="image/*" />
									<!-- 要多張照片用multiple="multiple" -->
								</div>
								<div class="col-sm-3">
									<div class="form-control" style="height: 100px;">
										<img src="<c:url value='/images/default2.jpg'/>"
											name="img-preview" id="img-preview" class="h-100 w-100" />
									</div>
								</div>
							</div>
						</div>

					</div>
					<button type="button" id="checksubmit" class="btn btn-primary">送出</button>
					<button style="visibility: hidden" type="submit" id="submit"
						class="btn btn-primary"></button>
				</form:form>
				<div class="text-danger"></div>

			</div>
		</c:otherwise>
	</c:choose>
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
						<!--
            All the links in the footer should remain intact.
            You can delete the links only if you purchased the pro version.
            Licensing information: https://bootstrapmade.com/license/
            Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/buy/?theme=EstateAgency
          -->
						Designed by <a href="<c:url value='https://bootstrapmade.com/'/>">BootstrapMade</a>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<!-- End  Footer -->

	<div id="preloader"></div>
	<a href="<c:url value='#'/>"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

	<!-- Vendor JS Files -->
	<script
		src='<c:url value="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"/>'></script>
	<script
		src='<c:url value="/assets/vendor/swiper/swiper-bundle.min.js"/>'></script>
	<script
		src='<c:url value="/assets/vendor/php-email-form/validate.js"/>'></script>

	<!-- Template Main JS File -->
	<script src='<c:url value="/assets/js/main.js"/>'></script>
</body>

</html>