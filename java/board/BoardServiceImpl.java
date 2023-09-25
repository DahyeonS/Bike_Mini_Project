package board;

import java.util.List;

public class BoardServiceImpl implements BoardService {
	private BoardDAO dao;

	public BoardServiceImpl() {
		this.dao = new BoardDAOImpl();
	}
	
	@Override
	public List<BoardDTO> getBoardList() {
		return dao.getBoardList();
	}
}
