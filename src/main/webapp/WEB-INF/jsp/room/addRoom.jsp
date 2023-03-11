<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</style>

<script>
	window.onload = function() {
		$("#roomId").on("input", function() {
			let roomId = document.getElementById("roomId");
			if (roomId.value != "") {
				$('.roomIderror').html("")
			} else {
				$('.roomIderror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})
			}

			$.ajax({
				method : 'get',
				data : {
					'roomId' : roomId.value
				},
				url : 'addCheckId',

				success : function(result) {
					$('.roomIderror').html(result).css({
						"color" : "red",
						"font-size" : "10%"
					})
					if (result != "")
						$('#submit').prop('disabled', true)
					else
						$('#submit').prop('disabled', false)
				}
			})
		})

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
					'name' : name.value
				},
				url : 'addCheckNamne',

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

		$("#type").on("input", function() {
			let type = document.getElementById("type");
			if (type.value == "") {
				$('.typeerror').html("必選").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.typeerror').html("")
			}
		})

		$("#price").on("input", function() {
			let price = document.getElementById("price");
			if (price.value == "") {
				$('.priceerror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.priceerror').html("")
			}
		})

		$("#roomNameIntroduction").on(
				"input",
				function() {
					let roomNameIntroduction = document
							.getElementById("roomNameIntroduction");
					if (roomNameIntroduction.value == "") {
						$('.roomNameIntroductionerror').html("必填").css({
							"color" : "red",
							"font-size" : "10%"
						})
					} else {
						$('.roomNameIntroductionerror').html("")
					}
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

		$("#equipment").on("input", function() {
			let equipment = document.getElementById("equipment");
			if (equipment.value == "") {
				$('.equipmenterror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.equipmenterror').html("")
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

		$("#remark").on("input", function() {
			let remark = document.getElementById("remark");
			if (remark.value == "") {
				$('.remarkerror').html("必填").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.remarkerror').html("")
			}
		})

		$("#room-photos").on("input", function() {
			let room_photos = document.getElementById("room-photos");
			if (room_photos.value == "") {
				$('.room-photoserror').html("必選").css({
					"color" : "red",
					"font-size" : "10%"
				})
			} else {
				$('.room-photoserror').html("")
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
									modelAttribute="roomBean" enctype="multipart/form-data"
									id="room">
									<div class="row">
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="roomId">房號:</form:label>
												<br>
												<form:input path="roomId" id="roomId" type="number"
													class="input" required="true" />
												<span class="roomIderror err"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="name">房名:</form:label>
												<br>
												<form:input path="name" id="name" class="input"
													required="true" />
												<span class="nameerror err"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="type">
																	房型:</form:label>
												<br>
												<form:select path="type" id="type" class="input"
													required="true">
													<option value="">請選擇房型</option>
													<option value="雙人房">雙人房</option>
													<option value="四人房">四人房</option>
													<option value="六人房">六人房</option>
												</form:select>
												<span class="typeerror err"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="price">
																	價錢:</form:label>
												<br>
												<form:input path="price" id="price" class="input"
													type="number" required="true" />
												<span class="priceerror err"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="roomNameIntroduction">
																	房型介紹:</form:label>
												<br>
												<form:textarea path="roomNameIntroduction"
													id="roomNameIntroduction" class="input" rows="10" cols="40"
													required="true" />
												<span class="roomNameIntroductionerror err"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="introduce">
																	簡介:</form:label>
												<br>
												<form:textarea path="introduce" id="introduce" class="input"
													rows="10" cols="40" required="true" />
												<span class="introduceerror err"></span>
											</div>
										</div>

										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="equipment">
																	設備:</form:label>
												<br>
												<form:textarea path="equipment" id="equipment" class="input"
													rows="10" cols="40" required="true" />
												<span class="equipmenterror err"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="service">
																	服務:</form:label>
												<br>
												<form:textarea path="service" id="service" class="input"
													rows="10" cols="40" required="true" />
												<span class="serviceerror err"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="remark">
																	備註:</form:label>
												<br>
												<form:textarea path="remark" id="remark" class="input"
													rows="10" cols="40" required="true" />
												<span class="remarkerror err"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<label for="room-photos">圖片:</label> <input type="file"
													id="room-photos" class="input" name="files" required="true"
													multiple> <span class="room-photoserror err"></span>
											</div>
										</div>
									</div>
									<div style="text-align: right">
										<input style="display: none" type="submit" value="Submit"
											id="submit" /> <input style="display: none" type="button"
											value="submittest" id="submittest" /> <input type="button"
											value="確認" id="submitShow" />
									</div>
								</form:form>
								<div class="col-md-6 mb-3">
									<div class="form-group">
										<a class="btn btn-danger"
											href="${contextRoot}
															/admin/room/backstage">上一頁</a>
									</div>
								</div>
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


<<<<<<< HEAD
	<div class="card-body">
		<form:form method="POST" action="${contextRoot}/admin/room/add"
			modelAttribute="roomBean" enctype="multipart/form-data">
			<table>
				<tr>
					<td><form:label path="roomId">roomId</form:label></td>
					<td><form:input path="roomId" /></td>
				</tr>
				<tr>
					<td><form:label path="name">name</form:label></td>
					<td><form:input path="name" /></td>
				</tr>
				<tr>
					<td><form:label path="type">
              type</form:label></td>
					<td><form:input path="type" /></td>
				</tr>
				<tr>
					<td><form:label path="price">
              price</form:label></td>
					<td><form:input path="price" /></td>
				</tr>
				<tr>
					<td><form:label path="roomNameIntroduction">
              roomNameIntroduction</form:label></td>
					<td><form:input path="roomNameIntroduction" /></td>
				</tr>
				<tr>
					<td><form:label path="introduce">
              introduce</form:label></td>
					<td><form:input path="introduce" /></td>
				</tr>
				<tr>
					<td><form:label path="equipment">
              equipment</form:label></td>
					<td><form:input path="equipment" /></td>
				</tr>
				<tr>
					<td><form:label path="service">
              service</form:label></td>
					<td><form:input path="service" /></td>
				</tr>
				<tr>
					<td><form:label path="remark">
              remark</form:label></td>
					<td><form:input path="remark" /></td>
				</tr>
				<tr>
					<td><label for="room-photos">Room Photos</label> <input
						type="file" id="room-photos" name="files" multiple></td>
				</tr>
				<tr>
					<td><input type="submit" value="Submit" /></td>
				</tr>
				<tr>
					<td><a class="btn btn-danger"
						href="<c:url value="/admin/backstage"/>">上一頁</a></td>
				</tr>
			</table>
		</form:form>
		<div>${err}</div>
	</div>
=======
>>>>>>> exhibitSystem
</body>

</html>