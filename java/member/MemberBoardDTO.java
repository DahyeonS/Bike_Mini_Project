package member;

public class MemberBoardDTO {
	private int num, visitCount;
	private String id, title, context, category, postdate;
	
	public MemberBoardDTO() {
	}
	
	public MemberBoardDTO(int num, int visitCount, String id, String title, String context, String category, String postdate) {
		super();
		this.num = num;
		this.visitCount = visitCount;
		this.id = id;
		this.title = title;
		this.context = context;
		this.category = category;
		this.postdate = postdate;
	}
	
	public MemberBoardDTO(int num, int visitCount, String title, String context, String category, String postdate) {
		this.num = num;
		this.visitCount = visitCount;
		this.title = title;
		this.context = context;
		this.category = category;
		this.postdate = postdate;
	}

	public MemberBoardDTO(String id, String title, String context, String category) {
		this.id = id;
		this.title = title;
		this.context = context;
		this.category = category;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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
	
	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getVisitCount() {
		return visitCount;
	}

	public void setVisitCount(int visitCount) {
		this.visitCount = visitCount;
	}

	public String getPostdate() {
		return postdate;
	}

	public void setPostdate(String postdate) {
		this.postdate = postdate;
	}

	@Override
	public String toString() {
		return "제목: " + title + ", 내용: " + context + ", 카테고리: " + category;
	}
}
