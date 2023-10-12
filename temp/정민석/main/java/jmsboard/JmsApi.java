package jmsboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import member.MemberDAO;
import member.MemberDAOImpl;
import member.MemberDTO;



public class JmsApi {

	
	
	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		HttpSession session = request.getSession();
		
		if (action.equals("/writeJson.json")) {
			String id=	(String)session.getAttribute("id");
			System.out.println(id);
			
			
			JsonObject jsonObject = new JsonObject();
			
			if (id != null) {
				jsonObject.addProperty("rs", 1);
			}else {
				jsonObject.addProperty("rs", 0);				
			}
			response.getWriter().write(jsonObject.toString());
		}else if (action.equals("/DeleteProcess.json")) {
			String sNum=request.getParameter("num");
			int num=Integer.parseInt(sNum);
			BoardDTO dto=new BoardDTO();
			
			BoardDAO dao =new BoardDAOimpl();
			dto=dao.selectView(sNum);
			String sessionId=session.getAttribute("id").toString();
			int delResult=0;
			if(sessionId.equals(dto.getId())){
				dto.setNum(num);
				delResult=dao.deletePost(dto);
			}
			if(delResult==1) {
				String saveFileName=dto.getFileName();
				FileUtil.deleteFile(request, "/uploads", saveFileName);
			}
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("delResult",delResult);
			String gson = new Gson().toJson(map);
			response.getWriter().write(gson);
		}else if (action.equals("/ReplyView.json")) {
			BoardDAO dao =new BoardDAOimpl();
			MemberDTO md=new MemberDTO(); 
			MemberDAO ma=new MemberDAOImpl();
			String id=(String)session.getAttribute("id");
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			if(id!=null) {
				md.setId(id);
				md=ma.getMember(md);				
			}else {
				md.setId("");
			}
			
			BoardDTO dto = new BoardDTO();
			dto.setNum(num);
			
			List<BoardDTO> list = dao.getReplyList(dto);
			if (list.size() == 0) list.add(new BoardDTO());
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("list", list);
			map.put("nickname", md.getNickname());
			String gson = new Gson().toJson(map);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		}else if (action.equals("/WriteReply.json")) {
			BoardDAO dao =new BoardDAOimpl();
			MemberDTO md=new MemberDTO(); 
			MemberDAO ma=new MemberDAOImpl();
			JsonObject jsonObject = new JsonObject();
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			String id = (String)session.getAttribute("id");
			int rs = 0;
			if(id==null) {
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());
			}else {
				md.setId(id);
				md=ma.getMember(md);				
				String nickname = md.getNickname();
				String context = request.getParameter("context");
				
				BoardDTO dto = new BoardDTO();
				dto.setId(id);
				dto.setNickname(nickname);
				dto.setContext(context);
				dto.setNum(num);
				rs = dao.writeReply(dto);
				
				jsonObject.addProperty("rs", rs);
				response.getWriter().write(jsonObject.toString());				
			}
		}else if (action.equals("/DeleteReply.json")) {
			BoardDAO dao =new BoardDAOimpl();
			
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			BoardDTO dto = new BoardDTO();
			dto.setNum(num);
			int rs = dao.deleteReply(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
	}
}
