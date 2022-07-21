<%@page import="green_project.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/fix/sub_header.jsp"%>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/green_project/css/join.css">
<title>SB 유저 관리 페이지</title>
</head>
<body>
	<%
	String id = request.getParameter("id");
	
	if(id == null){
		response.sendRedirect("/green_project/admin/admin_index.jsp");
	}
	UserDTO user = dao.getUser(id);
	String pw = user.getPw();
	String name = user.getName();
	int age = user.getAge();
	String mobile = user.getMobile();
	String email = user.getEmail();
	int point = user.getPoint();
	%>
	<div id = "wrap">
	<form action="../ServicesServlet" method="post">
		<div class="contents">
			<input type = "hidden" name = "command" value = "updateUser">
			<input type = "hidden" name = "auth" value = "<%=user.getAuthority()%>">
			<input class="req" type="text" name="id" value=<%=id%> readonly>
			<span>비밀번호</span><br>
			<input class="req" type="password" name = "pw">
            <span>이름</span><br> 
			<input class="req" type="text" name = "name" value=<%=name%>>
            <span>나이</span><br>
            <input class="req" type="number" name="age" value = <%=age%>>
   			<br>
           		<span>핸드폰번호</span><br><br>
                <select name="country">
                    <option value="kor">대한민국 +82</option>
                </select> <br>
                <input class="req" type="text" id="mobile" name="mobile" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="mobile" title="###-####-####" value="<%=mobile%>">
                <input class="injng"type="button"  style ="cursor: pointer;" value="인증" onclick="checkMobile(form)">
            <span>이메일</span><br>
            <input class="req" type="email" placeholder="email" name="email" value="<%=email%>">
            <span>포인트</span><br>
            <input class="req" type="number" placeholder="point" name="point" value="<%=point%>" readonly>
            </div>
        <div class="buttons">
            <input class="back" style ="cursor: pointer;" type="button" value="뒤로" onclick="location.href ='/green_project/admin/admin_index.jsp'">
            <input class="del" style ="cursor: pointer;" type="button" value="유저 삭제" onclick="location.href ='/green_project/ServicesServlet?id=<%=id%>&command=deleteUser'">
            <input class="in" style ="cursor: pointer;" type="submit" value="확인">
        </div>
		</form> 
	</div>
</body>
<%@ include file="/fix/footer.jsp"%>