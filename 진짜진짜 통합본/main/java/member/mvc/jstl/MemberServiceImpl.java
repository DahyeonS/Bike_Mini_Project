package member.mvc.jstl;

import java.util.List;

import member.dao.MemberDAO;
import member.dto.MemberDTO;

public class MemberServiceImpl implements IMemberService{
	
	MemberDAO dao = new MemberDAO();

	@Override
	public List<MemberDTO> getMemberList() {
		
		return dao.getMemberList();
	}

	@Override
	public MemberDTO getMember(MemberDTO dto) {
		
		return dao.getMember(dto);
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
	public List<MemberDTO> getMemberSearchNameList(MemberDTO dto) {
		
		return dao.getMemberSearchNameList(dto);
	}

}
