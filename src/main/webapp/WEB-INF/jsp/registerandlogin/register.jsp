<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="<c:url value='/favicon.ico' />">
<meta charset="UTF-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<title>貝殼窩BackHome</title>
<meta content="" name="description">
<meta content="" name="keywords">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<!-- Favicons -->

<link href="<c:url value='/assets/img/favicon.png' />" rel="icon">

<link href="<c:url value='/assets/img/apple-touch-icon.png' />"
	rel="apple-touch-icon">

<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700"
	rel="stylesheet">

<!-- Vendor CSS Files -->

<link
	href="<c:url value='/assets/vendor/animate.css/animate.min.css' />"
	rel="stylesheet">

<link
	href="<c:url value='/assets/vendor/bootstrap/css/bootstrap.min.css' />"
	rel="stylesheet">

<link
	href="<c:url value='/assets/vendor/bootstrap-icons/bootstrap-icons.css' />"
	rel="stylesheet">

<link
	href="<c:url value='/assets/vendor/swiper/swiper-bundle.min.css' />"
	rel="stylesheet">

<!-- Template Main CSS File -->

<link href="<c:url value='/assets/css/style.css' />" rel="stylesheet">

<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>"></script>

<script>
window.onload = function() {
	let error;
	let email = document.getElementById("email");
	let password = document.getElementById("password");
	let confirm = document.getElementById("confirm");
	let accountName = document.getElementById("accountName");
	let required = document.querySelectorAll(".form-control");
	let colerror = document.querySelectorAll(".error");
	$("#email").on("input",function() {
			filter = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
			if (!email.value.match(filter)) {
				$('.emailerror').html("請輸入正確格式").css({
					"color" : "red",
					"font-size" : "10%"
				})
			}else{
				if(email!="")
				$('.emailerror').html("")
			}

		});
	   
	
	$("#email").on("input",function() {
		let email = $('#email').val();
		$.ajax({
			method : 'get',
			data : {
				"email" : email
			},
			url : 'checkemailduplicate',
			success : function(result) {
				$('#duplicate').html(result).css({
					"color" : "red",
					"font-size" : "10%"
				})
			
				if ($('.emailerror').text() == "" && $('#duplicate').html() == "") {
						    $('#emailverify').prop("disabled", false);
						}
				else{
					$('#emailverify').prop("disabled", true);
				}
			}

		})
		
		
		
		
		
		
	});
	

	
	
	
	$("#password").on("input",function() {
		filter =  /^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,16}$/;
		if (!password.value.match(filter)) {
			$('.passworderror').html("密碼輸入8-16位(至少含一位數字及一位特殊字符)").css({
				"color" : "red",
				"font-size" : "10%"
			})
			if(confirm.value!=password.value)
				$('.confirmerror').html("密碼不符,請再次確認").css({
					"color" : "red",
					"font-size" : "10%"
				})
			
		}
		
		else{
			if(confirm.value==password.value)
				$('.confirmerror').html("")
			if(password!="")
				$('.passworderror').html("")
		}

	});
	
	
	$("#confirm").on("input",function() {
		if(confirm.value!=password.value) {
			if (password.value!="")
				$('.confirmerror').html("密碼不符,請再次確認").css({
					"color" : "red",
					"font-size" : "10%"
				})
		}else{
			if(confirm!="")
			$('.confirmerror').html("")
		}

	});
	

	$("#accountName").on("input",function() {
		if (accountName.value.length<2 | accountName.value.length>10) {
			$('.accountNameerror').html("帳號名稱至少兩個字,最多十個字").css({
				"color" : "red",
				"font-size" : "10%"
			})
		}else{
			$('.accountNameerror').html("")
		}

	});

	
			$('#checksubmit').on("click",function(event){
				error="no"
				
				for (let i = 0; i < required.length; i++) {
				   if( required[i].value=="" ){
					    error="yes"; 
					   	$(required[i]).closest("div").find(".error").html("必填").css({
 							"color" : "red",
 							"font-size" : "10%"
 						})
				    }
				    
				}
				for (let i = 0; i < colerror.length; i++) {
					   if( $(colerror[i]).html()!="" | $('#duplicate').html()!=""){
						    error="yes"; 
					    }
					    
				}	
				
				
				
				
				
				
				
				
				$.ajax({
					method : 'get',
					data : {
						"email" : $('#email').val()
					},
					url : 'checkEmail',
					success : function(result) {
						$('#emailnotice').html(result).css({
							"color" : "green",
							"font-size" : "10%"
						})
						
						
						
						if($('#emailnotice').html()=="您尚未進行驗證")
							error="yes"
						if(error=="no"){
							$('#submit').click();
							$('#registerForm').find('button').prop('disabled', true);
							for (let i = 0; i < required.length; i++) {
								required[i].disabled = true;
							}
						}	
						
						
					}

				})
				
				
				
				
				
				
// 				if(error=="no"){
// 					$('#submit').click();
// 					$('#registerForm').find('button').prop('disabled', true);
// //						$("#success").html("註冊成功,三秒後跳轉首頁")	
// 					for (let i = 0; i < required.length; i++) {
// 					    required[i].disabled = true;
// 					}
// 				}	
				
				
				
				
				
				
				
				
				
				
				
			}	
			)	
			
			
			$('#submit').on("click", function(event) {
				$.ajax({
					method : 'post',
					data : {
						"email" : $('#email').val(),
						"accountName" : $('#accountName').val(),
						"password" : $('#password').val()
					},
					success : function(result) {
						$('#success').html(result).css({
							"color" : "green",
							"font-size" : "10%"
						})
						setTimeout(function() {
		            	window.location.href = '/main';
		          		}, 3000);
					}

				})
			
				return false;
				
				});
			
			
			
			
			 $('#checksubmitadmin').on("click",function(event){
					error="no"
					event.preventDefault();
					for (let i = 0; i < required.length; i++) {
					   if( required[i].value=="" ){
						    error="yes"; 
						   	$(required[i]).closest("div").find(".error").html("必填").css({
									"color" : "red",
									"font-size" : "10%"
								})
					    }
					    
					}
					for (let i = 0; i < colerror.length; i++) {
						   if( $(colerror[i]).html()!="" | $('#duplicate').html()!=""){
							    error="yes"; 
						    }
						    
					}	
					if(error=="no"){
						$('#submitadmin').click();
						$('#registerForm').find('button').prop('disabled', true);
						for (let i = 0; i < required.length; i++) {
						    required[i].disabled = true;
						}
					}	
					
				}	
				)	
				
// 				$('#clear').prop('disabled', true)
		        $("#submitadmin").on("click",function() {
		        	$('#searchbtn').prop('disabled', true)
					$.ajax({
						method : 'post',
						data : {
							"email" : $('#email').val(),
							"accountName" : $('#accountName').val(),
							"password" : $('#password').val()
						},
						url:"insertadmin",
						success : function(result) {
							$('#success').html(result).css({
								"color" : "green",
								"font-size" : "10%"
							})
							$('#clear').prop('disabled', false)
							$('#searchbtn').prop('disabled', false)
						}

					})
					
					return false;
				});
			
			
			
// 			var clearButton = document.getElementById('clear');

			
// 			clearButton.addEventListener('click', function() {
// 			  var inputs = document.getElementsByTagName('input');
// 			  for (var i = 0; i < inputs.length; i++) {
// 			    inputs[i].value = '';
// 			  }
// 			  $('#registerForm').find('button').prop('disabled', false);
// 			  $('#success').html("");
// 			  $('#clear').prop('disabled', true)
// 			  for (let i = 0; i < required.length; i++) {
// 						    required[i].disabled = false;
// 						}
// 			});
	
			
			
			//驗證信開始
			$('#emailverify').prop("disabled",true);
			$("#emailverify").on("click",function() {
				let email = $('#email').val();
				$.ajax({
					method : 'post',
					data : {
						"email" : email
					},
					url : 'send-email',
					success : function(result) {
						$('#emailnotice').html(result).css({
							"color" : "green",
							"font-size" : "10%"
						})
					}

				})
				
				
			})
			
			
			//驗證信結束
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
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
								<li><a class="dropdown-item active"
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
							<h1 class="title-single">註冊</h1>
							<div class="form-comments">
								<form:form id="registerForm" method="post"
									modelAttribute="loginBean">
									<div class="row">
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<label for="email">Email</label>
												<form:input id="email" class="form-control" type="text"
													placeholder="Email" name="email" path="email" />
												<span id="duplicate"></span> <span class="emailerror error"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<label for="accountName">使用者名稱</label>
												<form:input id="accountName" class="form-control"
													type="text" placeholder="帳號名稱" name="accountName"
													path="accountName" />
												<span class="accountNameerror error"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<label for="password">密碼</label>
												<form:input id="password" class="form-control"
													type="password" placeholder="密碼" name="password"
													path="password" />
												<span class="passworderror error"></span>
											</div>
										</div>
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<label for="confirm">確認密碼</label>
												<form:input id="confirm" class="form-control"
													type="password" placeholder="確認密碼" name="confirm"
													path="confirm" />
												<span class="confirmerror error"></span>
											</div>
										</div>
									</div>
									<div style="text-align: right">
										<button type="button" id="emailverify">驗證信</button>
										<span id="emailnotice"></span>
										<button type="button" id="checksubmit" class="btn btn-primary">註冊</button>
										<button style="visibility: hidden" type="submit" id="submit"
											class="btn btn-primary"></button>
									</div>
								</form:form>
								<div id="success" class="text-primary"></div>
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
