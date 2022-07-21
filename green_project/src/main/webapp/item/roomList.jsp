<%@page import="green_project.LikeListDTO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="green_project.ItemDTO"%>
<%@ page import="green_project.ItemDAO"%>
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
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<link rel="stylesheet" href="/green_project/css/item.css">
<style>
.pointer {
	cursor: pointer;
}

.list {
	
}

.list li {
	display: flex;
	border-top: 1px solid #dadada;
	border-bottom: 1px solid #dadada;
	padding: 20px;
}

.list li+li {
	border-top: 0;
}

.item_name {
	font-size: 1.64em;
	line-height: 1.6;
	font-weight: 600;
	letter-spacing: -0.05em;
}

.item_rate {
	text-align: right;
}

.item_heart {
	z-index: 5;
	position: absolute;
	top: 50%;
	right: 0;
	transform: translateY(-50%);
}
</style>
<link rel="stylesheet" href="css/common.css">
<link rel="stylesheet" href="css/roomListImage.css">
<link rel="stylesheet" href="css/roomList.css">
</head>
<body>

	<%
	String date = request.getParameter("date");
	System.out.println("룸 리스트 date : " + date);

	int code = 0;
	String city = request.getParameter("city");
	String county = request.getParameter("county");
	String address = city + "/" + county;

	if (city == null && county == null)
		address = "전체/전체";
	if (request.getParameter("address") != null)
		address = request.getParameter("address");
	System.out.println("룸 리스트 city : " + city);
	System.out.println("룸 리스트 county : " + county);

	ArrayList<ItemDTO> roomList = idao.getItemList(address);
	if (address.equals("전체/전체"))
		roomList = idao.getItemList();
	System.out.println("사이즈 : " + roomList.size());

	String id = dao.getLog();
	String like = request.getParameter("like");
	/// null "null"
	//String type = like.getClass().getSimpleName();
	//System.out.println(like);

	System.out.println("룸리스트 id 여부: " + id);
	System.out.println("룸리스트 라이크 여부: " + like);
	if (like != null) {

		if (like.equals("yes")) {
			roomList = LikeListDAO.getInstance().getLikeListItem(id);
			System.out.println("룸 리스트 찜 목록 : ");
			System.out.println("룸 리스트 찜 목록 : ");

			city = "전체";
			county = "전체";
			date = "선택 안함";
		}
	}

	LikeListDAO likeDAO = LikeListDAO.getInstance();

	ArrayList<LikeListDTO> likeList = likeDAO.getLikeList(id);
	%>
	<div id="wrap">

		<h3 class="title_name">숙박예약</h3>

		<div class="search_middle_wrap">
			<div class="search_bar">
				<form name=form method="post" action="ServicesServlet">
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
			<button class="like_link"
				onclick="location.href='ServicesServlet?command=roomList&id=<%=dao.getLog()%>&like=yes'">찜목록
				바로가기</button>
			<%
			}
			%>
		</div>


		<ul class="list">


			<%
			String value = "false";
			for (int i = 0; i < roomList.size(); i++) {
				code = roomList.get(i).getCode();
				String name = roomList.get(i).getName();
				float rate = roomList.get(i).getRate();
				int price = roomList.get(i).getPrice();
				String thumbnail = roomList.get(i).getThumbnail();
				String contents = roomList.get(i).getContents();

				value = "false";
				for (LikeListDTO likeDTO : likeList) {
					System.out.println("룸인포 라이크 리스트 : " + likeDTO.getCode());
					if (likeDTO.getCode() == code) {
			%>
			<script>
					$('#heart').prop('checked', true);
				</script>
			<%
			value = "true";
			}
			}
			System.out.println("좋아요 : " + value);
			%>
			<li>
				<form id=form method="post" action="/green_project/ServicesServlet">
					<div class="pointer" onclick="clickEvent()">
						<input type="hidden" name="command" value="roomInfo"> <input
							type="hidden" name="code" value="<%=code%>"> <input
							type="hidden" name="city" value="<%=city%>"> <input
							type="hidden" name="county" value="<%=county%>"> <input
							type="hidden" name="address" value="<%=address%>"> <span
							class="img_wrap"> <img src="<%=thumbnail%>"
							alt="<%=name%>의 메인 사진">
						</span>
						<div class="item_wrap">
							<h4 class="item_name"><%=name%></h4>
							<p class="item_rate">
								별점 :
								<%=rate%></p>
							<!-- <p>대실 x시간 x원<span></span></p> -->
							<p class="item_price">
								숙박 23:00부터
								<%=price%>원<span></span>
							</p>
							<!-- <p>객실 최근 이슈?? 이벤트?? ex) 넷플릭스 프리존 , 항균 소독<span></span></p> -->
							<p class="item_subtext">
								객실 소개 :
								<%=contents%></p>
						</div>
					</div>
					<p class="item_heart">
						<%
						if (id != null) {
							System.out.println("회원으로 조회");
						%>
					
					<div class="heart_wrap">
						<input type="checkbox" name="heart" id="heart"
							value="/green_project/ServicesServlet?command=roo"> <label
							for="heart" value="/green_project/ServicesServlet?command=roo"></label>
					</div>
					<%
					}
					%>
					</p>
				</form>
			</li>
			<%
			}
			%>
		</ul>
		<script type="text/javascript">
		function clickEvent() {
			let form = document.getElementById('form');
			form.submit();
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
			}, function(start, end, label) {
				console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
			});
		});
	</script>
		<script>
        // const heart = document.body.querySelector('#heart');
        const heart = $('#heart');
        //const heart = document.body.querySelector('#heart');
        heart.click(e => {
        	let t = $(e.target);
        	console.log(t.value);
            if(t.prop('checked')){
            	<%//value="true";
//code=%>            	
				$.ajax({
					method: 'post',
					//url: t.value




					
				})
            }
            else{
            	<%//value="false";%>
				$.ajax({
					method: 'post',
					//url: t.value
				})
            }
        });
        
        
		
		
	</script>
	</div>
</body>
</html>
<%@ include file="/fix/footer.jsp"%>