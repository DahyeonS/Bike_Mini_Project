package novel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import control.JDBCUtil;

public class NovelDAOImpl implements NovelDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	String sql = "";
	

	/*
	 * public BoardDTO getOne(BoardDTO dto){ BoardDTO retDto = null;
	 * 
	 * try { conn = JDBCUtil.getConnection(); sql =
	 * "select num, nickname, title, category,context, postdate, visit_count from post WHERE category = '일반'"
	 * ; pstmt = conn.prepareStatement(sql); pstmt.setString(1, dto.getId()); rs =
	 * pstmt.executeQuery();
	 * 
	 * while (rs.next()) { String id = rs.getString("id"); int num =
	 * rs.getInt("num"); String nickname = rs.getString("nickname"); String title =
	 * rs.getString("title"); String category = rs.getString("category"); String
	 * context = rs.getString("context"); String postdate =
	 * rs.getString("postdate"); int visit_count = rs.getInt("visit_count"); retDto
	 * = new BoardDTO(num, visit_count, context, id, nickname, title, category,
	 * postdate); } } catch (SQLException e) { e.printStackTrace(); } finally {
	 * JDBCUtil.close(pstmt, conn); } return retDto; }
	 */
	public int BoardInsert(NovelDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "INSERT INTO post (num,id, nickname, title, context, category) VALUES (post_idx.NEXTVAL,?, ?, ?, ?, '소설')";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContext());
			
			System.out.print("id " + dto.getId() + " /");
			System.out.print("name " + dto.getNickname() + " /");
			System.out.print("title " + dto.getTitle() + " /");
			System.out.print("context " + dto.getContext() + " /");
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	public int delete(NovelDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "delete from post where num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	public NovelDTO view(NovelDTO dto) {
		ResultSet rs;
		
		conn = JDBCUtil.getConnection();
		sql = "select id, nickname, title, category,context, postdate, visit_count from post WHERE category = '소설' and num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				String postdate = rs.getString("postdate");
				int visit_count = rs.getInt("visit_count");
				
				
				dto = new NovelDTO(context, nickname, id, title, visit_count, postdate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return dto;
	}
	public int update(NovelDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "UPDATE post SET title = ?, context = ? WHERE num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContext());
			pstmt.setInt(3, dto.getNum());
			
			System.out.print("update 확인");
			System.out.print("title " + dto.getTitle() + " /");
			System.out.print("context " + dto.getContext() + " /");
			System.out.print("num " + dto.getNum() + " /");
			
			rs = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	public NovelDTO prevWrite(NovelDTO dto) {
		ResultSet rs;
		
		conn = JDBCUtil.getConnection();
		sql = "select id, nickname, title, category,context, postdate, visit_count from post WHERE category = '소설' and num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				String postdate = rs.getString("postdate");
				int visit_count = rs.getInt("visit_count");
				
				
				dto = new NovelDTO(context, nickname, id, title, visit_count, postdate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return dto;
	}
	public int prev(NovelDTO dto) {
		ResultSet rs;
		int as = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "select num From(select * from post where category = '소설' and num > ? order by num) where rownum <=1";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				as = rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return as;
	}
	public int next(NovelDTO dto) {
		ResultSet rs;
		int as = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "select id, nickname,title, context, postdate,visit_count From(select * from post where category = '소설' and num < ? order by num desc) where rownum <=1";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				as = rs.getInt("num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return as;
	}
}




