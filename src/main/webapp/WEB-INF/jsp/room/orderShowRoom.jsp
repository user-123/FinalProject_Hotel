<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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

<!-- =======================================================
  * Template Name: EstateAgency - v4.10.0
  * Template URL: https://bootstrapmade.com/real-estate-agency-bootstrap-template/
  * Author: BootstrapMade.com
  * License: https://bootstrapmade.com/license/
  ======================================================== -->

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
#slideshow {
	position: relative;
	overflow: hidden;
	width: 1400px;
	height: 700px;
}

#slideshow .slides {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

#slideshow .slides img {
	display: none;
	width: 100%;
	height: 100%;
}

#slideshow .slides img.active {
	display: block;
}

.col-12 {
	-webkit-box-flex: 0;
	-ms-flex: 0 0 100%;
	flex: 0 0 100%;
	max-width: 100%;
	margin-top: 20px
}

.housing-info__item {
	-webkit-box-shadow: 0 1px 0 0 #8e7614;
	box-shadow: 0 1px 0 0 #8e7614;
	margin-bottom: 20px;
	padding-bottom: 20px;
}

.housing-info__title {
	line-height: 25px;
	font-size: 25px;
	font-weight: 300;
	margin-top: 20px;
	margin-bottom: 20px;
	color: #8e7614
}

.housing-intro__box {
	padding: 20px;
	background-color: #dcdcdc;
}

.housing-intro__title {
	line-height: 25px;
	font-size: 30px;
	font-weight: 300;
	color: #8e7614;
	margin-bottom: 20px;
}

.dataDiv1 {
	overflow: hidden;
	max-height: 3em;
	/* 顯示三行 */
}

.dataDiv2 {
	overflow: hidden;
	max-height: 3em;
	/* 顯示三行 */
}

.dataDiv3 {
	overflow: hidden;
	max-height: 3em;
	/* 顯示三行 */
}

.housing-info__item button {
	float: right;
	margin-right: 5rem;
}

.my-btn {
	width: 100px; 
	height: 40px; 
	margin-bottom:50px 
}
</style>
<script>
	window.onload = function() {
		$(function() {
			var slides = $('.slides img');
			var currentIndex = 0;
			slides.eq(currentIndex).addClass('active');

			function showNextSlide() {
				slides.eq(currentIndex).removeClass('active');
				currentIndex = (currentIndex + 1) % slides.length;
				slides.eq(currentIndex).addClass('active');
			}

			function showPrevSlide() {
				slides.eq(currentIndex).removeClass('active');
				currentIndex = (currentIndex - 1 + slides.length)
						% slides.length;
				slides.eq(currentIndex).addClass('active');
			}

			$('.controls .next').click(showNextSlide);
			$('.controls .prev').click(showPrevSlide);

			setInterval(showNextSlide, 2500);
		});

		$(".myDiv").each(function() {
			var textElement = $(this);
			var originalText = textElement.html();
			var formattedText = originalText.split("***").join("<br><br>");
			textElement.html(formattedText);
		})
		$(".myLi").each(function() {
			var textElement = $(this);
			var originalText = textElement.html();
			var formattedText = originalText.split("***").join("<li>");
			textElement.html(formattedText);
		})

		$(".btn1").on("click", function() {
			var data = document.getElementsByClassName("dataDiv1");
			var button = $(this);
			for (var i = 0; i < data.length; i++) {
				if (data[i].style.maxHeight == "none") {
					data[i].style.maxHeight = "3em";
					button.text("顯示更多");
				} else {
					data[i].style.maxHeight = "none";
					button.text("顯示更少");
				}
			}
		})

		$(".btn2").on("click", function() {
			var data = document.getElementsByClassName("dataDiv2");
			var button = $(this);
			for (var i = 0; i < data.length; i++) {
				if (data[i].style.maxHeight == "none") {
					data[i].style.maxHeight = "3em";
					button.text("顯示更多");
				} else {
					data[i].style.maxHeight = "none";
					button.text("顯示更少");
				}
			}
		})

		$(".btn3").on("click", function() {
			var data = document.getElementsByClassName("dataDiv3");
			var button = $(this);
			for (var i = 0; i < data.length; i++) {
				if (data[i].style.maxHeight == "none") {
					data[i].style.maxHeight = "3em";
					button.text("顯示更多");
				} else {
					data[i].style.maxHeight = "none";
					button.text("顯示更少");
				}
			}
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
					<li class="nav-item"><a class="nav-link active"
						href="<c:url value='/public/room/orderAllShow'/>">房型&訂房</a></li>
					<li class="nav-item"><a class="nav-link "
						href="<c:url value='/public/facility/show'/>">休閒設施</a></li>

					<li class="nav-item"><a class="nav-link "
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
							<h1 class="title-single">${room.name}</h1>
						</div>
					</div>
					<div class="col-12 col-lg-8">
						<div class="title-main__text-white">${room.introduce}</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End Intro Single-->
		<section class="property-grid grid">
			<div class="container">
				<div class="row">
					<div id="slideshow">
						<div class="slides">
							<c:forEach items="${room.roomPhotoBeans}" var="photo">
								<img src="<c:url value='/roomId/${photo.photoFile}'/>">
							</c:forEach>
						</div>
					</div>

					<div class="row">
						<div class="col-12 col-lg-8">
							<div class="housing-intro__box">
								<div class="col-12  housing-intro__title">房型簡介</div>
								<div>房型: ${room.type}</div>
								<br>
								<div class="myDiv">${room.roomNameIntroduction}</div>
								<br>
								<div>定價:$${room.price}</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="container housing-info">
			<div class="container">
				<div class="row">
					<div class="col-12 col-lg-6" id="tools">
						<div class="housing-info__item clearfix">
							<div class="housing-info__title">設備</div>
							<div class="housing-info__mini dataDiv1">
								<ul>
									<li class="myLi">${room.equipment}
								</ul>
							</div>
							<button class="btn1">顯示更多</button>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="container housing-info">
			<div class="container">
				<div class="row">
					<div class="col-12 col-lg-6" id="tools">
						<div class="housing-info__item clearfix">
							<div class="housing-info__title">服務</div>
							<div class="housing-info__mini dataDiv2">
								<ul>
									<li class="myLi">${room.service}
								</ul>
							</div>
							<button class="btn2">顯示更多</button>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="container housing-info">
			<div class="container">
				<div class="row">
					<div class="col-12 col-lg-6" id="tools">
						<div class="housing-info__item clearfix">
							<div class="housing-info__title">備註</div>
							<div class="housing-info__mini dataDiv3">
								<ul>
									<li class="myLi">${room.remark}
								</ul>
							</div>
							<button class="btn3">顯示更多</button>
						</div>
					</div>
				</div>
			</div>
		</section>
		<section class="container housing-info">
			<div class="container">
				<div class="row">
					<div class="col-12 offset-11">
						<form action="<c:url value='/orders/add' />" method="get">
							<input size="" type="hidden" name="Id" value="${room.id}" /><input
								type="submit" class="btn btn-primary my-btn" value="訂房">
						</form>
					</div>
				</div>
			</div>
		</section>
	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->

	<footer>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="copyright-footer">
						<p class="copyright color-text-a">
							&copy; Copyright <span style="color:#41cff2">貝殼窩團隊</span> All
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