package qna;

import java.util.List;

public interface QnaDAO {
	QnaDTO getBoardNum(QnaDTO dto);
	
	List<QnaDTO> getBoardList(int pageNum);
	List<QnaDTO> getBoardListTitle(QnaDTO dto, int pageNum);
	List<QnaDTO> getBoardListContext(QnaDTO dto, int pageNum);
	List<QnaDTO> getBoardListNickname(QnaDTO dto, int pageNum);
	List<QnaDTO> getAnswerList(QnaDTO dto);
	List<QnaDTO> getReplyList(QnaDTO dto);
	
	int getPostNum(QnaDTO dto);
	int visitCnt(QnaDTO dto);
	int deleteBoard(QnaDTO dto);
	int writeQuestion(QnaDTO dto);
	int writeAnswer(QnaDTO dto);
	int updateBoard(QnaDTO dto);
	int writeReply(QnaDTO dto);
	int deleteReply(QnaDTO dto);
	
	int getBoardCount();
	int getBoardTitleCount(QnaDTO dto);
	int getBoardContextCount(QnaDTO dto);
	int getBoardNicknameCount(QnaDTO dto);
}
