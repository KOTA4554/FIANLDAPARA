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
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.6.0.min.js"></script>

<style>
.loginSection {
	width: 100%;
	padding: 150px 0px;
	display: flex;
	justify-content: center;
}

.loginSection input[type="text"], input[type="password"] {
	display: block;
	width: 300px;
	height: 30px;
}

.loginSection label {
	margin-top: 15px;
}

.checkBoxDiv {
	display: flex;
	justify-content: space-around;
	padding-bottom: 20px;
	border-bottom: 1px solid lightgray;
}

.signUp {
	margin-top: 30px;
	border-top: 1px solid lightgray;
	text-align: center;
	padding: 10px;
	color: gray;
}

.findId {
	text-align: center;
	margin-bottom: 10px;
	color: gray;
}

#loginBtn {
	margin-right: 50%;
	margin-bottom: 5%;
}

.primary-btn1 {
	display: inline-block;
	padding: 12px 30px;
	background-color: #D10024;
	border: none;
	width: 300px;
	border-radius: 5px;
	color: #FFF;
	text-transform: uppercase;
	font-weight: 700;
	text-align: center;
	-webkit-transition: 0.2s all;
	transition: 0.2s all;
}

.primary-btn1 :hover, .primary-btn1 :focus {
	opacity: 0.9;
	color: #FFF;
}

.loginSection i {
	margin: 15px 10px;
}

.inputFormTitle {
	display: inline-block;
	margin-left: 10px;
	font-weight: 500;
}

.loginSection input[type="text"], .loginSection input[type="password"] {
	height: 40px;
	padding: 0px 15px;
	border: 1px solid #E4E7ED;
	background-color: #FFF;
}

input[type="radio"] {
	margin-right: 5px;
}

.radioBtnTitle {
	font-size: 12px;
	color: gray;
}
</style>
</head>
<body>
	<c:import url="../common/header.jsp" />

	<div class="loginSection">
		<form action="userSearchInfo.do" method="post">
			<div class="checkBoxDiv">
				<div>
					<input type="radio" name="userType" value="user" checked /> <span
						class="radioBtnTitle">일반 회원</span>
				</div>
				<div>
					<input type="radio" name="userType" value="seller" /> <span
						class="radioBtnTitle">셀러 회원</span>
				</div>
			</div>
			<div class="formLine">
				<label for="sellerId"> <i class="fas fa-user-tag fa-lg"></i>
					<span class="inputFormTitle">이름</span>
				</label> <input type="text" name="userName" id="userName"
					placeholder="이름을 입력하세요." required />
			</div>

			<div class="formLine">
				<label for="sellerPw"> <i class="fas fa-phone fa-lg"></i> <span
					class="inputFormTitle">전화번호</span>
				</label> <input type="text" name="userPhone" id="userPhone"
					placeholder="전화번호를 입력하세요." required />
			</div>
			<div class="formLine">
				<label for="sellerPw"> <i class="fas fa-phone fa-lg"></i> <span
					class="inputFormTitle">이메일</span>
				</label> <input type="text" name="userEmail" id="userEmail"
					placeholder="이메일를 입력하세요." required />
			</div>
			<div class="signUp">
				<a href="${pageContext.request.contextPath}/member/memberSignUp.do"
					id="signUp">회원가입</a>
			</div>
			<div class="formLine">
				<input type="submit" id="loginBtn" class="primary-btn1 order-submit"
					value="찾기">
			</div>
		</form>
	</div>

	<c:import url="../common/footer.jsp" />

	<script>
		// 만약 일반회원이면 일반회원 로그인, 셀러면 셀러 로그인으로 이동

		$('input[type="radio"]').on('change', function() {
			var selectedType = $('input[type="radio"]:checked').val();

			// 일반회원 = user . 셀러 = seller 로 라디오 버튼 구분
			if (selectedType == 'user') {
				// !!! 기본 진입시 user 가 선택되므로, form 에서도 일반회원 가입 주소로 변경해주어야함 !!!
				console.log("user : userSearchInfo.do 로 이동합니다.");
				$('form').attr({
					'action' : 'userSearchInfo.do'
				});
				$('#userName').attr({
					'name' : 'userName'
				});
				$('#userPhone').attr({
					'name' : 'userPhone'
				});
				$("#userEmail").attr({
					'name' : 'userEmail'
				});
				$('#kakaoLogin').show();
			} else {
				console.log("seller : sellerLogin.do 로 이동합니다.");
				$('form').attr({
					'action' : 'sellerLogin.do'
				});
				$('#userId').attr({
					'name' : 'sellerId'
				});
				$('#userPw').attr({
					'name' : 'sellerPw'
				});
				$('#kakaoLogin').hide();
			}
		});
	</script>


</body>
</html>