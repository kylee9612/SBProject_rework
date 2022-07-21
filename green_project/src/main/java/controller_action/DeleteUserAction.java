package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.UserDAO;
import green_project.UserDTO;

public class DeleteUserAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		UserDAO dao = UserDAO.getInstance();
		UserDTO user = dao.getUser(id); 
		if(dao.deleteUser(user)) {
			System.out.println("Successfully Deleted");
		}
		else
			System.err.println("Deleting Failed");
		
		response.sendRedirect("/green_project/admin/admin_index.jsp");
	}
}
