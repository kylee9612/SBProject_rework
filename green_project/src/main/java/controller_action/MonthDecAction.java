package controller_action;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Action;

public class MonthDecAction implements Action{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String date = request.getParameter("month");
		int year = Integer.parseInt(date.substring(0,4));
		int month = Integer.parseInt(date.substring(5));
		if(--month < 1) {
			year--;
			month = 12;
		}
		String mon = "";
		if(month < 10)
			mon+="0"+month;
		else
			mon+=month;
		
		String url = "./admin/admin_index.jsp?month="+year+"-"+mon;
		System.out.println(url);
		response.sendRedirect(url);
	}

}
