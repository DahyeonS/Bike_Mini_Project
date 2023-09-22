package member;

public class MemberDTO {
	private int idx;
	private String id, pw, nickname, grade;
	
	public MemberDTO() {
	}

	public MemberDTO(int idx, String id, String pw, String nickname, String grade) {
		super();
		this.idx = idx;
		this.id = id;
		this.pw = pw;
		this.nickname = nickname;
		this.grade = grade;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	@Override
	public String toString() {
		return "일련번호: " + idx + ", 아이디: " + id + ", 비밀번호: " + pw +
				", 닉네임: " + nickname + ", 등급: " + grade;
	}
	
}
