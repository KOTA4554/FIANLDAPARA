<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>DAPARA : 장바구니</title>
    <script src="https://kit.fontawesome.com/c10cbac54f.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">
  
    
       <!-- Google font -->
       <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet">

       <!-- Bootstrap -->
       <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}resources/css/bootstrap.min.css"/>

    



    <style>

        

#order-section {
  padding: 30px 0;
}

#section-header {
  height: 50px;
}

#orderTitle {
  float: left;
}

#pageNav {
  float: right;
}

#pageNav label {
  font-weight: normal;
}

.fa-chevron-right {
  padding: 0 5px;
}

#th {

border-top: solid;
text-align: center;


}

#CIP{
    text-align: center; 
   
    border-top: solid;
    border-color: rgb(237, 237, 240);
   
    height: 100px;

    

}


#TII{
width: 100px;
height: 100px;
margin-bottom: 10px;
}

#brand{
font-size: 19px;
padding-left: 20px;

}

#prodname{
font-size: 20px;
padding-left: 20px;
}

#size{
font-size: 15px;
padding-left: 20px;

}

#sizebtn{
    background-color:white; 
    border-radius: 5px; 
    border : 1px solid rgb(237, 237, 240);
    height: 25px; 
    width: 75px;
    font-weight: lighter;
   
}

#rth{

    color: rgb(182, 179, 179);

}

#ftd{
    border-top: 3px solid rgb(237, 237, 240);

}



.input-number {
  position: relative;

}

.input-number input[type="number"]::-webkit-inner-spin-button, .input-number input[type="number"]::-webkit-outer-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

.input-number input[type="number"] {
  -moz-appearance: textfield;
  height: 40px;
  width: 100px;
  border: 1px solid #E4E7ED;
  background-color: #FFF;
  padding: 0px 35px 0px 15px;

}

.input-number .up, .input-number .down {
  position: absolute;
  display: block;
  width: 20px;
  height:  20px;
  border: 1px solid #E4E7ED;
  background-color: #FFF;
  text-align: center;
  font-weight: 700;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  
 
}

.input-number .up {
  right: 0;
  top: 0;
  border-bottom: 0px;
}

.input-number .down {
  right: 0;
  bottom: 0;
  padding-bottom: 2px;
  
}

.input-number .up:hover, .input-number .down:hover {
  background-color: #E4E7ED;
  color: #D10024;
}




    </style>
</head>
<body>
   <c:import url="../common/header.jsp"/>
    <div style="padding-left: 20%; padding-top: 42px; padding-right: 20%;">
        <div id="section-header" ">
            <h2 id="orderTitle">
                <i class="fas fa-shopping-cart"></i>
                장바구니(${count})
            </h2>

            <div id="pageNav" style="padding-top: 50px;">
                <i class="fas fa-shopping-cart" style="  color: #d10024;"></i>
                <label style="  color: #d10024;">장바구니</label>
                <i class="fas fa-chevron-right"></i>
                <i class="fas fa-clipboard-list"></i>
                <label>주문서 작성</label>
                <i class="fas fa-chevron-right"></i>
                <i class="fas fa-check-circle"></i>
                <label>주문완료</label>
            </div>
        </div>
        
    <br><br>
<table cellspacing="0" style="display:flex">

<th id="th" style="width: 75px; height: 50px;"><input type="checkbox" name="Y"></i></th>
<th id="th" colspan="2" style="width: 1500px;">상품정보</th>
<th id="th" style="width: 100px; ">수량</th>
<th id="th" style="width: 300px; text-align:right; padding-right : 25px;">가격</th>
<th id="th" style="width: 100px; text-align: left;">배송비</th>
</tr>

<c:forEach var="cart" items="${cart}" varStatus="status">
<tr>
<td id="CIP" style="height: 150px;"><input type="checkbox" name="Y"> </td>
<td id="CIP" style="padding-left: 10px; padding-right: 10px; padding-top: 10px;" > <img id="TII" src="${pageContext.request.contextPath}/resources/productUpload/${image[status.index]}"> </td>
<td id="CIP" style="width: 1000px; text-align: left; padding-right: 40px;" > <label id="brand" >${cartProduct[status.index].productBrand}</label><br> <label id="prodname">${cartProduct[status.index].productName}</label>
<br> <label id="size">사이즈 : ${cart.sizeName} <br></label> <button id="sizebtn">옵션변경</button> </td>
<td id="CIP" >  <div class="input-number"> 
  <input id="pdn" type="hidden" value="${cart.productNo}"/>
  <input id="pri" type="hidden" value ="${cartProduct[status.index].productPrice}" />
  <input type="hidden" id="total" value = "${total}" />
    <input id="amount" type="number" readonly value="${cart.cartAmount}" style="outline:none;" >
    <span class="up">+</span>
  
    <span  class="down">-</span>
</div></td>
<td id="CIP"><input class="PRICE" readonly type="text" value="${cartProduct[status.index].productPrice*cart.cartAmount}" style="text-align:right; border-style:none; outline:none;" />원</td>
<td id="CIP" style="text-align: left;">무료</td>
</tr>
</c:forEach>

<script>

$('.up').click(function(){
   
   
   var productNoVal =$(this).parent().find('#pdn').val();
   var amount = parseInt($(this).parent().find('#amount').val());
   var amountNo = $(this).parent().find('#amount');
   var dprice = $(this).parent().find('#pri').val();
   var price = $(this).parent().parent().parent().find('.PRICE');
    var total =  $("#email").val();
    var totalp =  $("#email");

   var params ={
         
         userId : "${member.userId}",
         productNo : productNoVal
         
   };
   
   
   $.ajax({
       url : "/dpr/changeAmountP.do",
       type: 'post',
       data : params,
       success : function(data) {
          
       if (data == '1') {
          
          amount += 1;
          dprice *= amount;
          total = dprice + total;
      
          
          console.log(amount)
          
          price.val(dprice);
           amountNo.val(amount);
            totalp.val(total);
          
          } else {
         console.log("실패")
          }
       }, error : function( code ) {
            console.log("오류")
       }
    });
   })



$('.down').click(function(){


   var productNoVal =$(this).parent().find('#pdn').val();
   var amount = parseInt($(this).parent().find('#amount').val());
   var amountNo = $(this).parent().find('#amount');
   var dprice = $(this).parent().find('#pri').val();
   var price = $(this).parent().parent().parent().find('.PRICE');

   
    var params ={
         
         userId : "${member.userId}",
         productNo : productNoVal
         
   };
   
   
   
    $.ajax({
       url : "/dpr/changeAmountM.do",
       type: 'post',
       data : params,
       success : function(data) {
          
       if (data == '1') {
          
          amount -= 1;
          dprice *= amount;
      
          
          console.log(amount)
          
          price.val(dprice);
           amountNo.val(amount);
      
          } else {
         console.log("실패")
          }
       }, error : function( code ) {
           console.log("오류")
       }
    });
   })

</script>

    
    <tr>

        <td id="ftd"></td>
        <td id="ftd"></td>
        <td id="ftd"></td>
        <td id="ftd"></td>
        <td id="ftd"></td>
        <td id="ftd"></td>


    </tr>


    </table>
<br>

<button id="sizebtn" style="width: 100px; height: 30px;">선택삭제</button>

    <br><br><br><br><br><br>



<table align="center">
    <tr>
        <th id="rth" style="text-align: center; width: 200px;">상품가격</th>
        <th id="rth" style="text-align: center; width: 40px;"></th>
        <th id="rth" style="text-align: center; width: 150px;">배송비</th>
        <th id="rth" style="text-align: center; width: 50px;"></th>
        <th id="rth" style="text-align: center; width: 200px;">총 결제금액</th>
    </tr>

    <tr>
        <td style="font-size: 25px; text-align: center;"> <span id= totalprice >${total}</span> 원</td>
        <td style="font-size: 40px;">+</td>
        <td style="text-align: center; font-size: 25px;">0원</td>
        <td style="font-size: 40px;">=</td>
        <td style="text-align: center; font-size: 25px; color: #D10024;"><span id=totalprice>${total}</span> 원</td>
    </tr>





</table>


<div class="btns" align="center">
    <br><br><br>
    <button id="gpbtn" style="width: 240px; height: 60px; background-color: #D10024; color: white; font-size: 25px; border-color: #d10024; border-radius: 10px;">선택상품 주문</label>
</div>
</div>

    <br><br><br><br><br><br>

   <c:import url="../common/footer.jsp"/>
      


<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/nouislider.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.zoom.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>


</body>



</html>