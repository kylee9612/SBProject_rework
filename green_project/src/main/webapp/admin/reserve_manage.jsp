<%@page import="green_project.ItemDTO"%>
<%@page import="green_project.ReservationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="/green_project/css/admin.css">
<link rel="stylesheet" href="/green_project/css/qaboard.css">
<link rel="stylesheet" href="/green_project/css/reserve_admin.css">
<%@ include file="/fix/sub_header.jsp"%>
<meta charset="UTF-8">
<div id="wrap">

	<%
	String month = request.getParameter("month");

	ArrayList<ReservationDTO> rList = rdao.getList(month);
	%>
	<h3 class = "title_name"><%=month%>&emsp;예약 현황</h3>	
	<div class="content scroll_theme" id = "reservation_list">
		<div class="label_wrap">
			<label class="day" for="day">예약 일</label> <label class="room_name" for="room_name">숙소
				이름</label> <label class="user_id" for="user_id">예약자 명</label> <label
				class="price" for="price">결제 금액</label>
				<label class="check_date" for="check_date">체크인 날짜</label>
				<label class="check_date" for="check_date">체크아웃 날짜</label>
				<label class="cancel" for="cancel">예약취소</label>
		</div>
		<ul>
			<%
			for (int i = 0; i < rList.size(); i++) {
				ItemDTO item = idao.getItem(rList.get(i).getCode());
			%>
			<li class="reservationInfo">
				<p class="day"><%=rList.get(i).getReserve_date()%></p>
					<p class = "room_name"><%=item.getName()%></p>
				<p class="user_id"><%=rList.get(i).getId()%></p>
				<p class="price"><%=rList.get(i).getPrice()%>원</p>
				<p class="check_date"><%=rList.get(i).getCheckin_date()%></p>
				<p class="check_date"><%=rList.get(i).getCheckout_date()%></p>
				<img class = "cancel_img" src = "/green_project/resources/garbagecan.png" onclick = "location.href = '../ServicesServlet?command=deleteReservation&reserve_code=<%=rList.get(i).getReservationCode()%>'">
			</li>
			<%
			}
			%>
		</ul>
	</div>
</div>
<%@ include file="/fix/footer.jsp"%>