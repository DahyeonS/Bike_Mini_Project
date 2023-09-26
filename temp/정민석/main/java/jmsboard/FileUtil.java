package jmsboard;


import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	public static MultipartRequest uploadFile(HttpServletRequest request,
			String saveDirectory,int maxPostSize) {
		try {
			return new MultipartRequest(request,saveDirectory,maxPostSize,"UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
