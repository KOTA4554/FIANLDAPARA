<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.mainSectionForm {
    width: 1100px;
    margin-left: auto;
    margin-right: auto;
    margin-top: 30px;
    margin-bottom: 30px;
}
.pageBarSection {
	display:flex;
    justify-content: center;
}
.mainSectionForm > table {
 	width: 100%;
}
.sectionTitles {
	padding: 10px 20px;
	border-bottom: 1px solid lightgray;
    background: linear-gradient( 45deg, #D10024 60%, rgb(255, 99, 99) );
    color: white;
    font-size: 18px;
}
tr>th:not(.sectionTitles, .optionTh){
	text-align: center;
	padding: 15px 20px;
}
table input[type="text"], select, input[type="number"] {
	height: 30px;
	border-radius: 0px;
	border: 1px solid #E4E7ED;
	padding: 0px 5px;	
}
#searchProdName {
	width: 500px;
}
#searchProdBrand {
	width: 500px;
}
.searchBtnSection {
	border-top: 1px solid lightgray;
	margin: 20px 0px;
}
#searchBtn {
	float: right;
	margin: 20px 0px;
	padding: 8px 18px;
	border-radius: 0px;
	border: 1px solid lightgray;
}
.datepicker {
	text-align: center;
}
#categorySelects {
	display: flex;
	justify-content: space-between;
}
.cateSelector {
	width: 130px;
}
#searchProdState, #searchProdNo {
	width: 100%;
}
#prodListTable td {
	padding: 10px 10px;
}
#prodListTable {
	font-size: 12px;
}
#prodListTitle {
	font-size: 13px;
	text-align: center;
	font-weight: bold;
}
#prodListTitle > td {
	padding: 10px;
}
.explainTitles {
	font-size: 13px;
	font-weight: 500;
}
li {
    display: flex;
    justify-content: space-between;
    padding: 5px 0px;
}
.prodListRows {
	border-bottom: 1px dotted lightgray;
	margin-bottom: 5px;
}
.prodRowPno {
	text-align:center;
	width: 85px;
}
.prodRowImg { width: 90px; }
.prodRowBrand {	width: 160px; }
.prodRowName { width: 275px; }
.prodRowPrice { width: 100px; text-align: center; }
.prodRowStart, .prodRowEnd { width: 100px; text-align:center; }
.prodRowOptionCnt { width: 70px; text-align:center; }
.prodRowCateNm {}

</style>

</head>
<body>
<c:import url="../common/header.jsp"/>	
<form action="${pageContext.request.contextPath}/seller/searchProd.do" method="get">
<div class="mainSectionForm">
	<table border="0">
		<tr>
			<th colspan="4" class="sectionTitles">검색 조건 설정</th>
		</tr>
	    <tr>
	        <th>판매기간</th>
	        <td><input type="text" class="datepicker" name="startDate" id="startDate" placeholder="판매 시작일">
	        	<span style="display: inline-block; margin: 0px 25px;"> ~ </span> 
	        	<input type="text" class="datepicker" name="endDate" id="endDate" placeholder="판매 종료일"></td>
	        <th>배송상태</th>
	        <td>
	            <select name="saleState" id="searchProdState">
	            	<option value="999">선택</option>
	                <option value="1">송장등록대기</option>
	                <option value="2">송장등록완료</option>
	                <option value="3">배송중</option>
	                <option value="3">배송완료</option>
	            </select>
	        </td>
	    </tr>
	    <tr>
	        <th>상품명</th>
	        <td><input type="text" name="searchNm" id="searchProdName"></td>
	        <th>상품번호</th>
	        <td>
	        	<input type="text" name="searchPno" id="searchProdNo" />
	        </td>
	    </tr>
	</table>
	<div class="searchBtnSection">
		<button id="searchBtn">검색</button>
	</div>
	</form>
	
	<form action="downloadExcel.do" method="post">	
	<table id="prodListTable" border="0">
		<tr>
			<th colspan="9" class="sectionTitles">상품 리스트
			<div class="explainTitles">현재 조회 주문 수 : 총 ${totalOrder}개</div></th>
		</tr>
	    <tr id="prodListTitle">
	        <td>주문번호</td>
	        <td>주문상세번호</td>
	        <td>택배사</td>
	        <td>운송장번호</td>
	        <td>상품번호</td>
	        <td>상품명</td>
	        <td>결제일</td>
	        <td>아이디</td>
	        <td>수령인</td>
	        <td>연락처</td>
	        <td>배송주소</td>
	        <td>배송요청사항</td>

	    </tr>
	    <c:forEach items="${list}" var="delivery" varStatus="status">
	    <c:set var="num" value="#{status.index}" />
	    <tr class="deliveryList" id="${delivery.productNo}">
			<td class="orderNo">${delivery.orderNo}
				<input type="hidden" name="deliveryList[${num}].orderNo" value="${delivery.orderNo}"/>
			</td>
			<td class="detailNo">${delivery.detailNo}
				<input type="hidden" name="deliveryList[${status.index}].detailNo" value="${delivery.detailNo}"/>
			</td>
			<td class="deliveryCode">${delivery.deliveryCode}
				<input type="hidden" name="deliveryList[${num}].deliveryCode" value="${delivery.deliveryCode}"/>
			</td>
			<td class="deliveryNo">${delivery.deliveryNo}
				<input type="hidden" name="deliveryList[${num}].deliveryNo" value="${delivery.deliveryNo}"/>
			</td>
	    	<td class="productNo" >${delivery.productNo}
	    		<input type="hidden" name="deliveryList[${num}].productNo" value="${delivery.productNo}"/>
	    	</td>
			<td class="productName">${delivery.productName}
				<input type="hidden" name="deliveryList[${num}].productName" value="${delivery.productName}"/>
			</td>
			<td class="payDate">
				<fmt:formatDate value="${delivery.payDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				<input type="hidden" name="deliveryList[${num}].payDate" value="${delivery.payDate}"/>
			</td>
			<td class="userId">${delivery.userId}
				<input type="hidden" name="deliveryList[${num}].userId" value="${delivery.userId}"/>
			</td>
			<td class="orderReceiver">${delivery.orderReceiver}
				<input type="hidden" name="deliveryList[${num}].orderReceiver" value="${delivery.orderReceiver}"/>
			</td>
			<td class="orderPhone">${delivery.orderPhone}
				<input type="hidden" name="deliveryList[${num}].orderPhone" value="${delivery.orderPhone}"/>
			</td>
			<td class="orderAddress">${delivery.orderAddress}
				<input type="hidden" name="deliveryList[${num}].orderAddress" value="${delivery.orderAddress}"/>
			</td>
			<td class="orderRequest">${delivery.orderRequest}
				<input type="hidden" name="deliveryList[${num}].orderRequest" value="${delivery.orderRequest}"/>
			</td>
		</tr>
		</c:forEach>
	</table>
		<input type="submit" value="엑셀로 다운로드" />
	</form>
	<form action="">
	<input type="file" name="" id="fileSelector" onchange="upload();"/>
	<button type="button" id="uploadBtn">엑셀 업로드</button>
	</form>
	<div class="pageBarSection">
		<c:out value="${pageBar}" escapeXml="false"/>
	</div>
</div>

<script>
	
	$('#uploadBtn').click(function(){
		$('#fileSelector').click();
		$('#fileSelector').hide();
		
	});
	
	function upload(){
		location.href="${pageContext.request.contextPath}/seller/uploadExcel.do";
	}
	
	
	/* function downloadExcel(){
		var list = [];
		$('.deliveryList').each(function(){
			var productNo = $(this).find('.productNo').text();
			var orderNo = $(this).find('.orderNo').text();
			var detailNo = $(this).find('.detailNo').text();
			var deliveryCode = $(this).find('.deliveryCode').text();
			var deliveryNo = $(this).find('.deliveryNo').text();
			var payDate = $(this).find('.payDate').val();
			var productName = $(this).find('.productName').text();
			var userId = $(this).find('.userId').text();
			var orderReceiver = $(this).find('.orderReceiver').text();
			var orderPhone = $(this).find('.orderPhone').text();
			var orderAddress = $(this).find('.orderAddress').text();
			var orderRequest = $(this).find('.orderRequest').text();
						
			var obj = { 
						productNo : productNo,
						orderNo : orderNo,
						detailNo : detailNo,
						deliveryCode : deliveryCode,
						payDate : payDate,
						productName : productName,
						userId : userId,
						orderReceiver : orderReceiver,
						orderPhone : orderPhone,
						orderAddress : orderAddress,
						orderRequest : orderRequest
					};
			
			list.push(obj);
		});
		
		$.ajax({
			url: "${pageContext.request.contextPath}/seller/downloadExcel.do",
			type: "post",
			data: JSON.stringify(list),
			contentType: "application/json; charset=UTF-8",
			success: function(data){
				console.log("전달 성공");
			},
			error: function(error){
				result = false;
				console.log("전달 실패");

			},
			async: false
		});
		
	} */

	//datepicker 사용
	$(function() {
	   //input을 datepicker로 선언
	    $('#startDate, #endDate').datepicker({
	        dateFormat: 'yy-mm-dd'
	        ,showOtherMonths: true
	        ,showMonthAfterYear:true
	        ,changeYear: true
	        ,changeMonth: true             
	        ,showOn: "both"
	        ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif"
	        ,buttonImageOnly: true
	        ,buttonText: "선택"             
	        ,yearSuffix: "년"
	        ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
	        ,dayNamesMin: ['일','월','화','수','목','금','토']
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
	    });                    
	
	    $('img.ui-datepicker-trigger').attr('style', 'padding: 7px;');
	});
</script>

<c:import url="../common/footer.jsp"/>
</body>
</html>