package qna;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class QnaControllerXml{
		
	protected void requestMapping(String action, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("MemberController - requestMapping");
		
		QnaService service = new QnaServiceImpl();
		String view = "";
		
		if(action.equals("/boardPrev.mx")) {
			System.out.println("/boardPrev.mx");
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String nickname = request.getParameter("nickname");
			
			int num = 0;
			String sNum = request.getParameter("num");
			if (sNum != null) num = Integer.parseInt(sNum);
			
			int result = 0;
			if (title != null) result = service.getBoardPrevTitle(num, title);
			else if (context != null) result = service.getBoardPrevContext(num, context);
			else if (nickname != null) result = service.getBoardPrevNickname(num, nickname);
			else result = service.getBoardPrev(num);
			request.setAttribute("num", result);
			
			view = "boardView.jsp?num=" + result;
			viewResolver(view, request, response);
		} else if(action.equals("/boardNext.mx")) {
			System.out.println("/boardNext.mx");
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String nickname = request.getParameter("nickname");
			
			int num = 0;
			String sNum = request.getParameter("num");
			if (sNum != null) num = Integer.parseInt(sNum);
			
			int result = 0;
			if (title != null) result = service.getBoardNextTitle(num, title);
			else if (context != null) result = service.getBoardNextContext(num, context);
			else if (nickname != null) result = service.getBoardNextNickname(num, nickname);
			else result = service.getBoardNext(num);
			request.setAttribute("num", result);
			
			view = "boardView.jsp?num=" + result;
			viewResolver(view, request, response);
		}
	}

	void viewResolver(String view, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String viewExt = view.split("\\.")[1];
		
		if(viewExt.equals("jsp")) {
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}else {
			response.sendRedirect(view);
		}
		
	}
}
