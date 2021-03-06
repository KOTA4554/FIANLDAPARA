<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>통계 : DAPARA</title>
<link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >

<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.min.js"></script>


<style>
.mainSectionForm {
    width: 1100px;
    margin-left: auto;
    margin-right: auto;
    margin-top: 30px;
    margin-bottom: 30px;
}
.pageBarSection {
	display:flex;
    justify-content: center;
}
.mainSectionForm table {
 	width: 100%;
}
.sectionTitles {
	padding: 10px 20px;
	border-bottom: 1px solid lightgray;
    background: linear-gradient( 45deg, #D10024 60%, rgb(255, 99, 99) );
    color: white;
    font-size: 18px;
}

.stateTitles {
    padding: 5px 20px;
    border-bottom: 1px solid lightgray;
    background: linear-gradient( 45deg, #D10024 60%, rgb(255, 99, 99) );
    color: white;
}

.stateTitleName {
       margin-top: 5px;
       margin-bottom: 0px;
       font-size: 18px;
       font-weight: 700;
}
tr>th:not(.sectionTitles, .optionTh){
	text-align: center;
	padding: 15px 20px;
}
table input[type="text"], select, input[type="number"] {
	height: 30px;
	border-radius: 0px;
	border: 1px solid #E4E7ED;
	padding: 0px 5px;	
}
#searchProdName {
	width: 500px;
}
#searchProdBrand {
	width: 500px;
}
.searchBtnSection {
	border-top: 1px solid lightgray;
	height: 60px;
	margin: 20px 0px;
}
#searchBtn {
	float: right;
	margin: 20px 0px;
	padding: 8px 18px;
	border-radius: 0px;
	border: 1px solid lightgray;
}
.datepicker {
	text-align: center;
}
#categorySelects {
	display: flex;
	justify-content: space-between;
}
.cateSelector {
	width: 130px;
}
#searchProdState, #searchProdNo {
	width: 100%;
}
#prodListTable td {
	padding: 10px 10px;
}
#prodListTable {
	font-size: 12px;
}
#prodListTitle {
	font-size: 13px;
	text-align: center;
	font-weight: bold;
}
#prodListTitle > td {
	padding: 10px;
}
.explainTitles {
	font-size: 13px;
	font-weight: 500;
}
li {
    display: flex;
    justify-content: space-between;
    padding: 5px 0px;
}
.prodListRows {
	border-bottom: 1px dotted lightgray;
	margin-bottom: 5px;
}
.prodRowPno {
	text-align:center;
	width: 85px;
}
.prodRowImg { width: 90px; }
.prodRowBrand {	width: 160px; }
.prodRowName { width: 275px; }
.prodRowPrice { width: 100px; text-align: center; }
.prodRowStart, .prodRowEnd { width: 100px; text-align:center; }
.prodRowOptionCnt { width: 70px; text-align:center; }

.chart{
	margin :50px 0;
}

</style>

</head>
<body>
<c:import url="../common/header.jsp"/>	
<div class="mainSectionForm">
	
	
	<div class="charArea">
		<!--차트가 그려질 부분-->
		<div class=chart>
			<div class="stateTitles">
	            <div class="stateTitleName">월별 매출액</div>
	        </div>
				<canvas id="myChart" width="1100" height="500"></canvas>
		</div>
		
		<div class=chart>
			<div class="stateTitles">
					<div class="stateTitleName">상품 별 총 매출액, 총 판매량</div>
			</div>
		
			<canvas id="productSaleRate" width="1100" height="500"></canvas>	
		</div>
		
		<div class=chart id="charArea2" style="display:flex; justify-content: space-between;">
		
			<div>
				<div class="stateTitles">
						<div class="stateTitleName">상품 평점 TOP4</div>
				</div>
				<canvas id="productStar" width="500" height="500"></canvas>	
			</div>
			
			<div>
				<div class="stateTitles">
						<div class="stateTitleName">구매자 성비</div>
				</div>
				<canvas id="genderRate" width="500" height="500"></canvas>	
			</div>
		</div>
		
	</div>
	
</div>

<script>

	//datepicker 사용
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
	
	// Chart.js
	
	// monthly sales revenue
	var month = new Array();
	var monRev = new Array();
	
	<c:forEach var="monthRevenue" items="${monthRevenue}">
		month.push("${monthRevenue.month}");
		monRev.push("${monthRevenue.revenue}");
	</c:forEach>
	
	var config = {
        type: 'line',
        data: {
        labels: month,
        datasets: [{
            label: '월 별 매출액',
            data: monRev,
            backgroundColor: [
                'rgba(13, 126, 206, 0.2)'

            ],
            borderColor: [
                'rgba(13, 126, 206, 1)'

            ],
            pointBackgroundColor: [
                'rgba(13, 126, 206, 1)'
            ],
            borderWidth: 2,
            tension: 0.25
        	}]
    	},
    	 options: {
         	responsive: false,
             scales: {
             	yAxes: [{
                     display: true,
                     ticks: {
                         suggestedMin: 0,    // minimum will be 0, unless there is a lower value.
                         // OR //
                         //beginAtZero: true   // minimum value will be 0.
                     }
                 }]
               }
         }
   	};


    var myChart = new Chart(
      document.getElementById('myChart'),
      config
    );
	
 	// product SaleRate
 	
 	// 상품별 총 매출액, 판매량, 상품명
 	var productNameList = new Array();
 	var productSaleAmount = new Array();
 	var productRevenueList = new Array();
 	
 	<c:forEach var="prodName" items="${productNameList}" varStatus="status">
 		productNameList.push("${prodName}");
 	</c:forEach>
	
 	<c:forEach var="prodAmount" items="${productSaleAmount}">
 		productSaleAmount.push("${prodAmount}");
 	</c:forEach>
 	
 	<c:forEach var="prodRevenue" items="${productRevenueList}">
 		productRevenueList.push("${prodRevenue}");
	</c:forEach>
 	
	var config1 = {
        type: 'line',
        data: {
        labels: productNameList,
        datasets: [{
            label: '상품 별 총 매출액(만원)',
            data: productRevenueList,
            backgroundColor: [
                'rgba(255, 135, 36, 0)'

            ],
            borderColor: [
                'rgba(255, 135, 36, 1)'

            ],
            pointBackgroundColor: [
                'rgba(255, 99, 132, 1)'
            ],
            borderWidth: 2,
            tension: 0.25
        	}, {
            label: '상품 별 총 판매량',
            data: productSaleAmount,
            backgroundColor: [
                'rgba(28, 197, 79, 0.8)'

            ],
            borderColor: [
                'rgba(28, 197, 79, 1)'

            ],
            pointBackgroundColor: [
                'rgba(255, 99, 132, 1)'
            ],
            type: 'bar',
            borderWidth: 2,
            tension: 0.25
        	}]
    	},
    	 options: {
         	responsive: false,
             scales: {
             	yAxes: [{
                     display: true,
                     ticks: {
                         suggestedMin: 0,    // minimum will be 0, unless there is a lower value.
                         // OR //
                         //beginAtZero: true   // minimum value will be 0.
                     }
                 }]
               }
         }
   	};


    var productSaleRate = new Chart(
      document.getElementById('productSaleRate'),
      config1
    );
    
 	// productStar Rate
 	
 	// top4 상품
 	var top4Name = new Array();
 	var top4Score = new Array();
 	
 	<c:forEach var="top4" items="${top4List}" varStatus="status">
		top4Name.push("${top4.productName}");
		top4Score.push("${top4.productScore}");
	</c:forEach>
 	console.log(top4Name);
 	console.log(top4Score);
 	
	var config1 = {
        type: 'bar',
        data: {
        labels: top4Name,
        datasets: [{
            label: '상품 평점 TOP4',
            data: top4Score,
            backgroundColor: [
                'rgba(191, 5, 0, 0.6)'

            ],
            borderColor: [
                'rgba(191, 5, 0, 1)'

            ],
            pointBackgroundColor: [
                'rgba(191, 5, 0, 1)'
            ],
            borderWidth: 2,
            tension: 0.25
        	}]
    	},
        options: {
        	responsive: false,
            scales: {
            	yAxes: [{
                    display: true,
                    ticks: {
                        suggestedMin: 0,    // minimum will be 0, unless there is a lower value.
                        // OR //
                        //beginAtZero: true   // minimum value will be 0.
                    }
                }]
              }
        }
   	};


    var productStar = new Chart(
      document.getElementById('productStar'),
      config1
    );
    
 	// Gender Rate
 	
 	// 남여 인원수
 	
 	var maleRate = '${userMan}';
 	var femaleRate = '${userWoman}';
 	
	var config1 = {
        type: 'doughnut',
        data: {
        labels: ['남성','여성'],
        datasets: [{
            label: '구매자 성비',
            data: [maleRate, femaleRate],
            backgroundColor: [
                'rgba(4, 160, 196, 0.6)', 'rgba(255, 148, 0, 0.6)' 

            ],
            borderColor: [
            	'rgba(4, 160, 196, 1)', 'rgba(255, 148, 0, 1)'

            ],
            pointBackgroundColor: [
            	'rgba(4, 160, 196, 1)', 'rgba(255, 148, 0, 1)'
            ],
            borderWidth: 2,
            tension: 0.25
        	}]
    	},
        options: {
        	responsive: false,
            scales: {
                y: {
                  stacked: true
                }
              }
        }
   	};


    var genderRate = new Chart(
      document.getElementById('genderRate'),
      config1
    );
    
</script>

<c:import url="../common/footer.jsp"/>
</body>
</html>