package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;

public class ReservationAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		int code = Integer.parseInt(request.getParameter("code"));
		String id = request.getParameter("id");
		String url="item/reservation.jsp?code="+code;
		
		request.getRequestDispatcher(url).forward(request, response);
//		System.out.println("아이템/룸리스트");
	}

}
