package controller_action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.UserDAO;

public class LoginAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = UserDAO.getInstance();
		PrintWriter out = response.getWriter();
	    //로그인 확인용 유저 dto생성

		String id=request.getParameter("id");
		String password=request.getParameter("password");
		String url = "/green_project/index";
		if(dao.logIn(id, password)) {

		}
		else {
			url = "/green_project/login/login.jsp?success=no";
		}
		response.sendRedirect(url);			
	}
}
