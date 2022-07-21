<%@page import="model.Board"%>
<%@page import="green_project.QuestionDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp" %>

<link rel="stylesheet" href="/green_project/css/qaboard.css">

<%
	String title = "";
	String contents = "";
	int no = -1;
	String type = "Answer";
	int questionno = -1;
	
	// 수정글인 경우
	if(request.getParameter("no") != null) {
		no = Integer.parseInt(request.getParameter("no"));
	}
	
	// type 받기
	if(request.getParameter("type") != null) {
		type = request.getParameter("type");		
	}
	
	if(request.getParameter("no") != null) {
		Board question = bdao.getBoard(type, no);
		title = question.getTitle();
		contents = question.getContents().replace("<br>", "\r\n");
	}
	
	if (request.getParameter("questionno") != null) {
		questionno = Integer.parseInt(request.getParameter("questionno"));
	}
	
	System.out.println(type);
%>

<div id="wrap">
    <h3 class="title_name">Q & A 작성</h3>
    <form method="post" action="/green_project/ServicesServlet" class="qaboard_write">
    	<%
	if(request.getParameter("no") != null && request.getParameter("questionno") == null) {
		%>
    	<input type="hidden" name="command" value="updateQuestion">
    	<input type="hidden" name="type" value="<%=type%>">
    	<input type="hidden" name="no" value="<%=no%>">
		<%
	} else {
			if (questionno != -1) {
    	%>
	    	<input type="hidden" name="type" value="<%=type%>">
	    	<input type="hidden" name="questionno" value="<%=questionno%>">
    	<%
			}
    	%>
    	<input type="hidden" name="command" value="writeQuestion">
    	<%	
	}
    	%>
        <div class="write_title">
            <label for="title">제목</label>
            <input type="text" name="title" id="" required value="<%=title%>" maxlength="20">
        </div>
        <textarea name="contents" id="contents" cols="30" rows="10" required maxlength="1000"><%=contents %></textarea>
        <input type="submit" value="작성하기">
    </form>
</div>

<%@ include file="/fix/footer.jsp" %>