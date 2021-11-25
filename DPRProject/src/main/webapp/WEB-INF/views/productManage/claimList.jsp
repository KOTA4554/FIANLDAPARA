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
#searchProdState {
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
.prodRowBrand {   width: 85px; text-align: center; }
.prodRowName { width: 350px; text-align: center;}
.prodRowPrice { width: 100px; text-align: center; }
.prodRowStart, .prodRowEnd { width: 100px; text-align:center; }
.prodRowOptionCnt { width: 70px; text-align:center; }
.prodRowCateNm {}

</style>

</head>
<body>
<c:import url="../common/header.jsp"/>   
   
<div class="mainSectionForm">
   <form action="${pageContext.request.contextPath}/seller/searchClaimList.do"method="post">

   <table border="0">
      <tr>
         <th colspan="4" class="sectionTitles">검색 조건 설정</th>
      </tr>
       <tr>
           <th>상품명</th>
           <td><input type="text" name="productName" id="searchProdName"></td>
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
           <th>판매상태</th>
           <td>
               <select name="claimCode" id="searchProdState">
                  <option value="6"></option>
                  <option value="0">교환</option>
                   <option value="1">환불</option>
                   <option value="2">취소</option>
                   <option value="3">교환완료</option> 
                   <option value="4">환불완료</option>
                  <option value="5">취소완료</option>
               </select>
           </td>
       </tr>
       <tr>
           <th>상품번호</th>
           <td>
              <input type="text" name="productNo" id="searchProdNo" size="30"/>
           </td>
       </tr>
   </table>
   <div class="searchBtnSection">
      <button type="submit" id="searchBtn">검색</button>
   </div>
   
   </form>
   <table id="prodListTable" border="0">
      <tr>
         <th colspan="9" class="sectionTitles">상품 리스트
         <div class="explainTitles">현재 조회 상품 수 : 총 ${totalProduct}개</div></th>
      </tr>
       <tr id="prodListTitle">
           <td>상품번호</td>
           <td>주문번호</td>
           <td>브랜드</td>
           <td>상품명</td>
           <td>클레임 내용</td>
           <td>클레임 상태</td>
           <td>클레임 날짜</td>
           <td>클레임 완료일</td>

       </tr>
      <c:forEach items="${claimList}" var="claim" varStatus="status">
               <tr class="prodListRows" id="${claim.claimNo}">
             <td class="prodRowPno">${cpList[status.index].productNo}</td>
            <td class="prodRowBrand">${claim.detailNo}</td>
            <td class="prodRowPrice">${cpList[status.index].productBrand}</td>
            <td class="prodRowStart">${cpList[status.index].productName}</td>
            <td class="prodRowName">${claim.claimContent}</td>
            <c:if test="${0 eq claim.claimCode}">
            <td class="prodRowEnd">교환</td>
            </c:if>
            <c:if test="${1 eq claim.claimCode}">
            <td class="prodRowEnd">환불</td>
            </c:if>
            <c:if test="${2 eq claim.claimCode}">
            <td class="prodRowEnd">취소</td>
            </c:if>
            <c:if test="${3 eq claim.claimCode}">
            <td class="prodRowEnd">교환 완료</td>
            </c:if>
            <c:if test="${4 eq claim.claimCode}">
            <td class="prodRowEnd">환불 완료</td>
            </c:if>
            <c:if test="${5 eq claim.claimCode}">
            <td class="prodRowEnd">취소 완료</td>
            </c:if>
            <td class="prodRowEnd">${claim.claimDate}</td>
            <c:if test="${!empty claim.completeClaim}">
            <td class="prodRowEnd">${claim.completeClaim}</td>
            </c:if>
            <c:if test="${empty claim.completeClaim}">
            <td class="prodRowEnd" onclick="a1(${claim.claimNo});">처리대기 중</td>
            </c:if>
         </tr>
      </c:forEach>
   </table>
   <div class="pageBarSection">
      <c:out value="${pageBar}" escapeXml="false"/>
   </div>
</div>

<script>
   function searchProduct(){
      location.href="${pageContext.request.contextPath}/seller/searchReviewProd.do";
   }
   
   function a1(claimNo){
      location.href="${pageContext.request.contextPath}/claim/claimcomplete.do?claimNo="+claimNo+"";
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
           ,minDate: "today"
       });                    
   
       $('img.ui-datepicker-trigger').attr('style', 'padding: 7px;');
   });
</script>

<c:import url="../common/footer.jsp"/>
</body>
</html>