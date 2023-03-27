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
<sec:authorize access="hasAuthority('user')||isAnonymous()">
	<title>貝殼窩BackHome</title>
</sec:authorize>
<sec:authorize access="hasAuthority('admin')">
	<title>貝殼窩-管理系統</title>
</sec:authorize>
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
.ui-dialog-titlebar-close {
	display: none;
}

.pageBtn {
	display: inline-block;
	margin: 0 5px;
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 3px;
	text-decoration: none;
	color: #333;
}

.currentBtn {
	display: inline-block;
	margin: 0 5px;
	padding: 5px 10px;
	border: 1px solid #ccc;
	border-radius: 3px;
	background-color: #41cff2;
	color: #333;
}

#edit-form, #addCart {
	position: fixed;
	z-index: 9999;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 800px;
	height: 550px;
	border: 1px solid #000;
	background-color: #fff;
	padding: 20px;
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
	<section class="intro-single">
		<sec:authorize access="hasAuthority('user')||isAnonymous()">
			<div class="container">
				<div class="title-single-box">
					<h1 class="title-single">商城</h1>
				</div>
			</div>
		</sec:authorize>
		<sec:authorize access="hasAuthority('admin')">
			<div class="container">
				<div class="title-single-box">
					<h1 class="title-single">商城管理</h1>
				</div>
			</div>
		</sec:authorize>

		<div class="container w-70 mt-5">
			<div class="input-group" style="display: flex">
				<div>
					<input type="text" class="rounded" placeholder="搜索關鍵字"
						aria-label="Search" aria-describedby="search-addon" id="searchbtn"
						name="searchbtn" />
				</div>

				<div style="margin-left: 10px">
					<button type="button" class="btn btn-info" id="searchsubmit">搜尋</button>
				</div>
			</div>
		</div>

		<sec:authorize access="hasAuthority('user')">
			<div style="margin-left: 1000px; display: flex;">
				<a href="${contextRoot}/myCart" class="button cartbtnnav"><img
					src="${contextRoot}/images/car.png"
					style="max-width: 50px; max-height: 50px;"></a> <a
					href="${contextRoot}/myHistoryOrder" class="button cartbtnnav"><img
					src="${contextRoot}/images/historyorder.jpg"
					style="max-width: 50px; max-height: 50px;"></a>
			</div>
		</sec:authorize>

		<sec:authorize access="hasAuthority('admin')">
			<div style="margin-left: 1000px">
				<a href="<c:url value='/admin/additem'/>">
					<button class="btn btn-info">新增產品</button>
				</a>
			</div>
		</sec:authorize>

		<!--   點擊選項卡的上層清單 -->
		<%-- ${categoryPages[0].content[0].price} --%>
		<ul class="d-flex justify-content-center nav nav-tabs">
			<c:forEach items="${categoryList}" var="category" varStatus="status">
				<li class="nav-item categoryhref" style="margin: 20px"><a
					href="${contextRoot}/public/shop/show?c=${categoryList[status.index].categoryId}&p=1">
						<button class="btn btn-info categorybtn"
							style="margin-right: 10px">${category.categoryName}</button>
				</a>
					<div style="display: none">${category.categoryId}</div></li>
			</c:forEach>
		</ul>
		<!--   點擊選項卡的上層清單結束 -->

		<div id=show></div>


		<!-- 跳出表單開始 -->

		<div id="edit-dialog">
			<form:form id="edit-form" method="post" modelAttribute="ProductBean"
				enctype="multipart/form-data">

				<div class="form-group col-md-6">
					<div class="form-group">
						<span id="priceerror" class="error"></span> <span
							class="accountNameerror error"></span> <label for="productName">商品名稱</label>
						<form:input id="productName" class="form-control" type="text"
							name="productName" path="productName" />
						<span id="productNameerror" class="error"></span>

						<label for="price">價格</label>
						<div style="display: flex; align-items: center;">
							<span>NT$</span>
							<form:input id="price" class="form-control" type="text"
								name="price" path="price" />
						</div>

					</div>
				</div>

				<div class="form-row">

						<div class="row">
							<div class="col-sm-9">
								<label for="uploadedFile" class="form-label">上傳照片</label> <input
									class="form-control" type="file" name="uploadedFile"
									id="uploadedFile" accept="image/*" />
								<!-- 要多張照片用multiple="multiple" -->
							</div>
							<div class="col-sm-3">
								<div class="form-control" style="height: 180px; width: 155px;"
									id="photo">
									<img src="<c:url value='/images/nopicture.jfif'/>"
										name="img-preview" id="img-preview" class="h-100 w-100" />
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-sm-3">
								<label for="status">存貨</label>
								<div class="input-group">
									<button class="btn btn-outline-secondary" type="button"
										id="minus10">
										-10
									</button>
									<form:input class="quantity-input form-control" type="number"
										min="1" max="99" value="1" path="status" name="status"
										onkeydown="return false" id="status" />
									<button class="btn btn-outline-secondary" type="button"
										id="plus10">
										+10
									</button>
								</div>
							</div>
						</div>
					</div>

					<label for="category">商品分類</label>
					<form:select name="category" path="category">
						<c:forEach items="${categoryList}" var="category">
							<form:option value="${category.categoryId}"
								label="${category.categoryName}" />
						</c:forEach>
					</form:select>
					<div style="text-align:right">
					<button type="submit" id="additemsubmit" class="btn btn-primary">送出修改</button>
					<button type="button" class="btn btn-danger cancelbtn">關閉</button>
				</div>

			</form:form>
	</div>
	
		<!-- 跳出表單結束 -->


		<!-- 跳出加入購物車開始 -->
		<div id="addCart">
			<div id="productNameCart"></div>
			<div id="priceCart"></div>
			<div id="photoCart"></div>




			<!--      <span><label for="status">請選擇欲購買數量</label></span> -->
			<!--      <div class="input-group quant"> -->
			<!--        	<input class="quantity-input form-control" type="number" min="1" max="99" value="1" name="status" onkeydown="return false" /> -->
			<!--      </div> -->




			<button type="button" class="btn btn-danger add">新增</button>
			<button type="button" class="btn btn-primary addcancel">取消</button>
			<div id="addsuccess"></div>
		</div>


		<!-- 跳出加入購物車結束 -->






	</section>

	<script>
window.onload=function(){

// 	show出商品開始
	var currentPage;
	var productId
	$('.categoryhref').on('click', function(event) {
        event.preventDefault();
    });
	const categoryIdInit = document.querySelector('.categorybtn').closest('li').querySelector('div').textContent;

	fetch(`${contextRoot}/public/shop/show?c=${categoryList[0].categoryId}&p=1`)
	  .then(response => response.json())
	  .then(data => {
		 categoryId=${categoryList[0].categoryId}
	     htmlmaker(data);
	  })


// 	var links = document.getElementsByTagName('a');
	const links = document.querySelectorAll('ul.nav-tabs a.nav-link');
	var categoryId;
	  for(var i = 0; i < links.length; i++) {
	    links[i].onclick = function() {
	      return false;
	    }
	  }


	const categorybtn = document.querySelectorAll('.categorybtn');
	categorybtn.forEach(btn => {
	  btn.addEventListener("click", (e) => {
		e.preventDefault();
		currentPage=1
		categoryId=btn.closest("li").querySelector('div').textContent
		fetch(btn.closest("a").href)
		.then(response =>
		response.json())
		.then(data => {
		   htmlmaker(data);
		})

	  });
	});




	function htmlmaker(data) {
		  let html = `
		    <section class="container">
		      <div class="row">`;

		  data.content.forEach((product, index) => {
		    html += `
		      <div class="col-sm-6 col-md-3">
		        <div class="thumbnail" style="width: 150px; height: 500px">
		          <div class="caption">
		          	<div  class="productId" style="display:none">\${product.productId}</div>
		          	<div  class="photopreview" style="display:none">\${product.photo}</div>

		            <div style="width:150px;" class="phototext">`


		            if(product.photo.trim() === '')
		            	html+=`<img width='130' height='150' src="${contextRoot}/images/nopicture.jfif" />`
		            else
		            	html+=`<img width='130' height='150' src="${contextRoot}/uploadProduct/\${product.photo}" />`


		            html+= `</div>
		            <p>
		              <b style='font-size: 16px;'>\${product.productName}</b>
		            </p>
		            <p>存貨:\${product.status}</p>
		            <p>價格:NT$\${product.price}</p>
		            <sec:authorize access="hasAuthority('admin')">
			            <a href="#" class="button editbtn"><img src="${contextRoot}/images/edit.png" style="max-width: 20px; max-height: 20px;"></a>
			            <a href="#" class="button deletebtn"><img src="${contextRoot}/images/delete.webp" style="max-width: 20px; max-height: 20px;"></a>
		       		</sec:authorize>
		       		<sec:authorize access="hasAnyAuthority('user')">
		            	<a href="#" class="button cartbtn"><img src="${contextRoot}/images/car.png" style="max-width: 20px; max-height: 20px;"></a>
		       		</sec:authorize>
		       		<sec:authorize access="hasAnyAuthority('ROLE_ANONYMOUS')">
						<a href="${contextRoot}/public/loginpage" class="button"><img src="${contextRoot}/images/car.png" style="max-width: 20px; max-height: 20px;"></a>
					</sec:authorize>
		          </div>
		        </div>
		      </div>`;

		    // 每四個換行
		    if ((index + 1) % 4 === 0) {
		      html += `<div class="row"></div>`;
		    }
		  });

		  html += `
		      </div>
		    </section>`;



	  let totalPages = data.totalPages;
	  html +='<div style="text-align:center">'
	  	if (currentPage === undefined) {
	  		currentPage=1
		}
	    for(var i = 1; i <=totalPages;i++){
	      if(i==currentPage)
	    	  html+=`<span class="currentBtn">\${currentPage}</span>`

	      else
	      	html += '<a class="pageBtn" data-pagenum="'+ i +'">'+ i  +'</a>'
	    }
		 html +='</div>'
		  $("#show").html(html);
		}

	let pageBtns = document.getElementsByClassName('pageBtn');
	$("#show").on("click", ".pageBtn", function(e) {
		   e.preventDefault();
		   console.log("button");
		   let pageNumber = this.getAttribute('data-pagenum');
		   currentPage=pageNumber
		   loadThatPage(pageNumber);

		 });

		    function loadThatPage(thatPage){
		    	  fetch(`${contextRoot}/public/shop/show?c=`+categoryId+`&p=` + thatPage,
		    	  {method:'get'})
		    	  .then(res =>{
		    	    return res.json()
		    	  })
		    	  .then(data =>{
		    	    htmlmaker(data)

		    	  })
		    	}

// 		    show出商品結束
// 		編輯跳出表單
		    var dialog = $('#edit-dialog').dialog({
	            autoOpen: false,
	            modal: true,
	    	});



	    	$('#edit-dialog').on('click', '.cancelbtn', function() {
	    		$(".deletebtn").prop('disabled', false);
	    		$(".editbtn").prop('disabled', false);
	    		$('.categorybtn').prop('disabled', false);
	    		$('.pageBtn').prop('disabled',false)
	    		$(".error").html("")
	    		$('#uploadedFile').val(null)
			    dialog.dialog('close');
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

		    $('#show').on('click', '.editbtn', function() {
		    		$(".editbtn").prop('disabled', true);
		    		$(".deletebtn").prop('disabled', true);
		    		$("#edit-form button").prop('disabled',false)

		    		$('.categorybtn').prop('disabled', true);
		    		$('.pageBtn').prop('disabled',true)

		    		let productName = $(this).closest("div").find("p:first").text().trim()
		    		let price = $(this).closest("div").find("p").eq(2).text().trim().replace("價格:NT$", "")
		    		let status = $(this).closest("div").find("p").eq(1).text().trim().replace("存貨:", "")
		    		productId = $(this).closest("div").find(".productId").text()
		    		photopreview = $(this).closest("div").find(".photopreview").text()

		    		console.log(productId)
		        	 $('#edit-dialog #productName').val(productName);
		        	 $('#edit-dialog #price').val(price);
		        	 $('#edit-dialog #status').val(status);

		        	 if(photopreview!="")
			        	 $('#edit-dialog #photo').html(`<img src="${contextRoot}/uploadProduct/`+photopreview+
								`" name="img-preview" id="img-preview" class="h-100 w-100" />`);
		        	 else
		        		 $('#edit-dialog #photo').html(`<img src="${contextRoot}/images/nopicture.jfif"
							 name="img-preview" id="img-preview" class="h-100 w-100" />`);

		        	 $('select[name=category]').val(categoryId);

		        dialog.dialog('open');

		    });





// 		   編輯跳出表單結束






	$('#uploadedFile').on("change", function() {
		  let output = document.getElementById('img-preview');
		  let file = this.files[0];
		  if (!file) {
			  if(photopreview == "")
		    		output.src = `http://localhost:8080/main/images/nopicture.jfif`;
		    	else
		       		output.src = `http://localhost:8080/main/uploadProduct/`+photopreview;
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
		// 		   驗證表單是否能送出開始
		$('#edit-dialog').on('click', '#additemsubmit', function() {
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
		var formData = new FormData($('#edit-form')[0]);
// 		formData.append("uploadedFile",$('#uploadedFile').val())




		fetch(`${contextRoot}/admin/edit?c=`+categoryId+`&p=` + currentPage+`&pId=` + productId, {
			  method: 'POST',
			  body: formData,
			  enctype:"multipart/form-data",
			  processData: false,
			  contentType: false
			})
			.then(response => {
			  if (response.ok) {
			    return response.json().then(data => {
			    	const pbjs = data.success;
			        htmlmaker(pbjs);
			        $('.categorybtn').prop('disabled', false);
			        $(".deletebtn").prop('disabled', false);
		    		$('.pageBtn').prop('disabled',false)
		    		$('#uploadedFile').val(null)
				     dialog.dialog('close');
				  });
			  } else {
			    response.json().then(errors => {
			      $.each(errors, function(key, value) {
			        $('#' + key + 'error').html(value).css({
			            "color" : "red",
			            "font-size" : "10%"
			        });
			      });
			    });
			  }
			});

	});






// 		   驗證表單是否能送出結束

// 		   刪除產品資料開始
		   $('#show').on('click', '.deletebtn',function(){
    	var $button = $(this);
    	var deleteId = $(this).closest("div").find(".productId").text();
    	console.log(deleteId)
    	var confirmed = confirm("確認刪除此商品嗎？");
    	 if (confirmed) {
			fetch(`${contextRoot}/admin/deleteproduct?c=`+categoryId+`&p=` + currentPage+`&dId=` + deleteId,
			  { method: 'DELETE'})
			  .then(res => res.json())
			  .then(data => {
			    htmlmaker(data);
			  })




    	}else{
    		return false;
    	}
    })

// 		   刪除產品資料結束

// 		   加入購物車開始
		let stock;
		$("#show").on("click", ".cartbtn", function(e) {
				productId=$(this).closest("div").find(".productId").text()
				stock = $(this).closest("div").find("p").eq(1).text().trim().replace("存貨:","")
				let productNameCart = $(this).closest("div").find("p:first").text().trim()
		    		let priceCart = $(this).closest("div").find("p").eq(2).text().trim()
		    		photoCart = $(this).closest("div").find(".photopreview").text()
		    		console.log(photoCart)
		        	 $('#addCart #productNameCart').text(productNameCart);
		        	 $('#addCart #priceCart').text(priceCart);


		        	 $('#addCart .quant').html(`<input class="quantity-input form-control" type="number" min="1" max=`+stock+` value="1" name="status" onkeydown="return false" />`);



		        	 if(photoCart!="")
			        	 $('#addCart #photoCart').html(`<img src="${contextRoot}/uploadProduct/`+photoCart+
			        			 `" class="h-10 w-10" />`);
		        	 else
		        		 $('#addCart #photoCart').html(`<img src="${contextRoot}/images/nopicture.jfif"
							 class="h-10 w-10" />`);
			   	addCart.dialog('open');
				$(".cartbtn").prop("disabled",true)
		})

		var addCart = $('#addCart').dialog({
            autoOpen: false,
            modal: true
    	});



		addCart.on('click', '.add', function() {
			$(".add").prop("disabled",true)
			$(".addcancel").prop("disabled",true)
			 $.ajax({
					method : 'post',
					data : {
			              "productId" : productId
			        },
					url:"${contextRoot}/addCart",
					success : function() {
						$('#addsuccess').html("已新增至您的購物車").css({
							"color" : "blue",
							"font-size" : "10%"
						});

						setTimeout(function() {
						      addCart.dialog('close');
						      $(".cartbtn").prop("disabled",false)
						      $(".add").prop("disabled",false)
						      $(".addcancel").prop("disabled",false)
								$('#addsuccess').html("")
						    }, 3000);
					}
			 });
// 			let buyquant=$('#addCart').find(".quantity-input").val()
// 			fetch(`${contextRoot}/addCart?c=`+categoryId+`&p=` + currentPage+`&pId=` + productId+`&buyquant=` + buyquant,
// 					{method: 'POST'})
// 				.then(res => res.json())
// 				.then(data => {
// 				  		  htmlmaker(data);
// 				  $('#addsuccess').html("已成功新增").css({
// 						"color" : "blue",
// 						"font-size" : "10%"
// 					});

// 					setTimeout(function() {
// 					      addCart.dialog('close');
// 					      $("#addCart").find(".quantity-input").val(1)
// 					      $(".cartbtn").prop("disabled",false)
// 					      $(".add").prop("disabled",false)
// 					      $(".addcancel").prop("disabled",false)
// 							$('#addsuccess').html("")
// 					    }, 3000);


// 				})



		});

		addCart.on('click', '.addcancel', function() {
		    addCart.dialog('close');
		    $(".cartbtn").prop("disabled",false)
		});

// 		   加入購物車結束







}
</script>
	<sec:authorize access="hasAuthority('user')||isAnonymous()">
		<!-- ======= Footer ======= -->

		<footer>
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<div class="copyright-footer">
							<p class="copyright color-text-a">
								&copy; Copyright <span style="color: #41cff2">貝殼窩團隊</span> All
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
	</sec:authorize>

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