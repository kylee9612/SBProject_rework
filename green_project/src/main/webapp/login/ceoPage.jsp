<%@page import="green_project.ItemDTO"%>
<%@page import="green_project.ReservationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/fix/sub_header.jsp"%>

<%
	
	ArrayList<ItemDTO> reserList = idao.getItemLists(log);


	%>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">


<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>

<link rel="stylesheet" href="/green_project/css/reserve_ceo.css">
</head>
<div id="wrap">
	
	<h3 class="title_name">ceo페이지</h3>
	<input type="hidden" name="command" value="join">
	<div class="contents">

		<h4>등록현황</h4><br>
		<div class="content scroll_theme" id="reservation_list">
			<%if(reserList.size() == 0){ 
        	 %>
			<p>예약 정보가 없습니다</p>
			<%
         }else{%>
			<div class="tit_wrap">
				<label class="room_name" for="room_name">숙소 이름</label> 
					<label class="code"  for="code">코드</label> 
					<label class="viewCut" for="viewCut">조회수</label> 
					<label class="likeCut" for="likeCut">좋아요</label> 
					<label class="category" for="category">카데고리</label>
					<label class="price" for="price">가격</label>
					<label class="del" for="del">버튼</label>
			</div>

			<ul class="contentss">
				<%
 			for (int i = 0; i < reserList.size(); i++) {
 				ItemDTO item = idao.getItem(reserList.get(i).getCode());
 			%>
				<li>
                    <ul class="item_wrap">
					 	<li class="room_name"><%=item.getName()%></li>
					 	<li class="code"><%=reserList.get(i).getCode()%></li>
						<li class="viewCut"><%=reserList.get(i).getView_count()%></li>
						<li class="likeCut"><%=reserList.get(i).getLike_count()%></li>
						<li class="category"><%=reserList.get(i).getCategory()%></li>
						<li class="price"><%=reserList.get(i).getPrice()%>원</li>
						<li class="del"> <a href="/green_project/ServicesServlet?command=deleteItem&id=<%=log%>&code=<%=reserList.get(i).getCode()%>"><img class="cancel_img" src="/green_project/resources/garbagecan.png" width = 20px></a></li>
					</ul>
				</li>


				<%} %>
			</ul>
			<%}%>
		</div>

		
			<br>
		<input type="submit" value="내정보"
			onclick="location.href = 'userUpdate.jsp'">
	</div>
</div>

<%@ include file="/fix/footer.jsp"%>