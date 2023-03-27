<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
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
		<!-- Bootstrap core CSS -->
		<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-star-rating/4.0.6/css/star-rating.min.css">
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
		<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.3.4/axios.min.js" integrity="sha512-LUKzDoJKOLqnxGWWIBM4lzRBlxcva2ZTztO8bTcWPmDSpkErWx0bSP4pdsjNH8kiHAUPaT06UXcb+vOEZH+HpQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
		<style type="text/css">
			* {
				margin: 0px;
				padding: 0px;
			}
			#div {
				width: 800px;
				height: 600px;
				//border: 1px dotted red;
				margin: auto;
				padding: 20px;
			}
			#div div:nth-child(1) {
				display: flex;
				align-items: center;
				justify-content: center;
			}
			/*#tbcal {border-collapse: collapse;width: 100%;text-align: center;}*/
			thead {text-align: center;}

			#tbcalbody tr, #tbcalbody td {
				text-align: right;
			}
			#tbcalbody td:hover {
				background: #eeeeee;
			}
			.dayBtn {
				display: block;
				background: #ffffff00;
				height: 100%;
				width: 100%;
				padding: 0;
				border: 0;
				text-align: right;
			}
			#tbcalbody td {
				padding: 0;
			}
			tr:first-child th:first-child {
            border-top-left-radius: 17px;
        }

        tr:first-child th:last-child {
            border-top-right-radius: 17px;
        }

        tr:last-child td:first-child {
            border-bottom-left-radius: 17px;
        }

        tr:last-child td:last-child {
            border-bottom-right-radius: 17px;
        }
		</style>

		<script type="text/javascript">
			//**********欠缺更進階自動計算時區，待完善**********
			window.onload=function(){
				getNowDate();
				initial();
				setYearAndMonth();
				document.getElementById("selyear").onchange=show;
				document.getElementById("selmonth").onchange=show;
				show();


				//document.getElementById("checkinDate_").addEventListener("input", formatDate);
				//document.getElementById("checkoutDate_").addEventListener("input", formatDate);
			}

			//抓取當前日期
			let nowDate;
			let nowYear;
			let nowMonth;
			let nowDay;
			function getNowDate() {
				nowYear=new Date().getFullYear();
				nowMonth=new Date().getMonth()+1;
				nowDay=new Date().getDate();
				nowDate=Date.parse(`\${nowYear}-\${nowMonth.toString().padStart(2, "0")}/\${nowDay.toString().padStart(2, "0")}`);
				console.log(`現在日期：\${nowYear}/\${nowMonth}/\${nowDay}`);
				console.log(nowDate);
			}



			//生成年月選單
			function initial() {
				var years=document.getElementById("selyear");
				var months=document.getElementById("selmonth");
				for (let i=nowYear;i<nowYear+2;i++) {
					var option=document.createElement("option");
					option.text=i;
					years.add(option);
				}
				for (let i=1;i<13;i++) {
					var option=document.createElement("option");
					option.text=i;
					months.add(option);
				}
			}

			//利用當前日期設定選單選項
			function setYearAndMonth() {
			document.getElementById("selyear").value=nowYear;
			document.getElementById("selmonth").value=nowMonth;
			}

			//生成月曆
			let year;
			let month;
			function show() {
				year=parseInt(document.getElementById("selyear").value);
				month=parseInt(document.getElementById("selmonth").value);
				let dateString = `\${year}-\${month.toString().padStart(2, "0")}-01`;		//設定查詢日期
				let flag=year%4==0&&year%100!=0||year%400==0;
				var dayOfMonth=[31,flag?29:28,31,30,31,30,31,31,30,31,30,31];
				var dt=new Date();
				dt.setFullYear(year);
				dt.setMonth(month-1);
				dt.setDate(1);
				var week=dt.getDay();
				var rows=Math.ceil((dayOfMonth[dt.getMonth()]+week)/7);
				var k=0;
				var table=document.getElementById("tbcalbody");
				while(table.rows.length>0){
					table.deleteRow(0);
				}

				//向後端request每日房間狀態
				roomId = ${roomId};	//==========測試用，須改為抓取context==========
				$.ajax({
					method : "get",
					data : {
						"roomId": roomId,
						"dateString": dateString
					},
					url : "checkroom",
					/*success : function(response) {
						console.log(response);
						//roomStateArray = JSON.parse(response);	//不需要轉換
						roomStateArray = response;
					    console.log(roomStateArray);
					}*/
				}).done(function(response) {
					console.log("Success:", response);
					let roomStateArray = response;
					//迴圈向表格中新增資料，生成日曆
					for(let i=0;i<rows;i++){
						document.getElementById("tbcalbody").innerHTML += `<tr id="tbcalbodytr\${i+1}"></tr>`;
						for(let j=0;j<7;j++){
							k++;
							if(k<=week || k>dayOfMonth[dt.getMonth()]+week){
								document.getElementById(`tbcalbodytr\${i+1}`).innerHTML += "<td></td>";
							}else {
								if(roomStateArray[k-week-1] === true) {
								document.getElementById(`tbcalbodytr\${i+1}`).innerHTML += `<td class="day\${k-week}"><button class="dayBtn" onclick="formatDate(\${k-week})">\${k-week}<br /><br />✔</button></td>`;
								}else if(roomStateArray[k-week-1] === false) {
								document.getElementById(`tbcalbodytr\${i+1}`).innerHTML += `<td class="day\${k-week}"><button class="dayBtn" onclick="formatDate(\${k-week})" disabled="disabled">\${k-week}<br /><br /></button>❌</td>`;
								}else {
								document.getElementById(`tbcalbodytr\${i+1}`).innerHTML += `<td class="day\${k-week}"><button class="dayBtn" onclick="formatDate(\${k-week})">\${k-week}<br /><br />❓</button></td>`;
								}
								//document.getElementById(`day\${k-week}`).addEventListener("click", () => console.log(k-week));
							}
						}
					}
					document.getElementById("selyear").value=year;
					document.getElementById("selmonth").value=month;
				})






			}
			//將選擇日期填入表單
			function formatDate(day) {
				console.log(`你選了\${year}/\${month}/\${day}`);
				let insertDate = `\${year}-\${month.toString().padStart(2, "0")}-\${day.toString().padStart(2, "0")}`;
				let checkinDate;
				let checkoutDate;
				if(document.getElementById("checkinDate").value === "") {
					document.getElementById("checkinDate").value = insertDate;
					document.getElementById("checkoutDate").value = "";
					document.getElementById("feedbackMsg").innerHTML = `你選了\${year}/\${month}/\${day}`;
				}else if(document.getElementById("checkinDate").value !== "" && document.getElementById("checkoutDate").value !== "") {
					document.getElementById("checkinDate").value = insertDate;
					document.getElementById("checkoutDate").value = "";
					document.getElementById("feedbackMsg").innerHTML = `你選了\${year}/\${month}/\${day}`;
				}else if(document.getElementById("checkinDate").value !== "" && document.getElementById("checkoutDate").value === "") {
					document.getElementById("checkoutDate").value = insertDate;
					document.getElementById("feedbackMsg").innerHTML += ` 到 \${year}/\${month}/\${day}`;
				}
				if(document.getElementById("checkinDate").value !== "" && document.getElementById("checkoutDate").value !== "") {
					checkinDate = Date.parse(document.getElementById("checkinDate").value);
					checkoutDate = Date.parse(document.getElementById("checkoutDate").value);
					if(checkinDate > checkoutDate || checkinDate < nowDate) {
						document.getElementById("feedbackMsg").innerHTML += `<br />退房日期不得早於訂房日期且訂房日期在今天(含)以前`;
						//other method
					}else {
						console.log("輸入正確，接受送出");
						document.getElementById("feedbackMsg").innerHTML += `<br />輸入正確，接受送出`;
					}
				}
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
		<section class="intro-single">
			<div class="container">
				<div class="row">
					<div class="col-md-12 col-lg-8">
						<div class="title-single-box">
							<h1 class="title-single">訂房資訊_${roomName}</h1>

							<div class="form-comments">
								<div class="title-box-d">
									<h5 class="title-d">即刻下訂</h5>
								</div>

								<div id="div">
									<!--定義年月選單-->
									<div>
										<select id="selyear"></select>&nbsp;年&nbsp;
										<select id="selmonth"></select>&nbsp;月&nbsp;
									</div>
									<div>
										<!--月曆-->
										<table id="tbcal" class="table table table-striped table-hover">
											<thead>
												<tr>
												<td>日</td>
												<td>一</td>
												<td>二</td>
												<td>三</td>
												<td>四</td>
												<td>五</td>
												<td>六</td>
												</tr>
											</thead>
											<tbody id="tbcalbody"></tbody>
										</table>
									</div>
									<div>
										<!--
										<form>
											入住時間：<input id="checkinDate" type="date" style="" disabled="disabled" />
											<input id="checkinDate_" type="text" />
											<br />
											退房時間：<input id="checkoutDate" type="date" style="" disabled="disabled" />
											<input id="checkoutDate_" type="text" />
										</form>
										-->
										<div id="feedbackMsg"></div>
									</div>
								</div>

								<form:form class="form-a" action="${contextRoot}/orders/post"
									modelAttribute="information">
									<div class="row">
										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="checkindate" style="font-weight: bold;">入住日期*</form:label>
												<form:input path="checkindate" type="text"
													class="form-control form-control-lg form-control-a"
													id="checkinDate" placeholder="入住日期" required="true" />
											</div>
										</div>

										<div class="col-md-6 mb-3">
											<div class="form-group">
												<form:label path="checkoutdate" style="font-weight: bold;">退房日期*</form:label>
												<form:input path="checkoutdate" type="text"
													class="form-control form-control-lg form-control-a"
													id="checkoutDate" placeholder="退房日期" required="true" />
											</div>
										</div>
										<div class="col-md-12 mb-3">
											<div class="form-group">
												<form:label path="message" style="font-weight: bold;">備註</form:label>
												<form:input class="form-control" path="message"
													placeholder="請輸入不超過30個字" maxlength="30" />
											</div>
										</div>

										<!-- 會員 -->
										<input type="hidden" name="userId"
											value="${sessionScope.id}" />


										<!-- 房號 -->
										<input type="hidden" name="rId" value="${Id}" />

									</div>

									<button type="submit" class="btn btn-primary"
										style="text-align: right;">送出</button>

								</form:form>
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
</body>
</html>