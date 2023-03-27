<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
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

					<li class="nav-item dropdown active"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" role="button"
						data-bs-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false">訂單管理</a>

						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/findall' />">訂單一覽</a></li>
							<li><a class="dropdown-item"
								href="<c:url value='/admin/orders/byemail' />">用Email查詢</a></li>
							<li><a class="dropdown-item active"
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
						</sec:authorize>
						<sec:authorize access="hasAuthority('ROLE_ANONYMOUS')">
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
							<h1 class="title-single">訂單一覽</h1>
							<div class="form-comments">
								<div class="title-box-d">
									<h5 class="title-d">訂單編號查詢</h5>
								</div>
								<form:form action="${contextRoot}/admin/orders/databyorderid"
									modelAttribute="orderid">
									<div class="input-group">
										<form:input id="inputText" path="orderid" class="form-control" />
									</div>
									<br />
									<div style="text-align: right">
										<button type="submit" class="btn btn-primary"
											id="submitButton">查詢</button>
									</div>
								</form:form>
								<c:choose>
									<c:when test="${datas==null&&searched==true}">
										<h3>目前尚無訂單</h3>
									</c:when>
									<c:when test="${datas==null}">							
									</c:when>
									<c:otherwise>
										<div class="row">
											<div class="offset-sm-3 col-sm-12 my-5 p-5 border shadow"
												style="background-color: #FFFFFF">
												<div class="col-md-12 mb-3">
													<div class="form-group">
														<label style="font-weight: bold;">訂單成立時間 : </label>
														<fmt:formatDate pattern="yyyy-MM-dd ,a hh:mm:ss EEEE"
															value="${datas.orderdate}" />
													</div>
												</div>
												<div class="col-md-12 mb-3">
													<div class="form-group">
													<label style="font-weight: bold;">訂單編號 : </label>
													${datas.orderid}</div>
												</div>
												<div class="col-md-12 mb-3">
													<div class="form-group">
													<label style="font-weight: bold;">會員 : </label>
													${datas.userid.accountName}</div>
												</div>
												<div class="col-md-12 mb-3">
													<div class="form-group">
													<label style="font-weight: bold;">房號 : </label>
													${datas.roomid.roomId}</div>
												</div>
												<div class="col-md-12 mb-3">
													<div class="form-group">
														<label style="font-weight: bold;">入住日期 : </label>
														<fmt:formatDate pattern="yyyy-MM-dd"
															value="${datas.checkindate}" />
													</div>
												</div>
												<div class="col-md-12 mb-3">
													<div class="form-group">
														<label style="font-weight: bold;">退房日期 : </label>
														<fmt:formatDate pattern="yyyy-MM-dd"
															value="${datas.checkoutdate}" />
													</div>
												</div>
												<div class="col-md-12 mb-3">
													<div class="form-group">
													<label style="font-weight: bold;">備註 : </label>
													${datas.message}</div>
												</div>
												<div class="col-md-12 mb-3">
														<div class="form-group">
														<label style="font-weight: bold;">金額 : </label>
														<label>$</label>
														${datas.roomid.price}</div>
													</div>
												<div class="col-md-12 mb-3">
													<div class="form-group">
													<label style="font-weight: bold;">付款狀態 : </label>
													${datas.paid}</div>
												</div>
												<div class="col-md-12 mb-3" style="text-align: right">
													<!--********************[編輯按鈕]******************** -->
													<form action="${contextRoot}/admin/orders/update"
														method="get">
														<input type="hidden" name="id" value="${datas.id}" /> <input
															type="hidden" name="jsp" value="byOrderid" /> <input
															type="hidden" name="searchid" value="" /> <input
															type="submit" class="btn btn-outline-info btn-sm"
															value="編輯">
													</form>
													<!--********************[刪除按鈕]******************** -->
													<!--********************onSubmit為form表單原生的屬性，判斷回傳之布林值決定下一步******************** -->
													<form action="${contextRoot}/admin/orders/backstagedel"
														method="post" onSubmit="return showConfirmation()">

														<input type="hidden" name="orderid"
															value="${datas.orderid}" /> <input type="hidden"
															name="jsp" value="byOrderid" /> <input type="hidden"
															name="searchid" value="" /> <input type="hidden"
															name="_method" value="delete" /> <input type="submit"
															class="btn btn-outline-danger btn-sm" value="刪除">

														<!--********************刪除前用來再次確認******************** -->

														<script>
															function showConfirmation() {
																  Swal.fire({
																    title: '您確定要刪除嗎?',
																    text: "",
																    icon: 'warning',
																    showCancelButton: true,
																    confirmButtonColor: '#d33',
																    cancelButtonColor: '#3085d6',
																    confirmButtonText: '刪除',
																    cancelButtonText: '取消' 
																  }).then((result) => {
																    if (result.isConfirmed) {
																      Swal.fire(
																        '刪除成功',
																        '',
																        'success'
																      ).then(() => {
																    	// 這個jsp的forms[0]是送出按鈕
																	    // 這個jsp的forms[1]是編輯按鈕
																        document.forms[2].submit(); // 提交表单
																      });
																    }
																  });

																  return false; // 防止表单提交
																}

                                                             </script>
													</form>
												</div>
											</div>
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</main>
						


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

	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>

</html>