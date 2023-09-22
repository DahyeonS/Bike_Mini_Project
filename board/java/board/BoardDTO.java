package board;

public class BoardDTO {
	int num, fileID, visitCount;
	String id, nickname, title, category, fileName, postdate;
	
	public BoardDTO() {
	}
	
	public BoardDTO(int num, int fileID, int visitCount, String id, String nickname, String title, String category,
			String fileName, String postdate) {
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

	@Override
	public String toString() {
		return "게시글 번호: " + num  + ", 작성자 ID: " + id + ", 작성자 닉네임: " + nickname 
				+ ", 게시글명: " + title + ", 게시판 분류: " + category + ", 파일 일련번호: " + fileID
				+ ", 파일명: " + fileName + ", 작성일자: " + postdate + ", 방문자 수: " + visitCount;
	}
}
