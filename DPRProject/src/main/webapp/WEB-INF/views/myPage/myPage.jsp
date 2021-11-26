<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 : DAPARA</title>
	
	<!-- css -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/myPage.css"/>

</head>
<body>
	<c:import url="../common/header.jsp"/>
	
	<!-- myPage 주문목록 / 배송조회 -->
		<div id=myPage>

			<div class="container">
				
				<div id="section-header">
					<h2 id="mypageTitle">
						MY페이지
					</h2>
				</div>

				<div id="myPageBody">

					<div id="sideMenu">
	
						<div id="infoDiv">
							<div>${member.userId} 님</div>
							<button type="button" id="myInfoBtn" onclick="goMyInfo();">회원정보 수정</button>
						</div>
	
						<div id="sideMenuList">
							<ul>
								<li class="listTitle">
									MY 쇼핑
									<ul>
										<li class="menu">
											<a href="${pageContext.request.contextPath}/myPage/myPage.do">주문목록 / 배송조회</a>
										</li>
									</ul>
								</li>
							</ul>
							<ul>
								<li class="listTitle">
									MY 활동
									<ul>
										<li class="menu"><a href="">문의내역 확인</a></li>
										<li class="menu"><a href="">리뷰 관리</a></li>
									</ul>
								</li>
							</ul>
						</div>
	
					</div>
	
					<div id="orderListArea">
	
						<div id="deliCountSection">
							<div id="deliCount">
								<table id="deliCountTable">
									<tr>
										<td>배송중</td>
										<td>취소/교환/반품</td>
									</tr>
	
									<tr>
										<td class="iconTr">
											<i class="fas fa-truck"></i>
											<span>1</span> <!-- userId가 user01인 회원의 배송중 상태 개수 -->
										</td>
										<td class="iconTr">
											<i class="fas fa-undo-alt"></i>
											<span>0</span> <!-- userId가 user01인 회원의 취소 반품 교환 상태 개수 -->
										</td>
									</tr>
								</table>
							</div>
	
							<div id="searchDate">
								<div id="btnArea">
									<button type="button" class="dateBtn">1개월</button>
									<button type="button" class="dateBtn">3개월</button>
									<button type="button" class="dateBtn">6개월</button>
									<button type="button" class="dateBtn">1년</button>
								</div>
								<div id="calArea">
									<input type="date" name="" id=""> - 
									<input type="date" name="" id="">
									<button type="button" id="searchBtn">조회</button>
								</div>
							</div>
	
						</div>
	
						<div id="orderList">
							<div id="orderList-header">
								<h3 id="orderListTitle">
									주문목록
								</h3>
							</div>
	
							<c:forEach var="order" items="${orderList}" varStatus="status">
								<div class="ordersArea">
									<div class="orderAreaHead">
										<p class="orderDate">${order.orderDate}</p> <!-- order.getOrderDate -->
										<span>주문번호 : <span class="orderNo">${order.orderNo}</span></span> <!-- order.getOrderNo -->
										<input type="hidden" name="detailNo" id="detailNo" value="${orderDetailList[status.index].detailNo}" /> <!-- orderDetail.getDetailNo -->
									</div>
									<table class="orderTable">
										<tr>
											<td rowspan="4" class="productImg"><img src="${pageContext.request.contextPath}/resources/productUpload/${productImgList[status.index]}" alt="상품이미지" width=100 height=100></td>
											<td style="width : 450px; font-weight: bold;">
												${prodList[status.index].productBrand}
												<input type="hidden" name="productNo" value="${orderDetailList[status.index].productNo}" /> <!-- orderDetail.getProductNo -->
											</td>
											<td rowspan="4" align="center" style="border-left: 1px solid lightgray;">
												<p>${sellerList[status.index].sellerId}</p> <!-- seller.getSellerId -->
												<p>${sellerList[status.index].sellerPhone}</p> <!-- seller.getSellerPhone -->
												<button type="button" class="qnaBtn">문의하기</button>
											</td>
											<td rowspan="4" align="center" class="btnArea2">
												<button type="button">배송 조회</button>
												<button type="button" onclick="goClaim(${orderDetailList[status.index].productNo});">취소, 교환, 반품 신청</button>
												<!-- processCode가 4 인 orderDetail일 경우 -->
												<c:if test="${ orderDetailList[status.index].processCode == 1 }">
													<button type="button" onclick="complete(${orderDetailList[status.index].detailNo});">구매 확정</button>
												</c:if>
												<!-- processCode가 5 인 orderDetail일 경우 -->
												<c:if test="${ orderDetailList[status.index].processCode == 5 }">
													<button type="button" onclick="goReviewForm(${orderDetailList[status.index].detailNo});">리뷰 작성</button>
												</c:if>
											</td>
										</tr>
										<tr>
											<td>${prodList[status.index].productName}</td>
										</tr>
										<tr>
											<td>옵션 : ${ orderDetailList[status.index].detailSize }</td>
										</tr>
										<tr>
											<td>${ orderDetailList[status.index].detailPrice }원 ${ orderDetailList[status.index].detailAmount }개</td>
										</tr>
									</table>
								</div>
							</c:forEach>
						</div>
	
					</div>
				</div>
				

			</div>

		</div>
	
	
	<c:import url="../common/footer.jsp"/>
</body>
	<!-- script -->
	<script>

		function goMyInfo(){
			location.href="${pageContext.request.contextPath}/myPage/myInfo.do";
		}
		
		//ajax로 detailno랑 유저아이디로 이미 등록한 리뷰있는지 확인하기
		function goReviewForm(detailNo){
			
			var userId = "${member.userId}";
			
			
			location.href="${pageContext.request.contextPath}/review/reviewForm.do?detailNo=" + detailNo + "";
			
		}
		
		function goClaim(productNo){
			location.href="${pageContext.request.contextPath}/claim/claim.do?productNo=" + productNo + "";
		}
		
		function complete(detailNo){
			if(confirm("구매 확정 하시겠습니까?") == true){
				location.href="${pageContext.request.contextPath}/myPage/complete.do?detailNo=" + detailNo + "";	
			}
		}
		
	</script>	
</html>