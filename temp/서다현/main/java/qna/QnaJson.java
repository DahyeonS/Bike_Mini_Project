package qna;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class QnaJson {
	QnaDAO dao = new QnaDAOImpl();
	
	public void qnaProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		
		if (action.equals("/qnaBoardList.json")) {
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String nickname = request.getParameter("nickname");
			QnaDTO dto = new QnaDTO();
			
			int page = 1;
			if (request.getParameter("page") != null) page = Integer.parseInt(request.getParameter("page"));
			List<QnaDTO> list = new ArrayList<QnaDTO>();
			
			if (title != null) {
				dto.setTitle(title);
				list = dao.getBoardListTitle(dto, page);
			} else if (context != null) {
				dto.setContext(context);
				list = dao.getBoardListContext(dto, page);
			} else if (nickname != null) {
				dto.setNickname(nickname);
				list = dao.getBoardListNickname(dto, page);
			} else list = dao.getBoardList(page);
			
			if (list.size() == 0) list.add(new QnaDTO());
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaBoardPaging.json")) {
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String nickname = request.getParameter("nickname");
			QnaDTO dto = new QnaDTO();
			
			int listNum = 10;
			int blockNum = 10;
			int pageNum = 1;
			if(request.getParameter("page") != null){
				pageNum = Integer.parseInt(request.getParameter("page"));
			};
			
			int totalCount = 0;
			if (title != null) {
				dto.setTitle(title);
				totalCount = dao.getBoardTitleCount(dto);
			} else if (context != null) {
				dto.setContext(context);
				totalCount = dao.getBoardContextCount(dto);
			} else if (nickname != null) {
				dto.setNickname(nickname);
				totalCount = dao.getBoardNicknameCount(dto);
			} else totalCount = dao.getBoardCount();
			
			//paging
			QnaPagingDTO paging = new QnaPagingDTO(totalCount, pageNum, listNum, blockNum);
			paging.setPaging();	
			
			String gson = new Gson().toJson(paging);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaBoardView.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			int rs = dao.visitCnt(dto);
			if (rs == 1) dto = dao.getBoardNum(dto);
			
			String gson = new Gson().toJson(dto);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaDeleteBoard.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			int rs = dao.deleteBoard(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/qnaWriteView.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			dto = dao.getBoardNum(dto);
			
			String gson = new Gson().toJson(dto);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaWrite.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			String id = request.getParameter("id");
			String nickname = request.getParameter("nickname");
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String fileName = request.getParameter("fileName");
			int rs = 0;
			
			QnaDTO dto = new QnaDTO(num, id, nickname, title, context, fileName);
			if (num == 0) {
				rs = dao.writeQuestion(dto);
				if (rs == 1) rs = dao.getPostNum(dto);
			} else {
				rs = dao.writeAnswer(dto);
				if (rs == 1) rs = num;
			}
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/qnaAnswerView.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			
			List<QnaDTO> list = dao.getAnswerList(dto);
			if (list.size() == 0) list.add(new QnaDTO());
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaUpdateView.json")) {
			String sNum = request.getParameter("update");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			dto = dao.getBoardNum(dto);
			
			String gson = new Gson().toJson(dto);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaUpdate.json")) {
			String sUpdate = request.getParameter("update");
			int update = 0;
			if (sUpdate != null) update = Integer.parseInt(sUpdate);
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			String title = request.getParameter("title");
			String context = request.getParameter("context");
			String fileName = request.getParameter("fileName");
			int rs = 0;
			
			QnaDTO dto = new QnaDTO(update, null, null, title, context, fileName);
			rs = dao.updateBoard(dto);
			if (rs == 1) {
				if (num != 0) rs = num;
				else rs = update;
			}
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/qnaWriteReply.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			String id = request.getParameter("id");
			String nickname = request.getParameter("nickname");
			String context = request.getParameter("context");
			int rs = 0;
			
			QnaDTO dto = new QnaDTO(num, 0, id, nickname, context);
			rs = dao.writeReply(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		} else if (action.equals("/qnaReplyView.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			
			List<QnaDTO> list = dao.getReplyList(dto);
			if (list.size() == 0) list.add(new QnaDTO());
			
			String gson = new Gson().toJson(list);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(gson);
		} else if (action.equals("/qnaDeleteReply.json")) {
			String sNum = request.getParameter("num");
			int num = 0;
			if (sNum != null) num = Integer.parseInt(sNum);
			
			QnaDTO dto = new QnaDTO();
			dto.setNum(num);
			int rs = dao.deleteReply(dto);
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("rs", rs);
			response.getWriter().write(jsonObject.toString());
		}
	}
}
