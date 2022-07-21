package controller_action;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.BoardDAO;
import controller.DBManager;
import controller.UserDAO;

public class WriteAnnouncementAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		contents = contents.replace("\r\n", "<br>");
		
		UserDAO dao = UserDAO.getInstance();
		String id = dao.getLog();
		int no = 0;
		
		BoardDAO bdao = BoardDAO.getInstance();
		bdao.addBoard("Announcement", id, title, contents, new Date(System.currentTimeMillis()), no);
		
		String url="/notice";
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
