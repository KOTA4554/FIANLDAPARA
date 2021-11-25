<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문완료 : DAPARA</title>
	
	<!-- css -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/orderComplete.css"/>

</head>
<body>
	<c:import url="../common/header.jsp"/>
	
	<!-- 주문 완료 페이지 -->
	<div id="orderComplete-section">
		
		<div class="container">

			<div id="section-header">
				<h3 id="orderTitle">
					주문완료
				</h3>
				<div id="pageNav">
					<i class="fas fa-shopping-cart"></i>
					<label>장바구니</label>
					<i class="fas fa-chevron-right"></i>
					<i class="fas fa-clipboard-list"></i>
					<label>주문서 작성</label>
					<i class="fas fa-chevron-right"></i>
					<i class="fas fa-check-circle"></i>
					<label>주문완료</label>
				</div>
			</div>

			<div id="section-body">

				<div id="completeMsg">
					<i class="far fa-check-circle"></i>
					<p>고객님의 주문이 정상적으로 완료되었습니다.</p>
				</div>

				<div id="moveBtn">
					<button type="button" id="goHome" onclick="goHome();">홈으로 이동</button> <br>
					<button type="button" id="goOrderDetail" onclick="goOrderDetail();">주문내역 상세보기</button>
				</div>

			</div>

		</div>
	</div>
	
	<c:import url="../common/footer.jsp"/>
</body>
	<!-- script -->
	<script>

		function goHome() {
			location.href="${pageContext.request.contextPath}/";
		}
		
		function goOrderDetail() {
			location.href="${pageContext.request.contextPath}/myPage/myPage.do";
		}

	</script>	
</html>