package member.mvc.jstl;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.go")
public class DispatcherServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		action(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		action(request, response);
	}
	
	protected void action(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("action");
		String uri = request.getRequestURI();
		System.out.println(uri); // /myweb/memberList.do
		
		String[] urlArr = uri.split("/");
		System.out.println(Arrays.toString(urlArr));
		
		int len = urlArr.length;
		String path = urlArr[len-2];
		String action = "/"+urlArr[len-1];
		System.out.printf("%s, %s\n", path, action);
		
		if(path.equals("member-mvc-jstl")) {
			MemberController controller = new MemberController();
			controller.requestMapping(action, request, response);
		}
	}

}
