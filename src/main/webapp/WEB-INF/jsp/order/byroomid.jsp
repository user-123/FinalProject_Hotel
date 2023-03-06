<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>XX飯店</title>
</head>
<body>

<div class="container">
<h1>Add House Page</h1>

<form id="house-form">
  <div>
   <label for="house-name">House Name</label>
   <input type="text" id="house-name" name="name">
  </div>
  <div>
    <label for="house-photos">House Photos</label>
    <input type="file" id="house-photos" name="files" multiple>
  </div>
  <button type="submit">Submit</button>
</form>

<div id="upload_result"></div>


</div>

<script>
    document.getElementById('house-form').addEventListener('submit', function(e){
        e.preventDefault();

        let houseName = document.getElementById('house-name').value;
        let housePhotos = document.getElementById('house-photos').files;
		//這裡FormData是javascript物件所以要大寫
        let formdata = new FormData();
        formdata.append('name',houseName);

        for(let i =0; i < housePhotos.length;i++){
            formdata.append('files',housePhotos[i])
        }

        axios.post('${contextRoot}/house/post',formdata,{
            headers:{
                'Content-Type':'multipart/form-data'
            }
        })
        .then( res =>{
            console.log(res)
            let resultBlock = document.getElementById('upload_result');
            resultBlock.innerHTML = res.data
        })
        .catch(err=>{
            console.log(res)
            let resultBlock = document.getElementById('upload_result');
            resultBlock.innerHTML = '上傳失敗'
        })

    })
</script>
</body>
</html>