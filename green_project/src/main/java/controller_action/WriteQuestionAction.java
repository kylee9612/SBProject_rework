package controller_action;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.BoardDAO;
import green_project.DBManager;
import green_project.UserDAO;

public class WriteQuestionAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		UserDAO udao = UserDAO.getInstance();
		BoardDAO bdao = BoardDAO.getInstance();
		
//		if (udao.getLog() == null) {
//			response.sendRedirect("/qaboardView");
//		}
		
		String type = "Question";
		int no = 0;
		if (request.getParameter("questionno") != null) {
			no = Integer.parseInt(request.getParameter("questionno"));
			type = "Answer";
		}
		
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		contents = contents.replace("\r\n", "<br>");
		
		String id = udao.getLog();
//		String id = "apple";
//		String id = "admin";
		DBManager dbm = new DBManager();
		
		Date date = new Date(System.currentTimeMillis());
		//SimpleDateFormat sim = new SimpleDateFormat("yyyy-mm-dd");
		//date = Date.valueOf(sim.format(date));
		
		System.out.println(bdao.addBoard(type, id, title, contents, date, no));			
		
		String url = "./qaboard";
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
