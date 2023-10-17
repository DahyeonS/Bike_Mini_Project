package qna;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class QnaDAOXmlImpl implements QnaDAOXml {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	SqlSession sqlSession = sqlSessionFactory.openSession(true);

	@Override
	public int getBoardPrev(int num) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardPrev", num);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardNext(int num) {
		int result = 0;
		String sResult = sqlSession.selectOne("qnaxml.getBoardNext", num);
		if (sResult != null) result = Integer.parseInt(sResult);
		return result;
	}

	@Override
	public int getBoardPrevTitle(int num, String title) {
		return 0;
	}

	@Override
	public int getBoardPrevContext(int num, String context) {
		return 0;
	}

	@Override
	public int getBoardPrevNickname(int num, String nickname) {
		return 0;
	}

	@Override
	public int getBoardNextTitle(int num, String title) {
		return 0;
	}

	@Override
	public int getBoardNextContext(int num, String context) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getBoardNextNickname(int num, String nickname) {
		return 0;
	}
	
}
