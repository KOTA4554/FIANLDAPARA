<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의류 : DAPARA</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/jeongho.css"/>
	
	
</head>
<body>
<header>
		<c:import url="../common/header.jsp"/>

</header>
<section>

		

	<div class="container">
	
    <!--div{$번째 영역}*3-->
    <div class="title">
    <h3>의류</h3>    
    </div>
    
    <div class="firstPar">
    <c:forEach var="row" begin="0" end="3" items="${list}" varStatus="status">
   
    
        <div class ="first">
            <div class = "productimg">
            <img  src="${pageContext.request.contextPath}/resources/productUpload/${ image[status.index] }" alt="logo" class = "" width=230 height=240>
            </div>
            <input type="hidden" name="productNo" value="${row.productNo }">
            
            <div class="productinfo"></div>
                <div class="productcategory">
                <p name="productBrand" id="productBrand" value="${row.productBrand }">'${row.productBrand}' </p>
            </div>
            <div class="productname">
               <a href="<%=request.getContextPath()%>/prod_detail.do?prodNo=${row.productNo}">
                <p  name="productName" id="productName" value="${row.productName}" required>'${row.productName}'</p>
                </a>						
            </div>
            <div class="productprice">
               <p  name="productPrice" id="product-price" value="" ><fmt:formatNumber value="${row.productPrice}" pattern="#,###"/> </p>
            </div>

            <br>
            <br>
        </div>
        
         </c:forEach>
        
        </div>
    </div>
   <div class="container">
	
    <!--div{$번째 영역}*3-->
    
    
    <div class="firstPar">
    <c:forEach var="row" begin="4" end="7" items="${list}" varStatus="status">
   
    
        <div class ="first">
            <div class = "productimg">
            <img  src="${pageContext.request.contextPath}/resources/productUpload/${ image[status.index] }" alt="logo" class = "" width=230 height=240>
            </div>
             <input type="hidden" name="productNo" value="${row.productNo }">
            <div class="productinfo"></div>
                <div class="productcategory">
               <p name="productBrand" id="productBrand" value="${row.productBrand }">'${row.productBrand}' </p>
            </div>
            <div class="productname">
                <a href="<%=request.getContextPath()%>/prod_detail.do?prodNo=${row.productNo}">
                <p  name="productName" id="productName" value="${row.productName}" required>'${row.productName}'</p>
                </a>						
            </div>
            <div class="productprice">
               <p  name="productPrice" id="product-price" value="" ><fmt:formatNumber value="${row.productPrice}" pattern="#,###"/> </p>
            </div>

            <br>
            <br>
        </div>
        
         </c:forEach>
        
        </div>
    </div>
    
    <div class="container">
	
    <!--div{$번째 영역}*3-->
    
    
    <div class="firstPar">
    <c:forEach var="row" begin="8" end="11" items="${list}" varStatus="status">
   
    
        <div class ="first">
            <div class = "productimg">
            <img  src="${pageContext.request.contextPath}/resources/productUpload/${ image[status.index] }" alt="logo" class = "" width=230 height=240>
            </div>
             <input type="hidden" name="productNo" value="${row.productNo }">
            <div class="productinfo"></div>
                <div class="productcategory">
                <p name="productBrand" id="productBrand" value="${row.productBrand }">'${row.productBrand}' </p>
            </div>
            <div class="productname">
              <a href="<%=request.getContextPath()%>/prod_detail.do?prodNo=${row.productNo}">
                <p  name="productName" id="productName" value="${row.productName}" required>'${row.productName}'</p>
                </a>							
            </div>
            <div class="productprice">
               <p  name="productPrice" id="product-price" value="" ><fmt:formatNumber value="${row.productPrice}" pattern="#,###"/> </p>
            </div>

            <br>
            <br>
        </div>
        
         </c:forEach>
        </div>
    </div>
        	<div class="container">
      	  <c:out value="${pageBar}" escapeXml="false"/>
        </div>
		<!-- /SECTION -->
		</section>
		<!-- jQuery Plugins -->
		<script src="${pageContext.request.contextPath }/resources/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/slick.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/nouislider.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/jquery.zoom.min.js"></script>
		<script src="${pageContext.request.contextPath }/resources/js/main.js"></script>
		
<footer>		
		<c:import url="../common/footer.jsp"/>
</footer>
		

</body>
</html>