<%@page import="java.sql.Date"%>
<%@page import="model.ItemDTO"%>
<%@page import="model.ReservationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/fix/sub_header.jsp"%>

<%
ArrayList<ReservationDTO> reserList = rdao.getLists(log);
String id = dao.getLog();
%>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
	<link rel="stylesheet" href="/green_project/css/admin.css">
	<link rel="stylesheet" href="/green_project/css/qaboard.css">
	<link rel="stylesheet" href="/green_project/css/reserve_admin.css">
	<link rel="stylesheet" href="/green_project/css/mypage.css">

</head>
<div id="wrap">
<%
	String initialPage = request.getParameter("page");
	UserDTO info = dao.getUser(dao.getLog());
	ArrayList<ItemDTO> roomList = ldao.getLikeListItem(id);
	if(dao.getLog()==null){
		%>
		<script>
		alert("로그인 후 이용해 주세요");
		</script>
		<%
		response.sendRedirect("/green_project/index.jsp");
	}
%>
	<h3 class="title_name">마이페이지</h3>
	<input type="hidden" name="command" value="join">
	<div class="sec_wrap">
		<div class="menu">
			<ul>
				<li onclick = 'changePage(`myInfo`)'><span >내 정보</span></li>
				<li onclick = 'changePage(`likelist`)'><span>찜 목록</span></li>
				<li onclick = 'changePage(`reserve`)'><span>예약 내역</span></li>
				<li onclick = 'changePage(`review`)'><span>리뷰를 달아주세요</span></li>
			</ul>
		</div>
		<div id="contents">
			<div class = "con">
			    <form method="Post" action="/green_project/ServicesServlet">
			    <input type = "hidden" name = "command" value = "updateUser">
			        <div class="contents">
			        <span>아이디</span><br> 
						<input class="req" type="text" name="id" value=<%=dao.getLog()%> readonly>
			            <span>비밀번호</span><br>
			            <input class="req" type="text" value="" name="pw" required="required"><br>
			            <span>이름</span><br> 
			            <input class="req" type="text" value=<%=info.getName()%> name="name"><br>
			            <span>나이</span><br>
			            <input class="req" type="number" value=<%=info.getAge()%> name="age">
			   			<br>
			           		<span>핸드폰번호</span><br><br>
			                <select name="country">
			                    <option value="kor">대한민국 +82</option>
			                </select> <br>
			                <input class="req" type="text" id="mobile" name="mobile" value=<%=info.getMobile()%>>
			            <span>이메일</span><br>
			            <input class="req" type="email" value=<%=info.getEmail()%> name="email">
			            <span>포인트</span><br>
			            <input class="req" type="email" value=<%=info.getPoint()%> name="point"  readonly>
			            <input class="req" type="hidden" value=<%=info.getAuthority()%> name="auth"  readonly>
			        </div>

			        <div class="buttons">
			            <input class="back" style ="cursor: pointer;" type="button" value="뒤로" onclick="location.href ='/green_project/login/mypage.jsp'">
			            <input class="in" style ="cursor: pointer;" type="submit" value="확인">
			        </div>
			    </form>
			    </div>
		</div>
	</div>
</div>

<script type="text/javascript">

let page = "";

if("<%=initialPage%>" !== null){
	page = "<%=initialPage%>";
	console.log(page);
	changePage(page);
}

	function changePage(page){
		if(page === "reserve"){
			document.getElementById("contents").innerHTML = `<div class="content scroll_theme" id="reserve_list">
			<%
			if (reserList.size() == 0) {
			%>
			<p>예약 정보가 없습니다</p>
			<%
			} else {
			%>
			<div class="label_wrap">
				<label class="day" for="day">예약 일</label> <label class="room_name"
					for="room_name">숙소 이름</label> <label class="user_id" for="user_id">예약자
					명</label> <label class="price" for="price">결제 금액</label> <label
					class="check_date" for="check_date">체크인 날짜</label> <label
					class="check_date" for="check_date">체크아웃 날짜</label> <label
					class="cancel" for="cancel">예약취소</label>
			</div>
			<ul>
				<%
				for (int i = 0; i < reserList.size(); i++) {
					ItemDTO item = idao.getItem(reserList.get(i).getCode());
				%>
				<li class="reservationInfo">
					<p class="day"><%=reserList.get(i).getReserve_date()%></p>
					<p class="room_name"><%=item.getName()%></p>
					<p class="user_id"><%=reserList.get(i).getId()%></p>
					<p class="price"><%=reserList.get(i).getPrice()%>원
					</p>
					<p class="check_date"><%=reserList.get(i).getCheckin_date()%></p>
					<p class="check_date"><%=reserList.get(i).getCheckout_date()%></p>
					<img class="cancel_img"
					src="/green_project/resources/garbagecan.png"
					onclick="location.href = '../ServicesServlet?command=deleteReservation&reserve_code=<%=reserList.get(i).getReservationCode()%>'">
				</li>
				<%
				}
				%>
			</ul>
			<%
			}
			%>
		</div>`
		}
		else if(page === "myInfo"){
			document.getElementById("contents").innerHTML = `
			<div class = "con">
			    <form method="Post" action="/green_project/ServicesServlet">
			    <input type = "hidden" name = "command" value = "updateUser">
			        <div class="contents">
			        <span>아이디</span><br> 
						<input class="req" type="text" name="id" value=<%=dao.getLog()%> readonly>
			            <span>비밀번호</span><br>
			            <input class="req" type="text" value="" name="pw" required="required"><br>
			            <span>이름</span><br> 
			            <input class="req" type="text" value=<%=info.getName()%> name="name"><br>
			            <span>나이</span><br>
			            <input class="req" type="number" value=<%=info.getAge()%> name="age">
			   			<br>
			           		<span>핸드폰번호</span><br><br>
			                <select name="country">
			                    <option value="kor">대한민국 +82</option>
			                </select> <br>
			                <input class="req" type="text" id="mobile" name="mobile" value=<%=info.getMobile()%>>
			            <span>이메일</span><br>
			            <input class="req" type="email" value=<%=info.getEmail()%> name="email">
			            <span>포인트</span><br>
			            <input class="req" type="email" value=<%=info.getPoint()%> name="point"  readonly>
			            <input class="req" type="hidden" value=<%=info.getAuthority()%> name="auth"  readonly>
			        </div>

			        <div class="buttons">
			            <input class="back" style ="cursor: pointer;" type="button" value="뒤로" onclick="location.href ='/green_project/login/mypage.jsp'">
			            <input class="in" style ="cursor: pointer;" type="submit" value="확인">
			        </div>
			    </form>
			    </div>`
		}
		else if(page === "likelist"){
			document.getElementById("contents").innerHTML = `
			<div class = "content scroll_theme" id = "like_list">
				<ul class="list">
			 	<%
				for (int i = 0; i < roomList.size(); i++) {
					int code = roomList.get(i).getCode();
					String name = roomList.get(i).getName();
					float rate = roomList.get(i).getRate();
					int price = roomList.get(i).getPrice();
					String thumbnail = roomList.get(i).getThumbnail();
					String contents = roomList.get(i).getContents();
				%>
				<li>
					<form id= "form<%=code%>" method="post" action="/green_project/ServicesServlet">
						<div class="pointer">
							<input type="hidden" name="command" value="roomInfo"> <input
								type="hidden" name="code" value="<%=code%>">
								<span
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
							</div>
						</div>
					</form>
				</li>
				<%
				}
				%>
				</ul>
			 </div>`
		}
		else if(page === "review"){
			document.getElementById("contents").innerHTML = `
				<div class = "content scroll_theme" id = "reserve_list">
					<div class="label_wrap">
						<label class="day" for="day">예약 일</label> 
						<label class="room_name"for="room_name">숙소 이름</label> 
						<label class="price" for="price">결제 금액</label> 
						<label class="check_date" for="check_date">체크인 날짜</label>
						<label class="check_date" for="check_date">체크아웃 날짜</label> 
						<label class="review" for="review">평점</label>
					</div>
				<ul>
				<%
				Date today = new Date(System.currentTimeMillis());
				for(int i = 0 ; i < reserList.size();i++){
					ReservationDTO r = reserList.get(i);
					if(r.getCheckout_date().before(today) && r.getReview() == 0){
						%>
						<li class="reservationInfo">
						<p class="day"><%=r.getReserve_date()%></p>
						<p class="room_name"><%=idao.getItem(r.getCode()).getName()%></p>
						<p class="price"><%=reserList.get(i).getPrice()%>원
						</p>
						<p class="check_date"><%=r.getCheckin_date()%></p>
						<p class="check_date"><%=r.getCheckout_date()%></p>
						<p class="star">
						<form name="myform" id='myform<%=r.getReservationCode()%>' class = "myform" method="post" action="" onclick ="radioChange(<%=r.getReservationCode()%>)">
					    <fieldset>
					        <input type="radio" name="rating" value="1" id="rate5"><label for="rate1">⭐</label>
					        <input type="radio" name="rating" value="2" id="rate4"><label for="rate2">⭐</label>
					        <input type="radio" name="rating" value="3" id="rate3"><label for="rate3">⭐</label>
					        <input type="radio" name="rating" value="4" id="rate2"><label for="rate4">⭐</label>
					        <input type="radio" name="rating" value="5" id="rate1"><label for="rate5">⭐</label>
					    </fieldset>
					</form>
						<%
					}
				}
				%>
			`
		}
	}
	
	function clickEvent(code) {
		let form = document.getElementById('form' + code);
		form.submit();
	}
	
	function radioChange(code){
		let selected = document.querySelector('input[name="rating"]:checked').value;
		console.log(selected);
		$.ajax({
			method: 'post',
			url: `/green_project/ServicesServlet?command=review&code=`+code+`&rate=`+selected,
			success :
			function(e){
				alert("리뷰를 남겼습니다~");	
			}
		});
	}
</script>

<%@ include file="/fix/footer.jsp"%>
