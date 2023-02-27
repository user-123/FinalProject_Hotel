<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %> --%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="<c:url value='/favicon.ico' />">
<meta charset="UTF-8">  
<title>首頁</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<hr />
憲憲
<hr />
<jsp:include page="linkout/navbar.jsp"></jsp:include>
<hr />
<br />
<br />
<br />



<hr />
硯硯
<hr />
<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
		
<a class="navbar-brand" href="<c:url value="/"/>">首頁</a>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page"
						href="<c:url value="/public/roombean/allShow"/>">展示房型</a></li>
					<li class="nav-item"><a class="nav-link"
						href="<c:url value="/roombean/backstage"/>">後台-房型</a></li>
				</ul>
			</div>		
		
		
		
		
		
<div class='center' >
<div class="dropdown">
  <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
    會員
  </a>
<c:choose>
   <c:when test="${requestScope.login==true}"> 
  		<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
		    <li><a class="dropdown-item" href="<c:url value='/addinfo' />">填寫及修改基本資料</a></li>
		    <li><a class="dropdown-item" href="<c:url value='/searchinfo' />">查詢資料</a></li>
	  	</ul>
  </c:when>
  <c:otherwise>
	   <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
		    <li><a class="dropdown-item" href="<c:url value='/public/loginpage' />">登入</a></li>
		    <li><a class="dropdown-item" href="<c:url value='/public/register' />">註冊</a></li>
		    <li><a class="dropdown-item" href="#">管理員</a></li>
	  </ul>
   </c:otherwise>
</c:choose>
</div>
</div>
</div>
</nav>

<hr />
<br />
<br />
<br />


</body>
</html>
