<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!---------------------------------------------
	page language 설정을 지워도 문제는 없지만 jsp 저장 시, 매번 무슨 charset으로 저장할지 물으며
	혹시 모를 오류가 있을 수 있으니 지우지 마세요! 
 --------------------------------------------->
<%@ include file="fix/sub_header.jsp" %>

<!---------------------------------------------
 !!!!!!!!!!!!!!! 해당 위치에 있는 head 태그는 내부까지 모두 싹 지워주세요 !!!!!!!!!!!!!!
 --------------------------------------------->

<!---------------------------------------------
	[ link & script ]
	#wrap 밖에서 선언하되, css는 위로 script:src는 아래로 선언해주세요.
 --------------------------------------------->
<link rel="stylesheet" href="./css/qaboard.css">

<div id="wrap">
	<h3 class="title_name">title</h3>
	<!---------------------------------------------
		[ title 설정 ] 
		h3 tag + class = "title_name"을 붙여주셔야 title이 수정됩니다.
	 --------------------------------------------->
</div>
<!--top button -->
<!-- #wrap 바로 아래에 해당 html 태그를 붙여넣으시면 top 버튼을 사용할 수 있습니다.-->
<button class="topBtn">top</button>

<!--<jsp:include page=""></jsp:include>-->

<!--<jsp:forward page="이동할페이지">
	<jsp:param value="" name=""> 에 전달할 파라미터
</jsp:forward>-->

<%@ include file="fix/footer.jsp" %>