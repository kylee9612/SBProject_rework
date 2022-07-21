package item;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.ItemDAO;
import green_project.ItemDTO;

public class roomListAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String city =request.getParameter("city");
		String county = request.getParameter("county");
		String address = city+"/"+county;
		
		if(city==null && county==null)
			address="전체/전체";
		if(request.getParameter("address")!=null)
			address=request.getParameter("address");
		
		System.out.println("룸리스트 액션 address : "+address);
		String id = request.getParameter("id");
		String like = request.getParameter("like");
		ItemDAO dao = ItemDAO.getInstance();
		String url="item/roomList.jsp?city="+city+"&county="+county+"&address="+address+"&id="+id+"&like="+like;
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		request.getRequestDispatcher(url).forward(request, response);
	}

}
