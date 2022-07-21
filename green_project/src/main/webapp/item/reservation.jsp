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
</head>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<body>
	<div id="wrap">
		<%
		String address = request.getParameter("address");
		int code = Integer.parseInt(request.getParameter("code"));
		//int code=123456789;
		ItemDTO room = idao.getItem(code);
		String id = request.getParameter("id");
		%>


		<div>
			방 정보 방 이름 :
			<%=room.getName()%>
		</div>
		<div>
			<form action="/green_project/ServicesServlet" method="post">
				<input type="hidden" value="reservation" name="command">
				<input type="hidden" value="<%=code%>" name="code">
				<input type="hidden" name="startDate" value="2022-07-21">
				<input type="hidden" name="endDate" value="2022-07-21">
				예약자 정보<br> 
				예약자 ID : <span name="id" value="<%=id%>"><%=id%></span><br>
				<h1>금액 및 할인 정보</h1>
					총 예약 금액
					<%=room.getPrice()%>원
				<p>--------------------------------------</p>
				
					결제 금액
				<div name="money" value="<%=room.getPrice()%>">원
				</div>
				<input type="submit" value="무료 예약">
			</form>
		</div>






		<div>
			결제~
			<button onclick="requestPay()">결제하기</button>
		</div>
			    <form name=form method="post" action="/green_project/ServicesServlet">
		        	<input type="submit" value="뒤로가기">
			        <input type="hidden" name="command" value="roomInfo">
			        <input type="hidden" name="code" value="<%=code%>">
			        <input type="hidden" name="address" value="<%=address%>">
	        </form>
	</div>


	<!DOCTYPE html>
<!-- 	
<html>
	<head>
	</head> 
	<body> 
		<input type="button" id="naverPayBtn" value="네이버페이 결제 버튼"> 
		
		<script src="https://nsp.pay.naver.com/sdk/js/naverpay.min.js"></script> 
		<script> 
		//var oPay = Naver.Pay.create({ "mode" : "production", // development or production "clientId": "u86j4ripEt8LRfPGzQ8" // clientId }); 
		// 직접 만든 네이버페이 결제 버튼에 click 이벤트를 할당하세요. 
		// var elNaverPayBtn = document.getElementById("naverPayBtn"); 
		// elNaverPayBtn.addEventListener("click", function() { 
		//	oPay.open({ 
		//	"merchantUserKey": "가맹점 사용자 식별키", 
		//	"merchantPayKey": "가맹점 주문 번호", 
		//	"productName": "상품명을 입력하세요", 
		//	"totalPayAmount": "1000", 
		//	"taxScopeAmount": "1000", 
		//	"taxExScopeAmount": "0", 
		//	"returnUrl": "사용자 결제 완료 후 결제 결과를 받을 URL" 
		//	}); 
		//}); 
		//}
		</script> 
	</body> 
</html>
 -->
	
	
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