package khBoard;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

public class KhBoardController {
	public void khBoardProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		System.out.println(uri + "내컨트롤러");

		String action = uri.substring(uri.lastIndexOf("/"));
		System.out.println(uri.split("/",4)[2] + "내컨트롤러");
		if (uri.split("/",4)[2].equals("khBoard")) {
			if (action.equals("/boardList.do")) response.sendRedirect("../khBoard/boardList.jsp");
			if (action.equals("/qnaList.do")) response.sendRedirect("../khBoard/qnaList.jsp");
			if (action.equals("/imageList.do")) response.sendRedirect("../khBoard/imageList.jsp");
			if (action.equals("/boardUpdate.do")) {

				String view = "../khBoard/boardUpdate.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(view);
				dispatcher.forward(request, response);
			}
			if (action.equals("/qnaUpdate.do")) {

				String view = "../khBoard/qnaUpdate.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(view);
				dispatcher.forward(request, response);
			}
			if (action.equals("/imageView.do")) {

				String view = "../khBoard/imageView.jsp";
				RequestDispatcher dispatcher = request.getRequestDispatcher(view);
				dispatcher.forward(request, response);
			}
			if (action.equals("/uploadProcess.do")) {
				System.out.println("uploadProcess");

				String saveDirectory = request.getServletContext().getRealPath("/uploads");
				String saveDirectory2 = "C:\\kdigital2307\\jsp\\jspws\\miniproject\\src\\main\\webapp\\khBoard\\images";
										
				System.out.println("saveDirectory : " + saveDirectory);
				int maxPostSize = 2048 * 2000;
				String encoding = "UTF-8";

				MultipartRequest mr = new MultipartRequest(request, saveDirectory2, maxPostSize, encoding);
				

				String fileName = mr.getFilesystemName("attechedFile");
				String ext = fileName.substring(fileName.lastIndexOf("."));
				String now = new SimpleDateFormat("yyyyMMdd_Hms").format(new Date());
				String newFileName = now + "(" + fileName + ")" + ext;

				File oldFile = new File(saveDirectory + File.separator + fileName);
				File newFile = new File(saveDirectory + File.separator + newFileName);
				
				File saveFile = new File(saveDirectory2 + File.separator + fileName);

				String title = mr.getParameter("title");
				String context = mr.getParameter("context");

				HttpSession session = request.getSession();
				String id = (String)session.getAttribute("id");
				String nickname = (String)session.getAttribute("nickname");

				KhBoardDTO dto = new KhBoardDTO(id, nickname, title, context, fileName);

				KhBoardDAO dao = new KhBoardDAO();
				int rs = dao.upload(dto);
				request.setAttribute("rs", rs);
				
				// 파일을 업로드 한 후에 khBoard 안의 images 폴더에 업로드한 파일을 다운받아 저장하는 과정
			
				
				
				// 파일 업로드
		
				if( rs == 1) {
					String view = "../khBoard/imageList.jsp";
					RequestDispatcher dispatcher = request.getRequestDispatcher(view);
					dispatcher.forward(request, response);
				}
				else {
					String view = "../khBoard/imageUpload.jsp";
					RequestDispatcher dispatcher = request.getRequestDispatcher(view);
					dispatcher.forward(request, response);

				}

			}

		}
	}
}
