package jmsboard;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import board.BoardDAO;
import board.BoardDAOimpl;
import board.BoardDTO;
import member.MemberService;
import member.MemberServiceImpl;


public class JmsApi {
	MemberService service = new MemberServiceImpl();

	
	
	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/writeJson.json")) {
			HttpSession session = request.getSession();
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
			HttpSession session = request.getSession();
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
		}
	}
}
