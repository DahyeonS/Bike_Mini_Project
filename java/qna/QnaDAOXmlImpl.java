package qna;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class QnaDAOXmlImpl implements QnaDAOXml {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	SqlSession sqlSession = sqlSessionFactory.openSession(true);

	@Override
	public int getBoardPrev(QnaDTO dto) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardPrev", dto);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardNext(QnaDTO dto) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardNext", dto);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardPrevTitle(QnaDTO dto) {
		System.out.println(dto.getTitle());
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardPrevTitle", dto);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardPrevContext(QnaDTO dto) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardPrevContext", dto);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardPrevNickname(QnaDTO dto) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardPrevNickname", dto);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardNextTitle(QnaDTO dto) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardNextTitle", dto);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardNextContext(QnaDTO dto) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardNextContext", dto);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardNextNickname(QnaDTO dto) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardNextNickname", dto);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}
	
}
