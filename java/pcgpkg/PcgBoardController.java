package pcgpkg;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import jmsboard.BoardDAO;
import jmsboard.BoardDAOimpl;
import jmsboard.BoardDTO;
import jmsboard.FileUtil;
import member.MemberDAO;
import member.MemberDAOImpl;
import member.MemberDTO;

public class PcgBoardController {
	public void PcgProcess(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri);
		System.out.println("PcgBoardController");

		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/", 4)[2]);
		if (uri.split("/", 4)[2].lastIndexOf(".") == -1) {
			if (action.equals("/FreeBoardList.do")) {
				response.sendRedirect("../pcgboard/FreeBoardList.jsp");
			} else if (action.equals("/PcgWrite.do")) {
				response.sendRedirect("../pcgboard/PcgWrite.jsp");
			} else if (action.equals("/PcgView.do")) {
				String num = request.getParameter("num");
				HttpSession session = request.getSession();
				String id = (String) session.getAttribute("id");
				MemberDAO mdao = new MemberDAOImpl();
				MemberDTO mdto = new MemberDTO();
				mdto.setId(id);
				String grade = "";
				if (id != null) {
					mdto = mdao.getMember(mdto);
					grade = mdto.getGrade();
				}
				PcgBoardDAO dao = new PcgBoardDAO() {
				};
				dao.updateVisitCount(num);
				PcgBoardDTO dto = dao.pcggetNumSearchView(num);

				dto.setContext(dto.getContext().replaceAll("\r\n", "<br/>"));

				request.setAttribute("dto", dto);
				request.setAttribute("id", id);
				// 등급이 스탭 이상이면 수정하기와 삭제하기가 보이도록 조건을 충족시키기위해
				// 같은값을 두개를보냅니다
				if (id != null) {
					if (grade.equals("MANAGER") || grade.equals("ASSOCIATE") || grade.equals("STAFF")) {
						request.setAttribute("admin", "OK");
						request.setAttribute("OK", "OK");
					} else {
						request.setAttribute("admin", "Fail");
					}
				}
				request.getRequestDispatcher("PcgView.jsp").forward(request, response);
			} else if (action.equals("/PcgEdit.do")) {
				String Num = request.getParameter("num");
				PcgBoardDAO dao = new PcgBoardDAO() {};
				PcgBoardDTO dto = dao.pcggetNumSearchView(Num);

				request.setAttribute("dto", dto);
				request.getRequestDispatcher("PcgEdit.jsp").forward(request, response);
			}else if (action.equals("/Pcgupdate.do")) {
				//새 파일을 저장합니다
				PcgBoardDTO dto =new PcgBoardDTO();
				PcgBoardDAO dao =new PcgBoardDAO();
				System.out.println("dto 왔다");
				String uri2 = request.getRequestURI();
				System.out.println(uri2);// /sam/*.do
				String snum = request.getParameter("num");
				int num = Integer.parseInt(snum);
				String title = request.getParameter("uptitle");
				String context = request.getParameter("upcontext");
				System.out.println(num+"근데 넌왜안옴");
				dto.setContext(context);
				dto.setTitle(title);
				dto.setNum(num);

				int rs=dao.pcgUpDate(dto);
				if(rs==1) {
					response.sendRedirect("PcgView.do?num="+num);
				}else {
					response.sendRedirect("PcgEdit.do?num="+num);
				}
			}else if (action.equals("/FreeBoardListPaging.do")) {//페이징 호출
				System.out.println("FreeBoardListPaging.do");
				//페이징 호출이 왔을때 페이지 넘버 변수 한번 초기화
				int pageNum = 1;
				int listNum = 10;
				int blockNum = 10;
				String categorySelect = request.getParameter("categorySelect");
				String textInputValue = request.getParameter("textInputValue");
				String Selecttext = request.getParameter("Selecttext");
				
				if(request.getParameter("listNum")!=null) {
				listNum = Integer.parseInt( request.getParameter("listNum"));
				}
				System.out.println("똑바로좀 와라"+categorySelect+textInputValue+Selecttext);
				if(request.getParameter("pageNum") != null){
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				};	
				
				PcgBoardDAO dao = new PcgBoardDAO();
				List<PcgBoardDTO> list = null;
				System.out.println(categorySelect+"/"+textInputValue+"/"+Selecttext+listNum+"검색값이 컨트롤러에 왔다");
				int totalCount=0;
				//검색 값이 왔다
				if( textInputValue  == null && Selecttext  == null) {
				 list =  dao.pcggetBoardListPaging(pageNum, listNum);
				totalCount = dao.pcgtotalCount();
				 System.out.println("최초 페이징");
				}else {
				list =  dao.pcggetBoardListPaging(pageNum, listNum ,categorySelect ,textInputValue , Selecttext);
				totalCount = dao.pcgtotalCount(pageNum, listNum ,categorySelect ,textInputValue , Selecttext);
				
				System.out.println("검색 페이징//categorySelect:"+categorySelect+"/textInputValue:"+textInputValue+"/Selecttext:"+Selecttext);
				};
				
				
//			 for (PcgBoardDTO dto : list) {
//				 String str= dto.getTitle();
//				 System.out.println(str);
//			 }
			 
			 System.out.println(totalCount); // 게시글 총
			 
			 PagingDTO PagingDTO = new PagingDTO(totalCount, pageNum, listNum, blockNum);
			 
			 PagingDTO.setPaging();	
				int totalPage = PagingDTO.getTotalPage();
				int startPage = PagingDTO.getStartPage();
				int endPage = PagingDTO.getEndPage();
				boolean isPrev = PagingDTO.getIsPrev();
				boolean isNext = PagingDTO.getIsNext();
				boolean isBPrev = PagingDTO.getIsBPrev();
				boolean isBNext = PagingDTO.getIsBNext();
				
				List<String> categorylist = new ArrayList<String>();
				categorylist = dao.pcgTotalCATEGORY();
				
				request.setAttribute("categorySelect", categorySelect);
				request.setAttribute("textInputValue", textInputValue);
				request.setAttribute("Selecttext", Selecttext);
				request.setAttribute("PagingDTO", PagingDTO);
				request.setAttribute("categorylist", categorylist);
				request.setAttribute("list", list);
				request.setAttribute("listNum", listNum);
				
				System.out.println(totalCount+categorySelect+textInputValue+Selecttext +"여기까지 또왔어");
				request.getRequestDispatcher("FreeBoardListPaging.jsp").forward(request, response);
				
			}else if (action.equals("/UploadProcess.do")) {
				pcgFileUtil multipartRequest = new pcgFileUtil();
				//430 페이지
				
				multipartRequest.uploadFile(request, action, 0);
				
				request.getRequestDispatcher("PcgEdit.jsp").forward(request, response);
			}
			
			
		}
	}
}
