package member.dto;

import java.util.Date;

public class MemberDTO {
	private int idx;
	private String id, pw, name, role;
	private Date regdate;
	
	public MemberDTO() {
	}

	public MemberDTO(String id, String pw, String name, String role) {
		super();
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.role = role;
	}

	public MemberDTO(int idx, String id, String pw, String name, String role, Date regdate) {
		super();
		this.idx = idx;
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.role = role;
		this.regdate = regdate;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	@Override
	public String toString() {
		return "MemberDTO [idx=" + idx + ", id=" + id + ", pw=" + pw + ", name=" + name + ", role=" + role + ", regdate="
				+ regdate + "]";
	}

	
	
	
}
