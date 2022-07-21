package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import green_project.UserDAO;
import green_project.UserDTO;


/***********************************************************************************/

//담당 : 이인상

/***********************************************************************************/

/**
 * Servlet implementation class loginAction
 */
@WebServlet("/loginAction")
public class loginAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet() 
     */
    public loginAction() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	
		// doGet() 메소드 : http request method - GET 
		
			UserDAO dao = UserDAO.getInstance();
		    //로그인 확인용 유저 dto생성

			String id=request.getParameter("id");
			String password=request.getParameter("password");
			//HttpSession session = request.getSession();
			//session.setAttribute("log", id);
			String url = "/kakaologin.jsp";
			if(dao.logIn(id, password)) {
				int auth = dao.getAuth(id);
				if(auth == 0)
					url = "admin/admin_index.jsp";
				else if (auth == 1)
					url = "index";
				else if(auth == 2)
					url = "index";
			}
			else {
				url = "/login.jsp";
			}
		
		//페이지 이동 관리
		request.getRequestDispatcher(url).forward(request, response);
		
		//세션활용 
		//request.getSession().setAttribute(password, url);
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		// doPost() 메소드 : http request method - GET
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		doGet(request, response);
	}

}
