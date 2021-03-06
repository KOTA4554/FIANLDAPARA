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
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >
	
	<!-- css -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/myPage.css"/>
</head>
<body>
	<c:import url="../common/header.jsp"/>
	<input type="hidden" name="userId" id="userId" value="${member.userId}" />
	
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
	
						<div id="orderList">
							<div id="orderList-header">
								<h3 id="orderListTitle">
									클레임 신청
								</h3>
							</div>
	
						
								<div class="ordersArea">			
								<form id="claimSubmit" action="" method="post">
									<div class="orderAreaHead">
										<p class="orderDate">${order.orderDate}</p> <!-- order.getOrderDate -->
										<span> <span class="orderNo">${order.orderNo}</span></span> <!-- order.getOrderNo -->
										<input type="hidden" name="detailNo" id="detailNo" value="${orderDetail.detailNo}" /> <!-- orderDetail.getDetailNo -->
									</div>
									<table class="<order></order>Table">
										<tr>
											<td rowspan="4" class="productImg"><img src="${pageContext.request.contextPath}/resources/productUpload/${prodImg}" alt="상품이미지" width=100 height=100></td>
											<td style="width : 450px; font-weight: bold;">
												${seller3.sellerCompany}
												<input type="hidden" name="productNo" value="${orderDetail.productNo}" /> <!-- orderDetail.getProductNo -->
											</td>
											<td rowspan="4" align="center" style="border-left: 1px solid lightgray;">
												<p>${seller3.sellerId}</p> <!-- seller.getSellerId -->
												<p>${seller3.sellerPhone}</p> <!-- seller.getSellerPhone -->
												
											</td>
											<td rowspan="4" align="center" class="btnArea2">
												<button type="button" onclick="change();">교환 신청</button>
												<button type="button" onclick="refund();">환불 신청</button>
												
												
												<button type="button" onclick="cancel();">취소 신청</button>
												
												
											</td>
										<div id="contentArea">
											<p class="text">클레임 이유를 적어주세요.</p>
											<textarea id="ClaimContent" name="claimContent" cols="90" rows="10" style="resize: none;"></textarea>
										</div>
										</tr>
										<tr>
											<td>${ prodName }</td>
										</tr>
										<tr>
											<td>옵션 : ${ orderDetail.detailSize }</td>
										</tr>
										<tr>
											<td>${ orderDetail.detailPrice }원 ${ orderDetail.detailAmount }개</td>
										</tr>
									</table>
									</form>
								</div>

						</div>
	
					</div>
				</div>
				

			</div>

		</div>
	
	
	<c:import url="../common/footer.jsp"/>
</body>
	<!-- script -->
	<script>

		function change(){
			
			
			$('#claimSubmit').attr("action","${pageContext.request.contextPath}/claim/change.do");
			$('#claimSubmit').submit();
		}
		
		
		function refund(){
			
			$('#claimSubmit').attr("action","${pageContext.request.contextPath}/claim/refund.do");
			$('#claimSubmit').submit();
			
		}
		
		function cancel(){
			$('#claimSubmit').attr("action","${pageContext.request.contextPath}/claim/cancel.do");
			$('#claimSubmit').submit();
		}
		
	</script>	
</html>