<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.kh.dpr.member.model.vo.Member, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정 : DAPARA</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
div#userId-container {
   position: relative;
   padding: 0px
}

span.state {
   display: none;
}


div#userId-container span.error, span.invalid {
   color: red;
}

</style>
</head>
<body>
   <c:import url="../common/header.jsp" />

   <!-- BREADCRUMB -->
   <div id="breadcrumb" class="section">
      <!-- container -->
      <div class="container">
         <!-- row -->
         <div class="row">
            <div class="col-md-12">
               <h3 class="breadcrumb-header">회원가입 수정</h3>
               <ul class="breadcrumb-tree">
                  <li><a href="${pageContext.request.contextPath}">Home</a></li>
                  <li class="active">change info</li>
               </ul>
            </div>
         </div>
         <!-- /row -->
      </div>
      <!-- /container -->
   </div>
   <!-- /BREADCRUMB -->

   <!-- SECTION -->
   <div class="Section">
      <!-- container -->
      <div id="memberContainer">
         <!-- row -->
         <div class="row">

            <form name="memberUpdate" action="memberUpdate.do" method="post" style="margin-left:20%;" onsubmit="return fn_enroll_validate();">            
               <!-- 회원가입 -->
               <div class="billing-details">
                  <div class="form-group" id="userId-container">
                     <input class="form-control" type="text" name="userId"
                        placeholder="아이디 (5글자이상)" id="userId" value="${member.userId}" readonly required> 
                  </div>
                  <div class="form-group">
                     <input class="input" type="text" name="userName"
                        placeholder="이름을 입력해주세요" value="${member.userName}" required>
                  </div>
                  <div class="form-group">
                     <input type="text" name="userBirthDate" id="startDate" value="${member.userBirthDate}"required>
                  </div>
                  <div class="form-group">
                     <label class="selection"> 
                        <input type="radio" name="userGender" value="M" ${member.userGender=='M'?'checked':''}/><span>남자</span>
                     </label> 
                     <label class="selection"> 
                        <input type="radio" name="userGender" value="F" ${member.userGender=='F'?'checked':''}/><span>여자</span>
                     </label>
                  </div>
                  <div class="form-group">
                     <input class="input" type="text" name="zipCode" id="zipCode" placeholder="우편번호"  value='${member.userAddress.split("/")[0]}' disabled>
                     <button type="button" onclick="searchAddress();">주소 검색</button>
                     <input class="input" type="text" name="searchAddr" id="searchAddr" placeholder="검색을 통해 주소를 입력하세요." value='${member.userAddress.split("/")[1]}' disabled required>
                     <input class="input" type="text" name="detailAddr" id="detailAddr" placeholder="상세 주소를 입력하세요." value='${member.userAddress.split("/")[2]}'>
                     <input class="input" type="text" name="userAddress" id="userAddress"  hidden value="${member.userAddress}">
                  </div>
                  <div class="form-group">
                     <input class="input" type="tel" name="userPhone" 
                        onkeyup="addHypenPhone(this);"placeholder="연착처를 '-' 없이 입력하세요." value="${member.userPhone}"required >
                  </div>
                  <div class="form-group">
                     <input type="text" name="userEmail" placeholder="이메일을 입력해주세요" value="${member.userEmail}"class="input">
                  </div>
               </div>
                  <input type="submit" class="primary-btn change-submit" value="수정">
                  <input type="reset" class="primary-btn delete" onclick="location.href='${pageContext.request.contextPath}/myPage/memberDelete.do'" value="탈퇴"/>
            </form>
         </div> <!-- /row -->
         </div> <!-- membercontainer -->
         <!-- /container -->
      </div>
      <!-- /SECTION -->

      <script>
         $(function(){
            $("#userId").on("keyup", function(){
               var userId = $(this).val().trim();
               var idPattern = /^[a-zA-Z0-9]+$/;
               
               if(userId.length == 0){
                  $(".state.error.id").hide();
                  $(".state.ok.id").hide();
                  $(".state.inval.id").hide();
                  $(".state.patter.id").hide();
                  $("#idCheckDuplicate").val(0);
               } else if(idPattern.test(userId) == false){
                  $(".state.error.id").hide();
                  $(".state.ok.id").hide();
                  $(".state.inval.id").hide();
                  $(".state.patter.id").hide();
                  $("#idCheckDuplicate").val(0);
               } else if(userId.length<5){
                  $(".state.error.id").hide();
                  $(".state.ok.id").hide();
                  $(".state.inval.id").show();
                  $(".state.patter.id").hide();
                  $("#idCheckDuplicate").val(0);
                  return;
               } else {
                  $.ajax({
                     url : "${pageContext.request.contextPath}/member/checkIdDuplicate.do",
                     data : {userId:userId},
                     dataType: "json",
                     success : function(data){
                        console.log(data);
                        if(data == true){
                           $(".state.error").hide();
                           $(".state.ok").show();
                           $(".state.invalid").hide();
                           $(".state.pattern.id").hide();
                           $("#idCheckDuplicate").val(1);
                        } else {
                           $(".state.error").show();
                           $(".state.ok").hide();
                           $(".state.invalid").hide();
                           $(".state.pattern.id").hide();
                           $("#idCheckDuplicate").val(0);
                        }
                     }, error : function(jqxhr, textStatus, errorThrown){
                        console.log("ajax 처리 실패");
                        console.log(jqxhr);
                        console.log(textStatus);
                        console.log(errorThrown);
                     }
                  });
               }
            });
            
            $("userPw2, #userPw").on("keyup", function(){
               var pw1 = $("#userPw").val, pw2 = $("#userPw2").val();
               if(pw1 != pw2){
                  $(".state.invalid.pw").show();
                  $(".state.ok.pw").hide();
               } else {
                  $(".state.invalid.pw").hide();
                  $(".state.ok.pw").show();
               }
            });
         });
         
         function validate(){
            var pw1 = $("#userPw").val();
            var pw2 = $("#userPw2").val();
            
            if($("#idCheckDuplicate").val() == 0 || pw1 != pw2){
               alert("아이디 또는 비밀번호를 다시 확인해주세요.");
               return false;
            } else {
               return true;
            }   
         }
         
         // datepicker 사용
          $(function() {
             //input을 datepicker로 선언
              $('#startDate').datepicker({
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

             //초기값을 오늘 날짜로 설정해줘야 합니다.
              $('#startDate').datepicker('setDate', '+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
              $('img.ui-datepicker-trigger').attr('style', 'padding: 7px;');
          });

         $(function(){
            $("#detailAddr").on("keyup", function(){
               var zipCode = $('#zipCode').val();
               var searchAddr = $('#searchAddr').val();
               var detailAddr = $('#detailAddr').val();
               
               $("#userAddress").val(zipCode + " / " + searchAddr + " / " + detailAddr);
            });
         });
         
          function searchAddress(){
            new daum.Postcode({
                 oncomplete: function(data) {
                      var fullAddr = '';
                      var extraAddr = '';

                      if (data.userSelectedType === 'R') { 
                          fullAddr = data.roadAddress;
                      } else { 
                          fullAddr = data.jibunAddress;
                      }

                      if(data.userSelectedType === 'R'){
                          if(data.bname !== ''){
                              extraAddr += data.bname;
                          }
                          if(data.buildingName !== ''){
                              extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                          }
                          fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                      }

                      $('#zipCode').val(data.zonecode); 
                      $('#searchAddr').val(fullAddr);
                      $("#userAddress").val(data.zonecode + " / " + fullAddr + " / ");
                      $('#detailAddr').focus();
                  }
             }).open();          
          }
          
         function addHypenPhone(obj) {
             var number = obj.value.replace(/[^0-9]/g, "");
             var phone = "";

             if(number.length < 4) {
                 return number;
             } else if(number.length < 7) {
                 phone += number.substr(0, 3);
                 phone += "-";
                 phone += number.substr(3);
             } else if(number.length < 11) {
                 phone += number.substr(0, 3);
                 phone += "-";
                 phone += number.substr(3, 3);
                 phone += "-";
                 phone += number.substr(6);
             } else {
                 phone += number.substr(0, 3);
                 phone += "-";
                 phone += number.substr(3, 4);
                 phone += "-";
                 phone += number.substr(7, 4);
             }
             obj.value = phone;
         }
      </script>
&nbsp;&nbsp;
<c:import url="../common/footer.jsp" />
</body>
</html>