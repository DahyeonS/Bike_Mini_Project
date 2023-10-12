package jmsboard;

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
	public List<BoardDTO> getReplyList(BoardDTO dto);
	public int writeReply(BoardDTO dto);
	public int deleteReply(BoardDTO dto);
}
