<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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


					<li class="nav-item"><a class="nav-link active"
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
								<li><a class="dropdown-item active"
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
	<input type="hidden" value="${orderId}" id="orderId" />
	<main id="main">
		<section class="intro-single">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="title-single-box">
							<h1 class="title-single">歷史訂單</h1>
							<div class="form-comments">
								<div class="title-box-d">
									<h5 class="title-d">訂單明細</h5>
								</div>
								<c:choose>
									<c:when test="${datas.isEmpty()}">
										<h3>目前尚無訂單</h3>
										<div style="height:100px"></div>
									</c:when>
									<c:otherwise>
										<c:forEach var="datas" items="${datas}">
											<div class="row" >
												<div class="offset-sm-3 col-sm-12 my-5 p-5 border shadow" style="background-color:	#ECF5FF">
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
														<label style="font-weight: bold;">房名 : </label>
														${datas.roomid.name}</div>
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
														<c:choose>
															<c:when test="${datas.paid=='未付款'}">
																<form id="idFormAioCheckOut" method="post"
																	action="<c:url value="/ECPay"/>">
																	<div style="display: none">
																		<div>
																			<input type="text" name="id" value="${datas.id}">
																			<label class="col-xs-12">房名:</label> <input
																				type="text" name="ItemName"
																				value="${datas.roomid.name}" class="form-control"
																				readonly />
																		</div>
																		<div>
																			<label class="col-xs-12">房型說明: </label> <input
																				name="TradeDesc" class=" form-control"
																				value="${datas.roomid.introduce}" readonly />
																		</div>
																		<div>
																			<label class="col-xs-12">金額:</label> <input
																				type="text" name="TotalAmount"
																				value="${datas.roomid.price}" class="form-control"
																				readonly />
																		</div>
																	</div>

																	<button type="submit"
																		class="btn btn-outline-info btn-sm">付款</button>
																</form>
															</c:when>
														</c:choose>
														<!--********************onSubmit為form表單原生的屬性，判斷回傳之布林值決定下一步******************** -->
														<form action="${contextRoot}/orders/delete" method="post"
															onSubmit="return showConfirmation()">

															<input type="hidden" name="orderid"
																value="${datas.orderid}" /> <input type="hidden"
																name="userId" value="${datas.userid.accountId}" /> <input
																type="hidden" name="_method" value="delete" /> <input
																type="submit" class="btn btn-outline-danger btn-sm"
																value="刪除">

															<!--********************刪除前用來再次確認******************** -->

															<script>
																if (result.isConfirmed) {
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
																    	// 這個jsp的forms[0]是付款按鈕
																        document.forms[1].submit(); // 提交表单
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
										</c:forEach>
									</c:otherwise>
								</c:choose>
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
	
	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
</html>