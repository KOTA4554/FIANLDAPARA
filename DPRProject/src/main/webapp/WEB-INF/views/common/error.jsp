
<%@page import="java.io.PrintStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
<style>
div#error-container{text-align:center;}
</style>
</head>
<body>
<c:import url="${pageContext.request.contextPath}/views/common/header.jsp"/>
	<div id="error-container">
	<%-- <c:import url="../common/header.jsp"/> --%>
		<h1>Error</h1>
		<!-- exception객체는 el로 접근할 수 없음. -->
		<%-- <h2>예외 발생: ${exception.message}</h2> --%>
		<h2 style="color:red;"><%= exception.getMessage() %></h2>
		<a href="${pageContext.request.contextPath}">첫페이지로 돌아가기</a>
	</div>
<c:import url="${pageContext.request.contextPath}/views/common/footer.jsp"/>
</body>

</html>