package member;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import qna.QnaDTO;

public class MemberJson {
	MemberDAO dao = new MemberDAOImpl();
	
	public void memberProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
//		로그인
		if (action.equals("/login.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = dao.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			
			if (dto != null) {
				if (pw.equals(dto.getPw())) {
					HttpSession session = request.getSession();
					session.setAttribute("id", id);
					session.setAttribute("nickname", dto.getNickname());
					session.setAttribute("grade", dto.getGrade());
					jsonObject.addProperty("rs", 1);
				}
			}
			else jsonObject.addProperty("rs", 0);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/idCheck.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = dao.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			if(dto != null) jsonObject.addProperty("rs", 1);
			else jsonObject.addProperty("rs", 0);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/nicknameCheck.json")) {
			String nickname = request.getParameter("nickname");
			
			MemberDTO dto = new MemberDTO();
			dto.setNickname(nickname);
			dto = dao.getMemberNickname(dto);
			
			JsonObject jsonObject = new JsonObject();
			if(dto != null) jsonObject.addProperty("rs", 1);
			else jsonObject.addProperty("rs", 0);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/join.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String nickname = request.getParameter("nickname");
			
			MemberDTO dto = new MemberDTO(id, pw, nickname);
			
			int rs = dao.insert(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/pwShow.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = dao.getMember(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("pw", dto.getPw());
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/update.json")) {
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			String nickname = request.getParameter("nickname");
			
			MemberDTO dto = new MemberDTO(id, pw, nickname);
			int rs = dao.update(dto);
			
			JsonObject jsonObject = new JsonObject();
			if (rs == 1) {
				HttpSession session = request.getSession();
				session.setAttribute("nickname", dto.getNickname());
			}
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/delete.json")) {
			HttpSession session = request.getSession();
			String id = (String)session.getAttribute("id");
			String pw = request.getParameter("pw");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			dto = dao.getMember(dto);
			int rs = 0;
			
			if (pw.equals(dto.getPw())) {
				session.invalidate();
				rs = dao.delete(dto);
			}
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/memberList.json")) {
			List<MemberDTO> list = dao.getMemberList();
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/memberShow.json")) {
			String context = request.getParameter("context");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(context);
			dto.setNickname(context);
			dto = dao.memberSearch(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", dto.getId());
			jsonObject.addProperty("pw", dto.getPw());
			jsonObject.addProperty("nickname", dto.getNickname());
			
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/updateAdmin.json")) {
			String id = request.getParameter("id");
			String nickname = request.getParameter("nickname");
			String grade = request.getParameter("grade");
			
			MemberDTO dto = new MemberDTO(id, null, nickname, grade);
			int rs = dao.updateAdmin(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/deleteAdmin.json")) {
			String id = request.getParameter("id");
			
			MemberDTO dto = new MemberDTO();
			dto.setId(id);
			int rs = dao.delete(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/memberPagingBoard.json")) {
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String category = request.getParameter("category");
			MemberBoardDTO dto = new MemberBoardDTO();
			dto.setId(id);
			dto.setTitle("");
			dto.setContext("");
			if (category == null) dto.setCategory("");
			
			int listNum = 10;
			int blockNum = 10;
			int pageNum = 1;
			if(request.getParameter("page") != null){
				pageNum = Integer.parseInt(request.getParameter("page"));
			};
			
			int totalCount = 0;
			if (title != "") {
				dto.setTitle(title);
			} else if (context != null) {
				dto.setContext(context);
			} else if (category != null) {
				if (category.equals("normal")) dto.setCategory("일반");
				else if (category.equals("question")) dto.setCategory("질문");
				else if (category.equals("answer")) dto.setCategory("답변");
				else if (category.equals("reply")) dto.setCategory("답글");
				else if (category.equals("novel")) dto.setCategory("소설");
				else if (category.equals("free")) dto.setCategory("자유");
				else if (category.equals("photo")) dto.setCategory("사진");
			}
			totalCount = dao.getBoardCount(dto);
			
			//paging
			MemberPagingDTO paging = new MemberPagingDTO(totalCount, pageNum, listNum, blockNum);
			paging.setPaging();	
			
			String gson = new Gson().toJson(paging);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/memberBoardList.json")) {
			String id = request.getParameter("id");
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String category = request.getParameter("category");
			MemberBoardDTO dto = new MemberBoardDTO();
			dto.setId(id);
			dto.setTitle("");
			dto.setContext("");
			if (category == null) dto.setCategory("");
			else {
				if (category.equals("normal")) dto.setCategory("일반");
				else if (category.equals("question")) dto.setCategory("질문");
				else if (category.equals("answer")) dto.setCategory("답변");
				else if (category.equals("reply")) dto.setCategory("답글");
				else if (category.equals("novel")) dto.setCategory("소설");
				else if (category.equals("free")) dto.setCategory("자유");
				else if (category.equals("photo")) dto.setCategory("사진");
			}
			
			int page = 1;
			if (request.getParameter("page") != null) page = Integer.parseInt(request.getParameter("page"));
			List<MemberBoardDTO> list = new ArrayList<MemberBoardDTO>();
			
			if (title != "") dto.setTitle(title);
			else if (context != null) dto.setContext(context);
			
			list = dao.getBoardList(dto, page);
			if (list.size() == 0) list.add(new MemberBoardDTO());
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/memberDeleteBoard.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			MemberBoardDTO dto = new MemberBoardDTO();
			dto.setNum(num);
			int rs = dao.deleteBoard(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
	}
}
