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
import model.Board;

public class UpdateAnnouncementAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		contents = contents.replace("\r\n", "<br>");
		System.out.println(title);
		UserDAO udao = UserDAO.getInstance();
		int no = Integer.parseInt(request.getParameter("no"));
		String type="Announcement";
		BoardDAO bdao = BoardDAO.getInstance();
		
		Board newBoard = new Board(title,contents) {};
		bdao.updateBoard(newBoard, type, no);
		String url="/notice";
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
