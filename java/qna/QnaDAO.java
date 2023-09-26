package qna;

import java.util.List;

public interface QnaDAO {
	QnaDTO getBoardNum(QnaDTO dto);
	
	List<QnaDTO> getBoardList();
	List<QnaDTO> getBoardListTitle(QnaDTO dto);
	List<QnaDTO> getBoardListContext(QnaDTO dto);
	List<QnaDTO> getBoardListNickname(QnaDTO dto);
}
