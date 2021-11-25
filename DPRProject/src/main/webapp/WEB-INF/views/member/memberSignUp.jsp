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

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
.input {
	width: 80%;
}
div.guide {
	margin: 10px;
	font-size: 12px;
	display: none;
}
div.ok { color: green; }
div.error, div.invalid, div.pattern { color: red; }
.col-md-5 order-details {
	border: 1px solid gray;
}
#sellerContainer {
	display: none;
}
#selectUserSellerDiv {
	color: gray;
	font-size: 13px;
}
#ifSellerCheckbox {
	margin-right: 10px;
}
.form-group input {
	width: 70%;
}

/* ----- member -----  */

div#userId-container {
	position: relative;
	padding: 0px
}

div.state {
	display: none;
}


div#userId-container span.error, span.invalid {
	color: red;
}

</style>
</head>
<body>
<c:import url="../common/header.jsp"/>
<!-- BREADCRUMB -->
		<div id="breadcrumb" class="section">
			<!-- container -->
			<div class="container">
				<!-- row -->
				<div class="row">
					<div class="col-md-12">
						<h3 class="breadcrumb-header">회원가입</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">Home</a></li>
							<li class="active">회원가입</li>
						</ul>
					</div>
				</div>
				<!-- /row -->
			</div>
			<!-- /container -->
		</div>
		<!-- /BREADCRUMB -->
		
		<!-- SECTION -->
		<div class="section">
			<!-- container -->
			<div class="container">
			<div id="selectUserSellerDiv"><input type="checkbox" name="" id="ifSellerCheckbox" />Seller 회원으로 가입을 원하시나요?</div>
				<div id="sellerContainer">
				<!-- row -->
				<div class="row">

					<div class="col-md-7">
					<form name="signUpForm" id="signUpForm" action="sellerSignUpEnd.do" method="post" onsubmit="return sellerValidate();">
						<!-- Billing Details -->
						<div class="billing-details">
							<div class="section-title">
								<h3 class="title">SELLER 회원가입</h3>
							</div>
							<div class="form-group">
								<i class="far fa-id-card fa-lg"></i>
								<input class="input" type="text" name="sellerId" id="sellerId" placeholder="아이디를 입력하세요" required>								
									<div class="guide invalid Id">5글자 이상 입력해주세요.</div>
									<div class="guide ok Id">사용 가능한 아이디입니다.</div>
									<div class="guide error Id">사용할 수 없는 아이디입니다.</div>
									<div class="guide pattern Id">영문 또는 숫자만 사용 가능합니다.</div>
								<input type="hidden" name="sellerDuplicateCheck" id="sellerDuplicateCheck" value="0"/>
							</div>
							<div class="form-group">
								<i class="fas fa-lock fa-lg"></i>
								<input class="input" type="password" name="sellerPw" id="sellerPw" placeholder="비밀번호를 입력하세요." required>
							</div>
							<div class="form-group">
								<i class="fas fa-lock fa-lg"></i>
								<input class="input" type="password" name="pwValidate" id="pwValidate" placeholder="비밀번호를 한번 더 입력하세요." required>
									<div class="guide invalid Pw">비밀번호가 일치하지 않습니다.</div>
									<div class="guide ok Pw">비밀번호가 일치합니다.</div>
							</div>
							<div class="form-group">
								<i class="fas fa-building fa-lg"></i>
								<input class="input" type="text" name="sellerNo" onKeyup="addHypenRegisterNo(this);" placeholder="사업자번호를 입력하세요." required>
							</div>
							<div class="form-group">
								<i class="fas fa-tag fa-lg"></i>
								<input class="input" type="text" name="sellerCompany" placeholder="회사명을 입력하세요." required>
							</div>
							<div class="form-group">
								<i class="fas fa-user-tag fa-lg"></i>
								<input class="input" type="text" name="sellerName" placeholder="대표자명을 입력하세요." required>
							</div>
							<div class="form-group">
								<i class="fas fa-home fa-lg"></i>
								<input class="input" type="text" name="zipCode" id="sellerZipCode" placeholder="우편번호" disabled>
								<button type="button" onclick="searchSellerAddress();">주소 검색</button>
								<input class="input" type="text" name="searchAddr" id="sellerSearchAddr" placeholder="검색을 통해 주소를 입력하세요." disabled required>
								<input class="input" type="text" name="detailAddr" id="sellerDetailAddr" placeholder="상세 주소를 입력하세요.">
								<input class="input" type="hidden" name="sellerAddress" id="sellerAddr" >
							</div>
							<div class="form-group">
								<i class="fas fa-phone fa-lg"></i>
								<input class="input" type="text" name="sellerPhone" onKeyup="addHypenPhone(this);" placeholder="연락처를 '-' 없이 입력하세요." required>
							</div>	
							<input type="submit" class="primary-btn order-submit" value="회원가입">
						</form>

						</div>
						<!-- /Billing Details -->

					</div>

				</div><!-- /row -->
				</div> <!-- seller container -->
				
			<div id="memberContainer">
			<!-- row -->
			<div class="row">

				<form name="memberEnrollFrm" action="memberEnrollEnd.do" method="post" onsubmit="return fn_enroll_validate();">				
					<!-- 회원가입 -->
					<div class="billing-details">
						<div class="section-title">
							<h3 class="title">회원가입</h3>
						</div>
						<div class="form-group" id="userId-container">
							<input class="form-control" type="text" name="userId"
								placeholder="아이디를 입력해 주세요" id="userId" required> 
								<div class="state ok id">사용 가능한 아이디입니다.</div> 
								<div class="state error id">사용할 수 없는 아이디입니다.</div> 
								<div class="state invalid id">5글자 이상 입력해주세요.</div>
								<div class="state pattern id">영문 또는 숫자만 사용 가능합니다.</div>
								<input type="hidden" name="idCheckDuplicate" id="idCheckDuplicate" value="0" />
						</div>
						<div class="form-group">
							<input class="input" type="password" name="userPw" id="userPw"
								placeholder="비밀번호를 입력하세요." required>
						</div>
						<div class="form-group">
							<input class="input" type="password" name="userPw2 "id="userPw2"
								placeholder="비밀번호를 한번 더 입력하세요." required>
							<div class="state invalid pw">비밀번호가 일치하지 않습니다.</div>
							<div class="state ok pw">비밀번호가 일치합니다.</div>
						</div>
						<div class="form-group">
							<input class="input" type="text" name="userName"
								placeholder="이름을 입력해주세요" required>
						</div>
						<div class="form-group">
							<input type="text" name="userBirthDate" id="startDate">
						</div>
						<div class="form-group">
							<label class="selection"> 
								<input type="radio" name="userGender" value="M" checked/><span>남자</span>
							</label> 
							<label class="selection"> 
								<input type="radio" name="userGender" value="F" /><span>여자</span>
							</label>
						</div>
						<div class="form-group">
							<input class="input" type="text" name="zipCode" id="zipCode" placeholder="우편번호" disabled>
							<button type="button" onclick="searchAddress();">주소 검색</button>
							<input class="input" type="text" name="searchAddr" id="searchAddr" placeholder="검색을 통해 주소를 입력하세요." disabled required>
							<input class="input" type="text" name="detailAddr" id="detailAddr" placeholder="상세 주소를 입력하세요.">
							<input class="input" type="hidden" name="userAddress" id="userAddr" >
						</div>
						<div class="form-group">
							<input class="input" type="tel" name="userPhone" 
								onkeyup="addHypenPhone(this);"placeholder="연착처를 '-' 없이 입력하세요." required >
						</div>
						<div class="form-group">
							<input type="text" name="userEmail" placeholder="이메일을 입력해주세요" class="input">
						</div>
					</div>	

					<input type="submit" class="primary-btn order-submit" value="회원가입">
				</form>
			</div> <!-- /row -->
			</div> <!-- membercontainer -->
				

			</div><!-- /container -->
		</div><!-- /SECTION -->
		
		<script>
		
		$(function(){
			$('#ifSellerCheckbox').on('change', function(){
				console.log("확인");
				var checked = $('#ifSellerCheckbox').prop('checked');
				console.log(checked);
				if(checked == false){
					$('#sellerContainer').hide();
					$('#memberContainer').show();
				} else {
					$('#sellerContainer').show();
					$('#memberContainer').hide();
				}
			});	
		});
		
		function addHypenRegisterNo(obj) {
		    var number = obj.value.replace(/[^0-9]/g, "");
		    var registerNo = "";

		    if(number.length < 4) {
		        return number;
		    } else if(number.length < 5) {
		    	registerNo += number.substr(0, 3);
		    	registerNo += "-";
		    	registerNo += number.substr(3);
		    } else if(number.length < 10) {
		    	registerNo += number.substr(0, 3);
		    	registerNo += "-";
		    	registerNo += number.substr(3, 2);
		    	registerNo += "-";
		    	registerNo += number.substr(5);
		    } else {
		    	registerNo += number.substr(0, 3);
		    	registerNo += "-";
		    	registerNo += number.substr(3, 2);
		    	registerNo += "-";
		    	registerNo += number.substr(5, 5);
		    }
		    obj.value = registerNo;
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
		
		// -- 주소 검색 및 최종 DB 주소 조합 (" / " 로 구분)
		$(function(){
			$("#sellerDetailAddr").on("keyup", function(){
				var zipCode = $('#sellerZipCode').val();
				var searchAddr = $('#sellerSearchAddr').val();
				var detailAddr = $('#sellerDetailAddr').val();
				
				$("#sellerAddr").val(zipCode + " / " + searchAddr + " / " + detailAddr);
			});
		});
		
	    function searchSellerAddress(){
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

	                $('#sellerZipCode').val(data.zonecode); 
	                $('#sellerSearchAddr').val(fullAddr);
	                $("#sellerAddr").val(data.zonecode + " / " + fullAddr + " / ");
	                $('#sellerDetailAddr').focus();
	            }
		    }).open();	    	
	    }
		
		$(function(){
			// 중복확인 및 정규식 적용 script
			$("#sellerId").on("keyup", function(){
		        var sellerId = $(this).val().trim();
		        var idPattern = /^[a-zA-Z0-9]+$/;
		        
		        if(sellerId.length == 0){ 
		        	$(".guide.error.Id").hide();
		        	$(".guide.ok.Id").hide();
		        	$(".guide.pattern.Id").hide();
		        	$(".guide.invalid.Id").hide();
		        	$("#sellerDuplicateCheck").val(0);
		        } else if(idPattern.test(sellerId) == false){
		        	$(".guide.error.Id").hide();
		        	$(".guide.ok.Id").hide();
		        	$(".guide.pattern.Id").show();
		        	$(".guide.invalid.Id").hide();
		        	$("#sellerDuplicateCheck").val(0);
		        } else if(sellerId.length < 5) {
		        	$(".guide.error.Id").hide();
		        	$(".guide.ok.Id").hide();
		        	$(".guide.pattern.Id").hide();
		        	$(".guide.invalid.Id").show();
		        	$("#sellerDuplicateCheck").val(0);
		        	return;     	
		        } else {
			        $.ajax({
			            url  : "${pageContext.request.contextPath}/member/checkSellerDuplicate.do",
			            data : {sellerId:sellerId},
			            dataType: "json",
			            success : function(data){
			                console.log(data);
			                if(data == true) {
			                    $(".guide.error.Id").hide();
			                    $(".guide.invalid.Id").hide();
			                    $(".guide.ok.Id").show();
			                    $(".guide.pattern.Id").hide();
			                    $("#sellerDuplicateCheck").val(1);
			                } else {
			                    $(".guide.error.Id").show();
			                    $(".guide.invalid.Id").hide();
			                    $(".guide.ok.Id").hide();
			                    $(".guide.pattern.Id").hide();
			                    $("#sellerDuplicateCheck").val(0);
			                }
			            }, error : function(jqxhr, textStatus, errorThrown){
			                console.log("ajax 처리 실패");
			                console.log(jqxhr);
			                console.log(textStatus);
			                console.log(errorThrown);
			            }
		        	});
		     	}
			});	// -- 아이디 중복확인 종료
			
			$("#pwValidate, #sellerPw").on("keyup", function(){
				var pw1 = $("#sellerPw").val(), pw2 = $("#pwValidate").val();
				if(pw1 != pw2){
                    $(".guide.invalid.Pw").show();
                    $(".guide.ok.Pw").hide();
				} else {
					$(".guide.ok.Pw").show();
					$(".guide.invalid.Pw").hide();
				}
			});
		});
		
		function sellerValidate(){
			var pw1 = $("#sellerPw").val();
			var pw2 = $("#pwValidate").val();
			
			var register = $('#registerCheck').prop('checked');
			
		    if($("#sellerDuplicateCheck").val() == 0 || pw1 != pw2){
		        alert("아이디 또는 비밀번호를 다시 확인해주세요.");
		        return false;
		    } else if(register == false){
		    	alert("약관에 동의해야 가입이 가능합니다.");
		        return false;
		    } else {	    	
				return true;
		    }
		}
		
		
		
		
		/* ------------------------ member script -------------------------------------- */
		
		
		
		$(function(){
				$("#userId").on("keyup", function(){
					var userId = $(this).val().trim();
					var idPattern = /^[a-zA-Z0-9]+$/;
					console.log(userId);
					
					if(userId.length == 0){
						$(".state.error.id").hide();
						$(".state.ok.id").hide();
						$(".state.invalid.id").hide();
						$(".state.pattern.id").hide();
						$("#idCheckDuplicate").val(0);
					} else if(idPattern.test(userId) == false){
						$(".state.error.id").hide();
						$(".state.ok.id").hide();
						$(".state.invalid.id").hide();
						$(".state.pattern.id").show();
						$("#idCheckDuplicate").val(0);
					} else if(userId.length < 5){
						$(".state.error.id").hide();
						$(".state.ok.id").hide();
						$(".state.invalid.id").show();
						$(".state.pattern.id").hide();
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
				
				$("#userPw2, #userPw").on("keyup", function(){
					var pw1 = $("#userPw").val();
					var pw2 = $("#userPw2").val();
					
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
			
			var register = $('#registerCheck').prop('checked');
			
		    if($("#sellerDuplicateCheck").val() == 0 || pw1 != pw2){
		        alert("아이디 또는 비밀번호를 다시 확인해주세요.");
		        return false;
		    } else if(register == false){
		    	alert("약관에 동의해야 가입이 가능합니다.");
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
	        	,maxDate: 'today'
	        });

	       //초기값을 오늘 날짜로 설정해줘야 합니다.
	        $('#startDate').datepicker('setDate', 'toay'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	        $('img.ui-datepicker-trigger').attr('style', 'padding: 7px;');
	    });

		
		
		
		$(function(){
			$("#detailAddr").on("keyup", function(){
				var zipCode = $('#zipCode').val();
				var searchAddr = $('#searchAddr').val();
				var detailAddr = $('#detailAddr').val();
				
				$('#userAddr').val(zipCode + " / " + searchAddr + " / " + detailAddr);
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
	                $("#userAddr").val(data.zonecode + " / " + fullAddr + " / ");
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
<c:import url="../member/agreement.jsp"/>
<c:import url="../common/footer.jsp"/>
</body>
</html>