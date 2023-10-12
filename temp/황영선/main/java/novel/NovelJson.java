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
		
		if (action.equals("/board.json")) {
			int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			int listNum = Integer.parseInt(request.getParameter("listNum"));
			System.out.print("pageNum : "+ pageNum);
			System.out.print("listNum : "+ listNum);
			List<NovelDTO> list = dao.getPostList(pageNum, listNum);
			
			JsonArray jsonArray = new JsonArray();
			for(NovelDTO dto: list){
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("id", dto.getId());
				jsonObject.addProperty("num", dto.getNum());
				jsonObject.addProperty("nickname", dto.getNickname());	
				jsonObject.addProperty("title", dto.getTitle());	
				jsonObject.addProperty("visit_count", dto.getVisitCount());	
				jsonObject.addProperty("postdate", dto.getPostdate());	
				
				System.out.printf("id : %s , num : %s, nickname : %s , title: %s , visit_count : %s, postdate: %s", dto.getId(), dto.getNum(), dto.getNickname(), dto.getTitle(), dto.getVisitCount(), dto.getPostdate());
				
				jsonArray.add(jsonObject);
			}
			
			response.setContentType("text/html; charset=UTF-8");
		    response.getWriter().write(jsonArray.toString());			
		} else if (action.equals("/writeJson.json")) {
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
			
		}else if (action.equals("/count.json")) {
			int num = 0;
			String numStr = request.getParameter("num");
			if (numStr != null) {
				// 문자열을 int로 형변환합니다.
				num = Integer.parseInt(numStr);
			} 
			System.out.print("조회수 num : "+ num);
			NovelDTO dto = new NovelDTO(num);
			
			dto.setNum(num);
			int rs = dao.boardCnt(dto);
			System.out.print("조회수 rs : "+ rs);
			
			
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
			
			System.out.print("업데이트  //");
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
			System.out.print("수정하기 num : "+ num +" / ");
			NovelDTO dto = new NovelDTO(num);
			
			
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
			String nStr = request.getParameter("num"); // 숫자 형식의 문자열을 가져옵니다.
			if (nStr != null) {
				// 문자열을 int로 형변환합니다.
				n = Integer.parseInt(nStr);
			} 
			System.out.print("전 prev꺼 num : "+ n +" / ");
			System.out.print("전 prev꺼 nStr : "+ nStr +" / ");
			NovelDTO dto = new NovelDTO(n);
			
			
			dto.setNum(n);
			NovelDTO rs = dao.prev(dto);
			System.out.print("이거 prev꺼 dto rs : "+ rs);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", rs.getId());
			jsonObject.addProperty("nickname", rs.getNickname());
			jsonObject.addProperty("title", rs.getTitle());
			jsonObject.addProperty("context", rs.getContext());
			jsonObject.addProperty("postdate", rs.getPostdate());
			jsonObject.addProperty("visitCount", rs.getVisitCount());
			jsonObject.addProperty("num", rs.getNum());
						
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());
						
		}else if (action.equals("/nextJson.json")) {
			int n2 = 0;
			String nStr2 = request.getParameter("num"); // 숫자 형식의 문자열을 가져옵니다.
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
		}else if (action.equals("/searchBtn.json")) {	
			int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			int listNum = Integer.parseInt(request.getParameter("listNum"));
			System.out.print("search pageNum : "+ pageNum);
			System.out.print("search listNum : "+ listNum);
			
			String option = request.getParameter("option");
			String text = request.getParameter("text");
			
			System.out.print("option : "+ option+ " / ");
			System.out.print("text: "+ text + " /");
			List<NovelDTO> list = dao.searchBtn(option,text, pageNum, listNum);
			
			
			JsonArray jsonArray = new JsonArray();
			for(NovelDTO dto: list){
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("id", dto.getId());
				jsonObject.addProperty("num", dto.getNum());
				jsonObject.addProperty("nickname", dto.getNickname());	
				jsonObject.addProperty("title", dto.getTitle());	
				jsonObject.addProperty("visit_count", dto.getVisitCount());	
				jsonObject.addProperty("postdate", dto.getPostdate());	
				
				System.out.printf("id : %s , num : %s, nickname : %s , title: %s , visit_count : %s, postdate: %s", dto.getId(), dto.getNum(), dto.getNickname(), dto.getTitle(), dto.getVisitCount(), dto.getPostdate());
				
				jsonArray.add(jsonObject);
			}
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonArray.toString());	
		} else if (action.equals("/searchCount.json")) {
			int pageNum = Integer.parseInt(request.getParameter("pageNum"));
			int listNum = Integer.parseInt(request.getParameter("listNum"));
			System.out.print("search pageNum : "+ pageNum);
			System.out.print("search listNum : "+ listNum);
			
			String option = request.getParameter("option");
			String text = request.getParameter("text");
			
			System.out.print("option : "+ option+ " / ");
			System.out.print("text: "+ text + " /");
			
			/////////////////////////////
			int blockNum = 5;
			if(request.getParameter("page") != null){
			pageNum = Integer.parseInt(request.getParameter("page"));
			};	
			
			NovelDAO dao = new NovelDAOImpl();
			int totalCount = dao.getSearchMemberCount(option, text);  
			System.out.print(" // totalCount:  " + totalCount);			
			PagingDTO paging = new PagingDTO(totalCount, pageNum, listNum, blockNum);
			paging.setPaging();	
			
			int totalPage = paging.getTotalPage();
			int startPage = paging.getStartPage();
			int endPage = paging.getEndPage();
			boolean isPrev = paging.isPrev();
			boolean isNext = paging.isNext();
			boolean isBPrev = paging.isBPrev();
			boolean isBNext = paging.isBNext();
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("totalPage", totalPage);
			jsonObject.addProperty("startPage", startPage);
			jsonObject.addProperty("endPage", endPage);
			jsonObject.addProperty("isPrev", isPrev);
			jsonObject.addProperty("isNext", isNext);
			jsonObject.addProperty("isBPrev", isBPrev);
			jsonObject.addProperty("isBNext", isBNext);
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());	
		}
		
	}
}
