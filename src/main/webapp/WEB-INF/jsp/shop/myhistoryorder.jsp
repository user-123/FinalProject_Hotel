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
<c:forEach items="${orderDateList}" var="orderdate" varStatus="status" >
<div>${orderdate}</div>
<div class="container">
	<table class="table table-bordered table-striped table-hover" >
    <thead>
      <tr>
        <th class="col-2">商品名</th>
        <th class="col-2">商品圖片</th>
        <th class="col-2">價格</th>
        <th class="col-2">購買數量</th>
      </tr>
    </thead>
		<c:forEach items="${productList[status.index]}" var="product" varStatus="status1" >
		 <tr>
		  <td class="col-2">
			<div>${product.productName}</div>
		  </td>
		  
		  
		  <td class="col-2">
		  <c:choose>
		  	<c:when test="${product.photo eq ''}">
		  		<img src="${contextRoot}/images/nopicture.jfif" width="80" class='m-1 border rounded' />
		  	</c:when>
		  	<c:otherwise>
				<img src="${contextRoot}/uploadProduct/${product.photo}" width="80" class='m-1 border rounded' />
		  	</c:otherwise>
		  </c:choose>
		  </td>
		  
		  
		  
		  
		  <td class="col-2">
			<div>${product.price}</div>
		  </td>
		  <td class="col-2">
			<div>${quantList[status.index][status1.index]}</div>
		  </td>
		  </tr>
		</c:forEach>
	</table>
</div>
</c:forEach>
</body>
</html>