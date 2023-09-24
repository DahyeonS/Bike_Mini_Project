package member;

import java.util.List;

public class MemberServiceImpl implements MemberService {
	private MemberDAO dao;
	
	public MemberServiceImpl() {
		this.dao = new MemberDAOImpl();
	}

	@Override
	public List<MemberDTO> getMemberList() {
		return dao.getMemberList();
	}
	
	@Override
	public MemberDTO getMember(MemberDTO dto) {
		return dao.getMember(dto);
	}

	@Override
	public MemberDTO getMemberNickname(MemberDTO dto) {
		return dao.getMemberNickname(dto);
	}
	
	@Override
	public MemberDTO memberSearch(MemberDTO dto) {
		return dao.memberSearch(dto);
	}
	
	@Override
	public int insert(MemberDTO dto) {
		return dao.insert(dto);
	}

	@Override
	public int update(MemberDTO dto) {
		return dao.update(dto);
	}

	@Override
	public int delete(MemberDTO dto) {
		return dao.delete(dto);
	}

	@Override
	public int updateAdmin(MemberDTO dto) {
		return dao.updateAdmin(dto);
	}
}
