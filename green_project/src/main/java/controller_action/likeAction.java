package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.ItemDAO;
import green_project.LikeListDAO;

public class likeAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		int code = Integer.parseInt(request.getParameter("code"));
		ItemDAO dao = ItemDAO.getInstance();
		
		
		
		LikeListDAO likeDAO = LikeListDAO.getInstance();
		
		
		String log = request.getParameter("log");
		
		
		String value = request.getParameter("value");
		System.out.println("라이크 액션 : "+value);
		
		
		
		if(value.equals("true")) {
			System.out.println("좋아요 올라가요");
			dao.addLikeCount(code);
			likeDAO.addLikeItem(log, code);
		}
		if(value.equals("false")) {
			System.out.println("좋아요 내려가요");
			dao.minusLikeCount(code);
			likeDAO.deleteLikeItem(log, code);
		}
//		String url="ServicesServlet";
		String url="item/roomInfo.jsp";
		request.getRequestDispatcher(url).forward(request, response);
//		System.out.println("아이템/룸리스트");
	}

}
