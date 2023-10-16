package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jhBoard.JhBoardController;
import jmsboard.JmsController;
import khBoard.KhBoardController;
import member.MemberController;
import novel.NovelController;
import pcgpkg.PcgBoardController;
import qna.QnaController;

@WebServlet("*.do")
public class DispatcherController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		process(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
//		한글 처리
		request.setCharacterEncoding("UTF-8");
		process(request, response);
	}

	protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (uri.split("/", 4)[2].equals("home")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.jsp");
			}
		} else if (uri.split("/", 4)[2].equals("jmsboard")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.jsp");
			}
			JmsController jmsControll = new JmsController();
			jmsControll.process(request, response);
		} else if (uri.split("/", 4)[2].equals("member")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.jsp");
			}
			MemberController memberControl = new MemberController();
			memberControl.memberProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("qna")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.jsp");
			}
			QnaController qnaControl = new QnaController();
			qnaControl.qnaProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("novel")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.jsp");
			}
			NovelController novelControl = new NovelController();
			novelControl.novelProcess(request, response);
		}  else if (uri.split("/", 4)[2].equals("pcgboard")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.jsp");
			}
			PcgBoardController boardControl = new PcgBoardController();
			boardControl.PcgProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("khBoard")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.jsp");
			}
			KhBoardController khBoardControl = new KhBoardController();
			khBoardControl.khBoardProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("jhBoard")) {
			if (action.equals("/index.do")) {
				response.sendRedirect("../index.jsp");
			}
			JhBoardController jhboardControl = new JhBoardController();
			jhboardControl.jhboardProcess(request, response);			
		} else {
			if (action.equals("/index.do")) response.sendRedirect("./home/index.jsp");
		}
	}
}
