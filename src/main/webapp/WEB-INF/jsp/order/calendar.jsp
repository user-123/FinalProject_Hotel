<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>訂房頁面_${roomName}</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
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
				border: 1px dotted red;
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
				border: 2px solid white;
				//height: 80px;
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


				document.getElementById("checkinDate_").addEventListener("input", formatDate);
				document.getElementById("checkoutDate_").addEventListener("input", formatDate);
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
				for (let i=nowYear;i<nowYear+5;i++) {
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
				})






			}

			//==========已棄用，可刪除==========
			function checkRoomState(roomId, dateString) {
				console.log(dateString);
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
				  roomStateArray = response;
				})
			}
			//==========已棄用，可刪除==========





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
						console.log("鬧夠了沒婊子，不要亂輸入");
						document.getElementById("feedbackMsg").innerHTML += `<br />鬧夠了沒婊子，不要亂輸入`;
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
				<form>
					入住時間：<input id="checkinDate" type="date" style="" disabled="disabled" />
					<input id="checkinDate_" type="text" />
					<br />
					退房時間：<input id="checkoutDate" type="date" style="" disabled="disabled" />
					<input id="checkoutDate_" type="text" />
				</form>
				<div id="feedbackMsg"></div>
			</div>
		</div>
	</body>
</html>