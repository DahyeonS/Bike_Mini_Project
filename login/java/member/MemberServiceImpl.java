package member;

public class MemberServiceImpl implements MemberService {
	private MemberDAO dao;
	
	public MemberServiceImpl() {
		this.dao = new MemberDAOImpl();
	}

	@Override
	public MemberDTO getMember(MemberDTO dto) {
		return dao.getMember(dto);
	}

	@Override
	public int insert(MemberDTO dto) {
		return dao.insert(dto);
	}

}
