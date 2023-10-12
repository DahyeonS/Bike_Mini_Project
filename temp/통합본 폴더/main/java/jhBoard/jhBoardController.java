package jhBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class jhBoardController {
	public void jhboardProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		
		String action = uri.substring(uri.lastIndexOf("/"));
		if (uri.split("/",4)[2].equals("jhBoard")) {
			if (action.equals("/boardList.do")) response.sendRedirect("../jhBoard/boardList.jsp");	
			if (action.equals("/write.do")) response.sendRedirect("../jhBoard/write.jsp");
			if (action.equals("/view.do")) {
				
				String view = "../jhBoard/view.jsp";
		        RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		        dispatcher.forward(request, response);				
			};
			if (action.equals("/qnaBoardList.do")) response.sendRedirect("../jhBoard/qnaBoardList.jsp");	
			if (action.equals("/qWrite.do")) response.sendRedirect("../jhBoard/qWrite.jsp");
			if (action.equals("/aWrite.do")) {
				String view = "../jhBoard/aWrite.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(view);
				dispatcher.forward(request, response);
			}
			if (action.equals("/qView.do")) {
				
				String view = "../jhBoard/qView.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(view);
				dispatcher.forward(request, response);				
			}
		}
	}
}
