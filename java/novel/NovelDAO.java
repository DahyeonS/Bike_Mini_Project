package novel;

import java.util.List;

public interface NovelDAO {
	int getMemberCount();
	List<NovelDTO> getPostList(int pageNum, int listNum);
	int BoardInsert(NovelDTO dto);
	int delete(NovelDTO dto);
	NovelDTO view(NovelDTO dto);
	int update(NovelDTO dto);
	NovelDTO prevWrite(NovelDTO dto);
	NovelDTO prev(NovelDTO dto);
	int next(NovelDTO dto);
	int boardCnt(NovelDTO dto);
	List<NovelDTO> searchBtn(String option, String text,int pageNum, int listNum);
	int getSearchMemberCount(String option, String text);
}
