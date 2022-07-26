package controller_action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.BoardDAO;
import controller.DBManager;
import model.Board;

public class DelNoticeAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		int no = Integer.parseInt(request.getParameter("no"));
		DBManager dbm=new DBManager();
		
		dbm.deleteBoard("Announcement",no);
		String url = "/notice";
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
