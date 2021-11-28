<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MY문의 : DAPARA</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/myPage.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reviewForm.css"/>

<style>

#qnaArea {
	width : 850px;
}
#qnaListTable {
	width : 100%;
	border-collapse : collapse;
}

#qnaListTable td{
	border-top : 1px solid lightgray;
	height : 50px;
}

.qnaListRows:hover{
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
	
					<div id="qnaArea">
						
						<div id="qnaTitle">
							<h3>내가 작성한 문의</h3>
						</div>

						<div class="tableArea">
                			<table id="qnaListTable" border="0">
							    <tr id="qnaListTitle">
							       <th style="width: 60px;">문의번호</th>
							        <th style="width: 60px;">상품번호</th>
							        <th style="width: 100px;">브랜드</th>
							        <th style="width: 150px;">상품명</th>
							        <th style="width: 150px;">문의글 제목</th>
							        <th style="width: 85px;">USERID</th>
							        <th style="width: 85px;">문의 날짜</th>
							        <th style="width: 85px;">답변여부</th>
						
							    </tr>
							    <c:forEach items="${qnaList}" var="qna" varStatus="status">
								  
								    <tr onclick="goQnA(${qna.getQNo()}, ${qpList[status.index].productNo});"; class="qnaListRows" id="${qna.getQNo()}">
								    	<td class="qnaRowQno">${qna.getQNo()}</td>
										<td class="qnaRowPno">${qpList[status.index].productNo}</td>
										<td class="qnaRowBrand">${qpList[status.index].productBrand}</td>
										<td class="qnaRowName">${qpList[status.index].productName}</td>
										<td class="qnaRowTitle">${qna.getQTitle()}</td>
										<td class="qnaRowId">${qna.userId}</td>
										<td class="qnaRowDate">${qna.qdate}</td>
										<td class="qnaRowDate">${qna.getQStatus()}</td>
							
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
	
	function goQnA(qNo, qProductNo){
		location.href="${pageContext.request.contextPath}//prod_detail.do?prodNo=" + qProductNo;
	}
</script>
</html>