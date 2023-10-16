package member.mybatis.inter;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import member.dto.MemberDTO;
import member.mybatis.mapper.MemberMapper;


public class MemberServiceImpl implements IMemberService{

	// Mybtis
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession(); 
	SqlSession sqlSession = sqlSessionFactory.openSession(true); // true : AutoCommit
	MemberMapper dao = sqlSession.getMapper(MemberMapper.class);

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
