package novel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import control.JDBCUtil;

public class BoardDAOImpl implements BoardDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	String sql = "";
	
	public List<BoardDTO> getPostList(){
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		
		conn = JDBCUtil.getConnection();
		sql = "select id, num, nickname, title, category,context, postdate, visit_count from post WHERE category = '소설'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = rs.getString("id");
				int num = rs.getInt("num");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String category = rs.getString("category");
				String context = rs.getString("context");
				String postdate = rs.getString("postdate");
				int visit_count = rs.getInt("visit_count");
				BoardDTO dto = new BoardDTO(num, visit_count, context, id, nickname, title, category, postdate);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return list;		
	}
}




