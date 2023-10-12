package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import khBoard.khBoardController;
import member.MemberController;
import qna.QnaController;

@WebServlet("*.do")
public class DispatcherController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		response.setContentType("application/x-json; charset=UTF-8");
		process(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
//		한글 처리
		response.setContentType("application/x-json; charset=UTF-8");
		process(request, response);
	}

	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri+"메인 컨트롤러 process");
		System.out.println(uri.split("/", 4)[2]+"메인 컨트롤러 process");
		
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (uri.split("/", 4)[2].equals("home")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../home/index.jsp");
			}
		} else if (uri.split("/", 4)[2].equals("member")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../home/index.jsp");
			}
			MemberController memberControl = new MemberController();
			memberControl.memberProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("qna")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../home/index.jsp");
			}
			QnaController qnaControl = new QnaController();
			qnaControl.qnaProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("khBoard")) {
			System.out.println(uri.split("/", 4)[2]+"+khBoard");
			khBoardController khBoardControl = new khBoardController();
			khBoardControl.khBoardProcess(request, response);
		} else {
			if (action.equals("/index.do")) response.sendRedirect("../home/index.jsp");
		}
	}
}
