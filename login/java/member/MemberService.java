package member;

import java.util.List;

public interface MemberService {
	MemberDTO getMember(MemberDTO dto);
	int insert(MemberDTO dto);
	int update(MemberDTO dto);
	int delete(MemberDTO dto);
	List<MemberDTO> getMemberList();
}
