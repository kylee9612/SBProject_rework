<%@page import="java.util.ArrayList"%>
<%@page import="green_project.DBManager"%>
<%@page import="green_project.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/green_project/css/snakeGame.css">
</head>
<body>
	<%
		//유저 로그 dao로 가져오기
		UserDAO dao=UserDAO.getInstance();
		String log=dao.getLog();
		DBManager dbm=new DBManager();
		ArrayList<String> rankList=dbm.snakeRankList();
		
		
		//랭크 정렬
		for(int n=0; n<rankList.size(); n++){
    		String[] temp=rankList.get(n).split("/");
    		String tempId=temp[0];
    		int num=Integer.parseInt(temp[1]);
    		for(int i=0; i<rankList.size(); i++){
	    		String[] target=rankList.get(n).split("/");
	    		String targetId=temp[0];
	    		int targetNum=Integer.parseInt(temp[1]);
    		}
		}
		
	%>
	<div id="wrap">
	<h1><a href="index.jsp">SB Project</a></h1>
		<h1>Snake Game</h1>
	    <div class="gameContainer">
	    </div>
	    <h4 class="winCnt"></h4>
	    <div class="result"><button class="reset">restart</button></div>
	    <div class="rank">
	        <div class="rankTitle"></div>
	        <div class="rankBoard">
	        <%
	        	for(int n=0; n<rankList.size(); n++){
	        		String[] temp=rankList.get(n).split("/");
	        %>
	        <div>No.<%=n+1%> : <%=temp[0]%> 점수: <%=Integer.parseInt(temp[1])%>점</div>	 
	        <%
	        	}
	        %>       
	        </div>
			<div type="hidden" id="userId" value="<%=log%>"></div>
	    </div>
	</div>
	
	<script src="./script/snakeFn.js"></script>
</body>
</html>
