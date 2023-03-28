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
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>"></script>
<script src="<c:url value='/javascript/jquery-ui.min.js'/>"></script>
<meta charset="utf-8">
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
<link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">
<!-- Bootstrap core CSS -->

<!-- FontAwesome core CSS -->
<link
	href="http://cdn.bootcss.com/font-awesome/4.7.0/css/font-awesome.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/htmleaf-demo.css">
<style>
/*.container {
	width: 900px;
	margin: 0 auto;
}*/
.messages {
	margin: 10px 5px;
	color: #dc3545
}
</style>
<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>"></script>
<script src="<c:url value='/javascript/jquery-ui.min.js'/>"></script>
<script>
window.onload=function(){
	$('#clear').prop('disabled', true)
	$('#uploadedFile').on("change", function() {
		  let output = document.getElementById('img-preview');
		  let file = this.files[0];
		  if (!file) {
			  if("<c:out value='${pb.photo}'/>" == "")
		    		output.src = `http://localhost:8080/main/images/nopicture.jfif`;
		    	else
		       		output.src = `http://localhost:8080/main/uploadProduct/${pb.photo}`;
		  }else{
			  let filetype = file.name.split(".")
			  let filesize = file.size
			  let accepttype = ["jpg", "png", "jpeg", "webp", "gif"]
			  if ((!accepttype.includes(filetype[filetype.length - 1]))
			    || (filesize > 5*1024 * 1024)) {
			    alert("請上傳圖片形式的檔案(檔案大小限制5mb)");
			    this.value = "";
			    return;
			  }
			  output.src = URL.createObjectURL(file);
			  console.log(event.target.files);
		  }
		  output.onload = function() {
		    URL.revokeObjectURL(output.src)
		  }
		});
	$("#productName").on("input",function(){
		let productName=$("#productName").val()
		if(productName!="")
			$("#productNameerror").html("")

	})


	$("#price").on("input",function(){
			$("#priceerror").html("")
	})



		var error=document.querySelectorAll('.error')
	$('#additemsubmit').on("click", function(event) {
// 		$("#priceerror").html("")
// 		for (let i = 0; i < error.length; i++) {
// 		    error[i].innerHTML="";
// 		}
		var priceInput = document.getElementById('price').value;

		  // 檢查是否為數字
		  if (isNaN(priceInput)) {
			  $('#priceerror').html('請輸入數字！').css({
					"color" : "red",
					"font-size" : "10%"
				});;
				let productName=$("#productName").val()
				if(productName=="")
					$("#productNameerror").html("商品名稱必填").css({
						"color" : "red",
						"font-size" : "10%"
					});
		    return false;
		  }

		  var price = parseInt(priceInput);

		  // 檢查是否在10-100000之間
		  if (price < 10 || price > 100000) {
		    $('#priceerror').html('請輸入10到100000之間的金額！').css({
				"color" : "red",
				"font-size" : "10%"
			});
		    if(productName=="")
				$("#productNameerror").html("商品名稱必填").css({
					"color" : "red",
					"font-size" : "10%"
				});
		    return false;
		  }

		  // 檢查是否為整數
		  if ((!Number.isInteger(price)&&priceInput!="")||(priceInput.includes("."))) {
			  $('#priceerror').html('請輸入整數！').css({
					"color" : "red",
					"font-size" : "10%"
				});;
				if(productName=="")
					$("#productNameerror").html("商品名稱必填").css({
						"color" : "red",
						"font-size" : "10%"
					});
		    return false;
		  }
		event.preventDefault();
		var formData = new FormData($('#addItemForm')[0]);
		$.ajax({
			method : 'post',
			data : formData,
			dataType: 'json',
			processData: false,
		    contentType: false,
			url:"additem",
			success : function(response) {
				$('#addItemForm').find('input').prop('disabled', true);
				$('#addItemForm').find('button').prop('disabled', true);
				$('#addItemForm').find('textarea').prop('disabled', true);
				$('#clear').prop('disabled', false)
				var success = response.success
				console.log(success)
				$('#additemsuccess').html(success).css({
					"color" : "green",
					"font-size" : "10%"
				})
			},
			error : function(xhr) {
			    var errors = xhr.responseJSON;
			    $.each(errors, function(key, value) {
			        $('#' + key + 'error').html(value).css({
						"color" : "red",
						"font-size" : "10%"
					});
			    });
			}
		});
	});



	var clearButton = document.getElementById('clear');


	clearButton.addEventListener('click', function() {
	  let output = document.getElementById('img-preview');
	  output.src = `http://localhost:8080/main/images/nopicture.jfif`;
	  output.onload = function() {
	    URL.revokeObjectURL(output.src)
	  }


	  var inputs = document.getElementsByTagName('input');
	  for (var i = 0; i < inputs.length; i++) {
	    inputs[i].value = '';
	  }
	  $('#addItemForm').find('textarea').prop('disabled', false);
	  $('#addItemForm').find('button').prop('disabled', false);
	  $('#additemsuccess').html("");
	  $('#addItemForm').find('textarea').val("")
	  $('#clear').prop('disabled', true)
	  $('#addItemForm').find('input').prop('disabled', false);
	  $('#addItemForm').find('button').prop('disabled', false);
	});




	 $("#plus10").click(function() {
	      var currentValue = parseInt($(".quantity-input").val());
	      if(currentValue < 90) {
	        $(".quantity-input").val(currentValue + 10);
	      }
	    });
	 $("#minus10").click(function() {
	      var currentValue = parseInt($(".quantity-input").val());
	      if(currentValue > 10) {
	        $(".quantity-input").val(currentValue - 10);
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
			<a class="navbar-brand text-brand" href="<c:url value='/'/>">貝殼窩<span
				class="color-b">BackHome</span></a>

			<div class="navbar-collapse collapse justify-content-center"
				id="navbarDefault">
				<ul class="navbar-nav">


					<li class="nav-item"><a class="nav-link" href="${contextRoot}">首頁</a></li>

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

					<li class="nav-item"><a class="nav-link active"
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
							<h1 class="title-single">商城管理</h1>

							<div class="form-comments">
								<div class="title-box-d">
									<h5 class="title-d">新增商品</h5>
								</div>
								<form:form id="addItemForm" method="post"
									modelAttribute="ProductBean" enctype="multipart/form-data">
									<div style="display: flex">
										<div>
											<div class="form-row">
												<div class="form-group col-md-40">
													<div class="form-group">
														<label for="productName" style="font-weight: bold;">商品名稱</label>
														<form:input id="productName" class="form-control"
															type="text" name="productName" path="productName" />
														<span id="productNameerror" class="error"></span>
													</div>
												</div>
											</div>
											<div style="height: 15px"></div>
											<div class="form-row">
												<div class="form-group col-md-40">
													<div class="form-group">
														<label for="price" style="font-weight: bold;">價格</label>
														<div style="display: flex; align-items: center;">
															<span>NT$</span>
															<form:input id="price" class="form-control" type="text"
																name="price" path="price" />
														</div>
															<span id="priceerror" class="error"></span>
													</div>
												</div>
											</div>
											<div>
												<div style="height: 15px"></div>
												<div class="mb-40">
													<label for="status" style="font-weight: bold;">存貨</label>
													<div style="display: flex;">
														<div class="col-md-40 form-group" style="display: flex;">
															<button class="btn btn-outline-secondary" type="button"
																id="minus10">-10</button>
															<form:input class="quantity-input" type="number" min="1"
																max="99" value="1" path="status" name="status"
																onkeydown="return false" />
															<button class="btn btn-outline-secondary" type="button"
																id="plus10">+10</button>
														</div>
													</div>
												</div>
												<div style="height: 20px"></div>
												<label for="category" style="font-weight: bold;">商品分類</label>
												<form:select name="category" path="category">
													<c:forEach items="${categoryList}" var="category">
														<form:option value="${category.categoryId}"
															label="${category.categoryName}" />
													</c:forEach>
												</form:select>

											</div>
										</div>
										<!-- 			<label for="status">狀態</label>	 -->
										<%-- 			<form:select name="status" path="status"> --%>
										<!-- 				<option value="上架">上架</option> -->
										<!-- 				<option value="下架">下架</option> -->
										<%-- 			</form:select> --%>
										<!-- 	  <div class="mb-3"> -->
										<!-- 		<div class="row"> -->
										<!-- 			<div class="col-sm-2"> -->
										<!-- 				<label for="status">存貨</label> -->
										<%-- 				  <form:input class="quantity-input form-control" type="number" min="1" max="99" value="1" path="status" name="status" onkeydown="return false" /> --%>
										<!-- 			</div> -->
										<!-- 		</div> -->
										<!-- 	</div> -->
										<div class="form-row mb-3" style="margin-left: 100px">
											<div class="row">
												<div class="col-sm-9">
													<label for="uploadedFile" class="form-label"
														style="font-weight: bold;">上傳照片</label> <input
														class="form-control" type="file" name="uploadedFile"
														id="uploadedFile" accept="image/*" />
													<!-- 要多張照片用multiple="multiple" -->
												</div>

											</div>
											<div style="height: 15px"></div>
											<div class="form-row mb-3">
												<img src="<c:url value='/images/nopicture.jfif'/>"
													name="img-preview" id="img-preview" class="h-100 w-100" />
											</div>
										</div>
									</div>
									<div style="margin-left: 700px">
										<button type="submit" id="additemsubmit"
											class="btn btn-primary">新增商品</button>
										<button type="button" id="clear" class="btn btn-primary"
											style="margin-top: 5px">重新新增商品</button>
									</div>
								</form:form>
								<div id="additemsuccess"></div>
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