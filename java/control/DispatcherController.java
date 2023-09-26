package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardController;
import member.MemberController;
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
		MemberController memberControl = new MemberController();
		memberControl.memberProcess(request, response);
		
		BoardController boardControl = new BoardController();
		boardControl.boardProcess(request, response);
		
		QnaController qnaControl = new QnaController();
		qnaControl.qnaProcess(request, response);
	}
}
