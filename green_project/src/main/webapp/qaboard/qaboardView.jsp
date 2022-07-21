<%@page import="green_project.AnswerDTO"%>
<%@page import="green_project.QuestionDTO"%>
<%@page import="model.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/fix/sub_header.jsp" %>

<link rel="stylesheet" href="/green_project/css/qaboard.css">

<%
	if (request.getParameter("no") == null) {
		%>
		<script>window.history.back()</script>
		<%
	}


	int no = Integer.parseInt(request.getParameter("no"));
 
	QuestionDTO question = (QuestionDTO)bdao.getBoard("Question", no);
	String title = question.getTitle();
	String id = question.getId();
	String contents = question.getContents().replace("<br>", "\r\n");
	Date written = question.getWritten();
%>

<div id="wrap">
    <h3 class="title_name">Q & A</h3>
    <div class="qaview_wrap">
    	<h5><span class="tit">제목 : </span><%=title %></h5>
    	<p class="q_id"><span class="tit">작성자 : </span><%=id %></p>
        <textarea name="contents" id="" cols="30" rows="10" required readonly><%=contents %></textarea>
        <p class="q_written"><span class="tit">작성일</span><%=written %></p>

		<div class="view_btn_wrap">
			<%
			if (log != null) {
			%>
			<%
			if (log.equals(id)) {
			%>
			<button class="modify_btn"
				onclick="location.href='/green_project/qaboard/qaboardWrite.jsp?no=<%=no%>&type=Question'">수정하기</button>
			<%
			}
			if (log.equals(id) || dao.getAuth(log) == 0) {
			%>
			<form action="/green_project/ServicesServlet" method="post">
				<input type="hidden" name="command" value="deleteQA"> <input
					type="hidden" name="type" value="Question"> <input
					type="hidden" name="no" value="<%=no%>"> <input
					type="submit" class="delete_btn" value="삭제하기" id="delete_btn">
			</form>
			<%
			}
			if (dao.getAuth(log) == 0) {
			%>
			<button class="answer_btn"
				onclick="location.href='/green_project/qaboard/qaboardWrite.jsp?questionno=<%=no%>&type=Answer'">답변달기</button>
			<%
			}
			}
			%>
			<%--
			<button class="back_btn"
			onclick="window.history.back()">뒤로가기</button>
			--%>
		</div>
	</div>
    
    <%
        ArrayList<Board> answerList = bdao.getBoardList("Answer", no);
        if (answerList.size() > 0) {
        	for (int i = 0; i < answerList.size(); i++) {
        		int ano = answerList.get(i).getNo();
        		String atitle = answerList.get(i).getTitle();
        		String aid = answerList.get(i).getId();
        		String acontents = answerList.get(i).getContents();
        		Date awritten = answerList.get(i).getWritten();
        %>
			    <div class="qaview_wrap answer_wrap">
			    	<h4>답변</h4>
			    	<h5><span class="tit">제목 : </span><%=atitle %></h5>
			    	<p class="q_id"><span class="tit">작성자 : </span><%=aid %></p>
			        <textarea name="contents" id="" cols="30" rows="10" required readonly><%=acontents %></textarea>
			        <p class="q_written"><span class="tit">작성일</span><%=awritten %></p>
			        
			        <%
			        if (dao.getLog() != null && dao.getLog().equals(aid)) {
			        %>
			        <div class="view_btn_wrap">
			        	<button class="modify_btn" onclick="location.href='/green_project/qaboard/qaboardWrite.jsp?no=<%=ano%>&type=Answer'">수정하기</button>
			       		<form action="/green_project/ServicesServlet" method="post">      		
   							<input type="hidden" name="command" value="deleteQA">				       		
		    				<input type="hidden" name="type" value="Answer">
		    				<input type="hidden" name="no" value="<%=ano%>">
				       		<input type="submit" class="delete_btn" value="삭제하기">
			       		</form>
			        </div>
			        <%
			        }
			        %>
			    </div>
    			<%
    		}
    	}
    %>
</div>
<button class="topBtn">top</button>

<script>
	$('.delete_btn').click(event => {
		let text = '삭제하시겠습니까?';
		if (!confirm(text)) {
			event.preventDefault();
		} else {
			event.unbind();
		}
	});
</script>

<%@ include file="/fix/footer.jsp" %>