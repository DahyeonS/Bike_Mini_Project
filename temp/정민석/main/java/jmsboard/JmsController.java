package jmsboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.oreilly.servlet.MultipartRequest;

import board.BoardDAO;
import board.BoardDAOimpl;
import board.BoardDTO;
import member.MemberDAO;
import member.MemberDAOImpl;
import member.MemberDTO;


public class JmsController {

       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doGet");
		process(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("doPost");
//		한글 처리
		request.setCharacterEncoding("UTF-8");
		process(request, response);
	}

	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
//		로그인
		
		if (action.equals("/write.do")) {
			HttpSession session = request.getSession();
			if(session.getAttribute("id")==null) {
				response.sendRedirect("../member/login.jsp");
			}else {
				response.sendRedirect("write.jsp");
			}
		}
//		게시판
		else if (action.equals("/board.do")) response.sendRedirect("board.jsp");
		else if (action.equals("/DeleteProcess.do")) {
			HttpSession session = request.getSession();
			String sNum=request.getParameter("num");
			int num=Integer.parseInt(sNum);
			BoardDTO dto=new BoardDTO();
			
			BoardDAO dao =new BoardDAOimpl();
			dto=dao.selectView(sNum);
			String sessionId=session.getAttribute("id").toString();
			int idCorrect=0;
			int delResult=0;
			if(sessionId.equals(dto.getId())){
				dto.setNum(num);
				delResult=dao.deletePost(dto);
				idCorrect=1;
			}
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("delResult",delResult);
			map.put("idCorrect",idCorrect);
			String gson = new Gson().toJson(map);
			response.getWriter().write(gson);
		}else if (action.equals("/upload.do")) {
			//webapp에 uploads 폴더생성 그안에 업로드폴더라는 빈파일 생성
			String saveDirectory=request.getServletContext().getRealPath("/uploads");
			System.out.println(saveDirectory);
			//용량 제한
			int maxPostSize= 1024*1000;
			MultipartRequest mr = FileUtil.uploadFile(request, saveDirectory, maxPostSize);
			if(mr==null) {
				return;
			}
			HttpSession session = request.getSession();
			String id=(String)session.getAttribute("id");
			MemberDTO dto=new MemberDTO();
			MemberDAO dao=new MemberDAOImpl();
			dto.setId(id);
			dto=dao.getMember(dto);
			BoardDTO bd=new BoardDTO();
			String nickName=dto.getNickname();
			String title=mr.getParameter("wTitle");
			String context=mr.getParameter("wContext");
			String category=mr.getParameter("category");
			System.out.println(category);
			String fileName=mr.getFilesystemName("fileUp");
			if(fileName!=null) {
				String now =new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
				String ext = fileName.substring(fileName.lastIndexOf("."));
				String newFileName= now+ext;
				File oldFile=new File(saveDirectory+File.separator+fileName);
				File newFile=new File(saveDirectory+File.separator+newFileName);
				oldFile.renameTo(newFile);
				bd.setFileName(newFileName);
			}
			bd.setCategory(category);
			bd.setNickname(nickName);
			bd.setContext(context);
			bd.setTitle(title);
			bd.setId(id);
			BoardDAO ba=new BoardDAOimpl();
			int rs=ba.insertWrite(bd);
			if(rs==1) {
				response.sendRedirect("board.do");
			}else {
				response.sendRedirect("write.do");
			}
			
		}else if (action.equals("/EditProcess.do")) {
			String title=request.getParameter("title");
			String context=request.getParameter("context");
			String sNum=request.getParameter("num");
			System.out.println(sNum);
			int num=Integer.parseInt(sNum);
			BoardDTO dto=new BoardDTO();
			BoardDAO dao =new BoardDAOimpl();
			dto.setNum(num);
			dto.setTitle(title);
			dto.setContext(context);
			int rs=dao.updateEdit(dto);
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("rs",rs);
			String gson = new Gson().toJson(map);
			response.getWriter().write(gson);
		}
	}

}
