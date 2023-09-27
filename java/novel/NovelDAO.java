package novel;

import java.util.List;

public interface NovelDAO {
	/* BoardDTO getOne(BoardDTO dto); */
	int BoardInsert(NovelDTO dto);
	int delete(NovelDTO dto);
	NovelDTO view(NovelDTO dto);
	int update(NovelDTO dto);
	NovelDTO prevWrite(NovelDTO dto);
	int prev(NovelDTO dto);
	int next(NovelDTO dto);
}
