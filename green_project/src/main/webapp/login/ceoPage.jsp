<%@page import="model.ItemDTO"%>
<%@page import="model.ReservationDTO"%>
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

	<h3 class="title_name">숙소 관리 페이지</h3>
	<input type="hidden" name="command" value="join">
	<div class="contents">
		<br>
		<%if(reserList.size() == 0){ 
        %>
		<p>등록된 숙소가 없습니다.</p>
		<%
         }else{%>
		<div class="content scroll_theme" id="reservation_list">
			<div class="tit_wrap">
				<label class="room_name" for="room_name">숙소 이름</label> <label
					class="code" for="code">코드</label> <label class="viewCut"
					for="viewCut">조회수</label> <label class="likeCut" for="likeCut">좋아요</label>
				<label class="category" for="category">카테고리</label> <label
					class="price" for="price">가격</label> <label class="del" for="del">버튼</label>
			</div>

			<ul class="contentss">
				<%
 			for (int i = 0; i < reserList.size(); i++) {
 				ItemDTO item = idao.getItem(reserList.get(i).getCode());
 			%>
				<li style = "cursor : pointer;">
					<ul class="item_wrap">
						<li class="room_name" onclick = "location.href = '/green_project/item/roomInfo.jsp?code=<%=reserList.get(i).getCode()%>'"><%=item.getName()%></li>
						<li class="code" onclick = "location.href = '/green_project/item/roomInfo.jsp?code=<%=reserList.get(i).getCode()%>'"><%=reserList.get(i).getCode()%></li>
						<li class="viewCut"><%=reserList.get(i).getView_count()%></li>
						<li class="likeCut"><%=reserList.get(i).getLike_count()%></li>
						<li class="category"><%=reserList.get(i).getCategory()%></li>
						<li class="price"><%=reserList.get(i).getPrice()%>원</li>
						<li class="del"><a
							href="/green_project/ServicesServlet?command=deleteItem&id=<%=log%>&code=<%=reserList.get(i).getCode()%>"><img
								class="cancel_img" src="/green_project/resources/garbagecan.png"
								width=20px></a></li>
					</ul>
				</li>
				<%} %>
			</ul>
			<%}%>
		</div>
		<br>
	</div>
</div>

<%@ include file="/fix/footer.jsp"%>
