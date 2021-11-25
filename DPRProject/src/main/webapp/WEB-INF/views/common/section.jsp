<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/jeongho.css"/>
</head>

<body>
<section>
<script>


$(function(){
    $.ajax({ // 컨트롤러와 통신
        type: 'POST',
        url: "/dpr/main.do",
        contentType: "application/json; charset=UTF-8",
        async: false,
        success: function(data) {
            // $('.products-slick').slick('unslick');
            console.log(data);
            result = "";
            for(var i in data){
                var product = data[i];
                result //+= '<div class="products-slick" data-nav="#slick-nav-' + i + '">'
                    += '<div class="product">'
                    +'<input type="hidden" name="productNo" ></input>'
                    + '<div class="product-img">'
                    + '<img  src="${pageContext.request.contextPath}/resources/productUpload/' + product.productNewImage + '" alt="logo" class = "" width=230 height=240>'
                    + '<div class="product-label">'
                    + '<span class="new">NEW</span>'
                    + '</div></div>'
                    + '<div class="product-body">'
                    + '<p class="product-category">' + product.productBrand + '</p>'
                    + '<h3 class="product-name"><a href="<%=request.getContextPath()%>/prod_detail.do?prodNo='+product.productNo +'">' + product.productName + '</a></h3>'
                    + '<h4 class="product-price">' + product.productPrice + '</h4>'
                    + '<div class="product-rating"></div>'
                    + '<div class="product-btns"></div></div>'
                    + '<div class="add-to-cart">'
                    // + '</div></div></div>'
                    + '</div></div>'
            }
            $('.products-slick').html(result);
            
            $('.products-slick').each(function() {
               
                var $this = $(this),
                    $nav = $this.attr('data-nav');
        
                $this.slick({
                    slidesToShow: 4,
                    slidesToScroll: 1,
                    autoplay: true,
                    infinite: true,
                    speed: 300,
                    dots: false,
                    arrows: true,
                    appendArrows: $nav ? $nav : false,
                    responsive: [{
                    breakpoint: 991,
                    settings: {
                      slidesToShow: 2,
                      slidesToScroll: 1,
                    }
                  },
                  {
                    breakpoint: 480,
                    settings: {
                      slidesToShow: 1,
                      slidesToScroll: 1,
                    }
                  },
                ]
                });
            });
        
            // Products Widget Slick
            $('.products-widget-slick').each(function() {
                var $this = $(this),
                        $nav = $this.attr('data-nav');
        
                $this.slick({
                    infinite: true,
                    autoplay: true,
                    speed: 300,
                    dots: false,
                    arrows: true,
                    appendArrows: $nav ? $nav : false,
                });
            });
            $('.products-slick').slick('refresh');
            
        },
        error: function(error) {
            alert("오류");
            console.log(error);
        },
    });
 });

   $(function(){
         $.ajax({ // 컨트롤러와 통신
             type: 'POST',
             url: "/dpr/top.do",
             contentType: "application/json; charset=UTF-8",
             async: false,
             success: function(data) {
                 // $('.products-slick').slick('unslick');
                 console.log(data);
                 result = "";
                 for(var i in data){
                     var product = data[i];
                     result //+= '<div class="products-slick" data-nav="#slick-nav-' + i + '">'
                  +='<div class ="first">'
                   +'<div class = "productimg">'
                   + '<img  src="${pageContext.request.contextPath}/resources/productUpload/' + product.productNewImage + '" alt="logo" class = "" width=230 height=240>'
                     +'</div>'
                 +'<input type="hidden" name="productNo" value="${row.productNo }">'
                 +'<div class="productinfo"></div>'
                 +'<div class="productcategory">'
                 +'<p>' + product.productBrand + '</p>'
                 +'</div>'
                 +'<div class="productname">'
                 +'<p style="font-weight:bold;" class="productname"><a href="<%=request.getContextPath()%>/prod_detail.do?prodNo='+product.productNo +'">' + product.productName + '</a></p>'                  
                 +'</div>'
                 +'<div class="productprice">'
                 +'<p  name="productPrice" value="${product.productPrice }" >'+ product.productPrice +' </p>'
                 +'</div>'
                 +'<br>'
                 +'<br>'
                 +'</div>'
                 }
                 $('.firstPar').html(result); 
                 

                 
             },
             error: function(error) {
                 alert("오류");
                 console.log(error);
             },
         });
      });
   

   

      
      </script>
      

      <!-- SECTION -->
      <div class="section">
         <!-- container -->
         <div class="container">
            <!-- row -->
            <div class="row">

               <!-- section title -->
               <div class="col-md-12">
                  <div class="section-title">
                     <h3 class="title">최근 뜨고있는 신상품</h3>
                     <div class="section-nav">
                     </div>
                  </div>
               </div>
               <!-- /section title -->

               <!-- Products tab & slick -->
               <div class="col-md-12">
                  <div class="row">
                     <div class="products-tabs">
                        <!-- tab -->
                        <div id="tab1" class="tab-pane active">
                           <div class="products-slick" data-nav="#slick-nav-1">
                           
                           
                              <!-- product -->
                              
                           
                              <div class="product">
                                 <div class="product-img">
                                    <img src="resources/img/product01.png" alt="">
                                    <div class="product-label">
                              
                                       <span class="new">NEW</span>
                                    </div>
                                 </div>
                                 <div class="product-body">
                                    <p class="product-category" name="productBrand" id="productBrand" value="${product.Brand }">'${product.Brand}'</p>
                                    <h3 class="product-name" name="productName" id="productName" value="${row.productName}" required>'${row.productName}'</h3>
                                    <h4 class="product-price" name="productPrice" value="${product.productPrice }" >'${row.productPrice }' </h4>
                                    <div class="product-rating">
                                       
                                    </div>
                                    <div class="product-btns">
                                       
                                    </div>
                                 </div>
                                 <div class="add-to-cart">

                                 </div>
                              </div>
                              <!-- /product -->

                              
                              <!-- /product -->
                              <!-- forEach -->
                              
                              
                           </div>
                           <div id="slick-nav-1" class="products-slick-nav"></div>
                        </div>
                        <!-- /tab -->
                     </div>
                  </div>
               </div>
               <!-- Products tab & slick -->
            </div>
            <!-- /row -->
         </div>
         <!-- /container -->
      </div>
      <!-- /SECTION -->

      <!-- HOT DEAL SECTION -->
      <div id="hot-deal" class="section">
         <!-- container -->
         <div class="container">
            <!-- row -->
            <div class="row">
               <div class="col-md-12">
                  <div class="hot-deal">
                     <ul class="hot-deal-countdown">
                        <li>
                           <div>
                              <h3>02</h3>
                              <span>Days</span>
                           </div>
                        </li>
                        <li>
                           <div>
                              <h3>10</h3>
                              <span>Hours</span>
                           </div>
                        </li>
                        <li>
                           <div>
                              <h3>34</h3>
                              <span>Mins</span>
                           </div>
                        </li>
                        <li>
                           <div>
                              <h3>60</h3>
                              <span>Secs</span>
                           </div>
                        </li>
                     </ul>
                     <h2 class="text-uppercase">이번 주 HOT 딜</h2>
                     <p>최대 50% 할인 해택</p>
                     <a class="primary-btn cta-btn" href="#"> 구매 </a>
                  </div>
               </div>
            </div>
            <!-- /row -->
         </div>
         <!-- /container -->
      </div>
      <!-- /HOT DEAL SECTION -->

      <div class="container">
   
    <!--div{$번째 영역}*3-->
    <div class="title">
    <h3>TOP 4 상품</h3>    
    </div>
    
    <div class="firstPar">
   
   
    
        <div class ="first">
            <div class = "productimg">
            <img  src=".." alt="logo" class = "">
            </div>
            <input type="hidden" name="productNo" value="${row.productNo }">
            
            <div class="productinfo"></div>
                <div class="productcategory">
                <p id="productBrand" value="${row.productBrand}">'${row.productBrand }'</p>
            </div>
            <div class="productname">
                <p  name="productName" id="productName" value="${row.productName}" required>'${row.productName}'</p>
                                    
            </div>
            <div class="productprice">
               <p  name="productPrice" value="${product.productPrice }" >'${row.productPrice }' </p>
            </div>

            <br>
            <br>
        </div>
        
    
        <div class ="first">
            <div class = "productimg">
            <img  src=".." alt="logo" class = "">
            </div>
            <input type="hidden" name="productNo" value="${row.productNo }">
            
            <div class="productinfo"></div>
                <div class="productcategory">
                 <p id="productBrand" value="${row.productBrand}">'${row.productBrand }'</p>
            </div>
            <div class="productname">
                <p  name="productName" id="productName" value="${row.productName}" required>'${row.productName}'</p>
                                    
            </div>
            <div class="productprice">
               <p  name="productPrice" value="${product.productPrice }" >'${row.productPrice }' </p>
            </div>

            <br>
            <br>
        </div>
        
        <div class ="first">
            <div class = "productimg">
            <img  src=".." alt="logo" class = "">
            </div>
            <input type="hidden" name="productNo" value="${row.productNo }">
            
            <div class="productinfo"></div>
                <div class="productcategory">
                 <p id="productBrand" value="${row.productBrand}">'${row.productBrand }'</p>
            </div>
            <div class="productname">
                <p  name="productName" id="productName" value="${row.productName}" required>'${row.productName}'</p>
                                    
            </div>
            <div class="productprice">
               <p  name="productPrice" value="${product.productPrice }" >'${row.productPrice }' </p>
            </div>

            <br>
            <br>
        </div>
        

        <div class ="first">
            <div class = "productimg">
            <img  src=".." alt="logo" class = "">
            </div>
            <input type="hidden" name="productNo" value="${row.productNo }">
            
            <div class="productinfo"></div>
                <div class="productcategory">
                 <p id="productBrand" value="${row.productBrand}">'${row.productBrand }'</p>
            </div>
            <div class="productname">
                <p  name="productName" id="productName" value="${row.productName}" required>'${row.productName}'</p>
                                    
            </div>
            <div class="productprice">
               <p  name="productPrice" value="${product.productPrice }" >'${row.productPrice }' </p>
            </div>

            <br>
            <br>
        </div>
        
     
        </div>
      
        
    </div>
      </section>
      <!-- jQuery Plugins -->
      <script src="resources/js/jquery.min.js"></script>
      <script src="resources/js/bootstrap.min.js"></script>
      <script src="resources/js/slick.min.js"></script>
      <script src="resources/js/nouislider.min.js"></script>
      <script src="resources/js/jquery.zoom.min.js"></script>
      <script src="resources/js/main.js"></script>
</body>
</html>