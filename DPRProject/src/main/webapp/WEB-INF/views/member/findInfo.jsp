<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.kh.dpr.member.model.vo.Member, java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
	<h4>회원 아디이 찾기</h4>
	<form name="findId" action="findId.do">
		이름 <input type="text" name="user_name" id="name"><br>
		생년월일 <input type="text" name="user_birth" id="birth"><br>
		핸드폰 번호 <input type="text" name="user_phoneNumber" id="tel"><br>

	</form>
	<button id="findId">아이디 찾기</button>
	<br>
	<br>

	<span id="emailList"></span>
	
<script>
$(document).on('click','#findId',function(){
	var name = $('#name').val();
 	var birth = $('#birth').val();
 	var tel = $('#tel').val();

 	var postData = {'user_name' : name , 'user_birth' : birth , 'user_phoneNumber' : tel};

	$.ajax({
        url:'/user/findingId',
        type:'POST',
        data: postData,
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType : "json",

        success:function(data){
        	var emailLists = data.user_email;
        	var emailLength = emailLists.length
        	var emailfind = emailLists.substring(1, emailLength-1)
       	 		 $("#emailList").append("<h1>"+"회원님의 정보로 등록된 이메일은 : "+emailfind+" 입니다.</h1>")

        },
        error: function (XMLHttpRequest, textStatus, errorThrown){

        	alert('정보를 다시 입력해주시길 바랍니다.' );
        }
    });
});

</script>
</body>
</html>