package qna;

public class QnaServiceImpl implements QnaService {
	QnaDAOXml dao = new QnaDAOXmlImpl();
	
	@Override
	public int getBoardPrev(int num) {
		return dao.getBoardPrev(num);
	}

	@Override
	public int getBoardNext(int num) {
		return dao.getBoardNext(num);
	}

	@Override
	public int getBoardPrevTitle(int num, String title) {
		return dao.getBoardPrevTitle(num, title);
	}

	@Override
	public int getBoardPrevContext(int num, String context) {
		return dao.getBoardPrevContext(num, context);
	}

	@Override
	public int getBoardPrevNickname(int num, String nickname) {
		return dao.getBoardPrevNickname(num, nickname);
	}

	@Override
	public int getBoardNextTitle(int num, String title) {
		return dao.getBoardNextTitle(num, title);
	}

	@Override
	public int getBoardNextContext(int num, String context) {
		return dao.getBoardNextContext(num, context);
	}

	@Override
	public int getBoardNextNickname(int num, String nickname) {
		return dao.getBoardNextNickname(num, nickname);
	}

}
