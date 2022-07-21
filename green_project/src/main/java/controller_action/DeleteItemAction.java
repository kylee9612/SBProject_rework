package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.ItemDAO;
import green_project.UserDAO;

public class DeleteItemAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ItemDAO dao = ItemDAO.getInstance();
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		String id = request.getParameter("id");
		int code = Integer.parseInt(request.getParameter("code"));
		String url = "";

		if(dao.deleteItem(id,code)) {
			url = "/green_project/login/ceoPage.jsp";
		}else {
			url = "/green_project/login/ceoPage.jsp";
		}
		

		response.sendRedirect(url);
	}
}
