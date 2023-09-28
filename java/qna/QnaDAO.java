package qna;

import java.util.List;

public interface QnaDAO {
	QnaDTO getBoardNum(QnaDTO dto);
	
	List<QnaDTO> getBoardList();
	List<QnaDTO> getBoardListTitle(QnaDTO dto);
	List<QnaDTO> getBoardListContext(QnaDTO dto);
	List<QnaDTO> getBoardListNickname(QnaDTO dto);
	List<QnaDTO> getAnswerList(QnaDTO dto);
	
	int getPostNum(QnaDTO dto);
	int visitCnt(QnaDTO dto);
	int deleteBoard(QnaDTO dto);
	int writeQuestion(QnaDTO dto);
	int writeAnswer(QnaDTO dto);
}
