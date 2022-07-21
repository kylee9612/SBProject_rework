<%@page import="green_project.DBManager"%>
<%@page import="green_project.BoardDAO"%>
<%@page import="model.Board"%>
<%@page import="green_project.AnnouncementDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/fix/sub_header.jsp" %>
<html>
<head>
<meta charset="UTF-8">
<title>notice view</title>
<link rel="stylesheet" href="/green_project/css/noticeView.css">
</head>
<body>
<% 
	BoardDAO Bdaos = BoardDAO.getInstance();
	int no=Integer.parseInt(request.getParameter("no"));
	Board noticeBoard=Bdaos.getBoard("Announcement",no);
	AnnouncementDTO notice= (AnnouncementDTO)noticeBoard;
	DBManager dbm=new DBManager();
	AnnouncementDTO board=(AnnouncementDTO)dbm.getBoard("Announcement", no);
	/*
	
	*/
	UserDTO user;
	int auth;
	if(dao.getLog()!=null){
		user=dao.getUser(dao.getLog());
		auth=user.getAuthority();
	}
	else{
		auth=2;
	}
	if(auth==0){
		
		
	}
	else{
		%>
		<style>
			#delNoticeBt{
				display:none;
			}
			#updateNoticeBt{
				display:none;
			}
		</style>
		
		<% 
	}
%>
<div id="wrap">
    <h3>공지사항</h3>
    <form action="/notice" class="qaboard_write">
        <div class="write_title">
            <label for="title">제목</label>
            <input type="text" name="title" id="" readOnly value="<%=board.getTitle() %>">
        </div>
        <textarea name="contents" id="" cols="30" rows="10" readOnly><%=board.getContents() %></textarea>
        <input type="button" class="bt" value="뒤로가기" onclick="location.href='/green_project/notice/notice.jsp'">
        <input type="button" id="delNoticeBt" class="bt" value="삭제하기" onclick="location.href='/green_project/ServicesServlet?command=delNotice&no=<%=no%>'">
        <input type="button" id="updateNoticeBt" class="bt" value="수정하기" onclick="location.href='/green_project/updateNotice?no=<%=no%>'">
    </form>
</div>


</body>
</html>
<%@ include file="/fix/footer.jsp" %>