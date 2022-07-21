<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="/fix/sub_header.jsp" %>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link rel="stylesheet" href="/green_project/css/join.css">
</head>
<body>
<div id="wrap">
        <header>
       <center><span class = "title">비밀번호 찾기</span></center><br><br>
        <br>
        </header>
        <div id="container">

			<form method="post" action="/green_project/ServicesServlet">
			<input type="hidden" name = "command" value = "pwFind">
			
			<span>id</span><br>
			<input class = "req" type="text" name="id"><br> 
			<span>이름</span><br>
			<input class = "req" type="text" name="name"><br> 
			<span>핸드폰번호</span><br>
			<input class = "req" type="text" name="mobile"><br> 
			<input class= "in" type="submit" value="찾기"><br>
			</form>
        </div>
        <footer></footer>
    </div>
</body>
<%@ include file="/fix/footer.jsp" %>

</html>