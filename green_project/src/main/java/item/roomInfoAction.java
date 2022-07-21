package item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.ItemDAO;
import green_project.ItemDTO;

public class roomInfoAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		int code = Integer.parseInt(request.getParameter("code"));
		String city =request.getParameter("city");
		String county = request.getParameter("county");
		String address = request.getParameter("address");
		System.out.println("룸인포액션 코드 : "+code);
		System.out.println("룸인포액션 city : "+city);
		System.out.println("룸인포액션 county : "+county);
		System.out.println("룸인포액션 address : "+address);
		
		ItemDAO dao = ItemDAO.getInstance();
		dao.addViewCount(code);
		
		String url="item/roomInfo.jsp?city="+city+"&county="+county+"&code="+code+"&address="+address;
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		request.getRequestDispatcher(url).forward(request, response);
		System.out.println("아이템/룸인포액션 끝");
	}

}
