<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ include file="/fix/sub_header.jsp" %>

<head>
<meta charset="UTF-8">
<title>자주찾는질문</title>
<link rel="stylesheet" href="./css/OAQ.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>

	<div id="wrap">
        <h3><a href="/green_project/masterWebsocket"> 자주찾는질문</a></h3>
        <div class="qaboard">
		
	
	<!-- 사이드바 -->
	<div id="sidebar">
			<ul>
				<li><a href="/green_project/notice">공지사항</a></li>
				<li><a href="">이벤트</a></li>
				<li><a href="/green_project/pointGames">포인트게임</a></li>
				<li><a href="/green_project/oftenAQ">자주묻는질문</a></li>
				<li><a href="">1대1 문의</a></li>
			</ul>
	</div>
	<div id=mainContent>
		
			<div class="listQuestions">
				<h2>취소하려면 어떻게 해야하나요?</h2><br>
				<span>ㄴ 1대1문의, 실시간 채팅을 통해서 문의하시면 됩니다.</span>
			</div><br>
			<div class="listQuestions">
				<h2>숙소를 예약하려면 어떻게 해야하나요?</h2><br>
				<span>ㄴ숙소 예약 페이지로 이동하여 원하는 숙소를 골라 날짜를 선택하고 결제하면 됩니다.</span>
			</div><br>
			<div class="listQuestions">
				<h2>포인트 게임에서 얻은 포인트는 어디에 사용되나요?</h2><br>
				<span>ㄴ 숙소를 예약할 때 결제금액을 차감하는데 사용할 수 있습니다.</span>
			</div><br>
			<div class="listQuestions">
				<h2>예약 날짜/시간을 변경하고 싶어요.</h2><br>
				<span>ㄴ 예약 날짜/시간 변경은 불가능합니다. 취소 후 재예약하셔야 합니다. 
				만약 예약취소가 불가능하다면 1대1문의, 실시간 채팅을 통해서 문의하시면 됩니다.</span>
			</div><br>
			<div class="listQuestions">
				<h2>영수증을 받고 싶어요.</h2><br>
				<span>ㄴ 영수증을 발급받지 못했다면 1대1문의, 실시간 채팅을 통해서 문의하시면 됩니다.</span>
			</div><br> 
		</div>
	</div>
</div> 
</body>
</html>
<%@ include file="/fix/footer.jsp" %>