
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

<title>DAPARA : 상품 상세보기</title>
 <link rel="icon" href="${pageContext.request.contextPath}/resources/img/logo.png" >

<!-- Google font -->
<link
   href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700"
   rel="stylesheet">

<!-- Bootstrap -->
<link type="text/css" rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />

<!-- Slick -->
<link type="text/css" rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/slick.css" />
<link type="text/css" rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/slick-theme.css" />

<!-- nouislider -->
<link type="text/css" rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/nouislider.min.css" />

<!-- Font Awesome Icon -->
<link rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">

<!-- Custom stlylesheet -->
<link type="text/css" rel="stylesheet"
   href="${pageContext.request.contextPath}/resources/css/product.css" />

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
      
      
      
     <style>
     



        #report { border-collapse:collapse; width:1150px, padding-right : 10px;}
        #report h4 { margin:0px; padding:0px;}
        #report th { background: rgb(237, 237, 240) repeat-x scroll center left; padding:7px 15px; text-align:left;}
        #report td { background:#white none repeat-x scroll center left; color:#000; padding:7px 15px; }
        #report tr.odd td { background:#fff url(row_bkg.png) repeat-x scroll center left; cursor:pointer; padding-right : 10px;}
        #report div.arrow { background:transparent  no-repeat scroll 0px 0x; width:0px; height:16px; display:block;}
        #report div.up { background-position:0px 0px;}
     
     
     
     </style>




<script src="https://kit.fontawesome.com/c10cbac54f.js"
   crossorigin="anonymous"></script>

</head>
<body>
   <c:import url="../common/header.jsp" />
   <!-- BREADCRUMB -->
   <div id="breadcrumb" class="section">
      <!-- container -->
      <div class="container">
         <!-- row -->
         <div class="row">
            <div class="col-md-12">
               <ul class="breadcrumb-tree">
                  <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                  <li><c:if test="${prod.categoryNo2 < 10}">
                        <a href="#">의류</a>
                     </c:if> <c:if test="${prod.categoryNo2 > 10}">
                        <a href="#">몰랑</a>
                     </c:if></li>
                  <li><c:if test="${prod.categoryNo2 == 1}">
                        <a href="#">탑</a>
                     </c:if> <c:if test="${prod.categoryNo2 == 2}">
                        <a href="#">니트웨어</a>
                     </c:if> <c:if test="${prod.categoryNo2 == 3}">
                        <a href="#">셔츠/자켓</a>
                     </c:if> <c:if test="${prod.categoryNo2 == 4}">
                        <a href="#">셔츠</a>
                     </c:if> <c:if test="${prod.categoryNo2 == 5}">
                        <a href="#">수트</a>
                     </c:if> <c:if test="${prod.categoryNo2 == 6}">
                        <a href="#">팬츠</a>
                     </c:if> <c:if test="${prod.categoryNo2 == 7}">
                        <a href="#">언더웨어</a>
                     </c:if> <c:if test="${prod.categoryNo2 == 8}">
                        <a href="#">비치웨어</a>
                     </c:if> <c:if test="${prod.categoryNo2 == 9}">
                        <a href="#">기능성의류</a>
                     </c:if></li>


                  <li class="active">${prod.productName}</li>
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
         <!-- row -->
         <div class="row">
            <!-- Product main img -->
            <div class="col-md-5 col-md-push-2">
               <div id="product-main-img">
                  <c:forEach var="item" items="${image}" varStatus="status">
                     <div class="product-preview">
                        <img
                           src="${pageContext.request.contextPath}/resources/productUpload/${item}">
                     </div>
                  </c:forEach>

               </div>
            </div>
            <!-- /Product main img -->

            <!-- Product thumb imgs -->
            <div class="col-md-2  col-md-pull-5">
               <div id="product-imgs">
                  <c:forEach var="item" items="${image}" varStatus="status">
                     <div class="product-preview">
                        <img
                           src="${pageContext.request.contextPath}/resources/productUpload/${item}">
                     </div>
                  </c:forEach>

               </div>
            </div>
            <!-- /Product thumb imgs -->

            <!-- Product details -->
            <div class="col-md-5">
               <div class="product-details"
                  style="height: 458px; display: flex; flex-direction: column; justify-content: space-between;">
                  <div>
                     <h2 class="product-name">${prod.productName}</h2>
                     <div>

                        <a ><i class="fas fa-star" style="color:#D10024"> ${prod.productScore }</i>&nbsp;&nbsp; ${rCount}개의 리뷰가 있습니다! </a>
                     </div>
                     <div>
                        <h3 class="product-price"> <fmt:formatNumber value="${prod.productPrice}" pattern="#,###"/>원
                           <del class="product-old-price"></del>
                        </h3>
                     </div>
                     <p>${prod.productInfo}</p>
                  </div>

                  <form id="order"
                     action="${pageContext.request.contextPath}/order/order.do"
                     method="post">
                     <div>
                        <div class="product-options">
                           <label> 사이즈 <select name="sizeName"
                              class="input-select" id="sizeName">
                                 <option value="XS">XS</option>
                                 <option value="S">S</option>
                                 <option value="M">M</option>
                                 <option value="L">L</option>
                                 <option value="XL">XL</option>
                           </select>
                           </label>

                           <div class="qty-label">
                              수량
                              <div class="input-number">
                                 <input name="cartAmount" type="number" value="1" id="prodqty">
                                 <span class="qty-up">+</span> <span class="qty-down">-</span>
                              </div>
                           </div>
                        </div>
                        <input type="hidden" name="userId" value="${member.userId}" /> <input
                           type="hidden" name="productNo" value="${prod.productNo}" /> <input
                           type="hidden" name="productBrand" value="${prod.productBrand}" />
                  </form>

                  <div class="add-to-cart">

                     <button onclick="addcartbtn();" type="button"
                        class="add-to-cart-btn" id="addcart">
                        <i class="fa fa-shopping-cart"></i> 장바구니에 담기
                     </button>
                     <button type="submit" class="add-to-cart-btn">
                        <i class="far fa-credit-card"></i></i></i></i>&nbsp;&nbsp;즉시
                        구매하기&nbsp;&nbsp;
                     </button>
                  </div>

                  <c:if test="${member eq null}">
                     <script>
                        function addcartbtn() {
                           alert("로그인 하셔야합니다.");
                        }
                     </script>
                  </c:if>
                  <c:if test="${member ne null}">

                     <script>
                        function addcartbtn() {

                           var params = {

                              userId : "${member.userId}",
                              productNo : "${prod.productNo}",
                              cartAmount : $("#prodqty").val(),
                              sizeName : $("#sizeName").val()
                           };

                           $.ajax({
                              url : "/dpr/addcart.do",
                              type : 'post',
                              data : params,
                              success : function(data) {

                                 if (data == '1') {
                                    alert("장바구니에 등록되었습니다.");
                                 } else {
                                    alert("장바구니 등록에 실패하였습니다..");
                                 }
                              },
                              error : function(code) {
                                 alert("장바구니 등록에 실패하였습니다..");
                              }
                           });

                        }
                     </script>
                  </c:if>




                  <ul class="product-links">
                     <li>카테고리 :</li>
                     <li><c:if test="${prod.categoryNo2 < 10}">
                           <label>의류</label>
                        </c:if></li>
                  </ul>

               </div>
            </div>
         </div>
         <!-- /Product details -->

         <!-- Product tab -->
         <div class="col-md-12">
            <div id="product-tab">
               <!-- product tab nav -->
               <ul class="tab-nav">
                  <li class="active"><a data-toggle="tab" href="#tab1">상품
                        상세정보</a></li>
                  <li><a data-toggle="tab" href="#tab2">문의</a></li>
                  <li><a data-toggle="tab" href="#tab3">리뷰(${rCount})</a></li>
               </ul>
               <!-- /product tab nav -->

               <!-- product tab content -->
               <div class="tab-content">
                  <!-- tab1  -->
                  <div id="tab1" class="tab-pane fade in active">
                     <div class="row">
                        <div class="col-md-12" style="text-align:center;">
                        <c:forEach var="detail" items="${detailImage}" varStatus="status">
                        <img src="${pageContext.request.contextPath}/resources/productUpload/${detail}"/>
                        </c:forEach>
                           <p>${prod.productContent}</p>
                        </div>
                     </div>
                  </div>
                  <!-- /tab1  -->

                  <!-- tab2  -->
                  <div id="tab2" class="tab-pane fade in">
                     <div class="row">
                        <div class="col-md-12">
                           <div class="tableArea" style="text-align: center;">

<table align="center" cellspacing="100"  id="report">
        <tr>
            
            <th width="80px" style="text-align: center; height: 40px;">아이디</th>
            <th width="980px" style="text-align: center;">제목</th>
            <th width="100px" style="text-align: center;">답변여부</th>
            <th width="100px" style="text-align: center;">작성일</th>
            <th ></th>
        </tr>
      
      
       <c:forEach var="qnaList" items="${qna}" varStatus="status">
        <tr style="border-bottom: 1px solid white;"">
           
            <td>${qnaList.userId}</td>
            <td>${qnaList.getQTitle()}</td>
            <td>${qnaList.getQStatus()}</td>
            <td>${qnaList.qdate}</td>
             <td><div class="arrow"></div></td>

        </tr>
        <tr>
            <td style="background-color:rgb(237, 237, 240); border-bottom: 1px solid black;"></td>
        
            <td style="background-color:rgb(237, 237, 240); border-bottom: 1px solid black; padding-top:7px; padding-bottom:7px;">                        
                ${ qnaList.getQContent()} <br /><br />
                <c:if test="${qnaList.getQStatus() == 'Y'}">
                <h5>답변내용</h5>
                <span>${qnaList.getCContent() }</span>
                
                </c:if>
            </td>
            <td style="background-color:rgb(237, 237, 240);border-bottom: 1px solid black;"></td>
            <td style="background-color:rgb(237, 237, 240);border-bottom: 1px solid black;"></td>
            <td style="background-color:rgb(237, 237, 240);border-bottom: 1px solid black;"></td>
            
        </tr>
        </c:forEach>
   
                              <br />
                              <br />
                              
                              <form name="qnaFrom" action="qnaInsert.do" method="post" >
                              
                              <table cellspacing="100" id="listArea" align="center"
                                 style="width: max-content; margin-top:100px;">

                                 <tr>
                                 <td width="80px"> </td>
                                 <td width="1060px"; colspan='2'; style ="text-align:left" >
                                  <input name="qTitle" type="text" placeholder="제목을 입력해 주세요"; style ="width:950px; height:30px; margin-left:15px; outline:none"/>
                                 </td>
                                 
                                 </tr>
                                 
                                   <tr>
                                    <td width="80px"   style="text-align: left; font-weight: 700;">${member.userId}</td>
                                    <td width="980px" style="text-align: center">
                                    <input name="qContent" type="text" style="width: 950px; height: 75px; border-width: 1px;  border-color: #b8b8b8; border-top:none; outline:none;"/>
                                   
                                    <input type="hidden" name="userId" value="${member.userId}";    />
                                    <input type="hidden" name="productNo" value="${prod.productNo}";    />                                    
                                    </td>
                                    <td width="80px"
                                       style="text-align: center; font-size: 15px;">
                                
                                       <button type ="submit";   style="height: 50px; border-width: 1px; border-radius: 5px; border-color: #b8b8b8; ">문의하기</button>
                                     </td>

                                 </tr>
                              </table>
                              
                              </form>
                              
                           </div>
                        </div>
                     </div>
                  </div>
                  <!-- /tab2  -->

                  <!-- tab3  -->
                  <div id="tab3" class="tab-pane fade in">
                     <div class="row">

                        <!-- Reviews -->
                        <div class="col-md-6">
                           <div class="tableArea" style="text-align: center;">
                              <table cellspacing="100" id="listArea" align="center" style="width: max-content;">
                                 <thead>
                                    <tr>
                                       <th width="80px" style="text-align: center;">작성자</th>
                                       <th width="200px" style="text-align: center;">사진</th>

                                       <th width="782px" style="text-align: center;">내용</th>
                                       
                                       <th width= "100px">별점</th>

                                       <th width="80px" style="text-align: center;">작성일</th>

                                    </tr>
                                 </thead>
                                 <tbody align="center">
                                    <c:forEach var="rev" items="${review}" varStatus="status">
                                       <tr>
                                          <td style="height: 150px; border-top: solid; border-color: rgb(237, 237, 240);">${rev.userId}</td>
                                          <td style="height: 225px; border-top: solid; border-color: rgb(237, 237, 240);"> 
                                          
                                          
                                          <c:if test="${not empty rev.reviewNewImage}">
                              <img id="reviewImg" src="${pageContext.request.contextPath}/resources/reviewImg/${rev.reviewNewImage}" width="180" height="190" >
                           </c:if>
                           <c:if test="${empty rev.reviewNewImage || rev.reviewNewImage == ''}">
                              <img id="reviewImg" src="${pageContext.request.contextPath}/resources/img/noImage.jpg" width="180" height="190" >
                           </c:if>
                                          
                                          
                                          </td>
                                          <td style="border-top: solid; border-color: rgb(237, 237, 240); text-align: left; padding-left: 20px;">${rev.reviewContent}</td>
                                          <td style="border-top: solid; border-color: rgb(237, 237, 240); padding-right:65px"><i class="fas fa-star" style="color:#D10024"></i>${rev.reviewScore }</td>
                                          <td style="border-top: solid; border-color: rgb(237, 237, 240);">${rev.reviewDate}</td>

                                       </tr>
                                    </c:forEach>

                                    <tr>
                                       <td style="border-top: solid; border-color: rgb(237, 237, 240);"></td>
                                       <td style="border-top: solid; border-color: rgb(237, 237, 240);"></td>
                                       <td style="border-top: solid; border-color: rgb(237, 237, 240);"></td>
                                       <td style="border-top: solid; border-color: rgb(237, 237, 240);"></td>         
                                       <td style="border-top: solid; border-color: rgb(237, 237, 240);"></td>

                                    </tr>


                                 </tbody>
                              </table>
                           </div>
                        </div>
                        <!-- /Reviews -->


                     </div>
                  </div>
                  <!-- /tab3  -->
               </div>
               <!-- /product tab content  -->
            </div>
         </div>
         <!-- /product tab -->
      </div>
      <!-- /row -->
   </div>
   <!-- /container -->
   </div>
   <!-- /SECTION -->


   <!-- Section -->
   <div class="section">
      <!-- container -->
      <div class="container">
         <!-- row -->
         <div class="row">

            <div class="col-md-12">
               <div class="section-title text-center">
                  <h3 class="title">이런 상품들은 어떠신가요?</h3>
               </div>
            </div>

            <!-- product -->
            <c:forEach var="random" items="${random}" varStatus="status">
               <div class="col-md-3 col-xs-6">
                  <div class="product">
                     <div class="product-img">
                        <img src="${pageContext.request.contextPath}/resources/productUpload/${rImg[status.index]}">

                     </div>
                     <div class="product-body">
                        <p class="product-category">의류</p>
                        <h3 class="product-name">
                           <a>${random.productName}</a>
                        </h3>
                        <h4 class="product-price"><fmt:formatNumber value="${random.productPrice}" pattern="#,###"/>원</h4>


                     </div>
                     <div class="add-to-cart">
                        <button class="add-to-cart-btn">
                           <i class="fas fa-arrow-left"></i><a
                              href="<%=request.getContextPath()%>/prod_detail.do?prodNo=${random.productNo}"><span style="font-weight:bolder">보러가기</span>
                        </button>
                     </div>
                  </div>
               </div>
               <!-- /product -->

            </c:forEach>


         </div>
         <!-- /row -->
      </div>
      <!-- /container -->
   </div>
   <!-- /Section -->


   <c:import url="../common/footer.jsp" />



</body>


<script>
    $(document).ready(function(){

        $("#report tr:odd").addClass("odd");
        $("#report tr:not(.odd)").hide(); 
        $("#report tr:first-child").show(); //열머리글 보여주기

        $("#report tr.odd").click(function(){
            $(this).next("tr").toggle();
            $(this).find(".arrow").toggleClass("up");

        });
       

    });

</script>





<!-- jQuery Plugins -->
<script
   src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script
   src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script
   src="${pageContext.request.contextPath}/resources/js/slick.min.js"></script>
<script
   src="${pageContext.request.contextPath}/resources/js/nouislider.min.js"></script>
<script
   src="${pageContext.request.contextPath}/resources/js/jquery.zoom.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>



</html>



