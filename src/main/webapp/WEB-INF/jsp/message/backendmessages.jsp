<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<link href="<c:url value='/assets/css/style2.css'/>" rel="stylesheet">
<!-- <!-- Bootstrap core CSS -->
-->
<!-- <link -->
<!-- 	href="https://cdn.bootcss.com/bootstrap/4.1.0/css/bootstrap.min.css" -->
<!-- 	rel="stylesheet"> -->
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
	height: 150px;
	resize: none;
}

.showreply {
	vertical-align: middle;
	padding-left: 200px;
}

.reply {
	text-align: top;
	display: none;
	margin-left: 200px;
}

.dashboard {
	height: 150px;
	width: 70px;
	background-color: rgb(110, 138, 195);
	padding: 20px 20px 0 20px;
	position: absolute;
	buttom: -92px;
	z-index: 100;
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

					<li class="nav-item"><a class="nav-link active"
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
							<h1 class="title-single">評價管理</h1>
							<div class="form-comments">
								<c:forEach var="datas" items="${datas}">
									<label hidden="hidden">${datas.id}</label>
									<div class="row">
										<div class="offset-sm-3 col-sm-12 my-5 p-5 border shadow"
											style="background-color: #FFFFFF">
											<!-- 顯示留言 -->
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
												<div class="form-group">會員:${datas.userid.accountName}</div>
											</div>
											<div class="col-md-12 mb-3">
												<div style="width: 700px;">
													<div class="form-group">內容:${datas.usertext}</div>
												</div>
											</div>
											<div class="col-md-12 mb-3">
												<div class="form-group">
													<fmt:formatDate pattern="yyyy-MM-dd ,a hh:mm:ss EEEE"
														value="${datas.messagetime}" />
												</div>
											</div>
											<div class="col-md-12 mb-3" style="text-align: right">
												<button class="btn btn-outline-primary btn-sm" id="replyBtn"
													onClick="showReply(${datas.id})">回覆</button>
												<!--********************onSubmit為form表單原生的屬性，判斷回傳之布林值決定下一步******************** -->
												<form action="${contextRoot}/admin/messages/delete"
													method="post" onSubmit="return showConfirmation()">

													<input type="hidden" name="id" value="${datas.id}" /> <input
														type="hidden" name="_method" value="delete" /> <input
														type="submit" class="btn btn-outline-danger btn-sm"
														value="刪除">

													<!--********************刪除前用來再次確認******************** -->
													<script>
														/*		
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
																	    	alert(${datas.id});
																    	// 這個jsp的forms[0]是回覆按鈕
																    	// 這個jsp的forms[1]是送出按鈕
																        document.forms[2].submit(); // 提交表单
																      });
																    }
																  });																
																  return false; // 防止表单提交  
																}
																*/
                                                             </script>
												</form>
											</div>
										</div>
									</div>
									<!-- 顯示回覆 -->
									<c:if test="${not empty datas.admintext}">
										<div class="showreply">
											<h3>業主回覆</h3>
											<p>${datas.admintext}</p>
											<fmt:formatDate pattern="yyyy-MM-dd ,a hh:mm:ss EEEE"
												value="${datas.replytime}" />
										</div>
									</c:if>
									<div class="reply col-md-15 mb-3" id="${datas.id}">
										<form:form action="${contextRoot}/admin/messages/edit"
											method="put" modelAttribute="messages">
											<form:input type="hidden" path="id" value="${datas.id}" />
											<form:input type="hidden" path="stars" value="${datas.stars}" />
											<form:input type="hidden" path="usertext"
												value="${datas.usertext}" />
											<form:input type="hidden" path="userid"
												value="${datas.userid.accountId}" />
											<div>請輸入回覆內容：</div>
											<form:textarea path="admintext"></form:textarea>
											<div style="text-align: right">
												<button type="submit" class="btn btn-primary">送出</button>
											</div>
										</form:form>
									</div>

								</c:forEach>
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

	<!-- 評分星星 -->
	<script src='<c:url value="/javascript/jquery-1.11.0.min.js"/>'
		type="text/javascript"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script
		src="https://cdn.bootcss.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

	<script src='<c:url value="/javascript/jquery.rating-stars.min.js"/>'></script>

	<!-- sweetalert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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

		function showReply(id) {
			// 顯示輸入框
			document.getElementById(id).style.display = "block";
		}
		
		//回覆區塊特效彈出
/*		$('#animate .dashboard').hover(
               function () {
                  $(this).stop().animate(
                       {
                     	bottom: '0px',
                         backgroundColor: '#444'
                     },
                      500,
                     'easeInSine'
                   ); // end animate
              },
              function () {
                   $(this).stop().animate(
                     {
                       	bottom: '-92px',
                          backgroundColor: 'rgb(110,138,195)'
                       },
                     1500,
                     'easeOutBounce'
                    ); // end animate
                }
            ); // end hover
        });        */
	</script>
</body>
</html>