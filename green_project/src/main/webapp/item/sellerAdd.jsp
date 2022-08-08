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
	            <input class = "formInput" type="text" id="sample3_postcode" placeholder="우편번호" readonly required="required">
				<input type="button" class = "addressBtn" onclick="sample3_execDaumPostcode()" value="우편번호 찾기"><br>
				<div id="address"></div>
				<input type="text" id="sample3_roadAddress" class="formInput address" placeholder="도로명주소" readonly required="required">
				<input class = "formInput address" type="text" id="sample3_jibunAddress" placeholder="주소" name="address" readonly required="required"><br>
				<input class = "formInput etc" type="text" id="sample3_detailAddress" placeholder="상세주소" name="address2" required="required">
				<input class = "formInput etc" type="text" id="sample3_extraAddress" placeholder="참고항목"  name="address3" readonly required="required">
				<div id="address" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>
	        	<div class="div">
	        		<div>
	               	 	<input class = "req formInput" type="text" name="name" placeholder="상호명" required="required">
	                	<input class = "formInput" type="text" name="thumbnail" placeholder="썸네일 주소" required="required">
	                </div>
	                <div>
		                <select class = "formInput" name="category">
		                	<option value="motel">모텔</option>
	    	            	<option value="hotel">호텔</option>
	        	        	<option value="resort">리조트</option>
	            	    	<option value="Pension">펜션</option>
	                		<option value="guest house">게스트하우스</option>
	                		<option value="camping">캠핑</option>
	                	</select>
	        			<input class = "formInput req" type="number" name="max_people" placeholder="최대 인원" required="required">
	        			<input class = "formInput req" type="number" name="price" placeholder="가격" required="required">
	        		</div>
	                <textarea class = "formInput info" name="contents" id="www" placeholder="객실 정보" required="required"></textarea>
	        	</div>
	        </div>
	        <input class="addressBtn" type="submit" value="등록">
	        <input class="addressBtn" type="button" value="취소" onclick="location.href='../index'">
	    </form>
		        
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
	</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../script/addressApi.js"></script>
<script type="text/javascript">

function sample3_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ''; // 추가 정보 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample3_postcode').value = data.zonecode;
            document.getElementById("sample3_roadAddress").value = roadAddr;
            document.getElementById("sample3_jibunAddress").value = data.jibunAddress;
            
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if(roadAddr !== ''){
                document.getElementById("sample3_extraAddress").value = extraRoadAddr;
            } else {
                document.getElementById("sample3_extraAddress").value = '';
            }
        }
    }).open();
}
</script>
</body>
</html>
<%@ include file="/fix/footer.jsp" %>