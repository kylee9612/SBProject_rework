<%@page import="green_project.UserDAO"%>
<%@page import="green_project.UserDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="/green_project/css/webChat.css">
       <%
     //소켓용 추가
   	UserDTO user_;
    UserDAO daos=UserDAO.getInstance();
   	int auth_;
   	if(daos.getLog()!=null){
   		user_=daos.getUser(daos.getLog());
   		auth_=user_.getAuthority();
   	}
   	else{
   		auth_=2;
   	}
       
       %>
       <input type="hidden" value="<%=auth_%>" id="auth_">
       <footer>
       <button id="liveChatBn" onclick="liveChatOn()"><img src="/green_project/resources/chatImg.png" style="width: 45px; height: 25px;"><br>실시간문의</button>
		<div id="iframeLocal" name="1"></div>
           <div class="footer_wrap">

               <h2><a href="/green_project/index.jsp">SB Project</a></h2>

               <nav class="footer_menu">
                   <ul>
                       <li><a href="./qaboard">고객센터</a></li>
                       <li><a href="/green_project/oftenAQ">자주 묻는 질문</a></li>
                       <li><a href="/green_project/notice">공지사항</a></li>
                   </ul>
               </nav>
               <p class="copyright">Copyright ⓒ 이혜주, 이인상, 김병민, 박창우, 권도훈</p>
               
           </div>
           <div class="mem_wrap">
            <ul>
            	<li id="user">
            		<p class="mem_name">이혜주</p>
            		<address><a href="mailto:jinjoo648@naver.com">jinjoo648@naver.com</a></address>
            	</li>
            	<li id="user">
            		<p class="mem_name">이인상</p>
            		<address><a href="mailto:iiii410@naver.com">iiii410@naver.com</a></address>
            	</li>
            	<li id="user">
            		<p class="mem_name">김병민</p>
            		<address><a href="mailto:qudals7214@naver.com">qudals7214@naver.com</a></address>
            	</li>
            	<li id="user">
            		<p class="mem_name">박창우</p>
            		<address><a href="mailto:parkcc321@naver.com">parkcc321@naver.com</a></address>
            	</li>
            	<li id="user">
            		<p class="mem_name">권도훈</p>
            		<address><a href="mailto:ehgns0125@naver.com">ehgns0125@naver.com</a></address>
            	</li>
            </ul>
           </div>
       </footer>
       <script src="/green_project/script/liveChatFn.js"></script>
       <script src="/green_project/js/common.js"></script>
</body>
</html>