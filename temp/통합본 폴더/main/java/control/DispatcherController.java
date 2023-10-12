package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.BoardController;
import jhBoard.jhBoardController;
import jmsboard.JmsController;
import khBoard.khBoardController;
import member.MemberController;
import novel.NovelController;
import pcgpkg.PcgBoardController;
import pcgpkg.PcgJson;
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
//      한글 처리
      request.setCharacterEncoding("UTF-8");
      response.setContentType("application/x-json; charset=UTF-8");
      process(request, response);
   }

   protected void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String uri = request.getRequestURI();
      System.out.println(uri);
      
      String action = uri.substring(uri.lastIndexOf("/"));
      
      if (uri.split("/", 4)[2].equals("home")) {
         if (action.equals("/index.do")) {
            response.sendRedirect("../index.html");
         }
      } else if (uri.split("/", 4)[2].equals("jmsboard")) {
         JmsController jms=new JmsController();
         jms.process(request, response);
      } else if (uri.split("/", 4)[2].equals("member")) {
         MemberController memberControl = new MemberController();
         memberControl.memberProcess(request, response);
      }else if (uri.split("/", 4)[2].equals("qna")) {
         QnaController qnaControl = new QnaController();
         qnaControl.qnaProcess(request, response);
      } else if (uri.split("/", 4)[2].equals("board")) {
         BoardController boardControl = new BoardController();
         boardControl.boardProcess(request, response);
      } else if (uri.split("/", 4)[2].equals("novel")) {
			NovelController novelControl = new NovelController();
			novelControl.novelProcess(request, response);
		}  else if (uri.split("/", 4)[2].equals("pcgboard")) {
    	   PcgBoardController boardControl = new PcgBoardController();
           boardControl.PcgProcess(request, response);
        } else if (uri.split("/", 4)[2].equals("khBoard")) {
			System.out.println(uri.split("/", 4)[2]+"+khBoard");
			khBoardController khBoardControl = new khBoardController();
			khBoardControl.khBoardProcess(request, response);
		}else if (uri.split("/", 4)[2].equals("jhBoard")) {
			jhBoardController jhboardControl = new jhBoardController();
			jhboardControl.jhboardProcess(request, response);;					
		}

   }
}
