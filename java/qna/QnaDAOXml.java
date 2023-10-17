package qna;

public interface QnaDAOXml {
	int getBoardPrev(int num);
	int getBoardNext(int num);
	int getBoardPrevTitle(int num, String title);
	int getBoardPrevContext(int num, String context);
	int getBoardPrevNickname(int num, String nickname);
	int getBoardNextTitle(int num, String title);
	int getBoardNextContext(int num, String context);
	int getBoardNextNickname(int num, String nickname);
}
