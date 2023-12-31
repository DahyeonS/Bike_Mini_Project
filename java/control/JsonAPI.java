package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jhBoard.JhBoardJson;
import jmsboard.JmsApi;
import khBoard.KhBoardJson;
import member.MemberJson;
import novel.NovelJson;
import pcgpkg.PcgJson;
import qna.QnaJson;

@WebServlet("*.json")
public class JsonAPI extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		process(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
		// 한글 처리
		request.setCharacterEncoding("UTF-8");
		process(request, response);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String uri = request.getRequestURI();
		System.out.println(uri);
		
		if (uri.split("/", 4)[2].equals("member")) {
			MemberJson memberJson = new MemberJson();
			memberJson.memberProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("qna")) {
			QnaJson qnaJson = new QnaJson();
			qnaJson.qnaProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("pcgboard")) {
			PcgJson PcgJson = new PcgJson();
			PcgJson.pcgProcess(request, response);
		} else if (uri.split("/", 4)[2].equals("jmsboard")) {
			JmsApi jms = new JmsApi();
			jms.process(request, response);
		} else if (uri.split("/", 4)[2].equals("novel")) {
			NovelJson novelJson = new NovelJson();
			novelJson.novelProcess(request,response);
		} else if (uri.split("/", 4)[2].equals("khBoard")) {
			KhBoardJson khBoardJson = new KhBoardJson();
			khBoardJson.khBoardProcess(request, response);
		} else if (uri.split("/",4)[2].equals("jhBoard")) {
			JhBoardJson boardJson = new JhBoardJson();
			boardJson.boardProcess(request, response);
		}
	}
}
