package board;

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
	
	@Override
	public List<BoardDTO> getBoardList() {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT num, title, nickname, visit_count, postdate FROM post WHERE category = '질문'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				int visitCount = rs.getInt("visit_count");
				String postdate = rs.getString("postdate");
				BoardDTO dto = new BoardDTO(num, title, nickname, null, nickname, visitCount, postdate);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} JDBCUtil.close(rs, pstmt, conn);
		return list;
	}
}
