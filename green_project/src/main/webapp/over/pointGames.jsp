<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/fix/sub_header.jsp" %>

<head>
<meta charset="UTF-8">
<title>포인트게임</title>
<link rel="stylesheet" href="/green_project/css/pointGame.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
<%
		String logs = dao.getLog();
	%>
	<div id="wrap">
        <div class="qaboard">
	<!-- 사이드바 -->
	<div id="sidebar">
			<ul>
				<li><a href="/green_project/notice">공지사항</a></li>
				<li><a href="">이벤트</a></li>
				<li><a href="">포인트게임</a></li>
				<li><a href="/green_project/oftenAQ">자주묻는질문</a></li>
				<li><a href="">1대1 문의</a></li>
			</ul>
	</div>
	<div id=mainContent>
		<input type="hidden" value="<%=logs%>" id="log">
		<div onclick="logCheck()" style="width: 350px;"><img src="https://us.123rf.com/450wm/julos/julos1607/julos160777443/84329436-%EC%8A%A4%EB%84%A4%EC%9D%B4%ED%81%AC-%EC%BA%90%EB%A6%AD%ED%84%B0-%EC%84%A0%EA%B8%80%EB%9D%BC%EC%8A%A4-%EC%B0%A9%EC%9A%A9.jpg?ver=6" style="width: 350px; height: 250px;">
		<br><span><h4>스네이크 게임</h4></span>
		<br><span>스피드!!! 액션!! 다이나믹! 무한의 속도! 무한의 꼬리! 멈추지 않는 폭주 스네이크가 어디까지 성장할 수 있을지 직접 플레이해보세요. </span></div>
		<div onclick="logCheck()" style="width: 350px;"><img src="/green_project/resources/wait.png" style="width: 350px; height: 250px;">
		<br><span>게임 준비중입니다. 조금만 기다려주세요.</span></div>
		<div onclick="logCheck()" style="width: 350px;"><img src="/green_project/resources/wait.png" style="width: 350px; height: 250px;">
		<br><span>게임 준비중입니다. 조금만 기다려주세요.</span></div>
	</div>
	</div>
</div>
</body>
	<script src="/green_project/script/snakeGameLogCheck.js"></script>
</html>
<%@ include file="/fix/footer.jsp" %>