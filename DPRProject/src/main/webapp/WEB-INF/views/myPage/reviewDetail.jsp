<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰상세 : DAPARA</title>

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/myPage.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reviewForm.css"/>

</head>
<body>

	<c:import url="../common/header.jsp"/>
	
	<!-- myPage 리뷰작성 -->
		<div id=myPage>

			<div class="container">
				
				<div id="section-header">
					<h2 id="mypageTitle">
						MY페이지
					</h2>
				</div>

				<div id="myPageBody">

					<div id="sideMenu">
	
						<div id="infoDiv">
							<div>${member.userId} 님</div>
							<button type="button" id="myInfoBtn">회원정보 수정</button>
						</div>
	
						<div id="sideMenuList">
							<ul>
								<li class="listTitle">
									MY 쇼핑
									<ul>
										<a href="${pageContext.request.contextPath}/myPage/myPage.do">주문목록 / 배송조회</a>
									</ul>
								</li>
							</ul>
							<ul>
								<li class="listTitle">
									MY 활동
									<ul>
										<li class="menu"><a href="">문의내역 확인</a></li>
										<li class="menu"><a href="${pageContext.request.contextPath}/myPage/reviewList.do">리뷰 관리</a></li>
									</ul>
								</li>
							</ul>
						</div>
	
					</div>
	
					<div id="reviewArea">
						
						<div id="reviewTitle">
							<h3>리뷰 상세/수정</h3>
						</div>

						<div id="productArea">
							<h4>상품 정보</h4>
							
							<table class="productTable">
								<tr>
									<td rowspan="4" class="productImg"><img src="${pageContext.request.contextPath}/resources/productUpload/${productImg}" alt="상품이미지" width=100 height=100></td>
									<td style="width : 450px; font-weight: bold; padding-left: 13px;">${ product.productBrand }</td>
								</tr>
								<tr>
									<td style="padding-left: 13px;">${ product.productName }</td>
								</tr>
								<tr>
									<td style="padding-left: 13px;">옵션 : ${ sizeName }</td>
								</tr>
							</table>
						</div>

						<form action="${pageContext.request.contextPath}/review/reviewUpdate.do" id="reviewForm" method="post" onsubmit="return validate();" enctype="multipart/form-data">
							<input type="hidden" name="reviewNo" value="${ review.reviewNo }">
							<input type="hidden" name="userId" value="${ member.userId }">
							<div id="starArea">
								<span class="text">별점</span>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<i class="fas fa-star"></i>
								<select name="reviewScore" id="star" hidden>
									<option value="0" <c:if test ="${reivew.reviewScore eq 0}">selected="selected"</c:if>>0</option>
									<option value="5" <c:if test ="${reivew.reviewScore eq 5}">selected="selected"</c:if>>5</option>
									<option value="4" <c:if test ="${reivew.reviewScore eq 4}">selected="selected"</c:if>>4</option>
									<option value="3" <c:if test ="${reivew.reviewScore eq 3}">selected="selected"</c:if>>3</option>
									<option value="2" <c:if test ="${reivew.reviewScore eq 2}">selected="selected"</c:if>>2</option>
									<option value="1" <c:if test ="${reivew.reviewScore eq 1}">selected="selected"</c:if>>1</option>
								</select>
							</div>

							<div id="imgArea">
								<span class="text">사진 등록</span>
								<div id="imgInput">
									<c:if test="${not empty review.reviewNewImage}">
										<img id="reviewImg" src="${pageContext.request.contextPath}/resources/reviewImg/${review.reviewNewImage}" width="200" height="250" >
									</c:if>
									<c:if test="${empty review.reviewNewImage || review.reviewNewImage == ''}">
										<img id="reviewImg" src="${pageContext.request.contextPath}/resources/img/noImage.jpg" width="200" height="250" >
									</c:if>
								</div>
							</div>

							<div id="contentArea">
								<p class="text">상품에 대한 평가를 남겨주세요.</p>
								<textarea name="reviewContent" id="reviewContent" cols="90" rows="10" style="resize: none;">${review.reviewContent}</textarea>
							</div>

							<div class="fileArea" id="fileArea">
								<!-- 첨부할 사진 추가 영역 -->
								<!-- (input:file#thumbnailImg[name=thumbnailImg onchange=loadImg(this, )])*4 -->
								<input type="file" name="upFile" id="upFile" onchange="loadImg(this,1);" multiple />
								
							</div>

							<div id="btnArea">
								<button type="submit" id="reviewBtn">리뷰 수정</button>
								<button type="button" id="reviewDelBtn" onclick="reviewDel(${review.reviewNo});">리뷰 삭제</button>
							</div>

						</form>

					</div>
				</div>
				

			</div>

		</div>
	
	
	<c:import url="../common/footer.jsp"/>
</body>

<script>
	// 사진 미리보기
	$(function(){
		$('#imgInput').click(function(){
			$('#upFile').click();
		});
	
		$('#fileArea').hide();
	})	
	
	function loadImg(img, num){
		if(img.files && img.files[0]) { // .files 추가한 파일이 있느냐
			
			var reader = new FileReader();
			
			var html = '<img id="reviewImg"  width="200" height="250" >';
	
			$('#imgBtn').replaceWith(html);
	
			reader.onload = function(e){
				
				switch(num){
				case 1 : $('#reviewImg').attr('src', e.target.result);
						break;
	
				}
			}
			
			reader.readAsDataURL(img.files[0]);
		}	
	}
	
	// 별점스크립트
	
	$('#starArea').children('i:eq(4)').click(
		function(){
		$('#star').val(5);
	
		var star = 5;
		for(var i = 0; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', '#d10024');
		}
		
	
	});
	
	$('#starArea').children('i:eq(3)').click(
		function(){
	
		$('#star').val(4);
	
		var star = 5;
		for(var i = 0; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', '#d10024');
		}
	
		for(var i = 4; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', 'rgb(84, 84, 107)');
		}
	
	});
	$('#starArea').children('i:eq(2)').click(
		function(){
	
		$('#star').val(3);
	
		var star = 5;
		for(var i = 0; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', '#d10024');
		}
	
		for(var i = 3; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', 'rgb(84, 84, 107)');
		}
	
	});
	
	$('#starArea').children('i:eq(1)').click(
		function(){
	
		$('#star').val(2);
	
		var star = 5;
		for(var i = 0; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', '#d10024');
		}
	
		for(var i = 2; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', 'rgb(84, 84, 107)');
		}
	
	});
	
	$('#starArea').children('i:eq(0)').click(
		function(){
	
		$('#star').val(1);
	
		var star = 5;
		for(var i = 0; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', '#d10024');
		}
	
		for(var i = 1; i < star; i++) {
			$('#starArea').children('i:eq('+i+')').css('color', 'rgb(84, 84, 107)');
		}
	
	});
	
	// 유효성 검사
	function validate(){
	
		var score = $('#star').val();
		var content = $("#reviewContent").val();
		
		if(score == 0){
			alert("별점을 등록해 주세요.");
			return false;
		} else if(content.trim().length==0) {
			alert("내용을 입력하세요");
			return false;
		}
	
		return true;
	}
	
	function reviewDel(reviewNo){
		if(confirm("삭제 시 복구할 수 없습니다. 삭제하시겠습니까?") == true){
			
			location.href="${pageContext.request.contextPath}/review/reviewDel.do?reviewNo=" + reviewNo;
		} else {
			return false;
		}
	}
	
</script>
</html>