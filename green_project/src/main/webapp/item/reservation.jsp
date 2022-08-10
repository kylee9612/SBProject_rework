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
		
		if(dao.getLog()==null){
			response.sendRedirect("/green_project/login");
		}
		%>


		<p class = "header_text">예약 정보</p>
		<div class="image_section">
				<img class="room_img" src="<%=room.getThumbnail()%>">
			</div>
		<div>
			<form id="reserve" action="/green_project/ServicesServlet" method="post">
				<input type="hidden" value="addReserve" name="command">
				<input type="hidden" value="<%=code%>" name="code">
				<input type="hidden" name="checkIn" value="<%=checkInDate%>">
				<input type="hidden" name="checkOut" value="<%=checkOutDate%>">
					<br>
					<p class = "room_name">숙소 명 : <%=room.getName()%></p>
					<div class = "reserve_info">
						<div class = "sub_title">
							<p><label>예약자 ID </label></p>
							<p><label>체크인 일정</label></p>
							<p><label>체크아웃 일정</label></p>
							<p><label>총 결제 금액</label></p>
						</div>
						<div class = "sub_data">
							<label><input type ="text" name = "id" value = "<%=dao.getLog()%>" readonly="readonly"></label><br>
							<label><input type ="date" value = "<%=checkInDate%>" readonly="readonly"></label><br>
							<label><input type ="date" value = "<%=checkOutDate%>" readonly="readonly"></label><br>
							<label><input type ="text" name = "price" value = "<%=room.getPrice()%>원" readonly="readonly"></label><br>
						</div>
						<br>
					</div>
			</form>
		</div>
		<div style="text-align: center;">
			<button onclick="submitForm('reserve')">무료 예약</button>
			<button onclick="requestPay()">결제하기</button>
		   	<button onclick="submitForm('back')">뒤로가기</button>
			<form id = "back" name=form method="post" action="/green_project/ServicesServlet">
			    <input type="hidden" name="command" value="roomInfo">
			    <input type="hidden" name="code" value="<%=code%>">
			    <input type="hidden" name="address" value="<%=address%>">
	        </form>
	    </div>
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

function submitForm(data){
	let form = document.getElementById(data);
	form.submit();
}

</script>
</body>
<%@ include file="/fix/footer.jsp"%>
</html>