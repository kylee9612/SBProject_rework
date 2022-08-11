<%@page import="java.sql.Date"%>
<%@page import="model.ReservationDTO"%>
<%@page import="controller.DBManager"%>
<%@page import="model.LikeListDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.ItemDTO"%>
<%@page import="controller.ItemDAO"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp"%>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/green_project/css/common.css">
<link rel="stylesheet" href="/green_project/css/heart.css">
<link rel="stylesheet" href="/green_project/css/itemInfo.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
	<div id="wrap">
	<script type="text/javascript">
		document.title = "숙소 페이지";
	</script>
		<%
			String address = request.getParameter("address");
			String city = request.getParameter("city");
			String county = request.getParameter("county");
			int code = Integer.parseInt(request.getParameter("code"));
			int days = request.getParameter("days") == null ? 0 : Integer.parseInt(request.getParameter("days"));
		
			String checkInDate = request.getParameter("checkIn");
			String checkOutDate = request.getParameter("checkOut");
			
			String id = dao.getLog();
			ItemDTO room = idao.getItem(code);
			LikeListDAO likeDAO = LikeListDAO.getInstance();
			
			ArrayList<LikeListDTO> likeList = likeDAO.getLikeList(id);
		%>
		<div class="room_contents">
			<div class="room_section">
				<img class="room_img" src="<%=room.getThumbnail()%>">
			</div>
			<div class="info">
				<div id = "room_info">
					<label class = "name">숙소 명<span class="name"><%=room.getName()%></span></label>
					<br> 
					<label>주소 <span class="address"><%=room.getAddress()%></span></label>
					<br> 
					<label>1박 요금<span class="price"><%=room.getPrice()%>원</span></label>
					 <br>  
					<label>정원 <span class="max_people"><%=room.getMax_people()%>명</span></label>
					<form id ="side_tabs" name=form method="post"
						action="/green_project/ServicesServlet">
						<input type="submit" value="예약하기">
						<input type="hidden"name="command" value="reservation">
						<input type="hidden" name="days" value="<%=days%>">
						<input type="hidden" name="code" value="<%=code%>"> 
						<input type="hidden" name="address" value="<%=address%>">
						<input type="hidden" name="id" value="<%=id%>">
						<input type="hidden" name="checkIn" value ="<%=checkInDate%>">
						<input type="hidden" name="checkOut" value ="<%=checkOutDate%>">
						<%
	        			if(id != null && !id.equals("null")){
	        		%>
					<div class="heart_wrap" style = "margin-left : 15%;">
						<input type="checkbox" name="heart" id="heart"> <label
							for="heart"></label>
					</div>
					<%
	        		}
	       			 %>
					</form>
				</div>
				<div id="roomListWrap">
					<label style ="color : #8f8f8f;">소개</label><br>
					<p><textarea class="content"><%=room.getContents()%></textarea><p>	
					
					<h5>객실 후기 <%=room.getRate()%></h5>
					<fieldset class = "fieldset">
					<%
					float rate = room.getRate();
					for(int i = 0; i < 5; i++){
						if(rate >= 1){
							rate -= 1;
							%>
							<label class = "full_star star">★</label>
							<%
							continue;
						}else if(rate >= 0.35){
							rate = 0;
							%>
							<label class = "half_star star">★</label>
							<%
						}else{
							%>
							<label class = "empty_star star">★</label>
							<%
						}
					}
			        %>
			        </fieldset>
				</div>
			</div>
		</div>
	</div>
	<%
	String value = "false";
	for(LikeListDTO likeDTO : likeList){
		if(likeDTO.getCode()==code){ %>
		<script>
			$('#heart').prop('checked', true);
		</script>
	<%
			value="true";
		}
	}
	%>
	<script>
        const heart = document.body.querySelector('#heart');
        heart.addEventListener('click', e=>{
            if(heart.checked){
            	console.log(heart.checked);
            	<%value="true";%>            	
				$.ajax({
					method: 'post',
					url: `/green_project/ServicesServlet?command=like&code=<%=code%>&log=<%=id%>&value=<%=value%>`
				})
            }
            else{
            	console.log(heart.checked);
            	<%value="false";%>
				$.ajax({
					method: 'post',
					url: `/green_project/ServicesServlet?command=like&code=<%=code%>&log=<%=id%>&value=<%=value%>`
				})
            }
        });
	</script>
</body>
<iframe name='blankifr' style='display: none;'></iframe>
</html>
<%@ include file="/fix/footer.jsp"%>
