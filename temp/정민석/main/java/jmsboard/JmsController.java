package jmsboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import member.MemberDAO;
import member.MemberDAOImpl;
import member.MemberDTO;


public class JmsController {

     
	public void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String action = uri.substring(uri.lastIndexOf("/"));
		//검색 
		String serchField = request.getParameter("serchField");
		String serchWord = request.getParameter("serchWord");
		//만든 업로드파일을 저장장소로 지정합니다
		String saveDirectory=request.getServletContext().getRealPath("/uploads");
		//업로드할 파일의 용량제한입니다
		int maxPostSize=1024*1000;
		if (action.equals("/write.do")) {
			request.getRequestDispatcher("write.jsp").forward(request, response);
		}
		else if (action.equals("/board.do")) {
			BoardDAO dao = new BoardDAOimpl();
			Map<String, Object> param = new HashMap<String, Object>();
			
			String reqUrl="board.do";
			if(serchWord!=null){
				param.put("serchField", serchField);
				param.put("serchWord", serchWord);
			}
			int totalCount = dao.selectCount(param);
			int pageSize=10;
			int blockPage=5;
			int totalPage=(int)Math.ceil((double)totalCount/pageSize);
			
			int pageNum=1;
			String pageNumTemp=request.getParameter("pageNum");
			System.out.println(pageNumTemp);
			if(pageNumTemp!=null && !pageNumTemp.equals("")){
				pageNum=Integer.parseInt(pageNumTemp);
			}
			int start = (pageNum -1)*pageSize +1;
			int end=pageNum*pageSize;
			param.put("start",start);
			param.put("end",end);
			List<BoardDTO> boardLists = dao.selectListPage(param);
			String pagingStr="";
			int pageTemp=(((pageNum-1)/blockPage)*blockPage)+1;
			if(pageTemp!=1) {
				pagingStr += "<a href='" + reqUrl + "?pageNum=1'>[첫 페이지]</a>";
				pagingStr+="&nbsp;";
				pagingStr+="<a href='"+reqUrl+"?pageNum="+(pageTemp-1)+"'>[이전블록]</a>";	
			}
			
			int blockCount=1;
			while(blockCount<=blockPage&&pageTemp<=totalPage) {
				if(pageTemp==pageNum) {
					pagingStr+="&nbsp;"+pageTemp+"&nbsp;";
				}else {
					pagingStr+="&nbsp;<a href = '"+reqUrl+"?pageNum="+pageTemp+"'>"+pageTemp+"</a>&nbsp;";
				}
				pageTemp++;
				blockCount++;
			}
			if(pageTemp<=totalPage) {
				pagingStr+="<a href='"+reqUrl+"?pageNum="+pageTemp+"'>[다음 블록]</a>";
				pagingStr+="&nbsp;";
				pagingStr+="<a href='"+reqUrl+"?pageNum="+totalPage+"'>[마지막 페이지]</a>";
			}
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("totalCount", totalCount);
			map.put("pageSize", pageSize);
			map.put("pageNum", pageNum);
			map.put("pagingImg", pagingStr);
			request.setAttribute("boardLists", boardLists);
			request.setAttribute("map", map);
			request.getRequestDispatcher("board.jsp").forward(request, response);
		}else if (action.equals("/upload.do")) {
			// uploads 폴더를 webapp에 만들어주시고 업로드파일이라는 빈파일을 생성해주세요
			// 업로드된 파일은 워크스페이스에/.metadata/.plugins/org.eclipse.wst.server.core/
			// tmp0/wtpwebapps/본인 프로젝트 명/uploads 쪽으로 생깁니다 
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
			//파일명을 현재시간으로 변환합니다
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
			
		}else if (action.equals("/Edit.do")) {
			String Num=request.getParameter("num");
			BoardDAO dao=new BoardDAOimpl();
			BoardDTO dto=dao.selectView(Num);
			
			request.setAttribute("dto", dto);
			request.getRequestDispatcher("Edit.jsp").forward(request, response);
		}else if (action.equals("/EditProcess.do")) {
			//새 파일을 저장합니다
			MultipartRequest mr = FileUtil.uploadFile(request, saveDirectory, maxPostSize);
			if(mr==null) {
				return;
			}
			BoardDTO bd=new BoardDTO();
			BoardDAO ba=new BoardDAOimpl();
			String sNum=mr.getParameter("num");
			int num=Integer.parseInt(sNum);
			String title=mr.getParameter("wTitle");
			String context=mr.getParameter("wContext");
			String prevSfile=mr.getParameter("prevSfile");
			System.out.println(prevSfile);
			String fileName=mr.getFilesystemName("fileUp");
			bd.setContext(context);
			bd.setTitle(title);
			bd.setNum(num);
			if(fileName!=null) {
				String now =new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
				String ext = fileName.substring(fileName.lastIndexOf("."));
				String newFileName= now+ext;
				File oldFile=new File(saveDirectory+File.separator+fileName);
				File newFile=new File(saveDirectory+File.separator+newFileName);
				oldFile.renameTo(newFile);
				bd.setFileName(newFileName);
				//이전파일을 제거합니다
				FileUtil.deleteFile(request,"/uploads", prevSfile);
			}else {
				bd.setFileName(prevSfile);
			}
			int rs=ba.updateEdit(bd);
			if(rs==1) {
				response.sendRedirect("View.do?num="+num);
			}else {
				response.sendRedirect("Edit.do?num="+num);
			}
		}else if (action.equals("/View.do")) {
			String num=request.getParameter("num");
			String index=request.getParameter("index");
			HttpSession session = request.getSession();
			String id=(String)session.getAttribute("id");
			MemberDAO ma=new MemberDAOImpl();
			MemberDTO md=new MemberDTO();
			md.setId(id);
			String grade="";
			if(id!=null) {
				md=ma.getMember(md);
				grade=md.getGrade();
			}
			BoardDAO dao=new BoardDAOimpl();
			dao.updateVisitCount(num);
			BoardDTO dto=dao.selectView(num);
			
			dto.setContext(dto.getContext().replaceAll("\r\n", "<br/>"));
			
			request.setAttribute("dto", dto);
			request.setAttribute("id", id);
			request.setAttribute("index", index);
			//등급이 스탭 이상이면 수정하기와 삭제하기가 보이도록 조건을 충족시키기위해 
			//같은값을 두개를보냅니다
			if(id!=null) {
				if(grade.equals("MANAGER")||grade.equals("ASSOCIATE")||grade.equals("STAFF")) {
					request.setAttribute("admin", "OK");
					request.setAttribute("OK", "OK");
				}else {
					request.setAttribute("admin", "Fail");
				}
			}
			request.getRequestDispatcher("View.jsp").forward(request, response);
		}else if (action.equals("/download.do")) {
			String sfile=request.getParameter("sfile");
			FileUtil.download(request, response, "/uploads", sfile);
		}
	}

}
