<%-- <%@ page language="java" contentType="text/html; charset=UTF-8" --%>
<%-- 	pageEncoding="UTF-8" isELIgnored="false"%> --%>
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> --%>
<%-- <%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%> --%>
<%-- <%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form"  %> --%>
<%-- <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%> --%>
<%-- <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%> --%>
<%-- <c:set var="contextRoot" value="${pageContext.request.contextPath}" /> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" /> -->
<%-- <script src="<c:url value='/javascript/jquery-3.6.0.min.js'/>" ></script> --%>
<%-- <script src="<c:url value='/javascript/jquery-ui.min.js'/>" ></script>  --%>
<!-- <script> -->
//         $(function () {
//             $("#tabs").tabs();
//         });
<!-- </script> -->

<!-- <meta charset="BIG5"> -->
<!-- <title>Insert title here</title> -->
<!-- </head> -->
<!-- <body> -->


<!-- <div class="container w-75 mt-5"> -->
<!-- 	<div class="input-group"> -->
<!-- 		<input type="text" class="rounded" placeholder="搜索關鍵字" -->
<!-- 			aria-label="Search" aria-describedby="search-addon" id="searchbtn" -->
<!-- 			name="searchbtn" /> -->
<!-- 		<button type="button" class="btn btn-outline-primary" -->
<!-- 			id="searchsubmit">搜尋</button>   -->
<!-- 	</div> -->
<%-- 	<sec:authorize access="hasAuthority('admin')"> --%>
<!-- 	<div> -->
<%-- 		<a href="<c:url value='/admin/additem'/>"><button>新增產品</button></a>   --%>
<!-- 	</div> -->
<!-- 	<div> -->
<%-- 		<a href="<c:url value='/admin/edititem'/>"><button>編輯刪除產品</button></a>   --%>
<!-- 	</div> -->
<%-- 	</sec:authorize> --%>
<!--   <div id="tabs" style="height: 600px"> -->
<!-- <!--   點擊選項卡的上層清單 --> -->
<!-- <ul class="d-flex justify-content-center nav nav-tabs"> -->
<%--   <c:forEach items="${categoryList}" var="category" varStatus="status"> --%>
<!--     <li class="nav-item"> -->
<!--       <a class="nav-link" href="#${status.index}"> -->
<%--         <button class="btn btn-link">${category.categoryName}</button> --%>
<!--       </a> -->
<!--     </li> -->
<%--   </c:forEach> --%>
<!-- </ul> -->
<!-- <!--   點擊選項卡的上層清單結束 --> -->
<%-- <c:forEach items="${categoryList}" var="category" varStatus="status"> --%>
<!-- <!-- 以下為SHOW出不同選項卡的頁面 --> -->
<%--   <div id="${status.index}"> --%>
<%--     	<section class="container"> --%>
<!--         <div class="row"> -->
<%-- 		<c:forEach items="${category.products}" var="product" varStatus="status"> --%>
<!-- <!-- 			SHOW每一個商品的樣式 --> -->
<!-- 		    <div class="col-sm-6 col-md-3"> -->
<!--                 <div class="thumbnail" style="width: 150px; height: 350px"> -->
<!-- 		        <div class="caption"> -->
<!-- 				<div style="width:150px;"> -->
<%-- 		                    <img width='130' height='150' src="${contextRoot}/uploadProduct/${product.photo}" /> --%>
<!-- 		                </div> -->
<!-- 		          <p> -->
<%-- 		            <b style='font-size: 16px;'>${product.productName}</b> --%>
<!-- 		          </p> -->
<%-- 		          <p>${product.status}</p> --%>
<%-- 		          <p>${product.price}</p> --%>
<!-- 		        </div> -->
<!-- 		      </div> -->
<!-- 		    </div> -->
<!-- <!-- 			每四個換行 --> -->
<%-- 		    <c:if test="${status.index != 0 && (status.index + 1) % 4 == 0}"> --%>
<!-- 		      <div class="row"></div> -->
<%-- 		    </c:if> --%>
<!-- <!-- 		    每四個換行結束 --> -->
<!-- <!-- 		    SHOW每一個商品的樣式結束 --> -->
<%-- 		</c:forEach> --%>
<!-- 		</div> -->
<%--     </section> --%>
<!-- <!--   SHOW每一個選項卡的頁數 --> -->
<%-- <%-- <c:forEach var="pageNumber" begin="1" end="${page.totalPages}"> --%> --%>
<%-- <%-- <c:choose> --%> --%>
<%-- <%--  <c:when test="${page.number != pageNumber-1}"> --%> --%>
<%-- <%--    <a href="${contextRoot}/public/shop?category=${category.categoryId}&p=${pageNumber}">${pageNumber}</a> --%> --%>
<%-- <%--  </c:when> --%> --%>
<%-- <%--  <c:otherwise> --%> --%>
<%-- <%--    ${pageNumber} --%> --%>
<%-- <%--  </c:otherwise> --%> --%>
<%-- <%-- </c:choose> --%> --%>
<%-- <%-- </c:forEach> --%> --%>
<!-- <!--   SHOW每一個選項卡的頁數結束 --> -->
<!--   </div> -->
  
<!-- <!-- 不同選項卡頁面顯示結束 --> -->
<%-- </c:forEach> --%>
<!-- </div> -->
<!-- </div> -->



<!-- </body> -->
<!-- </html> -->