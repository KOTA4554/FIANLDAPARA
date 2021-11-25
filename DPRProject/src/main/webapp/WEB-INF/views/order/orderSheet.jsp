<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="com.kh.dpr.product.model.vo.*, java.util.*" %>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문서 작성 : DAPARA</title>
	
	<!-- css -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/orderPage.css"/>
	
	<!-- kako Postcode -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	
	<!-- iamport.payment.js -->
	<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.8.js"></script>

</head>
<body>
	<c:import url="../common/header.jsp"/>
	
	<!-- 주문 페이지 -->
	<div id="order-section">
		
		<form class="container" id="orderForm" action="" method="post">

			<div id="section-header">
				<h3 id="orderTitle">
					주문서 작성
				</h3>
				<div id="pageNav">
					<i class="fas fa-shopping-cart"></i>
					<label>장바구니</label>
					<i class="fas fa-chevron-right"></i>
					<i class="fas fa-clipboard-list"></i>
					<label>주문서 작성</label>
					<i class="fas fa-chevron-right"></i>
					<i class="fas fa-check-circle"></i>
					<label>주문완료</label>
				</div>
			</div>

			<div id="orderInfo">
				<div class="infoHead">
					<h4>주문자 정보</h4>
				</div>

				<table id="infoTable">
					<tr>
						<td>이름 <p>*</p></td>
						<td>
							<input type="text" name="userId" id="userId" value="${member.userId}" hidden />
							<input id="userName" name="userName" type="text" value="${member.userName}">
							<!-- ${ user.getUserName } -->
						</td>
					</tr>
					<tr>
						<td>이메일 <p>*</p></td>
						<td><input id="userEmail" name="userEmail" type="text" value="${member.userEmail}"></td>
							<!-- ${ user.getUserEmail } -->
					</tr>
					<tr>
						<td>휴대폰 <p>*</p></td>
						<td>
							<input type="tel" name="userPhone" class="phoneNumber" id="userPhone" value="${member.userPhone}">
							<!-- ${ user.getUserPhone } -->
						</td>
					</tr>
				</table>
			</div>

			<br>

			<div id="deliveryInfo">
				<div class="infoHead">
					<h4>배송 정보</h4>
				</div>

				<table id="deliveryTable">
					<tr>
						<td>배송지 선택</td>
						<td>
							<input type="radio" name="addr" id="userAddr" checked="checked"> <label for="userAddr" style="padding-right: 10px;">주문자 정보와 동일</label>
							<input type="radio" name="addr" id="newAddr"> <label for="newAddr">새로운 주소</label>
						</td>
					</tr>
					<tr>
						<td>이름 <p>*</p></td>
						<td>
							<input type="text" value="" name="orderReceiver" id="orderReceiver">
						</td>
					</tr>
					<tr>
						<td>휴대폰 <p>*</p></td>
						<td>
							<input type="tel" name="orderPhone" class="phoneNumber" id="orderPhone" value="">
						</td>
					</tr>
					<tr>
						<td >주소 <p>*</p></td>
						<td>
							<input type="text" size="6" id="postNo" name="orderAddress" placeholder="우편번호" readonly>
							<button type="button" id="postNoBtn" onclick="searchPostNo();">우편번호 찾기</button>
						</td>
						
					</tr>
					<tr>
						<td></td>
						<td>
							<input type="text" id="addr1" name="orderAddress" placeholder="주소" readonly>
							<input type="text" id="addr2" name="orderAddress" placeholder="상세 주소">
							<!-- <input type="text" name="orderAddress" id="orderAddress" vlaue="" /> -->
						</td>

					</tr>
					<tr>
						<td>배송 요청사항</td>
						<td>
							<select name="orderRequest" id="orderRequest">
								<option value="선택 안함">선택 안함</option>
								<option value="배송시 연락주세요.">배송시 연락주세요.</option>
								<option value="부재시 문 앞에 놔주세요.">부재시 문 앞에 놔주세요.</option>
								<option value="부재시 경비실에 놔주세요.">부재시 경비실에 놔주세요.</option>
								<option value="부재시 택배함에 넣어주세요.">부재시 택배함에 넣어주세요.</option>
								<option value="직접 입력">직접 입력</option>
							</select>
							
							<input type="text" name="orderRequest" id="directInput" value="" />
						</td>
					</tr>
					
					<script>
						$('#orderRequest').change(function(){
							if($(this).val() == "직접 입력"){
								$('#direcInput').show();
							} else {
								$('#direcInput').hide();
							}
						});
					</script>
				</table>

			</div>

			<br>

			<div id="payInfo">
				<div class="infoHead">
					<h4>결제</h4>
				</div>

				<table id="payTable">
					<tr>
						<th colspan="2" style="width: 350px;">상품정보</th>
						<th>수량</th>
						<th>가격</th>
						<th>배송비</th>
					</tr>
					
					<c:forEach var="product" items="${productList}" varStatus = "status">
						<tr>
							<td rowspan="3" id="productImage">
								<img src="${pageContext.request.contextPath}/resources/productUpload/${productImgList[status.index]}" width="120" height="120" alt="상품이미지">
							</td><!-- ${ getProductImage } -->
							<td style="padding-left: 5px; width:500px;">
								<input type="text" name="productNo" value="${product.productNo}" hidden/>
								<!-- ${ getProductNo } -->
								<input type="text" name="productBrand" id ="productBrand" value="${product.productBrand}" size="50" readonly/>
								<!-- ${ getSellerCompany } -->
							</td>
							<td rowspan="3" align="center">
								<input type="text" name="detailAmount" value="${detailAmountList[status.index]}" size="3" readonly/>
								<!-- ${ productAmount } -->
							</td>
							<td rowspan="3" align="center">
								<input type="text" name="detailPrice" value="${detailPriceList[status.index]}" size="15" readonly/>
								<!-- ${ detailPrice } -->
							</td>
							<td rowspan="3" align="center">무료</td>
						</tr>
						<tr>
							<td style="padding-left: 5px; width:500px;">
								<input type="text" name="productName" value="${product.productName}" size="50"  readonly/>
								<!-- ${ getProductName } -->
							</td>
						</tr>
						<tr>
							<td style="padding-left: 5px; width:500px;">
								옵션 : <input type="text" name="detailSize" value="${detailSizeList[status.index]}" size="50"  readonly/>
								<!-- ${ detailSize } -->
							</td>
						</tr>
					</c:forEach>
				</table>

				<table id="billTable">
					<tr>
						<th>총 주문 금액</th>
						<th></th>
						<th style="width: 200px;">배송비</th>
						<th></th>
						<th>최종 결제 금액</th>
					</tr>
					<tr>
						<td><label id="orderPrice">${totalPrice}</label> 원</td> <!-- ${ detailPrice } -->
						<td><i class="fas fa-plus"></i></td>
						<td><label id="delCharge">0</label> 원</td>
						<td><i class="fas fa-equals"></i></td>
						<td><label id="totalPrice">${totalPrice + 0}</label> <span>원</span></td> <!-- ${ orderPrice + delCharge } -->
					</tr>
				</table>
			</div>

			<div id="order-footer">
				<div id="payMethod">
					<div id="payMethod-head">
						<h4>결제 수단 선택</h4>
					</div>

					<div id="payMethod-section">
						<input type="radio" name="payment" id="noBankbook" hidden/>
						<p id="noBankbookLabel">무통장입금</p>

						<input type="radio" name="payment" id="creditCard" hidden/>
						<p id="creditCardLabel">신용카드</p>
					</div>
				</div>

				<div id="agreement">
					<div id="checkArea">

						<div id="agrHead">
							<h4>주문자 동의</h4>
						</div>
	
						<div class="agr" onclick="showAgr1();">
								<p>전자금융거래 이용약관에 동의합니다.</p>
								<i class="fas fa-sort-down"></i>
							</div>
							
							<div class="agrContentList">
								<pre id="agrContent1">
제1조 (목적) 
이 약관은 주식회사 케이지이니시스(이하 '회사'라 합니다)가 제공하는 전자지급결제대행서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다. 

제2조 (용어의 정의)
① 이 약관에서 정하는 용어의 정의는 다음 각 호와 같습니다. 

1. '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스(이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다. 

2. '전자지급수단'이라 함은 전자자금이체, 직불전자지급수단, 선불전자지급수단, 전자화폐, 신용카드, 전자채권 그 밖에 전자적 방법에 따른 지급 수단을 말한다.

3. '전자지급결제대행서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.

4. '결제대금예치서비스'라 함은 '이용자'가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제대금'이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등'이라 합니다)을 공급받기 전에 미리 지급하는 경우, '회사'가 '이용자'의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다. 

5. '이용자'라 함은 이 약관에 동의하고 '회사'가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.

6. '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 '이용자' 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, '회사'에 등록된 '이용자'번호, '이용자'의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호 에서 정하고 있는 것을 말합니다.

7. '거래지시'라 함은 '이용자'가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 '회사'에 대하여 전자금융거래의 처리를 지시하는 것을 말합니다. 

8. '오류'라 함은 '이용자'의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 '이용자'의 거래지시에 따라 이행되지 아니한 경우를 말합니다.

9. '정보통신망'이라 함은 전기통신설비를 이용하거나 전기통신설비와 컴퓨터 및 컴퓨터의 이용기술을 활용하여 정보를 수집•가공•검색•송신 또는 수신하는 정보통신체제를 말한다. 
② 본 조 및 본 약관의 다른 조항에서 정의한 것을 제외하고는 전자금융거래법등 관계 법령에 따릅니다. 

제3조 (약관의 명시 및 변경)
① 회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.
② 회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다. 
③ 회사가 약관을 변경하는 때에는 그 시행일 1개월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.

제4조 (전자지급결제대행서비스의 종류)
회사가 제공하는 전자지급결제대행서비스는 지급결제수단에 따라 다음과 같이 구별됩니다. 
1. 신용카드결제대행서비스: 이용자가 결제대금의 지급을 위하여 제공한 지급결제수단이 신용카드인 경우로서, 회사가 전자결제시스템을 통하여 신용카드 지불정보를 송,수신하고 결제대금의 정산을 대행하거나 매개하는 서비스를 말합니다. 
2. 계좌이체대행서비스: 이용자가 결제대금을 회사의 전자결제시스템을 통하여 금융기관에 등록한 자신의 계좌에서 출금하여 원하는 계좌로 이체할 수 있는 실시간 송금 서비스를 말합니다. 
3. 가상계좌서비스: 이용자가 결제대금을 현금으로 결제하고자 경우 회사의 전자결제시스템을 통하여 자동으로 이용자만의 고유한 일회용 계좌의 발급을 통하여 결제대금의 지급이 이루어지는 서비스를 말합니다. 
4. 기타: 회사가 제공하는 서비스로서 지급결제수단의 종류에 따라 '휴대폰 결제대행서비스', 'ARS결제대행서비스', '상품권결제대행서비스'등이 있습니다.

제5조 (결제대금예치서비스의 내용)
① 이용자(이용자의 동의가 있는 경우에는 재화 등을 공급받을 자를 포함합니다. 이하 본조에서 같습니다)는 재화 등을 공급받은 사실을 재화 등을 공급받은 날부터 3영업일 이내에 회사에 통보하여야 합니다.
② 회사는 이용자로부터 재화 등을 공급받은 사실을 통보받은 후 회사와 통신판매업자간 사이에서 정한 기일 내에 통신판매업자에게 결제대금을 지급합니다.
③ 회사는 이용자가 재화 등을 공급받은 날부터 3영업일이 지나도록 정당한 사유의 제시없이 그 공급받은 사실을 회사에 통보하지 아니하는 경우에는 이용자의 동의없이 통신판매업자에게 결제대금을 지급할 수 있습니다.
④ 회사는 통신판매업자에게 결제대금을 지급하기 전에 이용자에게 결제대금을 환급받을 사유가 발생한 경우에는 그 결제대금을 소비자에게 환급합니다.
⑤ 회사는 이용자와의 결제대금예치서비스 이용과 관련된 구체적인 권리,의무를 정하기 위하여 본 약관과는 별도로 결제대금예치서비스이용약관을 제정할 수 있습니다. 

제6조 (이용시간)
① 회사는 이용자에게 연중무휴 1일 24시간 전자금융거래 서비스를 제공함을 원칙으로 합니다. 단, 금융기관 기타 결제수단 발행업자의 사정에 따라 달리 정할 수 있습니다. 
② 회사는 정보통신설비의 보수, 점검 기타 기술상의 필요나 금융기관 기타 결제수단 발행업자의 사정에 의하여 서비스 중단이 불가피한 경우, 서비스 중단 3일 전까지 게시가능한 전자적 수단을 통하여 서비스 중단 사실을 게시한 후 서비스를 일시 중단할 수 있습니다. 다만, 시스템 장애복구, 긴급한 프로그램 보수, 외부요인 등 
불가피한 경우에는 사전 게시없이 서비스를 중단할 수 있습니다.

제7조 (접근매체의 선정과 사용 및 관리)
① 회사는 전자금융거래 서비스 제공 시 접근매체를 선정하여 이용자의 신원, 권한 및 거래지시의 내용 등을 확인할 수 있습니다. 
② 이용자는 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공할 수 없습니다.
③ 이용자는 자신의 접근매체를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며, 접근매체의 도용이나 위조 또는 변조를 방지하기 위하여 충분한 주의를 기울여야 합니다. 
④ 회사는 이용자로부터 접근매체의 분실이나 도난 등의 통지를 받은 때에는 그 때부터 제3자가 그 접근매체를 사용함으로 인하여 이용자에게 발생한 손해를 배상할 책임이 있습니다.

제8조 (거래내용의 확인)
① 회사는 이용자와 미리 약정한 전자적 방법을 통하여 이용자의 거래내용(이용자의 '오류정정 요구사실 및 처리결과에 관한 사항'을 포함합니다)을 확인할 수 있도록 하며, 이용자의 요청이 있는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송 등의 방법으로 거래내용에 관한 서면을 교부합니다.
② 회사가 이용자에게 제공하는 거래내용 중 거래계좌의 명칭 또는 번호, 거래의 종류 및 금액, 거래상대방을 나타내는 정보, 거래일자, 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보와 해당 전자금융거래와 관련한 전자적 장치의 접속기록은 5년간, 건당 거래금액이 1만원 이하인 소액 전자금융거래에 관한 기록, 
전자지급수단 이용시 거래승인에 관한 기록, 이용자의 오류정정 요구사실 및 처리결과에 관한 사항은 1년간의 기간을 대상으로 한다.
③ 이용자가 제1항에서 정한 서면교부를 요청하고자 할 경우 다음의 주소 및 전화번호로 요청할 수 있습니다. 
주소: 463-400 경기도 성남시 분당구 대왕판교로 660 유스페이스A동 5층 (주)케이지이니시스 
이메일 주소: sm@inicis.com
전화번호: 1588-4954

제9조 (오류의 정정 등) 
① 이용자는 전자금융거래 서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대하여 그 정정을 요구할 수 있습니다. 
② 회사는 전항의 규정에 따른 오류의 정정요구를 받은 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받은 날부터 2주 이내에 그 결과를 이용자에게 알려 드립니다. 

제10조 (회사의 책임)
① '회사'는 다음 각 호의 사유 발생으로 인하여 '이용자'에게 손해가 발생하였을 경우 이에 대한 배상책임이 있습니다. 
1. 접근매체의 위조나 변조로 발생한 사고
2. 계약체결 또는 거래지시의 전자적 전송이나 처리 과정에서 발생한 사고
3. 전자금융거래를 위한 전자적 장치 또는 ‘정보통신망’에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한 사고
② 본 조 제1항에도 불구하고 다음 각 호의 사유로 발생한 사고에 대해선, 그 책임의 전부 또는 일부를 '이용자'가 부담합니다. 
1. 법인('중소기업기본법' 제2조 제2항에 의한 소기업을 제외합니다)인 '이용자'에게 손해가 발생한 경우로서 '회사'가 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한 경우
2. '이용자'가 제7조 제2항을 위반하여 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공한 경우
3. 제3자가 권한 없이 '이용자'의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 알 수 있었음에도 불구하고 '이용자'가 자신의 접근매체를 누설 또는 노출하거나 방치한 경우
4. 제7조 제1항의 따른 확인 외에 보안강화를 위하여 전자금융거래 시 '회사'가 요구하는 추가적인 보안조치를 요구하였음에도 불구하고 '이용자'가 정당한 사유 없이 이를 거부하여 '회사'의 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 사고가 발생한 경우
5. 이용자가 제3호에 따른 추가적인 보안조치에 사용되는 접근매체에 대하여 다음 각 목의 어느 하나에 해당하는 행위를 하여 '회사'의 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 사고가 발생한 경우
가. 누설•노출 또는 방치한 행위
나. 제3자에게 대여하거나 그 사용을 위임한 행위 또는 양도나 담보의 목적으로 제공한 행위

제11조 (전자지급거래계약의 효력)
① 회사는 이용자의 거래지시가 전자지급거래에 관한 경우 그 지급절차를 대행하며, 전자지급거래에 관한 거래지시의 내용을 전송하여 지급이 이루어지도록 합니다. 
② 회사는 이용자의 전자지급거래에 관한 거래지시에 따라 지급거래가 이루어지지 않은 경우 수령한 자금을 이용자에게 반환하여야 합니다.

제12조 (거래지시의 철회)
① 이용자는 전자지급거래에 관한 거래지시의 경우 지급의 효력이 발생하기 전까지 거래지시를 철회할 수 있습니다. 
② 전항의 지급의 효력 발생 시점은 다음 각 호의 사유를 말합니다. 
1. 전자자금이체의 경우에는 거래 지시된 금액의 정보에 대하여 수취인의 계좌가 개설되어 있는 금융기관의 계좌이체 원장에 입금기록이 끝난 때
2. 그 밖의 전자지급수단으로 지급하는 경우에는 거래 지시된 금액의 정보가 수취인의 계좌가 개설되어 있는 금융기관의 전자적 장치에 입력이 끝난 때
③ 이용자는 지급의 효력이 발생한 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령상 청약의 철회의 방법 또는 본 약관 제5조에서 정한 바에 따라 결제대금을 반환받을 수 있습니다.

제13조 (전자지급결제대행 서비스 이용 기록의 생성 및 보존)
① 회사는 이용자가 전자금융거래의 내용을 추적, 검색하거나 그 내용에 오류가 발생한 경우에 이를 확인하거나 정정할 수 있는 기록을 생성하여 보존합니다.
② 전항의 규정에 따라 회사가 보존하여야 하는 기록의 종류 및 보존방법은 제8조 제2항에서 정한 바에 따릅니다. 

제14조 (전자금융거래정보의 제공금지)
회사는 전자금융거래 서비스를 제공함에 있어서 취득한 이용자의 인적사항, 이용자의 계좌, 접근매체 및 전자금융거래의 내용과 실적에 관한 정보 또는 자료를 이용자의 동의를 얻지 아니하고 제3자에게 제공,누설하거나 업무상 목적 외에 사용하지 아니합니다. 다만, 「금융실명거래 및 비밀보장에 관한 법률」 제4조제1항 단서의 규정에 따른 경우 및 그 밖에 다른 법률에서 정하는 바에 따른 경우에는 그러하지 아니하다.

제15조 (분쟁처리 및 분쟁조정)
① 이용자는 다음의 분쟁처리 책임자 및 담당자에 대하여 전자금융거래 서비스 이용과 관련한 의견 및 불만의 제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다. 
담당자: RM팀
연락처(전화번호, FAX): 3430-5847, 3430-5889
E-mail : inirm@inicis.com
② 이용자가 회사에 대하여 분쟁처리를 신청한 경우에는 회사는 15일 이내에 이에 대한 조사 또는 처리 결과를 이용자에게 안내합니다. 
③ 이용자는 '금융감독기구의 설치 등에 관한 법률' 제51조의 규정에 따른 금융감독원의 금융분쟁조정위원회나 '소비자보호법' 제31조 제1항의 규정에 따른 소비자보호원에 회사의 전자금융거래 서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다.

제16조 (회사의 안정성 확보 의무)
회사는 전자금융거래의 안전성과 신뢰성을 확보할 수 있도록 전자금융거래의 종류별로 전자적 전송이나 처리를 위한 인력, 시설, 전자적 장치 등의 정보기술부문 및 전자금융업무에 관하여 금융감독위원회가 정하는 기준을 준수합니다.

제17조 (약관외 준칙 및 관할)
① 이 약관에서 정하지 아니한 사항에 대하여는 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다.
② 회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다. 
부칙 (2010년 4월 12일)
최초 시행일자 : 2007년 1월 1일
변경 공고일자 : 2018년 2월 23일
변경 시행일자 : 2018년 3월 26일
								</pre>
							</div>
		
							<div class="agr"  onclick="showAgr2();">
							<p>개인정보 이용 및 수집에 동의합니다.</p>
							<i class="fas fa-sort-down"></i>
						</div>

						<div class="agrContentList">
							<pre id="agrContent2">
								DAPARA는 고객님께서 구매하실 상품의 원활한 제공을 위해 아래와 같이 개인정보를 수집.이용합니다. 
								고객님께서는 개인정보 수집.이용에 동의하지 않을 수 있으며 동의하지 않으실 경우 구매가 제한됩니다.
								
								<table class="agrContentTable">
									<colgroup>
										<col width="*" />
										<col width="60" />
										<col width="*" />
									</colgroup>
									<tr>
										<th class="join-table-interval mi-font-basic c_gray3 mi-bg-gray verti_t" style="text-align:center!important">수집 및 이용목적</th>
										<th class="join-table-interval mi-font-basic c_gray3 mi-bg-gray verti_t" style="text-align:center!important">유형</th>
										<th class="join-table-interval mi-font-basic c_gray3 mi-bg-gray verti_t" style="text-align:center!important">항목</th>
									</tr>
									<tr>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">상품 및 경품 배송(반품/환불), 배송지 및 연락처 확인</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">필수</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">주문자명, 수령자명, 이메일, 휴대폰번호, 배송지주소</td>
									</tr>
										<tr> 
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">본인인증을 통한 본인확인(첫 구매시 1회 실행), 연령, 성별 서비스 제공</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">필수</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">DI(중복가입 확인 정보), 생년월일, 성별</td>
									</tr>
										<tr> 
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">대금결제 서비스, 구매취소 등에 따른 거래금액 환불</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">필수</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">신용카드정보, 은행계좌정보(계좌번호, 예금주, 은행명), 결제수단 정보</td>
									</tr>
									<tr> 
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">해외 직배송 상품 구매 시 통관을 위해 이용</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">필수</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">개인고유통관부호</td>
									</tr>
									<tr> 
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">현금영수증 발급 선택 시 발급에 이용</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">선택</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">현금영수증카드번호, 휴대전화번호</td>
									</tr>
									<tr> 
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">입력했을 시</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">선택</td>
										<td class="join-table-interval mi-font-basic c_gray8 mi-text-interval-basic">일반 전화번호</td>
									</tr>
								</table>
							</pre>
						</div>
	
						<div id="agrCheck">
							<div id="allCheck">
								<input type="checkbox" id="all">
								<label for="all">모든 내용을 확인하였으며 전체 동의합니다.</label>
							</div>
	
							<div class="check">
								<input type="checkbox" name="agrCheck" id="check1"> 
								<label for="check1">전자금융거래 이용약관 동의</label>
							</div>
	
							<div class="check">
								<input type="checkbox" name="agrCheck" id="check2"> 
								<label for="check2">개인정보 제 3자 제공 동의</label>
							</div>
	
							<div class="check">
								<input type="checkbox" name="agrCheck" id="check3"> 
								<label for="check3">구매 내역 확인 및 결제 진행 동의</label>
							</div>
						</div>
					</div>
					
					<div id="btnArea">
						<button id="payBtn" type="button" onclick="pay();">400,000 원 결제하기</button><!-- ${ totalPrice } -->
					</div>
				</div>

			</div>

		</form>

	</div>
	
	<c:import url="../common/footer.jsp"/>
</body>
	<!-- script -->
	<script>
		
		// 전화번호 하이픈 처리
		$(document).on("keyup", ".phoneNumber", function() {
			$(this).val( $(this).val().replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-") );
			});
	
		// user 주소 분할
		var userAddr = '${member.userAddress}'.split(' / ');
		
		// 수령인 정보
		var orderReceiver = '${member.userName}';
		var orderPhone = '${member.userPhone}';
		var postNo = userAddr[0];
		var addr1 = userAddr[1];
		var addr2 = userAddr[2];
		var orderAddress = postNo + '/' + addr1 + '/' + addr2;
		
		if($('#userAddr').is(":checked")) {	
			$('#orderReceiver').val(orderReceiver);
			$('#orderPhone').val(orderPhone);
			$('#postNo').val(postNo);
			$('#addr1').val(addr1);
			$('#addr2').val(addr2);
			$('#orderAddress').val(orderAddress);
		}
		
		$('#userAddr').click(function(){
			if($('#userAddr').is(":checked")) {
				$('#orderReceiver').val(orderReceiver);
				$('#orderPhone').val(orderPhone);
				$('#postNo').val(postNo);
				$('#addr1').val(addr1);
				$('#addr2').val(addr2);
				//$('#orderAddress').val(orderAddress);
			}	
		})
		
		$('#newAddr').click(function(){			
			if($('#newAddr').is(":checked")){
				$('#orderReceiver').val('');
				$('#orderPhone').val('');
				$('#postNo').val('');
				$('#addr1').val('');
				$('#addr2').val('');
				//$('#orderAddress').val('');
			}
		})
		
	
		// 우편 번호 찾기
		function searchPostNo() {
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

	                   $('#postNo').val(data.zonecode); 
	                   $('#addr1').val(fullAddr);
	                   $("#orderAddress").val(data.zonecode + " / " + fullAddr + " / ");
	                   $('#addr2').focus();
	               }
	          }).open();          

		}
		
		// 결제 수단 선택
		$('#noBankbookLabel').click(function(){
			if($('#noBankbook').is(":checked")) {
				$(this).css("border", "1px solid lightgray");
				$("#noBankbook").prop("checked", false);
			} else {
				$(this).css("border", "2px solid #D10024");
				$("#noBankbook").prop("checked", true);
				$('#creditCardLabel').css("border", "1px solid lightgray");
			}
		});

		$('#creditCardLabel').click(function(){
			if($('#creditCard').is(":checked")) {
				$(this).css("border", "1px solid lightgray");
				$("#creditCard").prop("checked", false);
			} else {
				$(this).css("border", "2px solid #D10024");
				$('#noBankbookLabel').css("border", "1px solid lightgray");
				$("#creditCard").prop("checked", true);
			}
		});

		// 약관 show, hide
		function showAgr1() {
			if($('#agrContent1').css("display") == "none") {
				$('#agrContent1').show();
			} else {
				$('#agrContent1').hide();
			}
		}

		function showAgr2() {
			if($('#agrContent2').css("display") == "none") {
				$('#agrContent2').show();
			} else {
				$('#agrContent2').hide();
			}
		}

		// 약관 전체 체크
		$('#all').click(function(){

			if($(this).is(":checked")) {
				$("input[name=agrCheck]").prop("checked", true);
			} else {
				$("input[name=agrCheck]").prop("checked", false);
			}
		});

		$("input[name=agrCheck]").click(function() {
			var total = $("input[name=agrCheck]").length;
			var checked = $("input[name=agrCheck]:checked").length;

			if(total != checked) $("#all").prop("checked", false);
			else $("#all").prop("checked", true); 
		});

		// Submit
		function pay() {

			// 주문 정보 체크
			if(!$('#userName').val() || !$('#userEmail').val() || !$('#userPhone').val()) {
				alert("주문자 정보를 입력해 주세요.");

				return false;
			}

			if(!$('#orderReceiver').val() || !$('#orderPhone').val() || !$('#postNo').val() ||
			   !$('#addr1').val() || !$('#addr2').val()) {
				alert("배송지 정보를 입력해 주세요.");

				return false;
			}

			if(!$('#noBankbook').is(":checked") && !$('#creditCard').is(":checked")) {
				alert("결제 수단을 선택해 주세요.");

				return false;
			}

			if(!$('#all').is(":checked")) {
				alert("약관 동의 후 결제 해주세요.");

				return false;
			}

			// 결제API (신용카드 선택)
 			/*if($('#creditCard').is(":checked")){
				
				var IMP = window.IMP; // 생략가능
				IMP.init( 'imp59581083' );
				
				IMP.request_pay({
					pg : 'html5_inicis',
					pay_method : 'card', // card : 신용카드 , vbank : 가상계좌
					merchant_uid : 'merchant_' + new Date().getTime(),
					name : '${totalName}', // productName
					amount : 100, //$('#totalPrice').val(),
					buyer_email : '${member.userEmail}', // ${ getUserEmail }.val(),
					buyer_name : '${member.userName}', 				// ${ getUserName }.val(),
					buyer_tel : '${member.userPhone}',		// ${ getUserPhone }.val(),
					buyer_addr : addr1 + addr2,		// ${ getUserAddress }.val(),
					buyer_postcode : postNo
				}, function(rsp) {
					if (rsp.success) {
						$('#orderForm').attr("action", "${pageContext.request.contextPath}/order/orderByCreditCard.do");
						$('#orderForm').submit();
					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;
						
						alert(msg);
					}
	
				});
			}else if($('#noBankbook').is(":checked")){ // 결제API(무통장입금 선택)

				var IMP = window.IMP; // 생략가능
				IMP.init( 'imp59581083' );
				
				IMP.request_pay({
					pg : 'html5_inicis',
					pay_method : 'vbank', // card : 신용카드 , vbank : 가상계좌
					merchant_uid : 'merchant_' + new Date().getTime(),
					name : 'DAPARA 상품 결제', // productName
					amount : 100, //$('#totalPrice').val(),
					buyer_email : '${member.userEmail}', // ${ getUserEmail }.val(),
					buyer_name : '${member.userName}',	// ${ getUserName }.val(),
					buyer_tel : '${member.userPhone}',		// ${ getUserPhone }.val(),
					buyer_addr : '서울시 강남구 역삼동',		// ${ getUserAddress }.val(),
					buyer_postcode : '01234'
				}, function(rsp) {
					if (rsp.success) {
						
						var vbankNum = rsp.vbank_num;
						var vbankName = rsp.vbank_name;
						var vbankHolder = rsp.vbank_holder;
						var vbankDate = rsp.vbank_date;
						
						console.log(vbankNum);
						console.log(vbankName);
						 						
						//$.ajax({
							//url : "${pageContext.request.contextPath}/order/orderByNoBankbook.do",
							//type : 'POST';,
							//data : { vbankNum, vbankName, vbankHolder, vbankDate }
						//});
						
						//$('#orderForm').attr("action", "${pageContext.request.contextPath}/order/orderByNoBankbook.do");
						//$('#orderForm').submit();
					} else {
						var msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;
						
						alert(msg);
					}
	
				}); 
			}*/
			
 			$('#orderForm').attr("action", "${pageContext.request.contextPath}/order/orderByCreditCard.do");
			$('#orderForm').submit();
		}

	</script>	
</html>