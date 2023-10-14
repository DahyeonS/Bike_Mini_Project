package jhBoard;

public class JhBoardDTO {
	
	int num, fileID, visitCount;
	String id, nickname, title, context, category, fileName, postdate;
	
	public JhBoardDTO() {
	
	}
	
	

	public JhBoardDTO(int num, String id) {
		super();
		this.num = num;
		this.id = id;
	}



	public JhBoardDTO(String id, String nickname, String title, String context) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.context = context;
	}

	public JhBoardDTO(int num, String postdate, String nickname, String title, int visitCount ) {
		super();
		this.num = num;
		this.postdate = postdate;
		this.nickname = nickname;
		this.title = title;
		this.visitCount = visitCount;
	}
	
	public JhBoardDTO(String id, String nickname, String title, String context, int num) {
		super();
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.context = context;
		this.num = num;
	}

	public JhBoardDTO(int num, String postdate, String nickname, String context, String title, int visitCount) {
		super();
		this.num = num;
		this.postdate = postdate;
		this.nickname = nickname;
		this.context = context;
		this.title = title;
		this.visitCount = visitCount;
	}

	public JhBoardDTO(int num, int fileID, int visitCount, String id, String nickname, String title, String context,
			String category, String fileName, String postdate) {
		super();
		this.num = num;
		this.fileID = fileID;
		this.visitCount = visitCount;
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.context = context;
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
		return "jhBoardDTO [num=" + num + ", fileID=" + fileID + ", visitCount=" + visitCount + ", id=" + id
				+ ", nickname=" + nickname + ", title=" + title + ", context=" + context + ", category=" + category
				+ ", fileName=" + fileName + ", postdate=" + postdate + "]";
	}
}
