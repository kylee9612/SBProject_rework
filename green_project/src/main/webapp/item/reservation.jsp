<%@page import="model.ItemDTO"%>
<%@page import="controller.ItemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp"%>
<!DOCTYPE html>
<html lang="kor">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/reserve.css">
</head>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<body>
	<div id="wrap">
		<%
		String address = request.getParameter("address");
		int code = Integer.parseInt(request.getParameter("code"));
		ItemDTO room = idao.getItem(code);
		String id = request.getParameter("id");
		String checkInDate = request.getParameter("checkIn");
		String checkOutDate = request.getParameter("checkOut");
		%>


		<p class = "header_text">예약 정보</p>
		<div class="image_section">
				<img class="room_img" src="<%=room.getThumbnail()%>">
			</div>
		<div>
			<label>숙소 명 : <%=room.getName()%></label>
			<form action="/green_project/ServicesServlet" method="post">
				<input type="hidden" value="reservation" name="command">
				<input type="hidden" value="<%=code%>" name="code">
				<input type="hidden" name="startDate" value="2022-07-21">
				<input type="hidden" name="endDate" value="2022-07-21">
					<br> 
					<label>예약자 ID : <%=dao.getLog()%></label><br>
					<label>체크인 날짜 : <%=checkInDate%></label><br>
					<label>체크아웃 날짜 : <%=checkOutDate%></label><br>
					<label>총 결제 금액 : <input type ="text" value = "<%=room.getPrice()%>" readonly="readonly">원</label><br>
				<input type="submit" value="무료 예약">
				<button onclick="requestPay()">결제하기</button>
			</form>
		</div>
			    <form name=form method="post" action="/green_project/ServicesServlet">
		        	<input type="submit" value="뒤로가기">
			        <input type="hidden" name="command" value="roomInfo">
			        <input type="hidden" name="code" value="<%=code%>">
			        <input type="hidden" name="address" value="<%=address%>">
	        	</form>
	</div>
	
<script>
function requestPay() {
  IMP.init('iamport'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
  IMP.request_pay({
    pg: "inicis",
    pay_method: "card",
    merchant_uid : 'merchant_'+new Date().getTime(),
    name : '결제테스트',
    amount : 100,
    buyer_email : 'iamport@siot.do',
    buyer_name : '구매자',
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456'
  }, function (rsp) { // callback
	  console.log(rsp);
	    if (rsp.success) {
	      var msg = '결제가 완료되었습니다.';
	      alert(msg);
	      location.href = "결제 완료 후 이동할 페이지 url"
	    } else {
	      var msg = '결제에 실패하였습니다.';
	      msg += '에러내용 : ' + rsp.error_msg;
	      alert(msg);
	    }
  });
}


</script>
</body>
<%@ include file="/fix/footer.jsp"%>
</html>