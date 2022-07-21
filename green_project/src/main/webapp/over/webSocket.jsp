<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>user chat</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" href="/green_project/css/webChat.css">
</head>
<body>
	<textarea id="messageTextArea" rows="15" cols="34" readOnly></textarea>
	<form>
	<!-- 메시지 작성 -->
	<input hidden="hidden" />
	<input id="textMessage" type="text">
	<!-- 메시지 보내는 버튼 -->
	<input id="sendBn" onclick="sendMessage()" value="Send" type="button">
	</form>
	<br />
	
	<!--  -->
	<script src="/green_project/script/webSocketFn.js"></script>
</body>
</html>