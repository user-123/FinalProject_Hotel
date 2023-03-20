<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

    
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<style>
.container {
  width: 900px;
  margin: 0 auto;
}
.container h1 {
  margin: 20px;
  text-align: center;
}
.container form {
  padding: 20px;
  background: #EBF0F4;
  border-radius: 10px;
}
.messages{
  margin: 10px 5px;
  color: #dc3545
}				

</style>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>" ></script>
<script src="<c:url value='/javascript/jquery-ui.min.js'/>" ></script> 
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
<div class="container">
	<h1>新增商品</h1>
		<form:form id="addItemForm" method="post"
			modelAttribute="ProductBean" enctype="multipart/form-data">
			<div class="form-row">
				<div class="form-group col-md-6">
					<div class="form-group">
						<label for="productName">商品名稱</label>
						<form:input id="productName" class="form-control" type="text"
							name="productName" path="productName" />
						<span id="productNameerror" class="error"></span>
					</div>
				</div>
			</div>
				<div class="form-row">
					<div class="form-group col-md-6">
						<div class="form-group">
							<label for="price">價格</label>
							<form:input id="price" class="form-control"
								type="text" name="price"
								path="price" />
						<span id="priceerror" class="error"></span>							<span class="accountNameerror error"></span>
						</div>
					</div>
				</div>
				<div class="form-row">
				
				
				
		  <div class="mb-3">
						<div class="row">
							<div class="col-sm-9">
								<label for="uploadedFile" class="form-label">上傳照片</label> <input
									class="form-control" type="file" name="uploadedFile"
									id="uploadedFile" accept="image/*" />		<!-- 要多張照片用multiple="multiple" -->
							</div>
							<div class="col-sm-3">
								<div class="form-control" style="height: 100px;">
									<img src="<c:url value='/images/nopicture.jfif'/>"
										name="img-preview" id="img-preview" class="h-100 w-100" />
								</div>
							</div>
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
			<div class="mb-3">
			  <div class="row">
			    <div class="col-sm-3">
			      <label for="status">存貨</label>
			      <div class="input-group">
			        <button class="btn btn-outline-secondary" type="button" id="minus10"><i class="fa fa-minus"></i>-10<i class="fa fa-minus"></i></button>
			        	<form:input class="quantity-input form-control" type="number" min="1" max="99" value="1" path="status" name="status" onkeydown="return false" />
			        <button class="btn btn-outline-secondary" type="button" id="plus10"><i class="fa fa-plus"></i>+10<i class="fa fa-plus"></i></button>
			      </div>
			    </div>
			  </div>
			</div>


			
			
			
			
			<label for="category">商品分類</label>	
			<form:select name="category" path="category">
			    <c:forEach items="${categoryList}" var="category">
			        <form:option value="${category.categoryId}" label="${category.categoryName}" />
			    </c:forEach>
			</form:select>
		</div>
			<button type="submit" id="additemsubmit" class="btn btn-primary">新增商品</button>
			<button type="button" id="clear" class="btn btn-primary">重新新增商品</button>
	</form:form>
	<div id="additemsuccess"></div>
</div>

</body>
</html>