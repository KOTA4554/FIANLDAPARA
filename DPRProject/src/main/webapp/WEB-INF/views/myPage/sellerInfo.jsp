<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.kh.dpr.seller.model.vo.Seller, java.util.*"%>
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
						<h3 class="breadcrumb-header">회원정보 수정</h3>
						<ul class="breadcrumb-tree">
							<li><a href="#">Home</a></li>
							<li class="active">회원정보 수정</li>
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
				<div id="sellerContainer">
				<!-- row -->
				<div class="row">

					<div class="col-md-7">
					<form name="signUpForm" id="signUpForm" action="updateSeller.do" method="post" onsubmit="return sellerValidate();">
						<!-- Billing Details -->
						<div class="billing-details">
							<div class="form-group">
								<i class="far fa-id-card fa-lg"></i>
								<input class="input" type="text" name="sellerId" id="sellerId" placeholder="아이디 (5글자이상)" value="${seller.sellerId}"  readonly required>								
							</div>
							<div class="form-group">
								<i class="fas fa-building fa-lg"></i>
								<input class="input" type="text" name="sellerNo" onKeyup="addHypenRegisterNo(this);" placeholder="사업자번호를 입력하세요." value="${seller.sellerNo}" required>
							</div>
							<div class="form-group">
								<i class="fas fa-tag fa-lg"></i>
								<input class="input" type="text" name="sellerCompany" placeholder="회사명을 입력하세요." value="${seller.sellerCompany}"required>
							</div>
							<div class="form-group">
								<i class="fas fa-user-tag fa-lg"></i>
								<input class="input" type="text" name="sellerName" placeholder="대표자명을 입력하세요." value="${seller.sellerName}" required>
							</div>
							<div class="form-group">
								<i class="fas fa-home fa-lg"></i>
								<input class="input" type="text" name="zipCode" id="sellerZipCode" placeholder="우편번호" value='${seller.sellerAddress.split("/")[0]}' disabled>
								<button type="button" onclick="searchSellerAddress();">주소 검색</button>
								<input class="input" type="text" name="searchAddr" id="sellerSearchAddr" placeholder="검색을 통해 주소를 입력하세요." value='${seller.sellerAddress.split("/")[1]}' disabled required>
								<input class="input" type="text" name="detailAddr" id="sellerDetailAddr" placeholder="상세 주소를 입력하세요." value='${seller.sellerAddress.split("/")[2]}'>
								<input class="input" type="hidden" name="sellerAddress" id="sellerAddr"  value="${seller.sellerAddress}">
							</div>
							<div class="form-group">
								<i class="fas fa-phone fa-lg"></i>
								<input class="input" type="text" name="sellerPhone" onKeyup="addHypenPhone(this);" placeholder="연락처를 '-' 없이 입력하세요." value="${seller.sellerPhone}" required>
							</div>	
							<input type="submit" class="primary-btn change-submit" value="수정">
							<input type="reset" class="primary-btn delete" onclick="location.href='${pageContext.request.contextPath}/myPage/sellerDelete.do'" value="탈퇴"/>
						</form>

						</div>
						<!-- /Billing Details -->

					</div>

				</div><!-- /row -->
				</div> <!-- seller container -->
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

</script>

<c:import url="../common/footer.jsp"/>
</body>
</html>