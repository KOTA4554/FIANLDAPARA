<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자 리뷰관리</title>

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
.mainSectionForm table {
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

#categorySelects {
	display: flex;
	justify-content: space-between;
}
.cateSelector {
	width: 130px;
}
#searchProdState {
	width: 100%;
}

#searchProdNo {
	width: 130px;
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
.reviewRowRno { width: 60px; text-align: center; }
.reviewRowPno {	width: 60px; text-align: center;  }
.reviewRowDno { width: 100px; text-align: center;  }
.reviewRowBrand { width: 100px; text-align: center; }
.reviewRowName { width: 200px; text-align: center; }
.reviewRowScore { width: 60px; text-align: center;}
.reviewRowId { width: 85px; text-align: center; }
.reviewRowDate { width: 85px; text-align: center; }

</style>

</head>
<body>
<c:import url="../common/header.jsp"/>	
	
<div class="mainSectionForm">
	<form action="${pageContext.request.contextPath}/seller/searchReviewProd.do" method="post">
		<table border="0">
			<tr>
				<th colspan="4" class="sectionTitles">검색 조건 설정</th>
			</tr>
		    <tr>
		        <th>상품명</th>
		        <td>
		        	<input type="text" name="productName" id="searchProdName">
		        </td>
		        <th>카테고리</th>
			        <td>
			        <div id="categorySelects">
		                    <select name="categoryNo" id="categoryNo" class="cateSelector">
		                        <option value="999">대분류</option>
		                        <option value="0">의류</option>
		                        <option value="1">슈즈</option>
		                        <option value="2">가방</option>
		                        <option value="3">액세서리</option>
		                        <option value="4">주얼리</option>
		                    </select>
		                    <select name="categoryNo2" id="categoryNo2" class="cateSelector">
		                    	<option value="999">소분류</option>
		                        <option value="1">탑</option>
		                        <option value="2">니트웨어</option>
		                        <option value="3">셔츠/자켓</option>
		                        <option value="4">셔츠</option>
		                        <option value="5">수트</option>
		                        <option value="6">팬츠</option>
		                        <option value="7">언더웨어</option>
		                        <option value="8">비치웨어</option>
		                        <option value="9">기능성의류</option>
		                    </select>
		                </div>
			        </td>
		    </tr>
		    <tr>
		        <th>브랜드</th>
		        <td><input type="text" name="productBrand" id="searchProdBrand"></td>
		        <th>상품번호</th>
		        <td>
		        	<input type="text" name="productNo" id="searchProdNo"/>
		        </td>
		    </tr>

		</table>
		
		<div class="searchBtnSection">
			<button type="submit" id="searchBtn">검색</button>
		</div>
	
	</form>
	
	<table id="prodListTable" border="0">
		<tr>
			<th colspan="9" class="sectionTitles">리뷰 리스트
			<div class="explainTitles">현재 조회 리뷰 수 : 총 ${totalProduct}개</div></th>
		</tr>
	    <tr id="prodListTitle">
	       <td style="width: 60px;">리뷰번호</td>
	        <td style="width: 60px;">상품번호</td>
	        <td style="width: 100px;">주문상세번호</td>
	        <td style="width: 100px;">브랜드</td>
	        <td style="width: 200px;">상품명</td>
	        <td style="width: 60px;">평점</td>
	        <td style="width: 85px;">USERID</td>
	        <td style="width: 85px;">리뷰 날짜</td>

	    </tr>
	    <c:forEach items="${reviewList}" var="review" varStatus="status">
		    <tr class="prodListRows" id="${review.reviewNo}">
		    	<td class="reviewRowRno">${review.reviewNo}</td>
				<td class="reviewRowPno">${rpList[status.index].productNo}</td>
				<td class="reviewRowDno">${review.detailNo}</td>
				<td class="reviewRowBrand">${rpList[status.index].productBrand}</td>
				<td class="reviewRowName">${rpList[status.index].productName}</td>
				<td class="reviewRowScore">${review.reviewScore}</td>
				<td class="reviewRowId">${review.userId}</td>
				<td class="reviewRowDate">${review.reviewDate}</td>
	
			</tr>
		</c:forEach>
	</table>
	<div class="pageBarSection">
		<c:out value="${pageBar}" escapeXml="false"/>
	</div>
</div>

<script>


</script>

<c:import url="../common/footer.jsp"/>
</body>

</html>