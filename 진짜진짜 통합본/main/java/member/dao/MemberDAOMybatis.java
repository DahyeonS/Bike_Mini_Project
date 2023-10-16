package member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import member.dto.MemberDTO;
import member.mybatis.xml.SqlSessionManager;

public class MemberDAOMybatis {

	// Mybtis
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession(); 
	SqlSession sqlSession = sqlSessionFactory.openSession(true); // true : AutoCommit

	public List<MemberDTO> getMemberList() {
		
		return sqlSession.selectList("memberxml.getMemberList");
	} // End	

	public MemberDTO getMember(MemberDTO dto) {
		
		return sqlSession.selectOne("memberxml.getMember",dto);
	} // End

	public int insert(MemberDTO dto) {
		
		return sqlSession.insert("memberxml.insert",dto);
	} // End

	public int update(MemberDTO dto) {
		
		return sqlSession.update("memberxml.update",dto);
	}

	public int delete(MemberDTO dto) {
		
		return sqlSession.update("membermapper.delete",dto);
	}

	public List<MemberDTO> getMemberSearchNameList(MemberDTO dto) {
		
		return sqlSession.selectList("memberxml.getMemberSearchNameList");
	} // End
	
	public List<MemberDTO> getMemberCount() {
		
		return sqlSession.selectList("memberxml.getMemberList");
	} // End
	
	public List<MemberDTO> getMemberListPasing() {
		
		return sqlSession.selectList("memberxml.getMemberList");
	} // End
	
	
}
