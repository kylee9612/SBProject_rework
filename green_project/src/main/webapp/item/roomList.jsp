<%@page import="java.util.Locale"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.sql.Date"%>
<%@page import="model.LikeListDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.ItemDTO"%>
<%@ page import="controller.ItemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp"%>
<!DOCTYPE html>
<html lang="kor">
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="/green_project/css/heart.css">

<script type="text/javascript"
	src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<script src = "/green_project/js/address.js"></script>
	<script src = "/green_project/js/common.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="/green_project/css/item.css">
<link rel="stylesheet" href="/green_project/css/common.css">
<link rel="stylesheet" href="/green_project/css/roomListImage.css">
<link rel="stylesheet" href="/green_project/css/roomList.css">
</head>
<body>

	<%
	String date[] = request.getParameter("date").split(" ~ ");
	Date checkInDate = Date.valueOf(date[0]);
	Date checkOutDate = Date.valueOf(date[1]);

	int code = 0;
	String city = request.getParameter("city");
	String county = request.getParameter("county");
	String address = city + "/" + county;
	System.out.println(date);

	if (city == null && county == null)
		address = "전체/전체";
	if (request.getParameter("address") != null)
		address = request.getParameter("address");

	ArrayList<ItemDTO> roomList = idao.getItemList(address);
	if (address.equals("전체/전체"))
		roomList = idao.getItemList();
	
	String id = dao.getLog();
	String like = request.getParameter("like");
	if (like != null) {
		if (like.equals("yes")) {
			roomList = LikeListDAO.getInstance().getLikeListItem(id);

			city = "전체";
			county = "전체";
		}
	}

	LikeListDAO likeDAO = LikeListDAO.getInstance();

	ArrayList<LikeListDTO> likeList = likeDAO.getLikeList(id);
	%>
	<div id="wrap">

		<h3 class="title_name">숙박예약</h3>

		<div class="search_middle_wrap">
			<div class="search_bar">
				<form name=form method="post" action="/green_project/ServicesServlet">
					<input type="hidden" name="command" value="roomList"> <select
						name='city' onchange="change(this.selectedIndex);" class="input">
						<option value='전체'>시/도</option>
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
					</select>
					<select name='county' class="select">
						<option value='전체'>구/군</option>
					</select>
					<div class="date_box">
						<input type="text" name="date" id="" class="date">
					</div>
					<input type="number" max="5" placeholder="인원"> <input
						type="submit" value="">
				</form>
			</div>
			<%
			if (dao.getLog() != null && dao.getAuth(dao.getLog()) == 2) {
			%>
			<button class="like_link"
				onclick="location.href='/green_project/ServicesServlet?command=roomList&id=<%=dao.getLog()%>&like=yes'">찜목록
				바로가기</button>
			<%
			}
			%>
		</div>
		<ul class="list">
			<%
			for (int i = 0; i < roomList.size(); i++) {
				if(!rdao.isValidDate(code, checkInDate, checkOutDate)){
					continue;
				}
				code = roomList.get(i).getCode();
				String name = roomList.get(i).getName();
				float rate = roomList.get(i).getRate();
				int price = roomList.get(i).getPrice();
				String thumbnail = roomList.get(i).getThumbnail();
				String contents = roomList.get(i).getContents();
			%>
			<li>
				<form id="form<%=code%>" method="post" action="/green_project/ServicesServlet">
					<div class="pointer">
						<input type="hidden" name="checkIn" value ="<%=checkInDate.toString()%>">
						<input type="hidden" name="checkOut" value ="<%=checkOutDate.toString()%>">
						<input type="hidden" name="command" value="roomInfo"> <input
							type="hidden" name="code" value="<%=code%>"> <input
							type="hidden" name="city" value="<%=city%>"> <input
							type="hidden" name="county" value="<%=county%>"> <input
							type="hidden" name="address" value="<%=address%>"> <span
							class="img_wrap"> <img src="<%=thumbnail%>" 
							alt="<%=name%>의 메인 사진"  onclick="clickEvent(<%=code%>)">
						</span>
						<div class="item_wrap" >
							<h4 class="item_name"  onclick="clickEvent(<%=code%>)"><%=name%></h4>
								<p class="item_rate">
									별점 :
									<span class = "bold_text"><%=rate%></p></span>
								<p class="item_price">
									가격 : <span class ="bold_text"><%=price%>원</span>
								</p>
								<p class="item_subtext">
									주소 :
									<span class = "bold_text"><%=roomList.get(i).getAddress()%></p>
							<p class="item_heart">
								<%
								if (id != null) {
								%>
								<div class="heart_wrap" onclick="heartClick(<%=code%>)">
									<input type="checkbox" name="heart" id="heart<%=code%>" value="<%=ldao.isLiked(id, code)%>">
									<label for="heart" value="<%=ldao.isLiked(id, code)%>"></label>
								</div>
								<script type="text/javascript">
									const heart<%=code%> = $("#heart"+<%=code%>);							
									if(heart<%=code%>.val() === "true"){
										heart<%=code%>.prop("checked",true);	
									}
								</script>
							<%}%>
							</p>
						</div>
					</div>
				</form>
			</li>
			<%
			}
			%>
		</ul>
		<script type="text/javascript">
		
		function heartClick(code){
       		const heart = $("#heart"+code);
            console.log("heart"+code);
            if(heart.val() === "true"){
            	heart.prop('checked',false);
            	console.log("true");
				$.ajax({
					method: 'post',
					url: `/green_project/ServicesServlet?command=like&code=`+code+`&log=<%=id%>&value=false`
				})
            }
            else{
            	heart.prop('checked',true);
				$.ajax({
					method: 'post',
					url: `/green_project/ServicesServlet?command=like&code=`+code+`&log=<%=id%>&value=true`
				})
            }
       	}
		
		$(function() {
			$('.date').daterangepicker({
				"locale": {
					"format": "YYYY-MM-DD",
					"separator": " ~ ",
					"applyLabel": "확인",
					"cancelLabel": "취소",
					"fromLabel": "From",
					"toLabel": "To",
					"customRangeLabel": "Custom",
					"weekLabel": "W",
					"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
					"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
				},
				"startDate": new Date(),
				"endDate": new Date(),
				"drops": "auto"
			}, 
			function(start, end, label) {
				console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
			});
		});
		
		function clickEvent(code) {
			let form = document.getElementById('form' + code);
			form.submit();
		}
       	</script>
	</div>
</body>
</html>
<%@ include file="/fix/footer.jsp"%>