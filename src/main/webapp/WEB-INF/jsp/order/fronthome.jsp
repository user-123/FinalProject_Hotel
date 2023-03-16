<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>XX旅館</title>
</head>
<body>
<h1>前台首頁</h1>

<form action="<c:url value='/front/orders/add' />" method="get">
  <input type="hidden" name="Id" value="3" /> 
  <input type="hidden" name="userId" value="3" /> <input
   type="submit" class="btn btn-outline-info btn-sm" value="訂房">
 </form>

<form action="<c:url value='/front/orders/history' />" method="get">
  <input type="hidden" name="userId" value="3" /> <input
   type="submit" class="btn btn-outline-info btn-sm" value="歷史">
 </form>
</body>
</html>