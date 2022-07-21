package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;
import green_project.AnswerDTO;
import green_project.BoardDAO;
import model.Board;

public class UpdateQuestionAction implements Action {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String title = request.getParameter("title");
		String contents = request.getParameter("contents");
		
		int no = Integer.parseInt(request.getParameter("no"));
		String type = request.getParameter("type");
		System.out.println(type);
		
		BoardDAO dao = BoardDAO.getInstance();
		
		Board newBoard = dao.getBoard(type, no);
		newBoard.setTitle(title);
		newBoard.setContents(contents);
		dao.updateBoard(newBoard, type, no);
		
		int nextNo = no;
		if (newBoard instanceof AnswerDTO) {
			nextNo= ((AnswerDTO)newBoard).getCode();
		}
		
//		String url="/qaboard";
		String url="./qaboardView?no=" + nextNo;
		
		request.getRequestDispatcher(url).forward(request, response);
	}

}
