<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="contextRoot" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<link href="${contextRoot}/css/bootstrap.min.css" rel="stylesheet" />
	</head>
	<body>
		
		
		<nav class="navbar navbar-expand-lg bg-light">
			<div class="container-fluid">
		    	<a class="navbar-brand" href="${contextRoot}/">尼瑪的SLOGAN</a>
		    	<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
		      		<span class="navbar-toggler-icon"></span>
		    	</button>
				<div class="collapse navbar-collapse" id="navbarNav">
					<ul class="navbar-nav">
				        <li class="nav-item">
							<a class="nav-link active" aria-current="page" href="${contextRoot}/">首頁</a>
				        </li>
				        <li class="nav-item">
							<a class="nav-link" href="${contextRoot}/XXX">XXXXX</a>
				        </li>
				        <li class="nav-item">
							<a class="nav-link" href="${contextRoot}/YYY">YYYYY</a>
				        </li>
				        <li class="nav-item">
							<a class="nav-link disabled">Disabled</a>
				        </li>
					</ul>
				</div>
			</div>
		</nav>
		
		
		
		
		
		<script src="${contextRoot}/js/bootstrap.bundle.min.js"></script>
		<script src="${contextRoot}/js/jquery-3.6.3.min.js"></script>
	</body>
</html>