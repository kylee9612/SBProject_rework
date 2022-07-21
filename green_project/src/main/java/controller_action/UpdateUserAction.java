package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.UserDAO;
import green_project.UserDTO;

public class UpdateUserAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		String mobile = request.getParameter("mobile");
		String email = request.getParameter("email");
		int point = Integer.parseInt(request.getParameter("point"));
		int auth = Integer.parseInt(request.getParameter("auth"));
		
		UserDTO user = new UserDTO(id, pw, name, age, mobile, email, point, auth);
		UserDAO dao = UserDAO.getInstance();
		String url ="";
		dao.updateUserInfo(user);
		if(dao.getAuth(dao.getLog()) == 0) {
			url = "/green_project/admin/admin_index.jsp";
		}else if(dao.getAuth(dao.getLog()) == 1) {
			url = "/green_project/login/ceoPage.jsp";
		}else if(dao.getAuth(dao.getLog()) == 2) {
			url = "/green_project/login/mypage.jsp";
		}
		
		
		
		response.sendRedirect(url);
	}
}
