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
	<div id="wrap" style="display:flex; ">
		<%
		String address = request.getParameter("address");
		int code = Integer.parseInt(request.getParameter("code"));
		ItemDTO room = idao.getItem(code);
		String id = request.getParameter("id");
		String checkInDate = request.getParameter("checkIn");
		String checkOutDate = request.getParameter("checkOut");
		int days = Integer.parseInt(request.getParameter("days"));
		
		if(dao.getLog()==null){
			%>
			<script>
			alert("로그인 후 이용해 주세요");
			location.href = "/green_project/login";
			</script>
			<%
		}
		%>

		<h3 class = "title_name" style = "display:none;">예약 정보</h3>
		<div class="image_section" style = "width : 50%;">
				<img class="room_img" style ="padding : 13% 0; width : 100%"src="<%=room.getThumbnail()%>">
			</div>
			<form id = "back" name=form method="post" action="/green_project/ServicesServlet">
			    <input type="hidden" name="command" value="roomInfo">
			    <input type="hidden" name="code" value="<%=code%>">
			    <input type="hidden" name="address" value="<%=address%>">
			    <input type="hidden" name="days" value="<%=days%>">
	        </form>
		<div style = "width : 50%;">
			<form id="reserve" action="/green_project/ServicesServlet" method="post">
				<input type="hidden" value="addReserve" name="command">
				<input type="hidden" value="<%=code%>" name="code">
					<br>
					<p class = "room_name"><%=room.getName()%></p>
					<div class = "reserve_info">
						<div class = "sub_title">
							<p><label>예약자 ID </label></p>
							<p><label>체크인 일정</label></p>
							<p><label>체크아웃 일정</label></p>
							<p><label>총 결제 금액</label></p>
						</div>
						<div class = "sub_data">
							<label><input type ="text" name = "id" value = "<%=dao.getLog()%>" readonly="readonly"></label><br>
							<%if(days != 0){ %>
							<label><input type ="date" id = "checkIn" name="checkIn" value = "<%=checkInDate%>" readonly="readonly"></label><br>
							<label><input type ="date" id = "checkOut" name="checkOut"value = "<%=checkOutDate%>" readonly="readonly"></label><br>
							<%}else{%>
							<label><input type ="date" id = "checkIn" name="checkIn" value = "<%=checkInDate%>"></label><br>
							<label><input type ="date" id = "checkOut" onblur="refreshPrice()" name="checkOut"value = "<%=checkOutDate%>"></label><br>
							<%}%>
							<label><input type ="text" id = "price" name = "price" value = "<%=room.getPrice()*days%>원" readonly="readonly"></label><br>
						</div>
						<br>
					</div>
		<div class = "btn_tag">
			<div id="reserve_btn" onclick="submitForm('reserve')">무료 예약</div>
			<div id="pay_btn" onclick="requestPay()">결제하기</div>
		   	<div id= "back_btn" onclick="submitForm('back')">뒤로가기</div>
	    </div>
			</form>
		</div>
	</div>
	
<script>

const checkInTo = document.getElementById("checkIn");
const checkOutTo = document.getElementById("checkOut");
const priceTo = document.getElementById("price");	

function refreshPrice(){
	let checkIn = new Date(checkInTo.value);
	let checkOut = new Date(checkOutTo.value);
	
	let dif = checkOut.getTime() - checkIn.getTime();
	priceTo.value = (dif / (24*60*60*1000))*<%=room.getPrice()%>;
}

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