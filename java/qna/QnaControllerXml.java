package qna;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			QnaDTO dto = new QnaDTO();
			
			int num = 0;
			String sNum = request.getParameter("num");
			if (sNum != null) num = Integer.parseInt(sNum);
			dto.setNum(num);
			
			int result = 0;
			if (title != null) {
				dto.setTitle(URLEncoder.encode(title, "UTF-8"));
				result = service.getBoardPrevTitle(dto);
				view = "boardView.jsp?num=" + result + "&title=" + title;
			}
			else if (context != null) {
				dto.setContext(URLEncoder.encode(context, "UTF-8"));
				result = service.getBoardPrevContext(dto);
				view = "boardView.jsp?num=" + result + "&context=" + context;
			}
			else if (nickname != null) {
				dto.setNickname(URLEncoder.encode(nickname, "UTF-8"));
				result = service.getBoardPrevNickname(dto);
				view = "boardView.jsp?num=" + result + "&nickname=" + nickname;
			}
			else {
				result = service.getBoardPrev(dto);
				view = "boardView.jsp?num=" + result;
			}
			request.setAttribute("num", result);
			
			viewResolver(view, request, response);
		} else if(action.equals("/boardNext.mx")) {
			System.out.println("/boardNext.mx");
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String nickname = request.getParameter("nickname");
			QnaDTO dto = new QnaDTO();
			
			int num = 0;
			String sNum = request.getParameter("num");
			if (sNum != null) num = Integer.parseInt(sNum);
			dto.setNum(num);
			
			int result = 0;
			if (title != null) {
				dto.setTitle(URLEncoder.encode(title, "UTF-8"));
				result = service.getBoardNextTitle(dto);
				view = "boardView.jsp?num=" + result + "&title=" + title;
			}
			else if (context != null) {
				dto.setContext(URLEncoder.encode(context, "UTF-8"));
				result = service.getBoardNextContext(dto);
				view = "boardView.jsp?num=" + result + "&context=" + context;
			}
			else if (nickname != null) {
				dto.setNickname(URLEncoder.encode(nickname, "UTF-8"));
				result = service.getBoardNextNickname(dto);
				view = "boardView.jsp?num=" + result + "&nickname=" + nickname;
			}
			else {
				result = service.getBoardNext(dto);
				view = "boardView.jsp?num=" + result;
			}
			request.setAttribute("num", result);
			
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
