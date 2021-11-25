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
	<form action="${pageContext.request.contextPath}/seller/searchProd.do" method="get">
		<table border="0">
			<tr>
				<th colspan="4" class="sectionTitles">검색 조건 설정</th>
			</tr>
		    <tr>
		        <th>상품명</th>
		        <td><input type="text" name="searchNm" id="searchProdName"></td>
		        <th>카테고리</th>
			        <td>
			        <div id="categorySelects">
		                    <select name="searchCate1" id="categoryNo" class="cateSelector">
		                        <option value="999">대분류</option>
		                        <option value="0">의류</option>
		                        <option value="1">슈즈</option>
		                        <option value="2">가방</option>
		                        <option value="3">액세서리</option>
		                        <option value="4">주얼리</option>
		                    </select>
		                    <select name="searchCate2" id="categoryNo2" class="cateSelector">
		                    	<option value="999">소분류</option>
		                        <option value="1">탑</option>
		                        <option value="2">니트웨어</option>
		                        <option value="3">셔츠/자켓</option>
		                        <option value="4">셔츠</option>
		                        <option value="5">수트</option>
		                        <option value="6">팬츠</option>
		                        <option value="7">언더웨어</option>
		                        <option value="8">비치웨어</option>
		                        <option value="9">기능성의류</option>
		                    </select>
		                </div>
			        </td>
		    </tr>
		    <tr>
		        <th>판매기간</th>
		        <td><input type="text" class="datepicker" name="startDate" id="startDate" placeholder="판매 시작일">
		        	<span style="display: inline-block; margin: 0px 25px;"> ~ </span> 
		        	<input type="text" class="datepicker" name="endDate" id="endDate" placeholder="판매 종료일"></td>
		        <th>판매상태</th>
		        <td>
		            <select name="saleState" id="searchProdState">
		            	<option value="999">선택</option>
		                <option value="1">판매대기</option>
		                <option value="2">판매중</option>
		                <option value="3">판매종료</option>
		            </select>
		        </td>
		    </tr>
		    <tr>
		        <th>브랜드</th>
		        <td><input type="text" name="searchBrand" id="searchProdBrand"></td>
		        <th>상품번호</th>
		        <td>
		        	<input type="text" name="searchPno" id="searchProdNo" />
		        </td>
		    </tr>
		</table>
		<div class="searchBtnSection">
			<button id="searchBtn">검색</button>
		</div>
	</form>
	
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
		
			<canvas id="productSaleRate" width="1100" height="400"></canvas>	
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
	var config = {
        type: 'line',
        data: {
        labels: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월'],
        datasets: [{
            label: '월 별 매출액(만원)',
            data: [700, 600, 900, 1200, 700, 800, 1700, 2200, 1800, 1500, 2000],
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
        	responsive: false
        }
   	};


    var myChart = new Chart(
      document.getElementById('myChart'),
      config
    );
	
 	// product SaleRate
	var config1 = {
        type: 'line',
        data: {
        labels: ['구찌후드티', '프라다니트','자라블레이저','톰브라운셔츠','구찌슬렉스','루이비통팬츠','캘빈클라임팬티'],
        datasets: [{
            label: '상품 별 총 매출액(만원)',
            data: [100, 470, 300, 430, 700, 210, 45],
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
            data: [30, 45, 100, 20, 10, 23, 75],
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
                y: {
                  stacked: true
                }
              }
        }
   	};


    var productSaleRate = new Chart(
      document.getElementById('productSaleRate'),
      config1
    );
    
 	// productStar Rate
	var config1 = {
        type: 'bar',
        data: {
        labels: ['구찌후드티', '프라다니트','자라블레이저','톰브라운셔츠'],
        datasets: [{
            label: '상품 평점 TOP4',
            data: [4.8, 4.7, 4.5, 4.0, 3.9],
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
                y: {
                  stacked: true
                }
              }
        }
   	};


    var productStar = new Chart(
      document.getElementById('productStar'),
      config1
    );
    
 // productStar Rate
	var config1 = {
        type: 'doughnut',
        data: {
        labels: ['남성','여성'],
        datasets: [{
            label: '구매자 성비',
            data: [40, 60],
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