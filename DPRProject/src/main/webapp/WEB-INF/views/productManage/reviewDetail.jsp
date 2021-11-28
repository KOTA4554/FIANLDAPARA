<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰상세 : DAPARA</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >

<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/myPage.css"/>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/reviewForm.css"/>

</head>

<style>

#reviewList {
  color: white;
  background-color: #d10024;
  border: none;
  width: 100px;
  height: 40px;
  font-size: 13pt;
  border-radius: 3px;
}

</style>
<body>

	<c:import url="../common/header.jsp"/>
	
	<!-- myPage 리뷰작성 -->
		<div id=myPage>

			<div class="container">
				
	
					<div id="reviewArea">
						
						<div id="reviewTitle">
							<h3>리뷰 상세</h3>
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

							<input type="hidden" name="reviewNo" value="${ review.reviewNo }">
							<input type="hidden" name="userId" value="${ member.userId }">
							<div id="starArea">
								<span class="text">별점</span>
								<i class="fas fa-star" style="color: #d10024;"></i>
								<span>${ review.reviewScore }</span>
							</div>

							<div id="imgArea">
								<span class="text">리뷰 사진</span>
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
								<p class="text">상품 평가.</p>
								<textarea name="reviewContent" id="reviewContent" cols="90" rows="10" style="resize: none; outLine: none;" readonly>${review.reviewContent}</textarea>
							</div>

							<div id="btnArea">
								<button type="button" id="reviewList" onclick="reviewList();">목록</button>
							</div>

					</div>
				</div>
				

			</div>

		</div>
	
	
	<c:import url="../common/footer.jsp"/>
</body>

<script>
	
	function reviewList(){
		location.href="${pageContext.request.contextPath}/seller/reviewList.do";
	}
	

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