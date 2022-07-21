<%@page import="green_project.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp" %>
    
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 결과 화면</title>
</head>
<body>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
String result = request.getParameter("result");
%>

<script>
alert("찾으신던 비밀번호는" +<%=result%>+"입니다");
location.href = "/green_project/index";
</script><%@ include file="/fix/footer.jsp" %>

