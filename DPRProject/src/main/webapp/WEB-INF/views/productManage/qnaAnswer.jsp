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
    <h3>따뜻한셔츠</h3>

    <table align="center" style="text-align: center;">

<tr>
<td><h4>문의제목</h4></td>
</tr>

<tr>
<td><textarea id="qContent" readonly value="" style="outline: none; width:550px; height: 100px;  padding: 5px; resize: none;"></textarea></td>
</tr>


<tr>
<td><h4>답변내용</h4></td>
</tr>

<form action="">
    <input type="hidden" value="QNO들어갈자리">
    <input type="hidden" value="sellerId들어갈자리">
<tr>
<td><textarea id="cContent" name="cContent" style="width:550px; height: 100px; padding: 5px; resize: none;"></textarea></td>
</tr>
</form>

<tr>
<td style="padding-top: 30px;"><button type="submit" style="width: 120px; height: 40px; font-weight: bold; background-color: #D10024; border-style: none; border-radius: 5px; color: azure;">답변하기</button></td>
</tr>


</table>

</div>












    
</body>

<c:import url="../common/footer.jsp"/>
</html>