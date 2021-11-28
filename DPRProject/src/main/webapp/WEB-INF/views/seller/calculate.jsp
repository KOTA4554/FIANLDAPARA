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
    width: 850px;
    margin-left: auto;
    margin-right: auto;
    margin-top: 30px;
    margin-bottom: 30px;
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
.searchBtnSection {
	border-top: 1px solid lightgray;
	margin: 10px 0px;
}
#searchBtn {
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
#calListTable td {
	padding: 10px 10px;
}
#calListTable {
	margin: 50px 0px;
	margin-bottom: 100px;
	font-size: 12px;
}
#prodListTable {
	margin: 40px 0px;
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
.detailCalRows {
	text-align: center;
}
#totalCalculate {
	font-size: 20px;
}
#totalCalculateRow {
	padding: 30px 0px;
}
#lastCalculateRow, #totalCalculateRow, #prodListTitle {
	border-bottom : 1px dotted lightgray;
}
.montlyListRow {
	text-align: center;
	font-size: 12px;
	padding: 5px;
}
.montlyListRow.real {
	font-size: 13px;
	font-weight: 500;
}
.detailCalTh {
	width: 250px;
}
.detailCalRows.gross {
	width: 170px;
}
.detailCalRows.total {
	font-weight: 550;
}
.detailCalRows:not(.total) {
	color: gray;
}

</style>

</head>
<body>
<c:import url="../common/header.jsp"/>	
<form action="${pageContext.request.contextPath}/seller/inquireCal.do" method="get">
<div class="mainSectionForm">
	<table border="0">
		<tr>
			<th colspan="4" class="sectionTitles">검색 조건 설정</th>
		</tr>
	    <tr>
	        <th>조회기간</th>
	        <td><input type="text" class="datepicker" name="startDate" id="startDate" placeholder="조회 시작일" required readonly>
	        	<span style="display: inline-block; margin: 0px 25px;"> ~ </span> 
	        	<input type="text" class="datepicker" name="endDate" id="endDate" placeholder="조회 종료일" required readonly>
	        </td>
			<td>
				<button type="button" id="searchBtn" onclick="validate();">검색</button>
				<input type="submit" id="searchSubmitBtn" hidden/>
			</td>
	      
	</table>
	</form>
	<div class="searchBtnSection"></div>
	<table id="prodListTable" border="0">
		<tr>
			<th colspan="4" class="sectionTitles">조회 결과
		</tr>
	    <tr id="prodListTitle">
			<th style="padding: 8px 20px;">기준월</th>
			<th style="padding: 8px 20px;">판매대금</th>
			<th style="padding: 8px 20px;">공제금</th>
			<th style="padding: 8px 20px;">정산액</th>
	    </tr>
	    <c:forEach items="${monthly}" var="mon" varStatus="status">
		<c:set var="saleGross" value="${mon.totalMonthGross - mon.cancleMonthGross}" />
		<tr>
			<td class="montlyListRow">${mon.month}</td>
			<td class="montlyListRow gross"><fmt:formatNumber value="${saleGross}" pattern="#,###"/></td>
			<td class="montlyListRow gross"><fmt:formatNumber value="${-saleGross*0.1}" pattern="#,###"/></td>
			<td class="montlyListRow gross real"><fmt:formatNumber value="${saleGross - saleGross*0.1}" pattern="#,###"/></td>
		</tr>	    
	    </c:forEach>
	</table>

	<table id="calListTable" border="0">
		<tr>
			<th colspan="12" class="sectionTitles">기간 내 합계 내역
		</tr>
		<tr>
			<th id="totalCalculateRow" colspan="6">
				<span id="totalCalculate">
				전체 합계 (A+B+C) : <fmt:formatNumber value="${total.realGross-total.commission}" pattern="#,###"/>
				원
				</span>
			</th>
		</tr>
	    <tr id="prodListTitle">
			<th colspan="2" class="detailCalTh">A. 판매대금</th>
			<th colspan="2" class="detailCalTh">B. 공제/환급금</th>
			<th colspan="2" class="detailCalTh">C. 셀러 부담 쿠폰/할인</th>
	    </tr>
	    <tr>
	    	<td class="detailCalRows total">합계</td>
	    	<td class="detailCalRows gross total"><fmt:formatNumber value="${--total.realGross}" pattern="#,###"/></td>
	    	<td class="detailCalRows total">합계</td>
	    	<td class="detailCalRows gross total"><fmt:formatNumber value="${-total.commission}" pattern="#,###"/></td>
	    	<td class="detailCalRows total">합계</td>
	    	<td class="detailCalRows gross total"><fmt:formatNumber value="${-total.discount}" pattern="#,###"/></td>
	    </tr>
	    <tr>
	    	<td class="detailCalRows">전체 판매 금액</td>
	    	<td class="detailCalRows gross"><fmt:formatNumber value="${--total.totalGross}" pattern="#,###"/></td>
	    	<td class="detailCalRows">서비스 수수료</td>
	    	<td class="detailCalRows gross"><fmt:formatNumber value="${-total.commission}" pattern="#,###"/></td>
	    	<td class="detailCalRows">쿠폰할인</td>
	    	<td class="detailCalRows gross"><fmt:formatNumber value="${-total.discount}" pattern="#,###"/></td>
	    </tr>
	    <tr id="lastCalculateRow">
	    	<td class="detailCalRows">취소 환불 금액</td>
	    	<td class="detailCalRows gross"><fmt:formatNumber value="${-total.cancleGross}" pattern="#,###"/></td>

	    </tr>
	</table>

</div>

<script>
	function validate(){
	
		var startDate = $('#startDate').val(), endDate = $('#endDate').val();
		if(startDate > endDate || startDate == "" || endDate == ""){
			alert("조회기간을 확인해주세요.")
		} else {
			$('#searchSubmitBtn').trigger('click');
		}
	}		

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