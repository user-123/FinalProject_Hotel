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
<title>會員基本資料</title>
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


</head>
<body>
<c:choose>
   <c:when test="${requestScope.noinfo==true}"> 
   	您尚未填寫基本資料
   </c:when>
   <c:otherwise>
	    姓名: ${mb.userName}
	    手機: ${mb.phone}
	    性別: ${mb.gender}
	    地址: ${mb.address}
	    生日: ${mb.birthDate}
	    照片: ${sessionScope.photo}
	    ${requestScope.message}
	</c:otherwise>    
</c:choose>	    
	    <form action="<c:url value='/logout' />" method="post">
		  <button type="submit">登出</button>
		  <input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
		</form>
</body>
</html>
