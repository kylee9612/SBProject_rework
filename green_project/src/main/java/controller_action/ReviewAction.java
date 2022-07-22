package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.ReservationDAO;

public class ReviewAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    response.setCharacterEncoding("UTF-8"); 
		
	    int code = Integer.parseInt(request.getParameter("code"));
	    int review = Integer.parseInt(request.getParameter("rate"));
	    
	    ReservationDAO rdao = ReservationDAO.getInstance();
	    rdao.updateReview(code, review);
	}

}
