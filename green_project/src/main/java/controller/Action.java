package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/***********************************************************************************/

// 담당 : 이인상

/***********************************************************************************/

public interface Action {
	public void execute (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
}
