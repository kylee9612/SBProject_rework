package controller_action;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import controller.BoardDAO;
import controller.DBManager;
import controller.UserDAO;

public class WriteQuestionAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");

		UserDAO dao = UserDAO.getInstance();
		BoardDAO bdao = BoardDAO.getInstance();

		String type = "Question";
		int no = 0;
		if (request.getParameter("questionno") != null) {
			no = Integer.parseInt(request.getParameter("questionno"));
			type = "Answer";
		}

		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		contents = contents.replace("\r\n", "<br>");

		String id = dao.getLog();
		
		Date date = new Date(System.currentTimeMillis());
		
		System.out.println(bdao.addBoard(type, id, title, contents, date, no));
		
		String url = "./qaboard";

		request.getRequestDispatcher(url).forward(request, response);
	}

}
