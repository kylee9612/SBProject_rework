package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.ItemDAO;
import controller.LikeListDAO;

public class LikeAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		int code = Integer.parseInt(request.getParameter("code"));
		ItemDAO dao = ItemDAO.getInstance();
		LikeListDAO likeDAO = LikeListDAO.getInstance();
		String log = request.getParameter("log");
		String value = request.getParameter("value");
		
		if(value.equals("true")) {
			dao.addLikeCount(code);
			likeDAO.addLikeItem(log, code);
		}
		if(value.equals("false")) {
			System.out.println("change");
			dao.minusLikeCount(code);
			likeDAO.deleteLikeItem(log, code);
		}
		
		String url="item/roomInfo.jsp";
		request.getRequestDispatcher(url).forward(request, response);
	}
}
