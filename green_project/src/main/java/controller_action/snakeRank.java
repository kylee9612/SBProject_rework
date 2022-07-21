package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.DBManager;

public class snakeRank implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		String log=request.getParameter("log");
		int score=Integer.parseInt(request.getParameter("score"));
		int point=score/10;
		DBManager dbm=new DBManager();
		dbm.addRank(log,score);
		dbm.updateUserPoint(log, point);
		String url="/pointGame/snakeGame.jsp";
		request.getRequestDispatcher(url).forward(request, response);
		
	}
}
