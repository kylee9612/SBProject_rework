<%@page import="green_project.DBManager"%>
<%@page import="green_project.BoardDAO"%>
<%@page import="model.Board"%>
<%@page import="green_project.AnnouncementDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice view</title>
<link rel="stylesheet" href="/green_project/css/qaboard.css">
</head>
<body>
<% 

	BoardDAO dao = BoardDAO.getInstance();
	int no=Integer.parseInt(request.getParameter("no"));
	Board noticeBoard=dao.getBoard("Announcement",no);
	AnnouncementDTO notice= (AnnouncementDTO)noticeBoard;
	DBManager dbm=new DBManager();
	AnnouncementDTO board=(AnnouncementDTO)dbm.getBoard("Announcement", no);
	
%>
	<form method="post" action="/green_project/ServicesServlet?command=updateNotice&no=<%=no%>" class="qaboard_write">
        <div class="write_title">
            <label for="title">제목</label>
            <input type="text" name="title" id="" value="<%=board.getTitle() %>" required>
        </div>
        <textarea name="contents" id="" cols="40" rows="20" required><%=board.getContents()%></textarea>
        <input type="button" value="뒤로가기" onclick="location.href='/green_project/notice/notice.jsp'">
        <input type="submit" value="수정">
    </form>
	
</body>
</html>