package controller_action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.ItemDAO;

public class RoomInfoAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int code = Integer.parseInt(request.getParameter("code"));
		String city =request.getParameter("city");
		String county = request.getParameter("county");
		String address = request.getParameter("address");
		String checkInDate = request.getParameter("checkIn");
		String checkOutDate = request.getParameter("checkOut");
		System.out.println("룸인포액션 코드 : "+code);
		System.out.println("룸인포액션 city : "+city);
		System.out.println("룸인포액션 county : "+county);
		System.out.println("룸인포액션 address : "+address);
		
		ItemDAO dao = ItemDAO.getInstance();
		dao.addViewCount(code);
		
		String url="item/roomInfo.jsp?city="+city+"&county="+county+"&code="+code+"&address="+address+"&checkIn="+checkInDate+"&checkOut="+checkOutDate;
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		request.getRequestDispatcher(url).forward(request, response);
		System.out.println("아이템/룸인포액션 끝");
	}

}
