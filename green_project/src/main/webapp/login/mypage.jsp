<%@page import="green_project.ItemDTO"%>
<%@page import="green_project.ReservationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/fix/sub_header.jsp"%>

<%
	
	ArrayList<ReservationDTO> reserList = rdao.getLists(log);
	%>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<link rel="stylesheet" href="/green_project/css/admin.css">
<link rel="stylesheet" href="/green_project/css/qaboard.css">
<link rel="stylesheet" href="/green_project/css/reserve_admin.css">
</head>
<div id="wrap">
	<%--<center>
		<span class="title">마이페이지</span>
	</center> --%>

	<h3 class="title_name">마이페이지</h3>
	<input type="hidden" name="command" value="join">
	<div class="contents">

		<h4>예약현황</h4>
		<div class="content scroll_theme" id="reservation_list">
			<%if(reserList.size() == 0){ 
        	 %>
			<p>예약 정보가 없습니다</p>
			<%
         }else{%>
			<div class="label_wrap">
				<label class="day" for="day">예약 일</label> <label class="room_name"
					for="room_name">숙소 이름</label> <label class="user_id" for="user_id">예약자
					명</label> <label class="price" for="price">결제 금액</label> <label
					class="check_date" for="check_date">체크인 날짜</label> <label
					class="check_date" for="check_date">체크아웃 날짜</label> <label
					class="cancel" for="cancel">예약취소</label>
			</div>

			<ul>
				<%
 			for (int i = 0; i < reserList.size(); i++) {
 				ItemDTO item = idao.getItem(reserList.get(i).getCode());
 			%>
				<li class="reservationInfo">
					<p class="day"><%=reserList.get(i).getReserve_date()%></p>
					<p class="room_name"><%=item.getName()%></p>
					<p class="user_id"><%=reserList.get(i).getId()%></p>
					<p class="price"><%=reserList.get(i).getPrice()%>원
					</p>
					<p class="check_date"><%=reserList.get(i).getCheckin_date()%></p>
					<p class="check_date"><%=reserList.get(i).getCheckout_date()%></p>
					<img class="cancel_img"
					src="/green_project/resources/garbagecan.png"
					onclick = "location.href = '../ServicesServlet?command=deleteReservation&reserve_code=<%=reserList.get(i).getReservationCode()%>'">
				</li>


				<%} %>
			</ul>
		<%}%>
		</div>

		

		<input type="submit" value="내정보"
			onclick="location.href = 'userUpdate.jsp'">
	</div>
</div>

<%@ include file="/fix/footer.jsp"%>