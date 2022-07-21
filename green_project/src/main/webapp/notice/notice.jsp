<%@page import="green_project.DBManager"%>
<%@page import="green_project.UserDTO"%>
<%@page import="green_project.AnnouncementDTO"%>
<%@page import="green_project.UserDAO"%>
<%@page import="java.sql.Date"%>
<%@page import="model.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="green_project.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp" %>


<head>
	<meta charset="UTF-8">
	<title>공지사항</title>
    <link rel="stylesheet" href="/green_project/css/announcement.css">
</head>

<%
	DBManager dbm=new DBManager();
//페이지당 게시글
	int size = 10;
//현재페이지
	int pageNum=1;
	//페이지 가져오기
	if(request.getParameter("pageNum")!=null){
		
		int tempPage=Integer.parseInt(request.getParameter("pageNum"));
		if(tempPage!=0){
			pageNum=tempPage;
		}
	}
	int startNum=(pageNum-1)*size;
	int endNum=pageNum*size;
	//총 게시글
	int totalNotice=dbm.getNoticeCnt();
	//페이지 갯수
	int endPage=(int)Math.ceil(totalNotice/(double)size);
	BoardDAO Bdao = BoardDAO.getInstance();
	
	ArrayList<Board> noticeList = dbm.getBoardList("Announcement", startNum, endNum);
	
	UserDTO user;
	int auth;
	if(dao.getLog()!=null){ 
		user=dao.getUser(dao.getLog());
		auth=user.getAuthority();
	}
	else{
		auth=2;
	}
%> 

<div id="wrap">
<input type="hidden" value="<%=auth%>" id="auth">
        <h3>공지사항</h3>
        <div class="qaboard">
            <div class="label_wrap">
                <label class="no" for="no">no</label>
                <label class="title" for="title">title</label>
                <label class="user_id" for="user_id">id</label>
                <label class="write_date" for="write_date">date</label>
            </div>
            
           <ul>
            <%
            // 
           	for (int i = 0; i < noticeList.size(); i++) {
           		AnnouncementDTO notice= (AnnouncementDTO)noticeList.get(i);
           		int no = notice.getNo();   
           		String id = notice.getId();
           		String title = notice.getTitle();
           		Date written = notice.getWritten();
           		%>
                <li class="question" onclick="location.href='/green_project/noticeView?no=<%=no%>'">
                    <p class="no"><%=no %></p>
                    <p class="title"><%=title %></p>
                    <p class="id"><%=id %></p>
                    <p class="write_date"><%=written %></p>
                </li>
             <%
           	}
            %> 
            </ul> 
            <input type="hidden" id="page" value="<%=pageNum%>">
            <input type="hidden" id="endpage" value="<%=endPage%>">
            <div class="pre_next_wrap">
                <span class="pre" onclick="pageDown()">이전</span>
                <span><%=pageNum %> / <%=endPage %></span>
                <span class="next" onclick="pageUp()">다음</span>
            </div>
            <button onclick="location.href='/green_project/noticeWrite?no=<%=noticeList.size()+1 %>'" class="write_btn">작성하기</button>
        </div>
</div>



<script src="./script/paging.js">
</script>
<%@ include file="/fix/footer.jsp" %>