package novel;

import java.util.List;

import javax.servlet.RequestDispatcher;

public interface BoardDAO {
	List<BoardDTO> getPostList();
}
