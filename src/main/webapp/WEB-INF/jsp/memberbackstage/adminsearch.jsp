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
<script src="<c:url value='/javascript/jquery-3.6.0.min.js' />"></script>
<script src="<c:url value='/javascript/jquery-ui.min.js' />"></script>
<link href="<c:url value='/assets/css/style2.css'/>" rel="stylesheet">
<meta charset="BIG5">
<style>
#edit-form {
	position: fixed;
	z-index: 9999;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	width: 400px;
	height: 400px;
	border: 1px solid #000;
	background-color: #fff;
	padding: 20px;
}

.input-group {
	margin: 30px
}
</style>
</head>
<body>
	<div class="input-group">
		<input type="text" class="rounded" placeholder="name"
			aria-label="Search" aria-describedby="search-addon" id="searchbtn"
			name="searchbtn" />
		<button type="button" class="btn btn-outline-danger btn-sm"
			id="searchsubmit">查詢</button>
	</div>
	<table
		class="table table-dark table-light table-bordered table-striped table-hover"
		id="showtable">
		<tr>
			<td>編號</td>
			<td>帳號</td>
			<td>用戶名</td>
			<td>頭貼</td>
			<td>操作</td>
		</tr>
	</table>
	<div id="edit-dialog">
		<form id="edit-form">
			<div class="form-row">
				<div id="username"></div>
<!-- 				<div id="useraddress"></div> -->
				<div id="usergender"></div>
				<div id="userphone"></div>
				<div id="userbirthday"></div>
				<div id="userphoto"></div>
				<button type="button" class="btn btn-danger cancelbtn">關閉</button>
			</div>
		</form>
	</div>










	<script>
    $('#searchsubmit').on("click", function(event) {
      $.ajax({
        method : 'get',
        data : {
          "search" :$('#searchbtn').val()
        },
        url:"search",
        success:function(data){
        	 var rowsToDelete = $('#showtable tr:not(:first)');
        	 rowsToDelete.each(function() {
        	     $(this).remove();
        	 });
        	$.each(data, function (index, value) {
                $("table").append(`<tr>
                    <td>\${index+1}</td>
                    <td style="display:none;">\${value[0]}</td>
                    <td>\${value[1]}</td>
                    <td>\${value[2]}</td>
                    <td style="display:none;">\${value[3]}</td>
                    <td style="display:none;">\${value[4]}</td>
                    <td style="display:none;">\${value[5]}</td>
                    <td style="display:none;">\${value[6]}</td>
                    <td style="display:none;">\${value[7]}</td>
                    <td><div><img src=\${value[8]} width='80' class='m-1 border rounded' /></div></td>
                    <td><button type="button" class="btn btn-outline-primary editbtn"
                		>詳細資料</button>
                    <button type="button" class="btn btn-outline-danger deletebtn"
            			>刪除</button>
            			</td>
                			</tr>`);
            });
        }
      })
    });


    $('table').on('click', '.deletebtn',function(){
    	var $button = $(this);
    	var deleteId = $(this).closest("tr").find("td:eq(1)").text();
    	var confirmed = confirm("確認刪除此使用者資料嗎？");
    	 if (confirmed) {
    	$.ajax({
            method : 'delete',
            data : {
              "deleteId" : $(this).closest("tr").find("td:eq(1)").text()
            },
            url:"deleterow",
            success:function(data){
            	$button.closest("tr").remove();
            }
          })
    	}else{
    		return false;
    	}
    })




    var dialog = $('#edit-dialog').dialog({
            autoOpen: false,
            modal: true,
    	});



    	$('#edit-dialog').on('click', '.cancelbtn', function() {
		    dialog.dialog('close');
		});


	    $('table').on('click', '.editbtn', function() {
	    	var row = $(this).closest('tr');
	    	var username = "姓名:"+row.find('td:eq(4)').text();
	        var useraddress = "地址:"+row.find('td:eq(5)').text();
	        var usergender = "性別:"+row.find('td:eq(6)').text();
	        var userphone = "手機:"+row.find('td:eq(7)').text();
	        var userbirthday = "生日:"+row.find('td:eq(8)').text();
	        var userphoto = "頭貼:"+row.find('td:eq(9)').html();
	        if(username.trim() !== "姓名:"){
		    	$('#edit-dialog #username').text(username);
		    	//$('#edit-dialog #useraddress').text(useraddress);
		    	$('#edit-dialog #usergender').text(usergender);
		    	$('#edit-dialog #userphone').text(userphone);
		    	$('#edit-dialog #userbirthday').text(userbirthday);
		    	$('#edit-dialog #userphoto').html(userphoto);
	        }else{
	        	 $('#edit-dialog #username').text("該用戶尚未填寫其會員資料");
	             $('#edit-dialog #useraddress').text("");
	             $('#edit-dialog #usergender').text("");
	             $('#edit-dialog #userphone').text("");
	             $('#edit-dialog #userbirthday').text("");
	             $('#edit-dialog #userphoto').html("");
	        }
	        dialog.dialog('open');

	    });









</script>




</body>

</html>