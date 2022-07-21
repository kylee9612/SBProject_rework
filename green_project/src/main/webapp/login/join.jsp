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
    <title>회원가입페이지</title>
</head>
<body>
<div id="wrap">
    <center><span class = "title">회원가입</span></center><br><br>
    <form method="post" action="/green_project/ServicesServlet">
    <input type = "hidden" name = "command" value = "join">
        <div class="contents">
        <span>아이디</span><br> 
      
        <%
        String kid = request.getParameter("kid");
        String id = request.getParameter("id");
        System.out.println(kid);
        if(id!=null){
        	id = id.substring(1,id.length()-1);
        }else if(kid !=null){
        	kid = "kakao_"+kid;
        }
    	if(id != null && !dao.checkDupId(id)){
    	dao.setLog(id);
		String url="/green_project/index.jsp";	
		response.sendRedirect(url);
    	}else if(kid != null && !dao.checkDupId(kid)){
        	dao.setLog(kid);
    		String url="/green_project/index.jsp";	
    		response.sendRedirect(url);
        
    	}
    	else if(id != null||kid!=null){
		 if(kid !=null){
		 %> 
			<input class="req" type="text" name="id" value=<%=kid%> readonly>
			<input type="hidden" name="sns" value= 1>
		<% 
		 }else{
			 %>
			 <input class="req" type="text" name="id" value=<%=id%> readonly>
			 <input type="hidden" name="sns" value= 1>
			<% 
		 }
		 }else{%>
				<input class="req" type="text" placeholder="id" name="id">
				<input type="hidden" name="sns" value= 2>
			<%}%>
            <span class="warning">필수값 입력 바랍니다.<br></span>
            
            <span>비밀번호</span><br>
            <input class="req" type="password" placeholder="password" name="password"><br>
            <span>이름</span><br> 
            <input class="req" type="text" placeholder="name" name="name"><br>
            <span>나이</span><br>
            <input class="req" type="number" placeholder="age"name="age">
   			<br>
           		<span>핸드폰번호</span><br><br>
                <select name="country">
                    <option value="kor">대한민국 +82</option>
                </select> <br>
                <input class="req" type="text" id="mobile" name="mobile" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="mobile" title="###-####-####">
                <input class="injng"type="button"  style ="cursor: pointer;" value="인증" onclick="checkMobile(form)">
            <span>이메일</span><br>
            <input class="req" type="email" placeholder="email" name="email">
            <label><input type="radio" name="authority" checked="checked" value="2"/> 일반
  			<input type="radio" name="authority" value="1"> 사업자</label>
        	
        </div>
			<script src = "/green_project/js/validation.js"></script>	
        <div class="buttons">
            <input class="back" style ="cursor: pointer;" type="button" value="뒤로" onclick="location.href ='/green_project/index.jsp'">
            <input class="in" style ="cursor: pointer;" type="button" value="확인" onclick="checkJoinVal(form)">
        </div>
    </form>

  
    </div>
</body>
 <%@ include file="/fix/footer.jsp" %>
</html>