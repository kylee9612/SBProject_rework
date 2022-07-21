<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/fix/sub_header.jsp" %> 
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js" charset="utf-8"></script> 
<link rel="stylesheet" href="/green_project/css/login.css">

</head>
<body>
 <script src="script/validation.js"></script>
 	 <%
 	String success = request.getParameter("success");
 	 
 	if(success!=null&&success.equals("no")){%>
 		<script>
 		alert("아이디 및 비밀번호를 확인해주세요");

 		</script>
   <%}else if(success!=null&&success.equals("yes")){
	   %><script>
		alert("회원가입이 완료 됬습니다");
		</script>
	   
   <%}%>
      
    
	<div id="wrap">
        <header><h3 class="title_name">로그인</h3></header>
        <div id="container">
<br>
    <form method="post" action="/green_project/ServicesServlet"> 

		    
        <div class="contents">
        	<input type="hidden" name = "command" value = "login">
			<input type="text" name="id" placeholder = "id"><br><br>
			<input type="password" name="password" placeholder = "password">
       		 </div>
       		 <br>
        	<div class="buttons">
            <div class="warning">
                <span>제대로 입력해주세요.</span><br>
            </div><br>
			<input type="submit" class="w-btn w-btn-red" id = "id" value="login" style = "cursor : pointer;"> <br><br> 
            <input type="button" class="w-btn w-btn-red" onclick="location.href = 'idFind'" style = "cursor : pointer;" value="아이디찾기">
            <input type="button" class="w-btn w-btn-red" onclick="location.href = 'pwFind'" style = "cursor : pointer;" value="비밀번호찾기"> 
            <input type="button" class="w-btn w-btn-red" onclick="location.href = 'join'" style = "cursor : pointer;" value="회원가입"> <br>
        	<h5>-----------------------------------또는 -------------------------------</h5>
        	</div>
    		</form>
			<br> <a href="#0" id="kakaoLogin">
			
			<img src="/green_project/resources/kakao_login.png" alt="카카오계정 로그인"
				style="width: 278px; height: 60px;" /></a><br>
		<script src = "/green_project/js/snslogin.js"></script>

				  <div id="naverIdLogin"></div>
			<!--  <a href="#0" id="facebookLogin"><resources src="img/facebook_login.png" alt="페이스북계정 로그인" style="width:250px;height: 50px;"/></a><br>
<<<<<<< HEAD
<<<<<<< HEAD
           -->
    	

         <script type="text/javascript">
      var naverLogin = new naver.LoginWithNaverId({
        clientId: 'uAWhl5a1rFJ2UJ8hJgMH',
        callbackUrl: 'http://localhost:8080/green_project/login/naver_callback.html',
        isPopup: false /* 팝업을 통한 연동처리 여부 */,
        loginButton: { color: 'green', type: 3, height: 60 } /* 로그인 버튼의 타입을 지정 */,
      });

      /* 설정정보를 초기화하고 연동을 준비 */
      naverLogin.init();
    </script>
        
        
        </div>
       </div>
   <%@ include file="/fix/footer.jsp" %>
