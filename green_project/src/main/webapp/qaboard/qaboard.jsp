<%@page import="green_project.AnswerDTO"%>
<%@page import="java.sql.Date"%>
<%@page import="model.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="green_project.QuestionDTO"%>
<%@ include file="/fix/sub_header.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<link rel="stylesheet" href="/green_project/css/qaboard.css">

<%
	int curPage = 1;

	if (request.getParameter("page") != null) {
 		curPage = Integer.parseInt(request.getParameter("page"));
	}

	int size = 5;
	
	ArrayList<Board> questionList = bdao.getBoardList("Question");
	
	int index = (curPage-1) * size;
	int totPage = questionList.size() % size == 0 ? questionList.size()/size :questionList.size()/size+1;
	System.out.println(index);
%>

<div id="wrap">
        <h3 class="title_name">Q & A</h3>
        <div class="qaboard">
            <div class="label_wrap">
                <label class="no" for="no">no</label>
                <label class="title" for="title">title</label>
                <label class="user_id" for="user_id">id</label>
                <label class="write_date" for="write_date">date</label>
            </div>
            <ul>
            <%
           	for (int i = index; i < index + size; i++) {
           		if (i < questionList.size()) {
           		QuestionDTO question = (QuestionDTO)questionList.get(i);
           		int no = question.getNo();
           		String id = question.getId();
           		String title = question.getTitle();
           		Date written = question.getWritten();
           		%>
                <li class="question" onclick="location.href='/green_project/qaboard/qaboardView.jsp?no=<%=no%>'">
                    <p class="no"><%=(i+1) %></p>
                    <p class="title q_tit<%=i%>"><%=title %></p>
                    <p class="user_id"><%=id %></p>
                    <p class="write_date"><%=written %></p>
                </li>
           		<%
           		
           		ArrayList<Board> answerList = bdao.getBoardList("Answer", no);
           		
           		if (answerList != null && answerList.size() != 0) {
           			%>
           			<script type="text/javascript">
						$('.q_tit<%=i%>').prepend('<span class="answer_compl">답변완료</span>');
					</script>
           			<%
           			for (int j = 0; j < answerList.size(); j++) {
           				AnswerDTO answer = (AnswerDTO)answerList.get(j);
           				String aId = answer.getId();
           				String aTitle = answer.getTitle();
           				Date aWritten = answer.getWritten();
           		%>
           			
                <li class="answer" onclick="location.href='/green_project/qaboard/qaboardView.jsp?no=<%=no%>'">
                    <p class="title"><span class="a_tit">답변:</span><%=aTitle %></p>
                    <p class="user_id"><%=aId %></p>
                    <p class="write_date"><%=aWritten %></p>
                </li>	
           		<%
           				}
           			}
           		}
           	}
            %>
            </ul>
            <div class="pre_next_wrap">
			<span class="pre" onclick="prePage(<%=curPage%>)">이전</span>
			<%--<span><%=curPage %> / <%=totPage %></span> --%>
			<div class="page_number_wrap">
				<%
				int start = curPage - 2 <= 0 ? 1 : curPage - 2;
				int end = curPage + 2 > totPage ? totPage : curPage + 2;

				if (start > 1) {
				%>
				<p>...</p>
				<%
				}
				%>
				<ul class="page_number">
					<%
					for (int i = start; i <= end; i++) {
					%>
					<li onclick="location.href='/green_project/qaboard/qaboard.jsp?page=<%=i%>'"><%=i%></li>
					<%
					}
					if (end < totPage) {
					%>
					<p>...</p>
					<%
					}
					%>
				</ul>
			</div>
			<span class="next" onclick="nextPage(<%=curPage%>)">다음</span>
		</div>
            <%
            if (dao.getLog() != null) {
            %>
            <button onclick="location.href='/green_project/qaboard/qaboardWrite.jsp'" class="write_btn">작성하기</button>
            <%
            	} else {
            %>
            <button onclick="location.href='/green_project/login/login.jsp'" class="write_btn">작성하기</button>
            <%
            	}
            %>
        </div>
</div>


<script type="text/javascript">
	function prePage(page) {
		if (page > 1) {
			location.href='/green_project/qaboard/qaboard.jsp?page=' + (page-1);
		}
	}
	
	function nextPage(page) {
		if (page < <%=totPage%>) {
			location.href='/green_project/qaboard/qaboard.jsp?page=' + (page+1);
		}
	}

</script>
<%@ include file="/fix/footer.jsp" %>