package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.UserDAO;

public class IDFindAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDAO dao = UserDAO.getInstance();
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String name = request.getParameter("name");
		String mobile = request.getParameter("mobile");


		String url = "/green_project/login/idFindview.jsp?result=" + dao.getUserId(name, mobile);

		response.sendRedirect(url);
	}
}
