package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.ReservationDAO;
import green_project.UserDAO;

public class DeleteReservationAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reservation_code = Integer.parseInt(request.getParameter("reserve_code"));
		ReservationDAO rdao = ReservationDAO.getInstance();
		UserDAO dao = UserDAO.getInstance();
		if(rdao.deleteReservation(reservation_code)) {
			System.out.println("Successfully Deleted Reservation");
		}
		else {
			System.err.println("Deleting Failed");
		}
		String url = "";
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
