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
.sectionTitles {
   padding: 10px 20px;
   border-bottom: 1px solid lightgray;
    background: linear-gradient( 45deg, #D10024 60%, rgb(255, 99, 99) );
    color: white;
    font-size: 18px;
}
tr>th:not(.sectionTitles, .optionTh){
   text-align: center;
   padding: 35px 10px;
}
.optionTh {
   text-align: center;
   padding: 5px;
}
select {
   padding: 3px;
   padding-left: 15px;
   width: 100px;
}
.defaultTime {
   height: 30px;
   width: 100px;
}
table input[type="text"], select, input[type="number"] {
   height: 30px;
   border-radius: 0px;
   border: 1px solid #E4E7ED;
   padding: 0px 5px;   
}
#productTitle, #productBrand {
   width: 470px;
}
#productPrice {
   width: 200px;
}
#productInfo{
   height: 150px;
}
.datePickerDiv {
    display: flex;
    justify-content: space-between;
}
.defaultTime, .datepicker {
   text-align: center;
}
.OptionBtns {
   float: right;
   margin: 5px 0px;
   margin-left: 5px;
   padding: 2px 6px;
   border-radius: 0px;
   border: 1px solid lightgray;
}
#optionTable {
   font-size: 12px;
   border: 1px solid lightgray;
}
#optionTable td {
   padding: 1px;
}
#optionTh1 { width: 45px; }
#optionTh2 { width: 60px; }
#optionTh3 { width: 300px; }
#optionTh4 { width: 100px; }
#optionTh5 { width: 200px; }
.optionCheckbox, .optionNo, .optionSize { text-align: center; }
.optionProductName, .optionBrand, .optionAmount { width: 100% }
.optionPrice, .optionAmount { text-align: right; }
.optionAmount { width: 115px; }

.productImgSection {
   display: flex;
   justify-content: space-between;
   width: 827px;
}
.productMainImg, .productAdditionalImg, .productContentImg {
   border: 1px solid lightgray;
   display: flex;
   align-items: center;
    justify-content: center;
    color: lightgray;
    margin: 5px 0px;
}
.productMainImg {
   height: 560px;
   width: 560px;
}
#additionalImgSection {
   display: flex;
   justify-content: space-between;
   flex-direction: column;
}
.productAdditionalImg {
   width: 250px;
   height: 180px;
}
#contentImgSection {
   display: flex;
   justify-content: space-between;
}
.contentImg {
   height: 300px;
   width: 400px;
}
.imageSectionTitles {
   display: block;
   text-align: center;
   margin: 10px 0px;
   color: gray;
}
#productContent {
   height: 300px;
   margin-top: 20px;
}
textarea {
   width: 827px;
   margin: 10px;
   border-radius: 0px;
   resize: none;
   border: 1px solid lightgray;
}
#submitBtnArea {
   display: flex;
    margin-top: 30px;
    margin-right: 100px;
    justify-content: center;
}

</style>
</head>
<body>
<c:import url="../common/header.jsp"/>

<div class="mainSectionForm">
<form action="${pageContext.request.contextPath}/seller/productInsert.do" method="post" enctype="multipart/form-data">
    <input type="hidden" name="sellerId" value="${seller.sellerId}"/>
    <input type="hidden" id="productNo" name="productNo" value="${productNo}"/>
    <table border="0" id="mainTable">
        <th colspan="4" class="sectionTitles">상품 기본 정보</th>
        <tr>
            <th>상품명</th>
            <td>
                <input type="text" name="productName" id="productTitle" placeholder="상품명을 입력하세요." required>                
            </td>        
            <th style="width: 150px;">카테고리</th>
            <td>
                <div id="categorySelects">
                    <select name="categoryNo" id="categoryNo">
                        <option value="">대분류</option>
                        <option value="0">의류</option>
                        <option value="1">슈즈</option>
                        <option value="2">가방</option>
                        <option value="3">액세서리</option>
                        <option value="4">주얼리</option>
                    </select>
                    <select name="categoryNo2" id="categoryNo2">
                       <option value="">소분류</option>
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
           <th>브랜드 명</th>
           <td><input type="text" name="productBrand" id="productBrand" placeholder="브랜드를 입력하세요." required></td>
           <th>판매 가격</th>
           <td><input type="number" name="productPrice" id="productPrice" placeholder="판매 가격을 입력하세요." required></td>
        </tr>
        <tr>
           <th>상품설명</th>
           <td colspan="3"><textarea name="productInfo" id="productInfo" fixed required></textarea></td>
        </tr>
        <tr>
            <th>판매기간</th>
            <td colspan="3">
                <div class="datePickerDiv">
                   <input type="text" class="datepicker" name="productStartdate" id="startDate" placeholder="판매시작일" required>
                   <input type="text" value="00:00:00" class="defaultTime" disabled>
                   <span style="display: inline-block; margin: 0px 50px;"> ~ </span> 
                   <input type="text" class="datepicker" name="productEnddate" id="endDate" placeholder="판매종료일" required>
                   <input type="text" value="23:59:59" class="defaultTime" disabled>
                </div>
            </td>
        </tr>

        <th colspan="4" class="sectionTitles">상품 옵션 정보</th>
        <tr>
            <th>옵션생성</th>
            <td colspan="3">
            <span style="display: inline-block; margin: 5px 0px; color:gray; font-size: 11px;">
               사이즈 및 옵션 등록 <br />
                : 사이즈 중복에 유의해주세요.
            </span>
                <button type="button" class="OptionBtns" onclick="delOptionRow();">선택 삭제</button>
                <button type="button" class="OptionBtns" onclick="addOptionRow(this);" >옵션 추가</button>
                
                <table id="optionTable" style="width: 100%; margin:25px 0px; padding:5px;"  border="1">
                    <tr>
                        <th class="optionTh" id="optionTh1">선택</th>
                        <th class="optionTh" id="optionTh2">NO.</th>
                        <th class="optionTh" id="optionTh5">브랜드명</th>
                        <th class="optionTh" id="optionTh3">상품명</th>
                        <th class="optionTh" id="optionTh4">사이즈</th>
                        <th class="optionTh" id="optionTh6">판매수량</th>
                    </tr>
                    <tr class="product-opt">
                        <td class="optionCheckbox" ><input type="checkbox" name="" id=""></td>
                        <td class="optionNo"><span class="productNo">자동생성</span></td>
                        <td><input class="optionBrand" type="text" name="optionBrand" id="optionBrand" min="0" /></td>
                        <td><input type="text" class="optionProductName" name="optionName" id="optionName" readonly/></td>
                        <td>
                           <select class="optionSize" name="sizeId" id="sizeId">
                              <option value="0">XS</option>
                              <option value="1">S</option>
                              <option value="2">M</option>
                              <option value="3">L</option>
                              <option value="4">XL</option>
                           </select>
                       </td>
                        <td><input class="optionAmount" type="number" name="productAmount" id="productAmount" min="0" /></td>
                    </tr>
                </table> 
            </td>
        </tr>
        <th colspan="4" class="sectionTitles">컨텐츠 정보</th>
        <tr>
            <th rowspan="2">이미지 등록</th>
               <td colspan="4">
                  <span class="imageSectionTitles">메인 이미지 및 추가 이미지 등록</span>
                  
                  <div class="productImgSection">
                     <div class="productMainImg">
                        <img src="${pageContext.request.contextPath}/resources/img/addImage.png" alt="상품추가" id="mainImg"  width="555" height="555"/>
                        <input type="file" class="fileSelector" name="mainImg" id="mainProductImg" onchange="loadImg(this);"/>
                     </div>
   
                     <div id="additionalImgSection">
                        <div class="productAdditionalImg">
                             <img src="${pageContext.request.contextPath}/resources/img/addImage.png" alt="상품추가" class="optionalImg" width="245" height="175"/>
                           <input type="file" class="fileSelector" name="optionalImg" id="optionalProductImg1"  onchange="loadImg(this)"/>
                        </div>
                        <div class="productAdditionalImg">
                           <img src="${pageContext.request.contextPath}/resources/img/addImage.png" alt="상품추가" class="optionalImg" width="245" height="175"/>
                           <input type="file" class="fileSelector" name="optionalImg" id="optionalProductImg2"  onchange="loadImg(this)"/>
                        </div>
                        <div class="productAdditionalImg">
                           <img src="${pageContext.request.contextPath}/resources/img/addImage.png" alt="상품추가" class="optionalImg" width="245" height="175"/>
                           <input type="file" class="fileSelector" name="optionalImg" id="optionalProductImg3" onchange="loadImg(this)"/>
                        </div>
                     </div>
                  </div>
           </td>
        </tr>
        <tr>
           <td colspan="4" >
              <span class="imageSectionTitles">컨텐츠 이미지 등록</span>
              <div id="contentImgSection">
                 <div class="productContentImg">
                    <img src="${pageContext.request.contextPath}/resources/img/addImage.png" alt="상품추가" class="contentImg" width="395" height="295"/>
                    <input type="file" class="fileSelector" name="contentImgs" id="contentProductImg1"  onchange="loadImg(this)"/>
                 </div>
                 <div class="productContentImg">
                    <img src="${pageContext.request.contextPath}/resources/img/addImage.png" alt="상품추가" class="contentImg" width="395" height="295"/>
                    <input type="file" class="fileSelector" name="contentImgs" id="contentProductImg2"  onchange="loadImg(this)"/>
                 </div>
              </div>
           </td>
        </tr>
        <tr>
            <th>상세 설명</th>
            <td colspan="4" style="border-top: 1px dotted lightgray;">
               <textarea name="productContent" id="productContent" fixed></textarea>
            </td>
        </tr>
    </table>
    <div id="submitBtnArea">
       <input type="submit" id="submitBtn" value="submitBtn" hidden/>
       <button class="primary-btn order-submit" type="button" id="confirmBtn" onclick="insertProduct();">등록</button>
    </div>
</form>
</div>

<c:import url="../common/footer.jsp"/>
<script>
   
   function validate(){
      
      var validate = true;
      var title = $('#productTitle').val(), info = $('#productInfo').val();
      var startDate = $('#startDate').val(), endDate = $('#endDate').val();
      var cate = $('#categoryNo').val(), cate2 = $('#categoryNo2').val();
      var mainImg = $('#mainProductImg').val();
       
      if(cate == "" || cate2 == ""){
         alert("카테고리를 선택해주세요.");
         validate = false;
      } else if(info == ""){
         alert("상품 설명을 입력해주세요. (상세 설명 제외)");
         validate = false;
      } else if(startDate > endDate || startDate == "" || endDate == ""){
         alert("판매기간을 확인해주세요.");
         validate = false;
      } else if(!mainImg){
         alert("메인 이미지를 추가해주세요.");
         validate = false;
      } 
   
      return validate;
   }
   
   function insertProduct(){
      
      if(validate() == true){
         saveOption();
      } 
   }

   function saveOption(){
      
      var result;
      
      var productNo = Number($('#productNo').val());
      var productName = $('#productTitle').val();
      var productBrand = $('#productBrand').val();
      console.log("productNo : " + productNo);
      
      var optionList = [];
      $('.product-opt').each(function(){
         var sizeId = Number($(this).find('.optionSize').val());
         var productAmount = Number($(this).find('.optionAmount').val());
         
         var obj = {
               productNo : productNo,
               productName : productName,
               productBrand : productBrand,
               sizeId : sizeId,
               productAmount : productAmount
            };
         optionList.push(obj);
      });
      
      console.log(optionList);
      
      $.ajax({
         url: "${pageContext.request.contextPath}/seller/optionInsert.do",
         type: "post",
         data: JSON.stringify(optionList),
         contentType: "application/json; charset=UTF-8",
         success: function(data){
            console.log("전달 성공");
            result = true;
            $('#submitBtn').trigger("click");
         },
         error: function(error){
            result = false;
            console.log("전달 실패");
            console.log(error);
         },
         async: false
      });
      
      return result;
   }

   
   // 옵션명 / 가격 반영
   $(function(){
      $('#productTitle').on("keyup", function(){
         var productName = $('#productTitle').val();
         $('.optionProductName').val(productName);
      });
      $('#productBrand').on("keyup", function(){
         var productBrand = $('#productBrand').val();
         $('.optionBrand').val(productBrand);
      });
      
   });
   
   
   // 옵션 추가.삭제
   function addOptionRow(btn){
      console.log('클릭 확인');
      var numRow = $('input[type="checkbox"]').length;
      console.log(numRow);
      
      var origin = $(btn).next();
      console.log(origin);
      var originHtml = $(btn).next().html();
      var newRow = '<tr class="product-opt">' +
                    '<td class="optionCheckbox" ><input type="checkbox" name="" id=""></td>' +
                      '<td class="optionNo"><span class="productNo">자동생성</span></td>' +
                       '<td><input class="optionBrand" type="text" name="optionBrand" id="optionBrand" min="0" /></td>' +
                    '<td><input type="text" class="optionProductName" name="" id="" readonly/></td>' +
                    '<td>' +
                        '<select class="optionSize" name="sizeId" id="sizeId">' +
                           '<option value="0">XS</option>' +
                           '<option value="1">S</option>' +
                           '<option value="2">M</option>' +
                           '<option value="3">L</option>' +
                           '<option value="4">XL</option>' +
                        '</select>' +
                    '</td>' +
                    '<td><input class="optionAmount" type="number" name="productAmount" id="productAmount" min="0" /></td>' +
                '</tr>' + 
                '</tbody>' ;
      
      origin.html(originHtml.replace("</tbody>","") + newRow);
      var productName = $('#productTitle').val();
      $('.optionProductName').val(productName);
      var productBrand = $('#productBrand').val();
      $('.optionBrand').val(productBrand);
      
   }
   
   function delOptionRow(){
      var delRow = $('input[type="checkbox"]:checked').parent().parent();
      delRow.replaceWith('');

      var numRow = $('input[type="checkbox"]').length;
      console.log(numRow);
       
      for(i = 0; i < numRow; i++){
         var rows = $('.productNo');
         console.log(rows);
         console.log(rows[i]);
      } 
   }

   // 이미지 추가
   $(function(){
      $('.optionalImg, #mainImg, .contentImg').click(function(){
         $(this).next().click();
         console.log("input:file 접근 완료");
      });
      
      $('.fileSelector').hide();
      
   });

   function loadImg(img){

      if(img.files && img.files[0]){

         var reader = new FileReader();
         reader.onload = function(e){
            $(img).prev().attr('src', e.target.result);
         }
      }
      
      reader.readAsDataURL(img.files[0]);
   };
   
   // datepicker 사용
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

</body>
</html>