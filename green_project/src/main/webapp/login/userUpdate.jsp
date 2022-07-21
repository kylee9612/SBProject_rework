<%@page import="green_project.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/fix/sub_header.jsp" %>
   
<!DOCTYPE html>
<html lang="kor">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="/green_project/css/join.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <title>내정보</title>
</head>
<body>
<div id="wrap"> 
<%
UserDAO dao1 = UserDAO.getInstance();
String id = dao1.getLog(); 
UserDTO info = dao1.getUser(id);

%>


    <center><span class = "title">내정보 수정하기</span></center><br><br>
    <form method="Post" action="/green_project/ServicesServlet">
    <input type = "hidden" name = "command" value = "updateUser">
        <div class="contents">
        <span>아이디</span><br> 
      
			<input class="req" type="text" name="id" value=<%=id%> readonly>
            
            <span>비밀번호</span><br>
            <input class="req" type="text" value=<%=info.getPw()%> name="pw"><br>
            <span>이름</span><br> 
            <input class="req" type="text" value=<%=info.getName()%> name="name"><br>
            <span>나이</span><br>
            <input class="req" type="number" value=<%=info.getAge()%> name="age">
   			<br>
           		<span>핸드폰번호</span><br><br>
                <select name="country">
                    <option value="kor">대한민국 +82</option>
                </select> <br>
                <input class="req" type="text" id="mobile" name="mobile" value=<%=info.getMobile()%>>
            <span>이메일</span><br>
            <input class="req" type="email" value=<%=info.getEmail()%> name="email">
            <span>포인트</span><br>
            <input class="req" type="email" value=<%=info.getPoint()%> name="point"  readonly>
            <input class="req" type="hidden" value=<%=info.getAuthority()%> name="auth"  readonly>
        </div>

        <div class="buttons">
            <input class="back" style ="cursor: pointer;" type="button" value="뒤로" onclick="location.href ='/green_project/login/mypage.jsp'">
            <input class="in" style ="cursor: pointer;" type="submit" value="확인">
        </div>
    </form>

  
    </div>
</body>
 <%@ include file="/fix/footer.jsp" %>
</html>