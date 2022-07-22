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
			
			String id = dao.getLog();
			
			
			//String like =request.getParameter("like");
			
			ItemDTO room = idao.getItem(code);
			
			
			LikeListDAO likeDAO = LikeListDAO.getInstance();
			
			ArrayList<LikeListDTO> likeList = likeDAO.getLikeList(id);
		%>
		<div class="room_contents">
			<div name="방사진">
				<img alt="방 메인 사진" class="room_img" src="<%=room.getThumbnail()%>">
			</div>
			<div class="info">
				<div id = "room_info">
					<span class="name" name="name" value="상호 : <%=room.getName()%>"><%=room.getName()%></span>
					<br> 
					<span class="address" name="address" value="주소 : <%=room.getAddress()%>">주소 : <%=room.getAddress()%></span>
					<br> 
					<span class="price" name="price" value="가격 : <%=room.getPrice()%>원">가격 : <%=room.getPrice()%>원
					</span> <br> 
					<span class="thumbnail" name="thumbnail"img="src='<%=room.getThumbnail()%>'" value="이미지 : <%=room.getThumbnail()%>">
					</span> <br> 
					<span class="content" name="content" value="소개 : <%=room.getContents()%>">소개 : <%=room.getContents()%></span>
					<br> 
					<span class="max_people" name="max_people" value="인원 : <%=room.getMax_people()%>명">인원 : <%=room.getMax_people()%>명
					</span>
				</div>
				<div id="roomListWrap">
					<h4>객실 정보</h4>
					<span>숙박 : 1박 <%=room.getPrice()%>원</span>
					<h5>객실 제공 정보</h5>
					<span><%=room.getContents()%></span>
					<form name=form method="post"
						action="/green_project/ServicesServlet">
						<input type="submit" value="예약하기">
						<input type="hidden"name="command" value="reservation">
						<input type="hidden" name="code" value="<%=code%>"> 
						<input type="hidden" name="address" value="<%=address%>">
						<input type="hidden" name="id" value="<%=id%>">
					</form>
					<%
	        			if(id != null && !id.equals("null")){
	        		%>
					<div class="heart_wrap">
						<input type="checkbox" name="heart" id="heart"> <label
							for="heart"></label>
					</div>
					<%
	        		}
	       			 %>
					<h5>객실 후기</h5>
					<%
	        		//ReservationDAO rdao = ReservationDAO.getInstance(); 
	        		ArrayList<ReservationDTO> reviewList = rdao.getReviewList(code);
					if(reviewList.size()<1){
					%>
					<span>현재 이용 후기가 없습니다.</span>
					<%
				}
				for(ReservationDTO review : reviewList){
					%>
					<span>이용 기간 : <%=review.getCheckin_date()%>~ <%=review.getCheckout_date()%></span><br>
					<span>평점 : <%=review.getReview()%></span><br> <span>이용
						고객 : <%=review.getId()%></span><br>
					<%
				}
	        %>
				</div>
			</div>
		</div>
	</div>
	<%
	System.out.println("룸 인포 방 코드 : "+code);
	String value = "false";
	for(LikeListDTO likeDTO : likeList){
		System.out.println("룸인포 라이크 리스트 : "+likeDTO.getCode());
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
