<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>貝斯特BackHome</title>
<meta content="" name="description">
<meta content="" name="keywords">

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
<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-star-rating/4.0.6/css/star-rating.min.css">
<!-- FontAwesome core CSS -->
<link
	href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/htmleaf-demo.css">

<style>
a {
	color: #f1c40f;
}

a:hover, a:active, a:focus {
	color: #dab10d;
}

.rating-stars {
	width: 100%;
	text-align: left;
}

.rating-stars .rating-stars-container {
	font-size: 0px;
}

.rating-stars .rating-stars-container .rating-star {
	display: inline-block;
	font-size: 32px;
	color: #555555;
	cursor: pointer;
	padding: 5px 1px;
}

.rating-stars .rating-stars-container .rating-star.is--active,
	.rating-stars .rating-stars-container .rating-star.is--hover {
	color: #f1c40f;
}

.rating-stars .rating-stars-container .rating-star.is--no-hover {
	color: #555555;
}

.readonlystars {
	pointer-events: none;
}

textarea {
	width: 500px;
	height: 120px;
	resize: none;
}

.reply {
	vertical-align: middle;
	padding-left: 200px;
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
							<li><a class="dropdown-item active"
								href="<c:url value='/public/messages/all' />">評價&回饋</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link "
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
		<section class="intro-single">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="title-single-box">
							<h1 class="title-single">評價&回饋</h1>
							
							<div class="title-box-d">
								<h5 class="title-d">撰寫評論</h5>
							</div>
							<div class="form-comments">
								<form:form class="form-a" action="${contextRoot}/messages/post"
									modelAttribute="information">
									<!-- 會員 -->
									<input type="hidden" name="userid" value="${sessionScope.id}" />
									<!-- 評分星星 -->
									<div class="overflow-hidden">
										<div class="rating-stars block" id="rating">
											<input type="hidden" name="stars"
												class="form-control rating-value" id="rating-stars-value">
											<div class="rating-stars-container">
												<div class="rating-star">
													<i class="fa fa-star"></i>
												</div>
												<div class="rating-star">
													<i class="fa fa-star"></i>
												</div>
												<div class="rating-star">
													<i class="fa fa-star"></i>
												</div>
												<div class="rating-star">
													<i class="fa fa-star"></i>
												</div>
												<div class="rating-star">
													<i class="fa fa-star"></i>
												</div>
											</div>
										</div>
									</div>
									<div class="input-group">
										<form:textarea path="usertext" class="form-control"
											placeholder="請輸入文字..." />
									</div>
									<br />
									<div style="text-align: right">
										<button type="submit" class="btn btn-primary">送出</button>
									</div>
								</form:form>
								<h3 style="text-align: left;">
									<fmt:formatNumber pattern="平均星數: #.0" value="${averageStar}" />
								</h3>
								<c:forEach var="datas" items="${datas}">
									<label hidden="hidden">${datas.id}</label>
									<div class="row">
										<div class="offset-sm-3 col-sm-12 my-5 p-5 border shadow"
											style="background-color: #ECF5FF">
											<div class="rating-stars block" id="another-rating">
												<input type="hidden" readonly="readonly"
													class="form-control rating-value"
													id="another-rating-stars-value" value="${datas.stars}">
												<div class="rating-stars-container">
													<div class="rating-star readonlystars">
														<i class="fa fa-star"></i>
													</div>
													<div class="rating-star readonlystars">
														<i class="fa fa-star"></i>
													</div>
													<div class="rating-star readonlystars">
														<i class="fa fa-star"></i>
													</div>
													<div class="rating-star readonlystars">
														<i class="fa fa-star"></i>
													</div>
													<div class="rating-star readonlystars">
														<i class="fa fa-star"></i>
													</div>
												</div>
											</div>


											<div class="col-md-12 mb-3">
												<div class="form-group" style="font-weight: bold">會員:${datas.userid.accountName}</div>
											</div>
											<div class="col-md-12 mb-3">
												<div style="width: 700px;">
													<div class="form-group" style="font-weight: bold">內容:${datas.usertext}</div>
												</div>
											</div>
											<div class="col-md-12 mb-3">
												<div class="form-group" style="font-weight: bold">
													<fmt:formatDate pattern="yyyy-MM-dd ,a hh:mm:ss EEEE"
														value="${datas.messagetime}" />
												</div>
											</div>
										</div>
									</div>
									<!-- 顯示回覆 -->
									<c:if test="${not empty datas.admintext}">
										<div class="reply">
											<h3>業主回覆</h3>
											<p>${datas.admintext}</p>
											<fmt:formatDate pattern="yyyy-MM-dd ,a hh:mm:ss EEEE"
												value="${datas.replytime}" />
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>

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

	<!-- 評分星星 -->
	<script src='<c:url value="/javascript/jquery-1.11.0.min.js"/>'
		type="text/javascript"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script
		src="https://cdn.bootcss.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

	<script src='<c:url value="/javascript/jquery.rating-stars.min.js"/>'></script>
	<script>
		var ratingOptions = {
			selectors : {
				starsSelector : '.rating-stars',
				starSelector : '.rating-star',
				starActiveClass : 'is--active',
				starHoverClass : 'is--hover',
				starNoHoverClass : 'is--no-hover',
				targetFormElementSelector : '.rating-value'
			}
		};

		$(".rating-stars").ratingStars(ratingOptions);
	</script>

</body>
</html>