package qna;

public class QnaServiceImpl implements QnaService {
	QnaDAOXml dao = new QnaDAOXmlImpl();
	
	@Override
	public int getBoardPrev(QnaDTO dto) {
		return dao.getBoardPrev(dto);
	}

	@Override
	public int getBoardNext(QnaDTO dto) {
		return dao.getBoardNext(dto);
	}

	@Override
	public int getBoardPrevTitle(QnaDTO dto) {
		return dao.getBoardPrevTitle(dto);
	}

	@Override
	public int getBoardPrevContext(QnaDTO dto) {
		return dao.getBoardPrevContext(dto);
	}

	@Override
	public int getBoardPrevNickname(QnaDTO dto) {
		return dao.getBoardPrevNickname(dto);
	}

	@Override
	public int getBoardNextTitle(QnaDTO dto) {
		return dao.getBoardNextTitle(dto);
	}

	@Override
	public int getBoardNextContext(QnaDTO dto) {
		return dao.getBoardNextContext(dto);
	}

	@Override
	public int getBoardNextNickname(QnaDTO dto) {
		return dao.getBoardNextNickname(dto);
	}

}
