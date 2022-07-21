package controller_action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.BoardDAO;
import model.Board;

public class DeleteQAAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String type = request.getParameter("type");
		int no = Integer.parseInt(request.getParameter("no"));
		
		BoardDAO dao = BoardDAO.getInstance();
		
		ArrayList<Board> answerList;
		if (type.equals("Question")) {
			answerList = dao.getBoardList("Answer", no);
			for (int i = 0; i < answerList.size(); i++) {
				System.out.println(dao.delteBoard("Answer", answerList.get(i).getNo()));
			}
		}
		
		System.out.println(dao.delteBoard(type, no));
		
		String url = "./qaboard";
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
