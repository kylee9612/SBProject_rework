package controller_action;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.BoardDAO;
import green_project.DBManager;
import green_project.UserDAO;
import model.Board;

public class updateAnnouncementAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		contents = contents.replace("\r\n", "<br>");
		System.out.println(title);
		UserDAO udao = UserDAO.getInstance();
		String id = udao.getLog();
		DBManager dbm = new DBManager();
		int no = Integer.parseInt(request.getParameter("no"));
		String type="Announcement";
		BoardDAO bdao = BoardDAO.getInstance();
		
		Board newBoard = new Board(title,contents) {};
		bdao.updateBoard(newBoard, type, no);
		String url="/notice";
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
