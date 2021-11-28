<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MY리뷰 : DAPARA</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/myPage.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reviewForm.css"/>

<style>
#reviewListTable {
	width : 100%;
	border-collapse : collapse;
}

#reviewListTable td{
	border-top : 1px solid lightgray;
	height : 50px;
}

.reviewListRows:hover{
	background-color : lightgray;
	cursor : pointer
}

</style>

</head>
<body>

	<c:import url="../common/header.jsp"/>
	
	<!-- myPage 리뷰작성 -->
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
							<button type="button" id="myInfoBtn">회원정보 수정</button>
						</div>
	
						<div id="sideMenuList">
							<ul>
								<li class="listTitle">
									MY 쇼핑
									<ul>
										<a href="${pageContext.request.contextPath}/myPage/myPage.do">주문목록 / 배송조회</a>
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
	
					<div id="reviewArea">
						
						<div id="reviewTitle">
							<h3>내가 작성한 리뷰</h3>
						</div>

						<div class="tableArea">
                			<table id="reviewListTable" border="0">
							    <tr id="reviewListTitle">
							       <th style="width: 60px;">리뷰번호</th>
							        <th style="width: 60px;">상품번호</th>
							        <th style="width: 100px;">주문상세번호</th>
							        <th style="width: 100px;">브랜드</th>
							        <th style="width: 200px;">상품명</th>
							        <th style="width: 60px;">평점</th>
							        <th style="width: 85px;">리뷰 날짜</th>
						
							    </tr>
							    <c:forEach items="${reviewList}" var="review" varStatus="status">
								    <tr class="reviewListRows" id="${review.reviewNo}" onclick="reviewDetail(${review.reviewNo});">
								    	<td class="reviewRowRno">${review.reviewNo}</td>
										<td class="reviewRowPno">${rpList[status.index].productNo}</td>
										<td class="reviewRowDno">${review.detailNo}</td>
										<td class="reviewRowBrand">${rpList[status.index].productBrand}</td>
										<td class="reviewRowName">${rpList[status.index].productName}</td>
										<td class="reviewRowScore">${review.reviewScore}</td>
										<td class="reviewRowDate">${review.reviewDate}</td>
							
									</tr>
								</c:forEach>
							</table>
           				</div>

					</div>
				</div>
				

			</div>

		</div>
	
	
	<c:import url="../common/footer.jsp"/>
</body>

<script>
	
	function reviewDetail(reviewNo){
		location.href="${pageContext.request.contextPath}/review/reviewDetail.do?reviewNo=" + reviewNo;
	}
</script>
</html>