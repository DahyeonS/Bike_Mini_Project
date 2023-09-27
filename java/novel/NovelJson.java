package novel;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import member.MemberDAO;
import member.MemberDAOImpl;
import member.MemberDTO;

public class NovelJson {
	MemberDAO Mdao = new MemberDAOImpl();
	NovelDAO dao = new NovelDAOImpl();
	
	public void novelProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/writeJson.json")) {
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			NovelDTO dto = new NovelDTO(context, id, name, title);
			
			System.out.print("id : "+ id +" / ");
			System.out.print("name : "+ name +" / ");
			System.out.print("title : "+ title +" / ");
			System.out.print("context : "+ context +" // ");
			
			int rs = dao.BoardInsert(dto);
			System.out.print("rs : "+ rs);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
			
		}else if (action.equals("/viewJson.json")) {
			int num = 0;
			String numStr = request.getParameter("num"); // 숫자 형식의 문자열을 가져옵니다.
			if (numStr != null) {
				// 문자열을 int로 형변환합니다.
				num = Integer.parseInt(numStr);
			} 
			NovelDTO dto = new NovelDTO(num);
			
			System.out.print("num : "+ num +" / ");
			
			dto.setNum(num);
			NovelDTO rs = dao.view(dto);
			System.out.print("rs : "+ rs);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", rs.getId());
			jsonObject.addProperty("nickname", rs.getNickname());
			jsonObject.addProperty("title", rs.getTitle());
			jsonObject.addProperty("context", rs.getContext());
			jsonObject.addProperty("postdate", rs.getPostdate());
			jsonObject.addProperty("visitCount", rs.getVisitCount());
						
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());
		}else if (action.equals("/deleteJson.json")) {
			int num2 = 0;
			String numStr = request.getParameter("num"); // 숫자 형식의 문자열을 가져옵니다.
			if (numStr != null) {
				// 문자열을 int로 형변환합니다.
				num2 = Integer.parseInt(numStr);
			} 
			System.out.print("음 num : "+ num2 +" _____ ");
			System.out.print("음 numStr : "+ numStr +" _____ ");
			
			NovelDTO dto = new NovelDTO(num2);
			
			dto.setNum(num2);
			int rs = dao.delete(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
			
		}else if (action.equals("/updateJson.json")) {
			int num = 0;
			String numStr = request.getParameter("num");
			if (numStr != null) {
				// 문자열을 int로 형변환합니다.
				num = Integer.parseInt(numStr);
			} 
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			NovelDTO dto = new NovelDTO(context, title, num);
			
			System.out.print("num : "+ num +" / ");
			System.out.print("title : "+ title +" / ");
			System.out.print("context : "+ context +" // ");
			
			int rs = dao.update(dto);
			System.out.print("rs : "+ rs);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
			
		}else if (action.equals("/prevWrite.json")) {
			int num = 0;
			String numStr = request.getParameter("num"); // 숫자 형식의 문자열을 가져옵니다.
			if (numStr != null) {
				// 문자열을 int로 형변환합니다.
				num = Integer.parseInt(numStr);
			} 
			NovelDTO dto = new NovelDTO(num);
			
			System.out.print("num : "+ num +" / ");
			
			dto.setNum(num);
			NovelDTO rs = dao.prevWrite(dto);
			System.out.print("rs : "+ rs);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("title", rs.getTitle());
			jsonObject.addProperty("context", rs.getContext());
						
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());
		}else if (action.equals("/prevJson.json")) {
			int n = 0;
			String nStr = request.getParameter("num4"); // 숫자 형식의 문자열을 가져옵니다.
			if (nStr != null) {
				// 문자열을 int로 형변환합니다.
				n = Integer.parseInt(nStr);
			} 
			System.out.print("++ num : "+ n +" / ");
			NovelDTO dto = new NovelDTO(n);
			
			
			dto.setNum(n);
			int rs = dao.prev(dto);
			System.out.print("rs : "+ rs);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("num", rs);
						
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());
		}else if (action.equals("/nextJson.json")) {
			int n2 = 0;
			String nStr2 = request.getParameter("num5"); // 숫자 형식의 문자열을 가져옵니다.
			if (nStr2 != null) {
				// 문자열을 int로 형변환합니다.
				n2 = Integer.parseInt(nStr2);
			} 
			System.out.print("num : "+ n2 +" //// !!++");
			NovelDTO dto = new NovelDTO(n2);
			
			
			dto.setNum(n2);
			int rs = dao.next(dto);
			System.out.print("?? rs : "+ rs);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("num", rs);
						
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());
		}
		
	}
}
