package member;

public class MemberServiceImpl implements MemberService {
	private MemberDAO dao;
	
	public MemberServiceImpl() {
		this.dao = new MemberDAOImpl();
	}

	@Override
	public MemberDTO login(MemberDTO dto) {
		return dao.getMember(dto);
	}

}
