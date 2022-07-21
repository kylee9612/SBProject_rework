<%@page import="green_project.LikeListDAO"%>
<%@page import="green_project.ReservationDAO"%>
<%@page import="green_project.BoardDAO"%>
<%@page import="green_project.ItemDAO"%>
<%@page import="green_project.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%! UserDAO dao = UserDAO.getInstance(); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/green_project/css/common.css">
<link rel="stylesheet" href="/green_project/css/reset.css">
<title></title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
</head>
<body>
	<%
	String log = dao.getLog();
	
	UserDAO dao = UserDAO.getInstance();
	ItemDAO idao = ItemDAO.getInstance();
	BoardDAO bdao = BoardDAO.getInstance();
	ReservationDAO rdao = ReservationDAO.getInstance();
	LikeListDAO ldao = LikeListDAO.getInstance();
	%>
	<header>
		<div class="top_box normal_top">
			<h1>
				<a href="/green_project">SB Project</a>
			</h1>
			<nav id="gnb">
				<ul>
                    <li><a href="/green_project/roomList?city=전체&county=전체&id=<%=log%>">숙박예약</a></li>
						<li><a href="/green_project/pointGames">포인트게임</a></li>
						<li><a href="/green_project/qaboard/qaboard.jsp">고객센터</a></li>
						<%
						if (dao.getLog() != null) {
							%>
						<li><a href="/green_project/ServicesServlet?command=logout">로그아웃</a></li>

						<%
						System.out.println(dao.getAuth(dao.getLog()));
						if (dao.getAuth(dao.getLog()) == 1){ %>
						<li><a href="/green_project/login/ceoPage.jsp">마이페이지</a></li>
						<%}else if (dao.getAuth(dao.getLog()) == 2){%>
						<li><a href="/green_project/login/mypage.jsp">마이페이지</a></li>
						<%}%>

						<%
						if (dao.getAuth(dao.getLog()) == 1) {
						%>
						<li><a href="/green_project/item/sellerAdd.jsp">숙소 등록</a></li>
						<%
						}
						} else {
						%>
						<li><a href="/green_project/login/login.jsp">로그인</a></li>
						<li><a href="/green_project/login/join">회원가입</a></li>
						<%
						}
						%>
				</ul>
			</nav>
		</div>
	</header>

