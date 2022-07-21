<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp" %>
<!DOCTYPE html>
<html lang="kor">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="/green_project/css/item.css">
</head>
<body>
	<div id="wrap">
	    <form id=form method="post" action="/green_project/ServicesServlet">
	    	<input type="hidden" name="command" value="addItem">
	        <div>
	            <input type="hidden" name="id" value="admin">
	            <input type="text" id="sample3_postcode" placeholder="우편번호" readonly>
				<input type="button" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>
				<div id="address"></div>
				<input type="text" id="sample3_address" placeholder="주소" name="address"><br>
				<input type="text" id="sample3_detailAddress" placeholder="상세주소" name="address2">
				<input type="text" id="sample3_extraAddress" placeholder="참고항목"  name="address3">
				
				<div id="address" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
	
	        	<div>
	                <input class = "req" type="text" name="name" placeholder="상호명"><br>
	                <div>인풋 이미지??</div><br>
	                <textarea name="contents" id="www" placeholder="객실 정보"></textarea>
	        	</div>
	                <select name="category">
	                	<option value="motel">모텔</option>
	                	<option value="hotel">호텔</option>
	                	<option value="resort">리조트</option>
	                	<option value="Pension">펜션</option>
	                	<option value="guest house">게스트하우스</option>
	                	<option value="camping">캠핑</option>
	                </select>
	        	<div>
	        		<input type="text" name="thumbnail" placeholder="썸네일 주소">
	        		<input type="number" name="max_people" placeholder="최대 인원">
	        		<input type="number" name="price" placeholder="가격">
	        	</div>
	        </div>
	        
	        <input type="submit" value="등록">
	        <!-- <input type="button" value="등록" onclick="location.href='addItem'"> -->
	    </form>
	        <input type="button" value="취소" onclick="location.href='../index'">
		        
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
	</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../script/addressApi.js"></script>
</body>
</html>
<%@ include file="/fix/footer.jsp" %>