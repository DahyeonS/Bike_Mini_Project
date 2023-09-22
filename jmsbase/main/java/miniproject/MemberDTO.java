package miniproject;

public class MemberDTO {
	private String id, pass, name, regidate;
	
	
	public MemberDTO() {
		
	}
	

	
	public MemberDTO(String id, String pass, String name, String regidate) {
		this.id = id;
		this.pass= pass;
		this.name = name;
		this.regidate = regidate;
	}


	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPass() {
		return pass;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	
	public String getRegidate() {
		return regidate;
	}

	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}



	@Override
	public String toString() {
		return "MemberDTO [id=" + id + ", pass=" + pass + ", name=" + name + ", regidate=" + regidate + "]";
	}


}
