package item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.ItemDAO;

public class addItemAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
//		String id, String name, String address, String category, int price, String thumbnail, String contents, int max_people
		String name =request.getParameter("name");
		String address = request.getParameter("address");
		String category = request.getParameter("category");
		String thumbnail = request.getParameter("thumbnail");
		String contents = request.getParameter("contents");
		String id = request.getParameter("id");
		int price = Integer.parseInt(request.getParameter("price"));
		int max_people = Integer.parseInt(request.getParameter("max_people"));
		
		
		System.out.println(address);
		System.out.println(name);
		System.out.println(id);
		System.out.println(category);
		System.out.println(thumbnail);
		System.out.println(contents);
		System.out.println(price);
		System.out.println(max_people);
		String url="index";
		
		ItemDAO dao = ItemDAO.getInstance();
		dao.uploadItem(id, name, address, category, price, thumbnail, contents, max_people);
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		request.getRequestDispatcher(url).forward(request, response);
		
	}

}
