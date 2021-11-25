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
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
    #stateContainer {
        display: flex;
        flex-wrap: wrap;
        width: 800px;
        margin-left: auto;
        margin-right: auto;
        margin-top: 30px;
        margin-bottom: 30px;
    }
    #order, #cancel, #question, #product {
        width: 345px;
        margin: 10px;
        border: 1px solid lightgray;
    }
    .stateTitles {
        padding: 5px 20px;
        border-bottom: 1px solid lightgray;
        background: linear-gradient( 45deg, #D10024 60%, rgb(255, 99, 99) );
        color: white;
    }
    .sellerInfoUl {
        -webkit-padding-start:0px;
        padding: 5px 20px;
    }
    li {
        display: flex;
        justify-content: space-between;
        padding: 5px 0px;
    }
	.stateTitleName {
        margin-top: 5px;
        margin-bottom: 0px;
        font-size: 18px;
        font-weight: 700;
    }
    .explainTitles {
        font-size: 11px;
        margin-bottom: 5px;
    }
    .titles {
        font-size: 13px;
    }
    strong {
        font-size: 13px;
    }
    #chartDiv {
        border: 1px solid lightgray;
        margin: 10px;
        width: 710px;
    }
    .sellerInfoAtag {
    	font-weight: 700;
    }

    </style>
</head>
<body>
<c:import url="../common/header.jsp"/>

<div id="stateContainer">
    <div id="order">
        <div class="stateTitles">
            <div class="stateTitleName">주문/배송 현황</div>
            <span class="explainTitles">최근 1개월 기준</span>
        </div>
        <ul class="sellerInfoUl">
            <li>
                <div class="titles">미확인 주문</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
            <li>
                <div class="titles">운송장 등록 대기</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
            <li>
                <div class="titles">운송장 등록 완료</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
            <li>
                <div class="titles">배송중</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
            <li>
                <div class="titles">발송 지연</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
        </ul>
    </div>

    <div id="cancel">
        <div class="stateTitles">
            <div class="stateTitleName">취소/환불/교환 현황</div>
            <span class="explainTitles">최근 1개월 기준</span>
        </div>
        <ul class="sellerInfoUl">
            <li>
                <div class="titles">취소 요청</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
            <li>
                <div class="titles">환불 요청</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
            <li>
                <div class="titles">교환 요청</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
        </ul>
    </div>

    <div id="question">
        <div class="stateTitles">
            <div class="stateTitleName">고객문의/리뷰 현황</div>
            <span class="explainTitles">&nbsp;</span>
        </div>
        <ul class="sellerInfoUl">
            <li>
                <div class="titles">고객 문의</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a> | <a href="" class="sellerInfoAtag">미답변 0 건</a></strong>
            </li>

            <li>
                <div class="titles">고객 리뷰</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
        </ul>
    </div>

    <div id="product">
        <div class="stateTitles">
            <div class="stateTitleName">판매상품 현황</div>
            <span class="explainTitles">&nbsp;</span>
        </div>
        <ul class="sellerInfoUl">
            <li>
                <div class="titles">판매 중 상품</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
            <li>
                <div class="titles">종료임박 상품</div>
                <strong><a href="" class="sellerInfoAtag">0 건</a></strong>
            </li>
        </ul>
    </div>
    <div id="chartDiv">
        <div class="stateTitles">
            <div class="stateTitleName">일일 매출 통계</div>
            <span class="explainTitles">당일 00시부터 조회 시간의 -1시 까지의 매출 통계입니다. (상품 주문 기준)</span>
            <br><span class="explainTitles"> : select sum(*) ... where sellerID = 로그인셀러 having 시간 별로 합산하여 dataset에 추가</span>
        </div> 
        <canvas id="chart"></canvas>
    </div>
</div>

<c:import url="../common/footer.jsp"/>

<script>
    // === include 'setup' then 'config' above ===
    
    var config = {
        type: 'line',
        data: {
        labels: ['00시', '01시', '02시', '03시', '04시', '05시', '06시', '07시', '08시', '09시', '10시', '11시', '12시', '13시', '14시', '15시', '16시', '17시', '18시', '19시', '20시', '21시', '22시', '23시'],
        datasets: [{
            label: '시간 별 매출액',
            data: [30000, 0, 120000, 250000, 2, 3],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',

            ],
            borderColor: [
                'rgba(255, 99, 132, 1)',

            ],
            pointBackgroundColor: [
                'rgba(255, 99, 132, 1)'
            ],
            borderWidth: 2,
            tension: 0.25
        }]
    },
        options: {}
    };

    var myChart = new Chart(
      document.getElementById('chart'),
      config
    );
    
</script>

</body>
</html>