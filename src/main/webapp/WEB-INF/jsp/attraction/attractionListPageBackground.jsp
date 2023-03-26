<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
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

<!-- Custom By D.C., need to replace with non-CDN -->
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.min.js"></script>
<link
	href="https://code.jquery.com/ui/1.13.2/themes/smoothness/jquery-ui.css"
	rel="stylesheet" />
<!-- D.C. Never End, Ya~Ya~Ya~ -->

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@10.16.6/dist/sweetalert2.min.js"></script>

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

					<li class="nav-item"><a class="nav-link active"
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
							<h1 class="title-single">景點管理</h1>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End Intro Single-->

		<!-- ======= Property Grid ======= -->
		<section class="property-grid grid">
			<div class="container">
				<div class="row">
					<div class="col-sm-12">
						<button class="addBtn btn btn-outline-warning"
							onclick="addDetail()">➕</button>
						<div class="grid-option">
							<form action="<c:url value="/admin/attraction/findByCategory" />"
								method="get">
								<select name="category">
									<option value="">全部</option>
									<option value="food">美食</option>
									<option value="spot">景點</option>
								</select> <input type="submit" class="btn btn-dark btn-sm" value="搜尋">
							</form>
						</div>
					</div>
					<div class="container" id="attractionPage">
						<div class="row justify-content-between" id="aList">

							<c:forEach items="${attraction}" var="info" varStatus="status">
								<div class="col-6 col-sm-6 w-50" id="div${info.attractionId}">
									<br />
									<!-- <span id="span${info.attractionId}">${status.index+1}.</span> -->
									<div class="justify-content-center w-100"
										style="overflow: hidden; width: 512px; height: 384px;">
										<img
											src="<c:url value='/attractionPhoto/${info.attractionPhotoPath}'/>"
											style="width: 100%; height: 100%;"
											class="object-fit-contain border rounded" />
									</div>
									<!--
											<div class="zoomImage" style="background-image:url(<c:url value='/uploadDir/a0.jpg' />)">${status.index+1}.</div>
											 -->
									<div class="row justify-content-start">
										<div class="col-10 col-sm-10">
											${info.attractionName}<br /> ${info.attractionAddress}
										</div>
										<div class="col-2 col-sm-2">
											<!--
													<form action="<c:url value="/public/XXXX" />" method="get">
														<input type="hidden" id="${info.attractionId}" name="Id" value="${info.attractionId}" />
														<input type="submit" id="checkout" class="btn btn-outline-dark btn-sm" value="${XXXXX}檢視">
													</form>
													 -->
											<button class="checkoutBtn btn btn-outline-dark btn-sm"
												onclick="showDetail(${info.attractionId})">📝</button>
										</div>
									</div>
								</div>
							</c:forEach>


						</div>
					</div>
				</div>
				<script>
						$('#aPhoto').on("change", function() {
							let filetype = this.files[0]["name"].split(".")
							let filesize = this.files[0]["size"]
							let accepttype = ["jpg", "png", "jpeg", "webp", "gif"]
							if ((!accepttype.includes(filetype[filetype.length - 1]))
									|| (filesize > 10*1024*1024)) {
								alert("請上傳jpg、png、gif、webp格式的圖片(檔案大小限制10MB)");
								this.value = ""
								//$('#img-preview').attr('src', '<c:url value="/images/default2.jpg"/>')
							}
							//let output = document.getElementById('img-preview');
							//output.src = URL.createObjectURL(event.target.files[0]);
							//console.log(event.target.files);
							//output.onload = function() {URL.revokeObjectURL(output.src)	}

						})



							function showDetail(id) {
								$.ajax({
									method : "get",
									data : {"id": id},
									url : "checkoutAttractionDetail"
								}).done(function(response) {
									console.log("Success:", response);
									let attractionDetail = response;
									let message = `<div>`;
									message += `
										<div>
											<input type="hidden" id="aId" value="\${attractionDetail.attractionId}" />
											<input type="hidden" id="aNum" value="\${attractionDetail.attractionNum}" /><br />
											名稱：<input type="" id="aName" value="\${attractionDetail.attractionName}" required="required" /><br />
											分類：<select id="aCategory">
												<option value="美食">美食</option>
												<option value="景點">景點</option>
											</select><br />
											地址：<input type="" id="aAddress" value="\${attractionDetail.attractionAddress}" required="required" /><br />
											距離：<input type="" id="aDistance" value="\${attractionDetail.attractionDistance}" /><br />
											介紹：<input type="" id="aIntroduction" value="\${attractionDetail.attractionIntroduction}" /><br />
											照片：<input type="file" id="aPhoto" value="\${attractionDetail.attractionPhotoPath}" accept="image/*" /><br />
										</div>
									`;
									/*
									message += `
										<hr />
										<div>
											<button class="updateBtn btn btn-outline-success btn-sm">修改</button>　<button class="updateBtn btn btn-outline-danger btn-sm">刪除</button>　<button class="updateBtn btn btn-outline-secondary btn-sm" onclick="">關閉</button>
										</div>
									`;
									*/
									message += `</div>`
									console.log(message);
									let modal = $(message).dialog({
					                    width: 600, modal: true, autoOpen: true, title: `\<input value="\${attractionDetail.attractionName}" />`,
					                    buttons: [{text: "修改", click: function() {updateDetail(id);$(this).dialog("close");$(this).remove();}}, {text: "刪除", click: function() {deleteDetail(id);$(this).dialog("close");$(this).remove();}}, {text: "關閉", click: function() {$(this).dialog("close");$(this).remove();}}]
					                });
									$(".ui-dialog-titlebar").hide();
									//$(".ui-dialog-titlebar-close").hide();
									//$(".ui-dialog-buttonpane").hide();
									//$("#ui-id-2").hide();
									//效能問題，須棄用
									$(".ui-dialog-buttonset button:nth-child(1)").addClass("updateBtn btn btn-outline-success btn-sm");
									$(".ui-dialog-buttonset button:nth-child(2)").addClass("deleteBtn btn btn-outline-danger btn-sm");
									$(".ui-dialog-buttonset button:nth-child(3)").addClass("closeBtn btn btn-outline-secondary btn-sm");
									document.getElementById("aCategory").value =`\${attractionDetail.attractionCategory}`;
								})
							}
							function addDetail() {
								let message = `<div>`;
								message += `
									<div>
										名稱：<input type="" id="aName" required="required" /><br />
										分類：<select id="aCategory">
											<option value="美食">美食</option>
											<option value="景點">景點</option>
										</select><br />
										地址：<input type="" id="aAddress" required="required" /><br />
										距離：<input type="" id="aDistance" /><br />
										介紹：<input type="" id="aIntroduction" /><br />
										照片：<input type="file" id="aPhoto" accept="image/*" /><br />
									</div>
								`;
								message += `</div>`;
								console.log(message);
								let modal = $(message).dialog({
				                    width: 600, modal: true, autoOpen: true, title: ``,
				                    buttons: [{text: "新增", click: function() {createDetail();$(this).dialog("close");$(this).remove();}}, {text: "取消", click: function() {$(this).dialog("close");$(this).remove();}}]
				                });
								$(".ui-dialog-titlebar").hide();
								//$(".ui-dialog-titlebar-close").hide();
								//$(".ui-dialog-buttonpane").hide();
								//$("#ui-id-2").hide();
								//效能問題，須棄用
								$(".ui-dialog-buttonset button:nth-child(1)").addClass("updateBtn btn btn-outline-primary btn-sm");
								$(".ui-dialog-buttonset button:nth-child(2)").addClass("closeBtn btn btn-outline-secondary btn-sm");
							}
							function createDetail() {
								let aName=$("#aName").val();
								let aCategory=$("#aCategory").val();
								let aAddress=$("#aAddress").val();
								let aDistance=$("#aDistance").val();
								let aIntroduction=$("#aIntroduction").val();
								//let aPhotoPath=$("#aPhotoPath").val();
								let photoInput = $("#aPhoto")[0];
							    let aPhoto = photoInput.files[0];
							    let aData = new FormData();
							    aData.append("name", aName);
							    aData.append("category", aCategory);
							    aData.append("address", aAddress);
							    aData.append("distance", aDistance);
							    aData.append("introduction", aIntroduction);
							    aData.append("photoFile", aPhoto);
								$.ajax({
									method : "post",
									data : aData,
									url : "createAttractionDetail",
									processData: false,
								    contentType: false
								}).done(function(response) {
									console.log("Success:", response);
									if(response !== null) {
										let aId=`\${response.attractionId}`;
										let aName=`\${response.attractionName}`;
										let aAddress=`\${response.attractionAddress}`;
										let aPhotoPath =`\${response.attractionPhotoPath}`
										Swal.fire('新增成功', '', 'success');
										addList(aId, aName, aAddress, aPhotoPath);
									}else {
										Swal.fire('新增失敗', '', 'error');
									}
								})
							}
							function updateDetail(id) {
								console.log(id);
								//let aNum=$("#aNum").val();
								let aName=$("#aName").val();
								let aCategory=$("#aCategory").val();
								let aAddress=$("#aAddress").val();
								let aDistance=$("#aDistance").val();
								let aIntroduction=$("#aIntroduction").val();
								//let aPhotoPath=$("#aPhotoPath").val();
								let photoInput = $("#aPhoto")[0];
							    let aPhoto = photoInput.files[0];
							    let aData = new FormData();
							    aData.append("id", id);
							    aData.append("num", aNum);
							    aData.append("name", aName);
							    aData.append("category", aCategory);
							    aData.append("address", aAddress);
							    aData.append("distance", aDistance);
							    aData.append("introduction", aIntroduction);
							    aData.append("photoFile", aPhoto);
							    /*有問題待測試
							    var aPhoto2;
								let imageInput = document.getElementById("aPhoto");
								let photoFile = imageInput.files[0];
								let photoReader = new FileReader();
								photoReader.readAsDataURL(photoFile);
								photoReader.onload = ()=>{aPhoto2 = photoReader.result;}
								console.log(`\${aPhoto2}`);
								*/
								console.log(`\${aNum}&\${aName}&\${aCategory}&\${aAddress}&\${aDistance}&\${aIntroduction}&\${aPhoto}`);
								let aPhotoPath = "default.jpg";
								$.ajax({
									method : "put",
									data : aData,
									url : "updateAttractionDetail",
									processData: false,
								    contentType: false
								}).done(function(response) {
									console.log("Success:", response);
									if(response!==null) {
										Swal.fire('更新成功', '', 'success');
										aPhotoPath=`\${response.attractionPhotoPath}`
									}else {
										Swal.fire('更新失敗', '', 'error');
									}
									reflashList(id, aName, aAddress, aPhotoPath);
								})
							}
							function deleteDetail(id) {
								console.log(id);
								$.ajax({
									method : "delete",
									data : {"id": id},
									url : "deleteAttractionDetail"
								}).done(function(response) {
									console.log("Success:", response);
									if(response) {
										document.getElementById(`div\${id}`).remove();
										Swal.fire('刪除成功', '', 'success');
									}else {
										Swal.fire('刪除失敗', '', 'error');
									}
								})
							}
							function reflashList(id, aName, aAddress, aPhotoPath) {
								//document.getElementById(`div\${id}`).empty();
								document.getElementById(`div\${id}`).innerHTML = `
									<br />
									<!-- <span id="span\${id}">${status.index+1}.</span> -->
									<div class="justify-content-center w-100" style="overflow: hidden;width: 512px;height: 384px;">
										<img src="<c:url value='/attractionPhoto/' />\${aPhotoPath}" style="width: 100%;height: 100%;" class="object-fit-contain border rounded" />
									</div>
									<!--
									<div class="zoomImage" style="background-image:url(<c:url value='/uploadDir/a0.jpg' />)">${status.index+1}.</div>
									 -->
									<div class="row justify-content-start">
										<div class="col-10 col-sm-10">
											\${aName}<br />
											\${aAddress}
										</div>
										<div class="col-2 col-sm-2">
											<!--
											<form action="<c:url value="/public/XXXX" />" method="get">
												<input type="hidden" id="${info.attractionId}" name="Id" value="${info.attractionId}" />
												<input type="submit" id="checkout" class="btn btn-outline-dark btn-sm" value="${XXXXX}檢視">
											</form>
											 -->
											<button class="checkoutBtn btn btn-outline-dark btn-sm" onclick="showDetail(\${id})">📝</button>
										</div>
									</div>`
							}
							function addList(aId, aName, aAddress, aPhotoPath) {
								console.log(`\${aId}, \${aName}, \${aAddress}`);
								let list = document.getElementById("aList").innerHTML;
								console.log(list);
								document.getElementById(`aList`).innerHTML = `
									<div class="col-6 col-sm-6" id="div\${aId}">
										<br />
										<div class="justify-content-center w-100" style="overflow: hidden;width: 512px;height: 384px;">
											<img src="<c:url value='/attractionPhoto/' />\${aPhotoPath}" style="width: 100%;height: 100%;" class="object-fit-contain border rounded" />
										</div>
										<div class="row justify-content-start">
											<div class="col-10 col-sm-10">
												\${aName}<br />
												\${aAddress}
											</div>
											<div class="col-2 col-sm-2">
												<button class="checkoutBtn btn btn-outline-dark btn-sm" onclick="showDetail(\${aId})">📝</button>
											</div>
										</div>
									</div>` + list;
							}

							ScrollReveal({duration: 1500});
							ScrollReveal().reveal(".information");
						</script>
			</div>
		</section>























	</main>
	<!-- End #main -->



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