<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>master chat</title>
<link rel="stylesheet" href="/green_project/css/mswebChat.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
	<div class="template" style="display:none">    
		<!-- 서버와 메시지를 주고 받는 콘솔 텍스트 영역 -->    
		<textarea rows="20" cols="33" id="console" class="console" disabled="disabled"></textarea>  
		<form>     
			 <!-- 메시지 텍스트 박스 -->      
			 <input hidden="hidden" />
			<input type="text" class="message" id="textMessage">      
			<!-- 전송 버튼 -->      
			<input value="Send" type="button" id="sendBt" class="sendBtn">
		</form>    
		<br />
	</div>
	<!--  -->
	<script src="./script/masterWebSocketFn.js"></script>
</body>
</html>