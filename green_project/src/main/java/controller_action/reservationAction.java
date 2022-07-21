package controller_action;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.ItemDAO;
import green_project.ReservationDAO;

public class reservationAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int code = Integer.parseInt(request.getParameter("code"));
		String id = request.getParameter("id");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		System.out.println("예약 코드 : "+code);
		System.out.println("예약 아이디 : "+id);
		System.out.println("예약 스타트데이트 : "+startDate);
		System.out.println("예약 엔드데이트 : "+endDate);
		
		ReservationDAO dao = ReservationDAO.getInstance();
		LocalDate date = LocalDate.now();
		
		Date dd = new Date(date.getYear(),date.getMonthValue(),date.getDayOfMonth());
		
		dao.addNewReservation(id, code, dd, dd);
		
		String url="/green_priject/index";
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		request.getRequestDispatcher(url).forward(request, response);
		System.out.println("예약 액션 끝");
	}

}
