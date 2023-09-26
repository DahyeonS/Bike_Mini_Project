package qna;

import java.util.List;

public interface QnaDAO {
	List<QnaDTO> getBoardList();
	List<QnaDTO> getBoardListTitle(QnaDTO dto);
}
