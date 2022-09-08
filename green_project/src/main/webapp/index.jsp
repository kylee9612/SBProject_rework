<%@page import="model.AnnouncementDTO"%>
<%@page import="model.Board"%>
<%@page import="controller.LikeListDAO"%>
<%@page import="controller.ReservationDAO"%>
<%@page import="controller.BoardDAO"%>
<%@page import="model.ItemDTO"%>
<%@page import="controller.ItemDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controller.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
 
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<script src = "/green_project/js/address.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<title>SB Project</title>

<!-- 파비콘 -->
<link rel="shortcut icon" href="">

<meta property="og:title" content="SB Project">
<meta property="og:description"
	content="숙박업소의 실시간 특가를 SB Project에서 한 눈에 비교하세요.">
<meta property="og:image" content="">

<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/reset.css">
</head>
<body>
	<%
	UserDAO dao = UserDAO.getInstance();
	if (dao.getLog() != null && dao.getAuth(dao.getLog()) == 0)
	response.sendRedirect("/green_project/admin/admin_index.jsp");
	ItemDAO idao = ItemDAO.getInstance();
	BoardDAO bdao = BoardDAO.getInstance();
	ReservationDAO rdao = ReservationDAO.getInstance();
	LikeListDAO ldao = LikeListDAO.getInstance();
	String log = dao.getLog();
	%>
	<div id="wrap" class="main">
		<header>
			<div class="top_box">
				<h1>
					<a href="index.jsp">SB Project</a>
				</h1>
				<nav id="gnb">
					<ul>
					<%
					if(dao.getLog()== null || dao.getAuth(dao.getLog()) == 2){
					%>
                    <li><a href="/green_project/roomList?city=전체&county=전체&id=<%=log%>">숙박예약</a></li>
                    <%
					}
                    %>
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
			<div class="header_middle_wrap">
			<div class="search_bar">
				<form name=form method="post" action="ServicesServlet">
					<input type="hidden" name="command" value="roomList"> <select
						name='city' onchange="change(this.selectedIndex);" class="input">
						<option value='전체'>전체</option>
	            <option value='서울'>서울특별시</option>
	            <option value='부산'>부산광역시</option>
	            <option value='대구'>대구광역시</option>
	            <option value='인천'>인천광역시</option>
	            <option value='광주'>광주광역시</option>
	            <option value='대전'>대전광역시</option>
	            <option value='울산'>울산광역시</option>
	            <option value='경기'>경기도</option>
	            <option value='강원'>강원도</option>
	            <option value='충북'>충청북도</option>
	            <option value='충남'>충청남도</option>
	            <option value='전북'>전라북도</option>
	            <option value='전남'>전라남도</option>
	            <option value='경북'>경상북도</option>
	            <option value='경남'>경상남도</option>
	            <option value='제주'>제주도</option>
					</select> <select name='county' class="select">
						<option value='전체'>구/군</option>
					</select> 
					<div class="date_box">
						<input type="text" name="date" id="" class="date">
					</div>
					<!-- <input type="text" class="date"> -->
					<input type="number" max="5" placeholder="인원"> <input
						type="submit" value="">
				</form>
			</div>
			<%
			if (dao.getLog() != null && dao.getAuth(dao.getLog()) == 2) {
			%>
			<button class="like_link" onclick="location.href='ServicesServlet?command=roomList&id=<%=dao.getLog()%>&like=yes'">찜목록 바로가기</button>
			<%
			}
			%>
			</div> 
		</header>
		<div id="container">
			<nav class="direct_menu">
				<ul>
					<%
						if (dao.getLog() != null) {
						%>
				<li><a href="/green_project/ServicesServlet?command=logout">로그아웃</a></li><%
						}else{
					
							%><li><a href="/green_project/login/login.jsp">로그인<img src="resources/arrow_btn.png"
									alt="로그인 이동하기"></a></li>
				<%}%>	
					<li><a href="/green_project/item/roomList.jsp">숙박리스트<img src="resources/arrow_btn.png"
							alt="숙박리스트 이동하기"></a></li>
					<li><a href="/green_project/qaboard/qaboard.jsp">고객센터<img src="resources/arrow_btn.png" alt="고객센터 이동하기"></a></li>
				</ul>
			</nav>
			<div class="recommend_item_wrap">
				<h4>BEST</h4>
				<ul>
					<%
					ArrayList<ItemDTO> bestList = idao.getBestLikeItem();

					int size = bestList.size() < 8 ? bestList.size() : 8;

					for (int i = 0; i < size; i++) {
						ItemDTO room = bestList.get(i);
						String thumUrl = room.getThumbnail();
						if (thumUrl.equals("")) {
							thumUrl = "resources/empty_room_img.png";
						}
					%>
					<li><a
						href="/green_project/ServicesServlet?command=roomInfo&code=<%=room.getCode()%>">
							<span class="img_wrap"><img src="<%=thumUrl%>"
								alt="<%=room.getName()%> 전경"></span>
							<div class="recommend_item_info">
								<p class="item_title"><%=room.getName()%></p>
								<p class="item_address"><%=room.getAddress()%></p>
								<span class="grade"><%=room.getRate()%></span>
							</div>
					</a></li>
					<%
					}
					%>
				</ul>
				<span class="pre_btn"><img src="resources/arrow_btn_left.png"
					alt="좌로이동"></span> <span class="next_btn"><img
					src="resources/arrow_btn.png" alt="우로이동"></span>
			</div>
			<div class="row_wrap">
				<div class="brand_info_wrap">
					<h5>
						SB Project<span>간편하게 숙박예약하고,<br> 포인트로 저렴하게 여행
						</span>
					</h5>
					<p>SB에서 간단한 클릭만으로 깨끗하고 저렴한 숙박사이트를 예약해보세요. 간단한 게임을 통해 경쟁도 하고
						포인트도 받아 미루던 여행을 지금 떠나 보세요.</p>
				</div>
				<div class="notice_board_wrap">
					<h5>
						<span>공지사항</span><a href="./notice" class="plus_btn"></a>
					</h5>
					<ul>
						<%
						ArrayList<Board> announcementList = bdao.getBoardList("Announcement", 5, "written", "desc");

						for (int i = 0; i < announcementList.size(); i++) {
							Board board = announcementList.get(i);
						%>
						<li><a href="./noticeView?no=<%=board.getNo()%>"><span
								class="notice_title">[공지] <%=board.getTitle()%></span><span
								class="notice_date"><%=board.getWritten()%></span></a></li>
						<%	
						}
						%>
					</ul>
				</div>
			</div> 
		</div>
		<button class="topBtn">top</button>
	</div>
	<script src="js/main.js"></script>
	<script src="script/address.js"></script>
	<%@ include file="fix/footer.jsp"%>