<%@page import="green_project.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기 결과 화면</title>
</head>
<body>

 <div id="wrap">
        <header></header>
        <div id="container">
        <%
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String result = request.getParameter("result");
		
		%>

		<script>
		alert("찾으신던 아이디는" +<%=result%>+"입니다");
		location.href = "/green_project/index";
		</script>
            
        </div>
        <footer></footer>
    </div>

</body>
 <%@ include file="/fix/footer.jsp" %>
</html>