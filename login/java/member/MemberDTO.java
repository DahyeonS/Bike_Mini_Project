package member;

public class MemberDTO {
	private String idx, id, pw, name, regdate;
	private int age;
	
	public MemberDTO() {
	}
	
	public MemberDTO(String idx, String id, String pw, String name, int age, String regdate) {
		super();
		this.idx = idx;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
		this.regdate = regdate;
	}
	
	public MemberDTO(String id, String pw, String name, int age) {
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.age = age;
	}

	public String getIdx() {
		return idx;
	}

	public void setIdx(String idx) {
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
	
	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "회원번호: " + idx + ", ID: " + id + ", 비밀번호: " + pw + ", 이름: " + name + ", 나이: " + age + ", 가입날짜: " + regdate;
	}
}
