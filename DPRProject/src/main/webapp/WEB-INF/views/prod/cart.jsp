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

<th id="th" style="width: 75px; height: 50px;"><input type="checkbox" name="Y" id="checkAll"></i></th>
<th id="th" colspan="2" style="width: 1500px;">상품정보</th>
<th id="th" style="width: 100px; ">수량</th>
<th id="th" style="width: 300px; text-align:right; padding-right : 25px;">가격</th>
<th id="th" style="width: 100px; text-align: left;">배송비</th>
</tr>


 <form id="order" action="${pageContext.request.contextPath}/order/order.do" method="post">
 
<c:forEach var="cart" items="${cart}" varStatus="status">
<tr>

<td id="CIP" style="height: 150px;"><input type="checkbox" name="check" value="${cart.productNo}"/> </td>

<td id="CIP" style="padding-left: 10px; padding-right: 10px; padding-top: 10px;" > <img id="TII" src="${pageContext.request.contextPath}/resources/productUpload/${image[status.index]}"> </td>
<td id="CIP" style="width: 1000px; text-align: left; padding-right: 40px;" > <label id="brand" >${cartProduct[status.index].productBrand}</label><br> <label id="prodname">${cartProduct[status.index].productName}</label>
<br> <label id="size">사이즈 :  ${cart.sizeName} <br></label> <br />  <label style="padding-left:20px;">  사이즈 변경 : <select name="newSizeName"
                              class="input-select" id="sizeName" style="width:73px; height:32px;">
                                 <option value="XS">XS</option>
                                 <option value="S">S</option>
                                 <option value="M">M</option>
                                 <option value="L">L</option>
                                 <option value="XL">XL</option>
                           </select> <button class="updateSize" id="sizebtn">변경하기</button>
                            <input name="productNo" id="sizeUser" type="hidden" value="${cart.productNo}"/>
                               <input name="sizeName" id="sizeUser" type="hidden" value="${cart.sizeName}"/>
                           </label></td>
<td id="CIP" >  <div class="input-number"> 
  <input id="pdn" type="hidden" value="${cart.productNo}"/>
  <input id="pri" type="hidden" value ="${cartProduct[status.index].productPrice}" />
  <input type="hidden" id="total" value = "${total}" />
    <input name="cartAmount" id="amount" type="number" readonly value="${cart.cartAmount}" style="outline:none;" >
    <span class="up">+</span>
  
    <span  class="down">-</span>
</div></td>
<td id="CIP"><input class="PRICE" readonly type="text" value="${cartProduct[status.index].productPrice*cart.cartAmount}" style="text-align:right; border-style:none; outline:none;" />원</td>
<td id="CIP" style="text-align: left;">무료</td>
</tr>
</c:forEach>
</form>


<script>

$('.updateSize').click(function(){


	 var productNoVal =$(this).parent().find('#sizeUser').val();
	 var newSize = $(this).parent().find('#sizeName').val();
	 console.log(productNoVal)

	   var params ={
	         
	         userId : "${member.userId}",
	         productNo : productNoVal,
	         sizeName : newSize
	         
	         
	   };
	   
	   
	   $.ajax({
	       url : "/dpr/newSize.do",
	       type: 'post',
	       data : params,
	       success : function(data) {
	          
	       if (data == '1') {
	          
	    	   
               alert("변경 성공");
               location.reload();
	      
	          
	          } else {
	        alert("변경 실패")
	          }
	       }, error : function( code ) {
	           alert("변경 오류")
	       }
	    });
	   })







$('.up').click(function(){
   
   
   var productNoVal =$(this).parent().find('#pdn').val();
   var amount = parseInt($(this).parent().find('#amount').val());
   var amountNo = $(this).parent().find('#amount');
   var dprice = parseInt($(this).parent().find('#pri').val());
   var price = $(this).parent().parent().parent().find('.PRICE');
    var total =  parseInt($("#totalprice").val());
    var totalp =  $("#totalprice");
    var totalp2 = $("#totalprice2");

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
          
    	   
    	  total = total + dprice;
          amount += 1;
          dprice *= amount;
          
      
          
          console.log(amount)
          
          price.val(dprice);
           amountNo.val(amount);
            totalp.val(total);
            totalp2.val(total);
          
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
   var dprice = parseInt($(this).parent().find('#pri').val());
   var price = $(this).parent().parent().parent().find('.PRICE');
   var total =  parseInt($("#totalprice").val());
   var totalp =  $("#totalprice");
   var totalp2 = $("#totalprice2");

   
    var params ={
         
         userId : "${member.userId}",
         productNo : productNoVal,
         amount : amount
         
   };
    
  
   
   
   
    $.ajax({
       url : "/dpr/changeAmountM.do",
       type: 'post',
       data : params,
       success : function(data) {
    	     
       if (data == '1') {
   
    	   
           total = total - dprice; 
          amount -= 1;
          dprice *= amount;
   
      
          
          console.log(amount)
          
          price.val(dprice);
           amountNo.val(amount);
           totalp.val(total);
           totalp2.val(total);
      
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

<button class="deleteCart" id="sizebtn" style="width: 120px; height: 30px;">선택삭제</button>

<script>


$(document).ready(function(){
    //최상단 체크박스 클릭
    $("#checkAll").click(function(){
        //클릭되었으면
        if($("#checkAll").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[name=check]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
            $("input[name=check]").prop("checked",false);
        }
    })
})

















$('.deleteCart').click(function(){
    var valueArr = new Array();
    var userId = "${member.userId}";
  

    var list = $("input:checkbox[name='check']:checked");
	    for(var i = 0; i < list.length; i++){
    	if(list[i].checked){
        valueArr.push(list[i].value);
    		
    	}
    	
    	
    }
    
    
    if(valueArr.length == 0){
        alert("선택된 글이 없습니다.");
    }
    else{
    	var chk = confirm("정말 삭제하시겠습니까?");
        $.ajax ({     		 
            url : "/dpr/deleteCart.do",
            type : 'post',
            traditional : true,
            data : {
            	valueArr : valueArr,
            	userId : userId
            },
            
            success: function(jdata){
                if(jdata = 1) {
                alert("삭제 성공");
                location.reload();
                
                } else{
                
                alert("삭제 오류");
                }}
          
        })}})

</script>

    <br><br><br><br><br><br>



<table align="center">
    <tr>
        <th id="rth" style="text-align: center; width: 200px; padding-right: 60px;">상품가격</th>
        <th id="rth" style="text-align: center; width: 40px;"></th>
        <th id="rth" style="text-align: center; width: 150px;">배송비</th>
        <th id="rth" style="text-align: center; width: 50px;"></th>
        <th id="rth" style="text-align: center; width: 200px; padding-right: 65px;">총 결제금액</th>
    </tr>

    <tr>
        <td style="font-size: 25px; text-align: center;"><div style="display: flex; width: 100%;"><input id= totalprice type=number value=${total} readonly  style ="text-align : center; border-style:none; outline:none; width:150px;">원</input></div></td>
        <td style="font-size: 40px;">+</td>
        <td style="text-align: center; font-size: 25px;">0원</td>
        <td style="font-size: 40px;">=</td>
        <td style="text-align: center; font-size: 25px; color: #D10024;"><div style="display: flex; width: 100%;"><input id= totalprice2 type=number value=${total} readonly  style ="text-align : center; border-style:none; outline:none; width:150px;"></input>원</div></td>
    </tr>





</table>


<div class="btns" align="center">
    <br><br><br>
    <button type="button" onclick="submit();" id="gpbtn" style="width: 240px; height: 60px; background-color: #D10024; color: white; font-size: 25px; border-color: #d10024; border-radius: 10px;">전체상품 주문</label>
</div>
</div>

    <br><br><br><br><br><br>

   <c:import url="../common/footer.jsp"/>
   
   
   <script>
   function submit(){
	   
	   $('#order').submit(); 
 
	   
   }
   
   
   
   </script>
      


<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/slick.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/nouislider.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/jquery.zoom.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>


</body>



</html>