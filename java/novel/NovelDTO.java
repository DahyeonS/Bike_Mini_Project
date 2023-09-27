package novel;

import java.sql.Date;

public class NovelDTO {
	int num, fileID, visitCount;
	String id, nickname, title, category, fileName, postdate, context;
	
	public NovelDTO() {
	}
	
	public NovelDTO(int num, int fileID, int visitCount, String id, String nickname, String title, String category,
			String fileName, String postdate, String context) {
		super();
		this.num = num;
		this.fileID = fileID;
		this.visitCount = visitCount;
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.category = category;
		this.fileName = fileName;
		this.postdate = postdate;
		this.context = context;
	}
	public NovelDTO(String context, String id, String nickname, String title) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.context = context;
	}
	public NovelDTO(String context,String nickname, String id,String title, String category) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.category = category;
		this.context = context;
	}
	public NovelDTO(String context,String nickname, String id,String title, int visitCount, String postdate) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.postdate = postdate;
		this.context = context;
		this.visitCount = visitCount;
	}
	public NovelDTO(String context,String title, int num) {
		super();
		this.num = num;
		this.title = title;
		this.context = context;
	}
	public NovelDTO(int num) {
		super();
		this.num = num;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getFileID() {
		return fileID;
	}

	public void setFileID(int fileID) {
		this.fileID = fileID;
	}

	public int getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getPostdate() {
		return postdate;
	}

	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}
	public String getContext() {
		return context;
	}
	
	public void setcontext(String context) {
		this.context = context;
	}

	@Override
	public String toString() {
		return "게시글 번호: " + num  + ", 작성자 ID: " + id + ", 작성자 닉네임: " + nickname 
				+ ", 게시글명: " + title + ", 게시판 분류: " + category + ", 파일 일련번호: " + fileID
				+ ", 파일명: " + fileName + ", 작성일자: " + postdate + ", 방문자 수: " + visitCount + ", 게시글 내용: "+ context;
	}
}
