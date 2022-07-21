package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.UserDAO;
import green_project.UserDTO;

public class JoinAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8"); 
	    
	    UserDAO dao = UserDAO.getInstance();
		UserDTO user = null;

		String id=request.getParameter("id");
	    String password=request.getParameter("password");
	    String name=request.getParameter("name");
	    int age = Integer.parseInt(request.getParameter("age"));
	    String mobile = request.getParameter("mobile");
	    String email = request.getParameter("email");
	    int point = 0;
	    int authority = Integer.parseInt(request.getParameter("authority"));
	    int sns = Integer.parseInt(request.getParameter("sns"));

	    user= new UserDTO(id,password,name,age,mobile,email,point,authority);
	    
	    String url="";
	    
	    System.out.println(id);
	    
		if(dao.addUser(user)){
			//회원가입 성공
			System.out.println("유저생성");
			//login.jsp로 페이지 이동
			if(sns == 1) {
				dao.setLog(id);
				url="/green_project/index.jsp";	
			}else {		
				url="/green_project/login/login.jsp?success=yes";
			}
		}
		else{
			//중복으로 인한 회원가입 실패
			//join.jsp
			System.out.println("생성실패");
			//요청에 대한 응답처리를 해주는 것.
			url="/green_project/login/login.jsp";
		}
		
		response.sendRedirect(url);
	    
	}
}
