package member;

public interface MemberService {
	MemberDTO getMember(MemberDTO dto);
	int insert(MemberDTO dto);
}
