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
										<li class="menu"><a href="${pageContext.request.contextPath}/myPage/qnaList.do">문의내역 확인</a></li>
										<li class="menu"><a href="${pageContext.request.contextPath}/myPage/reviewList.do">리뷰 관리</a></li>
									</ul>
								</li>
							</ul>
						</div>
	
					</div>
	
					<div id="orderListArea">
	
	
						<div id="orderList">
							<div id="orderList-header">
								<h3 id="orderListTitle">
									주문목록
								</h3>
							</div>
	
							<c:forEach var="orderDetailList" items="${orderDetailList}" varStatus="status">
								<div class="ordersArea">
									<div class="orderAreaHead">
										<c:if test="${not empty orderList[status.index].orderDate}">
										<p class="orderDate">${orderList[status.index].orderDate}</p> <!-- order.getOrderDate -->
										<span>주문번호 : <span class="orderNo">${orderList[status.index].orderNo}</span></span> <!-- order.getOrderNo -->
										<input type="hidden" name="detailNo" id="detailNo" value="${orderDetailList.detailNo}" /> <!-- orderDetail.getDetailNo -->
										</c:if>
									</div>
									
									<table class="orderTable">
										<tr>
											<td rowspan="4" class="productImg"><img src="${pageContext.request.contextPath}/resources/productUpload/${productImgList[status.index]}" alt="상품이미지" width=100 height=100></td>
											<td style="width : 450px; font-weight: bold;">
												${prodList[status.index].productBrand}
												<input type="hidden" name="productNo" value="${orderDetailList.productNo}" /> <!-- orderDetail.getProductNo -->
											</td>
											<td rowspan="4" align="center" style="border-left: 1px solid lightgray;">
												<p>${sellerList[status.index].sellerId}</p> <!-- seller.getSellerId -->
												<p>${sellerList[status.index].sellerPhone}</p> <!-- seller.getSellerPhone -->
												<button type="button" class="qnaBtn">문의하기</button>
											</td>
											<td rowspan="4" align="center" class="btnArea2">
												
												<c:if test="${orderDetailList.claimNo == 0}">
												<button type="button" onclick="goClaim(${orderDetailList.detailNo});">취소, 교환, 반품 신청</button>													
												</c:if>
												<c:if test="${orderDetailList.claimNo != 0 && orderDetailList.claimCode == 0}">
													<p>교환 처리 중</p>
												</c:if>
												<c:if test="${orderDetailList.claimNo != 0 && orderDetailList.claimCode == 1}">
													<p>환불 처리 중</p>
												</c:if>
												<c:if test="${orderDetailList.claimNo != 0 && orderDetailList.claimCode == 2}">
													<p>취소 처리 중</p>
												</c:if>
												<c:if test="${orderDetailList.claimNo != 0 && orderDetailList.claimCode == 3}">
													<p>교환 완료</p>
												</c:if>
												<c:if test="${orderDetailList.claimNo != 0 && orderDetailList.claimCode == 4}">
													<p>환불 완료</p>
												</c:if>
												<c:if test="${orderDetailList.claimNo != 0 && orderDetailList.claimCode == 5}">
													<p>취소 완료</p>
												</c:if>
												
												<form action="http://info.sweettracker.co.kr/tracking/5" method="post" target="_blank">
		                                         
		                                            <input type="hidden" class="form-control" id="t_key" name="t_key" placeholder="제공받은 APIKEY" value="3SlDxD7VoJflx2sI2jOO1Q">
		                                      
		                                          
		                                            <input type="hidden" class="form-control" name="t_code" id="t_code" placeholder="택배사 코드" value="${deliveryList[status.index].deliveryCode2}">
		                                      
		                                          
		                                            <input type="hidden" class="form-control" name="t_invoice" id="t_invoice" placeholder="운송장 번호" value="${deliveryList[status.index].deliveryNo}">
		                                         
		                                       <button type="submit">배송 조회</button>
		                                      </form>
												<!-- processCode가 4 인 orderDetail일 경우 -->
												<c:if test="${ orderDetailList.processCode == 1 }">
													<button type="button" onclick="complete(${orderDetailList.detailNo});">구매 확정</button>
												</c:if>
												<!-- processCode가 5 인 orderDetail일 경우 -->
												<c:if test="${ orderDetailList.processCode == 5 }">
													<button type="button" onclick="goReviewForm(${orderDetailList.detailNo});">리뷰 작성</button>
												</c:if>
											</td>
										</tr>
										<tr>
											<td>${prodList[status.index].productName}</td>
										</tr>
										<tr>
											<td>옵션 : ${ orderDetailList.detailSize }</td>
										</tr>
										<tr>
											<td>${ orderDetailList.detailPrice }원 ${ orderDetailList.detailAmount }개</td>
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
		
		function goClaim(detailNo){
			location.href="${pageContext.request.contextPath}/claim/claim.do?detailNo=" + detailNo + "";
		}
		
		function complete(detailNo){
			if(confirm("구매 확정 하시겠습니까?") == true){
				location.href="${pageContext.request.contextPath}/myPage/complete.do?detailNo=" + detailNo + "";	
			}
		}
		
	</script>	
</html>