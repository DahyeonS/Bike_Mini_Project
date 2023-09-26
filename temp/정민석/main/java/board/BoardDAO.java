package board;

import java.util.List;
import java.util.Map;

public interface BoardDAO {
	public int selectCount(Map<String, Object> map);
	public List<BoardDTO> selectListPage(Map<String,Object> map);
	public int insertWrite(BoardDTO dto);
	public BoardDTO selectView(String num);
	public void updateVisitCount(String num);
	public int updateEdit(BoardDTO dto);
	public int deletePost(BoardDTO dto);

}
