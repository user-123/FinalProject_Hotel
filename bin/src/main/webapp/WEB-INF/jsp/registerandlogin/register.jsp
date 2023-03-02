<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"  %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="<c:url value='/favicon.ico' />">
<meta charset="UTF-8" />
<title>註冊</title>
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
				method : 'POST',
				data : {
					"email" : email
				},
				url : '/hotel/checkemailduplicate',
				success : function(result) {
					$('#duplicate').html(result).css({
						"color" : "red",
						"font-size" : "10%"
					})
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
						   if( $(colerror[i]).html()!="" ){
							    error="yes";
						    }

					}
					if(error=="no"){
						$('#submit').click();
						$('#registerForm').find('button').prop('disabled', true);
						$("#success").html("註冊成功,三秒後跳轉首頁")
						for (let i = 0; i < required.length; i++) {
						    required[i].disabled = true;
						}
					}

				}
				)


				$('#submit').on("click", function(event) {
					  $('#registerForm').submit();
					});




	}
</script>
</head>
<body>
	<div class="container">
  <h1>註冊</h1>
  <form:form id="registerForm" method="post" modelAttribute="loginBean" >
    <div class="form-row">
      <div class="form-group col-md-6">
        <label for="email">Email</label>
        <form:input id="email" class="form-control" type="text" placeholder="Email" name="email" path="email" />
        <span id="duplicate"></span>
        <span class="emailerror error"></span>
      </div>
      <div class="form-group col-md-6">
        <label for="accountName">使用者名稱</label>
        <form:input id="accountName" class="form-control" type="text" placeholder="帳號名稱" name="accountName" path="accountName"  />
      	<span class="accountNameerror error"></span>

      </div>
      <div class="form-group col-md-6">
        <label for="password">密碼</label>
          <form:input id="password" class="form-control" type="password" placeholder="密碼" name="password" path="password" />
      	  <span class="passworderror error"></span>
      </div>
      <div class="form-group col-md-6">
        <label for="confirm">確認密碼</label>
        <form:input id="confirm" class="form-control" type="password" placeholder="確認密碼" name="confirm" path="confirm" />
      	<span class="confirmerror error"></span>
      </div>
      </div>
    <button type="button" id="checksubmit" class="btn btn-primary">註冊</button>
    <button style="visibility:hidden" type="submit" id="submit" class="btn btn-primary"></button>
  </form:form>
    <div  id="success" class="text-primary"></div>
</div>

</body>
</html>
