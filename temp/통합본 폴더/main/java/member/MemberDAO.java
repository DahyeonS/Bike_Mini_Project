package member;

import java.util.List;

public interface MemberDAO {
	List<MemberDTO> getMemberList();
	MemberDTO getMember(MemberDTO dto);
	MemberDTO getMemberNickname(MemberDTO dto);
	MemberDTO memberSearch(MemberDTO dto);
	int insert(MemberDTO dto);
	int update(MemberDTO dto);
	int delete(MemberDTO dto);
	int updateAdmin(MemberDTO dto);
	
	List<MemberBoardDTO> getBoardList(MemberBoardDTO dto, int pageNum);
	int getBoardCount(MemberBoardDTO dto);
	int deleteBoard(MemberBoardDTO dto);
}