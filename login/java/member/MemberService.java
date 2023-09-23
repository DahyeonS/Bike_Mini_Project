package member;

import java.util.List;

public interface MemberService {
	List<MemberDTO> getMemberList();
	MemberDTO getMember(MemberDTO dto);
	MemberDTO memberSearch(MemberDTO dto);
	int insert(MemberDTO dto);
	int update(MemberDTO dto);
	int delete(MemberDTO dto);
}
