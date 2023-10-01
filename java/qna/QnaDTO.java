package qna;

public class QnaDTO {
	int num, fileID, visitCount, questNum, boardNum;
	String id, nickname, title, context, category, fileName, postdate, updateDate;
	
	public QnaDTO() {
	}
	
	public QnaDTO(int num, int fileID, int visitCount, int questNum, int boardNum, String id, String nickname, String title,
			String context, String category, String fileName, String postdate, String updateDate) {
		super();
		this.num = num;
		this.fileID = fileID;
		this.visitCount = visitCount;
		this.questNum = questNum;
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.context = context;
		this.category = category;
		this.fileName = fileName;
		this.postdate = postdate;
		this.boardNum = boardNum;
		this.updateDate = updateDate;
	}
	
	public QnaDTO(int num, String title, String nickname,
			String context, int visitCount, String postdate) {
		this.num = num;
		this.title = title;
		this.nickname = nickname;
		this.context = context;
		this.visitCount = visitCount;
		this.postdate = postdate;
	}

	public QnaDTO(int num, int fileID, int visitCount, String nickname, String title,
			String context, String fileName, String postdate) {
		this.num = num;
		this.nickname = nickname;
		this.title = title;
		this.context = context;
		this.fileID = fileID;
		this.fileName = fileName;
		this.postdate = postdate;
		this.visitCount = visitCount;
	}
	
	public QnaDTO(int num, String id, String nickname,
			String title, String context, String fileName) {
		this.id = id;
		this.num = num;
		this.nickname = nickname;
		this.title = title;
		this.context = context;
		this.fileName = fileName;
	}
	
	public QnaDTO(int num, int boardNum, String id, String nickname, String context) {
		this.id = id;
		this.num = num;
		this.nickname = nickname;
		this.context = context;
		this.boardNum = boardNum;
	}
	
	public QnaDTO(int num, int boardNum, String id, String nickname, String context, String postdate) {
		this.id = id;
		this.num = num;
		this.nickname = nickname;
		this.context = context;
		this.boardNum = boardNum;
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

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
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
