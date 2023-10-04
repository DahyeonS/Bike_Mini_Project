package khBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class khBoardController {
	public void khBoardProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/",4)[2]);
		if (uri.split("/",4)[2].equals("khBoard")) {
			if (action.equals("/boardList.do")) response.sendRedirect("../khBoard/boardList.jsp");
			if (action.equals("/qnaList.do")) response.sendRedirect("../khBoard/qnaList.jsp");
			if (action.equals("/boardUpdate.do")) {
			
				String view = "../khBoard/boardUpdate.jsp";
		        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		        dispatcher.forward(request, response);
			}
			if (action.equals("/qnaUpdate.do")) {
				
				String view = "../khBoard/qnaUpdate.jsp";
		        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		        dispatcher.forward(request, response);
			}
		}
	}
}
