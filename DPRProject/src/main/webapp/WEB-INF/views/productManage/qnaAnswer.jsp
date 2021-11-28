<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <title>DAPARA : 문의답변</title>
</head>
<body>
<c:import url="../common/header.jsp"/>

<div style="text-align: center; margin-top: 50px;">
    <h3>${product.productName}</h3>
<br /><br /><br />
    <table align="center" style="text-align: center;">

<tr>
<td><h4>${qna.getQTitle()}</h4></td>
</tr>

<tr>
<td><input type="text" id="qContent" readonly value="${qna.getQContent()}" style="outline: none; width:550px; height: 100px;  padding: 5px; resize: none;"></input></td>
</tr>




<c:if test="${qna.getQStatus() == 'Y'}">

<tr>
<td style="padding-top:50px;"><h4>답변하신내용</h4></td>
</tr>

 <tr>
<td style ="padding-bottom:50px;"><input value="${comment.getCContent()}" id="cContent" name="cContent" style="width:550px; height: 100px; padding: 5px; resize: none; outline:none; "></input></td>
</tr>
</c:if> 


<c:if test="${qna.getQStatus() == 'N'}">

<tr>
<td style="padding-top:50px;"><h4>답변내용 입력</h4></td>
</tr>

<form action="${pageContext.request.contextPath}/qnaReturn.do">
    <input name="qNo" type="hidden" value="${qna.getQNo()}">
    <input name="sellerId" type="hidden" value="${seller.sellerId}">
<tr>
<td><textarea id="cContent" name="cContent" style="width:550px; height: 100px; padding: 5px; resize: none;"></textarea></td>
</tr>


<tr>
<td style="padding-top: 30px; padding-bottom:50px;"><button type="submit" style="width: 120px; height: 40px; font-weight: bold; background-color: #D10024; border-style: none; border-radius: 5px; color: azure;">답변하기</button></td>
</tr>
</form>
</c:if>
</table>

</div>












    
</body>

<c:import url="../common/footer.jsp"/>
</html>