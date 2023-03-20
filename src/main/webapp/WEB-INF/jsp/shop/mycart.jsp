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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>"></script>
<script src="<c:url value='/javascript/jquery-ui.min.js'/>"></script>

<meta charset="BIG5">
<title>Insert title here</title>
<style>
table {
    border-collapse: collapse;
    margin: 0 auto;
}

td,th {
    text-align: center;
    vertical-align: middle;
}
</style>
</head>
<body>
<div>我的購物車</div>
<div class="container">
  <table class="table table-bordered table-striped table-hover" id="carttable">
    <thead>
      <tr>
        <th class="col-2">商品名</th>
        <th class="col-2">商品圖片</th>
        <th class="col-1">價格</th>
        <th class="col-1">操作</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach items="${sblist}" var="cart" varStatus="status">
        <tr>
          <td class="col-2" style="display:none" >
            <div>${cart.productShoppingCar.productId}</div>
          </td>
          <td class="col-2" style="display:none" >
            <div>${cart.productShoppingCar.status}</div>
          </td>
          <td class="col-2">
            <div>${cart.productShoppingCar.productName}</div>
          </td>
          <td class="col-2">
            <c:choose>
              <c:when test="${cart.productShoppingCar.photo eq ''}">
                <img width='60' height='60' src="${contextRoot}/images/nopicture.jfif" />
              </c:when>
              <c:otherwise>
                <img width='60' height='60' src="${contextRoot}/uploadProduct/${cart.productShoppingCar.photo}" />
              </c:otherwise>
            </c:choose>
          </td>
          <td class="col-1">
            <div>${cart.productShoppingCar.price}</div>
          </td>
          <td class="col-1" style="display:none">
            <div>${cart.shoppingCarId}</div>
          </td>
          <td class="col-1">
            	<a href="#" class="button deletebtn"><img src="${contextRoot}/images/delete.webp" style="max-width: 20px; max-height: 20px;"></a>
            <c:if test="${cart.productShoppingCar.status ne 0 }">  
            	<a class="button buybtn productId${cart.productShoppingCar.productId}"><img src="${contextRoot}/images/checkout.png" style="max-width: 20px; max-height: 20px;"></a>
          	</c:if> 
          	<c:if test="${cart.productShoppingCar.status eq 0 }">
            	<img src="${contextRoot}/images/soldout.png" style="max-width: 20px; max-height: 20px;">
          	</c:if>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>




<div>訂購明細</div>
<div class="container">
  <table class="table table-bordered table-striped table-hover" id="buytable">
    <thead>
      <tr>
        <th class="col-2">商品名</th>
        <th class="col-1">價格</th>
        <th class="col-1">數量</th>
        <th class="col-1">金額</th>
        <th class="col-1">刪除</th>
      </tr>
    </thead>
    <tbody id="buy">
    </tbody>
      <tr><td id="total" colspan="5" style="text-align: right;">商品總額:0</td></tr>
      <tr><td id="checkout" colspan="5" style="text-align: right;"><button id="checkoutBtn">確認結帳</button></td></tr>
  </table>
</div>

	
	
	
	
	
	
	
	
<!-- 	ecpay部分開始 -->
<form id="idFormAioCheckOut" method="post" action="ECPayServer" class="border shadow p-3 mb-5" style="display:none">			
			<div class="row text-primary ">				
				<div class="mb-3 col-sm-3">
					<label class="col-xs-12">TotalAmount(交易金額):</label>
					<input type="text" name="TotalAmount" value="0" class="form-control" id="totalAmount" />
					請帶整數，不可有小數點。僅限新台幣。
				</div>			
				<div class="mb-3 col-sm-4">
					<label class="col-xs-12">TradeDesc(交易描述): </label>
					<input type="text" name="TradeDesc" value="刷兩三下就光亮如新" class="form-control" />
					請勿帶入特殊字元。
				</div>
				<div class="mb-3 col-sm-5">
					<label class="col-xs-12">ItemName(商品名稱):</label>
					<input type="text"	name="ItemName" value="馬桶刷850元x1#消毒水200元" class="form-control" id="itemName" />
					商品名稱<br/> 
					1. 如果商品名稱有多筆，需在金流選擇頁一行一行顯示商品名稱的話，商品名稱請以符號#分隔。
				    2. 商品名稱字數限制為中英數 400 字內，超過此限制系統將自動截斷。
				</div>
			</div>
			<input type="text"	name="productIdArr" value="" id="productIdArr" />
			<input type="text"	name="quantArr" value="" id="quantArr" />
			<button type="submit" class="btn btn-primary">結帳</button>
		</form>
<!-- 	ecpay部分結束 -->


<script>
window.onload=function(){
	let total
	$("#checkout").prop("disabled", true).css({
		  "pointer-events": "none",
		  "opacity": "0.5"
		});
	$(".buybtn").on("click",function(){
		$(this).prop("disabled", true).css({
			  "pointer-events": "none",
			  "opacity": "0.5"
			});
		total=0
		let productName = $(this).closest("tr").find("td").eq(2).text()
		let price = $(this).closest("tr").find("td").eq(4).text()
		let productId = $(this).closest("tr").find("td").eq(0).text()
		let status = $(this).closest("tr").find("td").eq(1).text()
		let shoppingCarId = $(this).closest("tr").find("td").eq(5).text().trim()
		$('#buy').append(`<tr> 
						   <td class="col-2" style="display:none"> 
				             <div>`+productId+`</div> 
				           </td> 
				           <td class="col-1" style="display:none"> 
				             <div>`+status+`</div> 
				           </td> 
				           <td class="col-2"> 
				             <div>`+productName+`</div> 
				           </td> 
				           <td class="col-1"> 
				             <div>`+price+`</div> 
				           </td> 
				           <td class="col-1"> 
				           		<div class="input-group quant">
				                   	<input class="quantity-input form-control" type="number" min="1" max=\${status} value="1" name="status" onkeydown="return false" /> 
				                </div>
				           </td> 
				           <td class="col-1"> 
				             <div>`+price+`</div> 
				           </td> 
				           <td class="col-1" style="display:none"> 
				             <div class="product\${shoppingCarId}">`+shoppingCarId+`</div> 
				           </td> 
				           <td class="col-1"> 
				            <a href="#" class="button deletebuybtn"><img src="${contextRoot}/images/delete.webp" style="max-width: 20px; max-height: 20px;"></a>
           					</td>
				         </tr>`);
		$("#buy tr").each(function(){
		      let rowPrice = $(this).find("td").eq(5).find("div").text();
		      total += parseFloat(rowPrice);
		  });
		$("#total").text(`商品總額:\${total}`)
		$("#checkout").prop("disabled", false).css({
			  "pointer-events": "auto",
			  "opacity": "1"
			});
		
	})
	
	
	
	
	$("#buy").on("change", ".quantity-input", function() {
		 total=0
		 let quant = $(this).val()
		 let price = $(this).closest("tr").find("td").eq(3).text()
		 let productprice = quant*price
		 $(this).closest("tr").find("td").eq(5).find("div").text(productprice) 
		 $("#buy tr").each(function(){
		      let rowPrice = $(this).find("td").eq(5).find("div").text();
		      total += parseFloat(rowPrice);
		  });
		 $("#total").html(`商品總額:\${total}`);
		 });
	
	
	
	$("#buy").on("click", ".deletebuybtn", function() {
		let productId = $(this).closest("tr").find("td").eq(0).text().trim()
		let productClass = `.productId\${productId}`;
		$(productClass).prop("disabled",false).css({
			  "pointer-events": "auto",
			  "opacity": "1"
			});;
		
		
		
		
		total=0
		let productprice = $(this).closest("tr").find("td").eq(5).find("div").text()
		$(this).closest("tr").remove()
		$("#buy tr").each(function(){
		      let rowPrice = $(this).find("td").eq(5).find("div").text();
		      total += parseFloat(rowPrice);
		  });
		$("#total").html(`商品總額:\${total}`);
		if(total!=0){
			$("#checkout").prop("disabled", false).css({
				  "pointer-events": "auto",
				  "opacity": "1"
				});
			
		}
		else{
			$("#checkout").prop("disabled", true).css({
				  "pointer-events": "none",
				  "opacity": "0.5"
				});
			
		}
	});
	
	
	
	
	
	$(".deletebtn").on("click",function(){
		let cartId = $(this).closest("tr").find("td").eq(5).text().trim()
		let row=$(this)
		$.ajax({
			method : 'delete',
			data : {
				"cartId" : cartId
			},
			url : '${contextRoot}/deleteCart',
			success : function() {
// 				total=0
// 				let productClass = `.product\${cartId}`;
// 				$(productClass).closest("tr").remove()
				row.closest("tr").remove()
// 				$("#buy tr").each(function(){
// 				      let rowPrice = $(this).find("td").eq(5).find("div").text();
// 				      total += parseFloat(rowPrice);
// 				  });
// 				$("#total").html(`商品總額:\${total}`);
			}

		})
	
		
	})
	
	$("#checkout").on("click",function(){
		let totalAmount = $("#total").text().trim().replace("商品總額:","")
		let itemName = ""
	    $("#buy tr").each(function(){
        	itemName += $(this).find("td").eq(2).find("div").text().trim()+"#";
	    })
	    let quantArr=""
    	$("#buy tr").each(function(){
        	quantArr += $(this).find("input").val().trim()+"#";
	    })
	    let productIdArr=""
    	$("#buy tr").each(function(){
        	productIdArr += $(this).find("td").eq(0).find("div").text().trim()+"#";
	    })
	    
		$("#totalAmount").val(totalAmount)
		$('#itemName').val(itemName)
		$('#productIdArr').val(productIdArr)
		$('#quantArr').val(quantArr)
		$("#idFormAioCheckOut").submit()
		
			})
	
		
		
	
}
</script>	

</body>
</html>