package khBoard;

public class khBoardDTO {
	int num, file_id, visit_count, quest_num;
	String id, nickname, title, context, category, file_name, postdate;
	
	public khBoardDTO() {
		
	}
	
	public khBoardDTO(String id, int num, String title, String nickname, String postdate, int visit_count) {
		super();
		this.num = num;
		this.visit_count = visit_count;
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.postdate = postdate;
	}
	
	
	
	public khBoardDTO(int num, String nickname, String context, String postdate) {
		super();
		this.num = num;
		this.nickname = nickname;
		this.context = context;
		this.postdate = postdate;
	}

	public khBoardDTO(int num, int visit_count, String nickname, String title, String postdate) {
		super();
		this.num = num;
		this.visit_count = visit_count;
		this.nickname = nickname;
		this.title = title;
		this.postdate = postdate;
	}

	public khBoardDTO(int num, int file_id, int visit_count, String id, String nickname, String title,
			String context, String category, String file_name, String postdate) {
		super();
		this.num = num;
		this.file_id = file_id;
		this.visit_count = visit_count;
		this.id = id;
		this.nickname = nickname;
		this.title = title;
		this.context = context;
		this.category = category;
		this.file_name = file_name;
		this.postdate = postdate;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getFile_id() {
		return file_id;
	}

	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}

	public int getVisit_count() {
		return visit_count;
	}

	public void setVisit_count(int visit_count) {
		this.visit_count = visit_count;
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

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
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
				+ ", 게시글명: " + title + ", 게시판 분류: " + category + ", 파일 일련번호: " + file_id
				+ ", 파일명: " + file_name + ", 작성일자: " + postdate + ", 방문자 수: " + visit_count;
	}
}
