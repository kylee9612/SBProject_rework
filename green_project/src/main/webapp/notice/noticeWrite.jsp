<%@page import="green_project.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp" %>

<head>
	<meta charset="UTF-8">
	<title>공지사항 Write</title>
    <link rel="stylesheet" href="/green_project/css/qaboard.css">
</head>
<%
	int no=Integer.parseInt(request.getParameter("no"));
	UserDTO user;
	int auth;
	if(dao.getLog()!=null){
		user=dao.getUser(dao.getLog());
		auth=user.getAuthority();
	}
	else{
		auth=2;
	}
	System.out.println(auth);
%>
<div id="wrap">
    <h3>공지사항 작성</h3>
    <input type="hidden" value="<%=auth%>" id="auth">
    <form action="/green_project/ServicesServlet" class="qaboard_write">
        <div class="write_title">
            <label for="title">제목</label>
            <input type="text" name="title" id="" required>
        </div>
        <textarea name="contents" id="" cols="30" rows="10" required></textarea>
        <input type="hidden" name="command" value="Announcement">
        <input type="submit" value="작성하기">
    </form>
</div>
<script src="/green_project/script/noticeAuthCheck2.js"></script>
<%@ include file="/fix/footer.jsp" %>