<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>XX飯店</title>
</head>
<body>
	<div class="container">
		<h1>歷史訂單</h1>
		<c:forEach var="datas" items="${datas}">
			<span>訂單成立時間: <fmt:formatDate
					pattern="yyyy-MM-dd ,a hh:mm:ss EEEE" value="${datas.orderdate}" /></span>
			<div>訂單編號:${datas.orderid}</div>
			<div>會員:${datas.userid.accountName}</div>
			<div>房號:${datas.roomid.roomId}</div>
			<div>入住日期:${datas.checkindate}</div>
			<div>退房日期:${datas.checkoutdate}</div>
			<div>備註:${datas.message}</div>

			<form action="${contextRoot}/orders/delete" method="post">
				<input type="hidden" name="orderid" value="${datas.orderid}" /> <input
					type="hidden" name="文彥的id傳過來的名字" value="${datas.userid.accountId}" />
				<input type="hidden" name="_method" value="delete" /> <input
					type="submit" class="btn btn-outline-danger btn-sm" value="刪除">

				<!--********************刪除前用來做再次確認的範本******************** -->
				<!-- <input class='popuptest' type="button" value="按我"> -->
				<!--     <p class='show'></p> -->

				<!--     <script> 
         var button = document.querySelector('.popuptest');
         var showtxt = document.querySelector('.show');

         function popup2(e) {
             window.confirm('您確定要刪除嗎');
             if (confirm('確定') == true) {
                 作刪除的動作
             } else {
                 //返還history.jsp(當沒發生過)
                 //這裡可以不寫
             }

         };
         button.addEventListener('click', popup2);
    </script> -->



			</form>

		</c:forEach>

	</div>
</body>
</html>