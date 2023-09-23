package member;

import java.util.List;

public interface MemberDAO {
	List<MemberDTO> getMemberList();
	MemberDTO getMember(MemberDTO dto);
	int insert(MemberDTO dto);
	int update(MemberDTO dto);
	int delete(MemberDTO dto);
}