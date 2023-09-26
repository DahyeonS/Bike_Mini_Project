package qna;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import control.JDBCUtil;

public class QnaDAOImpl implements QnaDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	String sql = "";
	
	@Override
	public List<QnaDTO> getBoardList() {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		
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
				QnaDTO dto = new QnaDTO(num, title, nickname, null, nickname, visitCount, postdate);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} JDBCUtil.close(rs, pstmt, conn);
		return list;
	}

	@Override
	public List<QnaDTO> getBoardListTitle(QnaDTO dto) {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT num, title, nickname, visit_count, postdate FROM post WHERE category = '질문' AND title LIKE ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + dto.getTitle() + "%");
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				int visitCount = rs.getInt("visit_count");
				String postdate = rs.getString("postdate");
				dto = new QnaDTO(num, title, nickname, null, nickname, visitCount, postdate);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} JDBCUtil.close(rs, pstmt, conn);
		return list;
	}
}
