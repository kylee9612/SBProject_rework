package controller_action;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.ReservationDAO;

public class AddReservationAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		int code = Integer.parseInt(request.getParameter("code"));
		Date checkIn = Date.valueOf(request.getParameter("checkIn"));
		Date checkOut = Date.valueOf(request.getParameter("checkOut"));
		String id = request.getParameter("id");
		String priceRaw = request.getParameter("price");
		int price = Integer.parseInt(priceRaw.substring(0,priceRaw.length()-1));
		ReservationDAO rDao = ReservationDAO.getInstance();
		rDao.addNewReservation(id, code, price, checkIn, checkOut);
		
		response.sendRedirect("/green_project/login/mypage.jsp?page=reserve");
	}
}
