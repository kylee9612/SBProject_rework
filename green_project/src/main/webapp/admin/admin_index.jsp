<%@page import="green_project.UserDTO"%>
<%@page import="green_project.ReservationDTO"%>
<%@page import="model.Board"%>
<%@page import="green_project.QuestionDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="green_project.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/green_project/css/admin.css">
<link rel="stylesheet" href="/green_project/css/qaboard.css">
<!DOCTYPE html>
<%@ include file="/fix/sub_header.jsp"%>
<head>
<title>관리자 페이지</title>
</head>
	<%
	/***********************************************************************************/

	// 담당 : 이인상

	/***********************************************************************************/
	String userId = dao.getLog();
	Date date = new Date(System.currentTimeMillis());
	String month = date.toString().substring(0, 7);
	if (request.getParameter("month") != null)
		month = request.getParameter("month");	
	if (userId == null || dao.getAuth(userId) != 0) {
		response.sendRedirect("/green_project/index");
	}
	%>
	<div class="wrap">
		<div class="qaboard scroll_theme" id="newly_question">
			<div class="label_wrap">
				<label class="no" for="no">no</label> <label class="title"
					for="title">title &emsp;&emsp;&emsp;&emsp; 오늘 올라온 질문</label> <label
					class="user_id" for="user_id">id</label>
			</div>
			<ul>
				<%
				ArrayList<Board> qlist = bdao.getBoardList("Question", date);
				ArrayList<ReservationDTO> rList = rdao.getList(month);
				ArrayList<UserDTO> uList = dao.getUserList();
				int total = 0;
				for (int i = 0; i < rList.size(); i++) {
					total += rList.get(i).getPrice();
				}

				for (int i = 0; i < qlist.size(); i++) {
					int no = qlist.get(i).getNo();
					String id = qlist.get(i).getId();
					String title = qlist.get(i).getTitle();
				%>
				<li class="question"
					onclick="location.href='../qaboardView?no=<%=no%>'">
					<p class="no"><%=no%></p>
					<p class="title q_tit<%=i%>"><%=title%></p>
					<p class="user_id"><%=id%></p>
				</li>
				<%
				}
				%>
			</ul>
		</div>
		<div id="monthly_reservation">
			<div class="label_wrap">
				<label class="month" for="month"><div class="month_change"
						onclick="location.href='/green_project/ServicesServlet?command=monthdec&month=<%=month%>'"><</div><%=month%><div
						class="month_change"
						onclick="location.href='/green_project/ServicesServlet?command=monthadd&month=<%=month%>'">></div></label>
				<label class="con" for="con">현황</label> <label class="total_revenue"
					for="total_revenue">총 결제 금액</label>
			</div>
			<ul>
				<li class="current_board"
					onclick="location.href = '/green_project/admin/reserve_manage.jsp?month=<%=month%>'"
					style="cursor: pointer">
					<p class="month"></p>
					<p class="con">
						예약
						<%=rList.size()%>개
					</p>
					<p class="total_revenue"><%=total%>원
					</p>
				</li>
			</ul>
		</div>
		<div id="logo_text">
			<p class="text_logo">SB Project</p>
		</div>
		<div id="user_list" class="scroll_theme">
			<div class="label_wrap">
				<label class="id" for="id">ID</label> <label class="email"
					for="email">Email</label> <label class="total_reserve"
					for="total_reserve">총 예약 수</label> <label class="auth" for="auth">접근
					권한</label>
			</div>
			<ul>
				<%
				for (int i = 0; i < uList.size(); i++) {
					String auth = "";
					int total_reserve = rdao.reservationCount(uList.get(i).getId());
					if (uList.get(i).getAuthority() == 1) {
						auth = "Enterprise";
					} else if (uList.get(i).getAuthority() == 2) {
						auth = "Customer";
					} else {
						auth = "Admin";
					}
				%>
				<li class="user_list"
					onclick="location.href = 'user_manage.jsp?id=<%=uList.get(i).getId()%>'">
					<p class="id"><%=uList.get(i).getId()%>
					</p>
					<p class="email"><%=uList.get(i).getEmail()%>
					</p>
					<p class="reserve_count"><%=total_reserve%>
					</p>
					<p class="user_auth"><%=auth%>
					</p>
				</li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
	<%@ include file="/fix/footer.jsp"%>