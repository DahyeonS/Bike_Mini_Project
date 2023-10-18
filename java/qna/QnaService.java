package qna;

public interface QnaService {
	int getBoardPrev(QnaDTO dto);
	int getBoardNext(QnaDTO dto);
	int getBoardPrevTitle(QnaDTO dto);
	int getBoardPrevContext(QnaDTO dto);
	int getBoardPrevNickname(QnaDTO dto);
	int getBoardNextTitle(QnaDTO dto);
	int getBoardNextContext(QnaDTO dto);
	int getBoardNextNickname(QnaDTO dto);
}
