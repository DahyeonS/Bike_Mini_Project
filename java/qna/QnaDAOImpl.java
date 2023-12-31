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
	public List<QnaDTO> getBoardList(int pageNum) {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		int offSet = (pageNum - 1) * 10;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT * FROM (SELECT num, title, nickname, visit_count, postdate, ROWNUM AS offset FROM "
		+ "(SELECT * FROM post WHERE category = '질문' ORDER BY num DESC)) WHERE offset > ? AND ROWNUM <= 10";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, offSet);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				int visitCount = rs.getInt("visit_count");
				String postdate = rs.getString("postdate");
				QnaDTO dto = new QnaDTO(num, title, nickname, null, visitCount, postdate, null);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public List<QnaDTO> getBoardListTitle(QnaDTO dto, int pageNum) {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		int offSet = (pageNum - 1) * 10;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT * FROM (SELECT num, title, nickname, visit_count, postdate, ROWNUM AS offset FROM "
				+ "(SELECT * FROM post WHERE category = '질문' AND title LIKE ? ORDER BY num DESC)) WHERE offset > ? AND ROWNUM <= 10";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + dto.getTitle() + "%");
			pstmt.setInt(2, offSet);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				int visitCount = rs.getInt("visit_count");
				String postdate = rs.getString("postdate");
				dto = new QnaDTO(num, title, nickname, null, visitCount, postdate, null);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public List<QnaDTO> getBoardListContext(QnaDTO dto, int pageNum) {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		int offSet = (pageNum - 1) * 10;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT * FROM (SELECT num, title, nickname, visit_count, postdate, ROWNUM AS offset FROM "
				+ "(SELECT * FROM post WHERE category = '질문' AND context LIKE ? ORDER BY num DESC)) WHERE offset > ? AND ROWNUM <= 10";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + dto.getContext() + "%");
			pstmt.setInt(2, offSet);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				int visitCount = rs.getInt("visit_count");
				String postdate = rs.getString("postdate");
				dto = new QnaDTO(num, title, nickname, null, visitCount, postdate, null);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public List<QnaDTO> getBoardListNickname(QnaDTO dto, int pageNum) {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		int offSet = (pageNum - 1) * 10;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT * FROM (SELECT num, title, nickname, visit_count, postdate, ROWNUM AS offset FROM "
				+ "(SELECT * FROM post WHERE category = '질문' AND nickname LIKE ? ORDER BY num DESC)) WHERE offset > ? AND ROWNUM <= 10";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + dto.getNickname() + "%");
			pstmt.setInt(2, offSet);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				int visitCount = rs.getInt("visit_count");
				String postdate = rs.getString("postdate");
				dto = new QnaDTO(num, title, nickname, null, visitCount, postdate, null);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return list;
	}

	@Override
	public List<QnaDTO> getAnswerList(QnaDTO dto) {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT num, title, nickname, context, postdate, update_date FROM post WHERE quest_num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				String context = rs.getString("context");
				String postdate = rs.getString("postdate");
				String updateDate = rs.getString("update_date");
				
				if (updateDate != null) dto = new QnaDTO(num, title, nickname, context, 0, postdate, updateDate);
				else dto = new QnaDTO(num, title, nickname, context, 0, postdate, "0");
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<QnaDTO> getReplyList(QnaDTO dto) {
		List<QnaDTO> list = new ArrayList<QnaDTO>();
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT num, id, nickname, context, postdate FROM reply WHERE post_num = ? ORDER BY num";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String context = rs.getString("context");
				String postdate = rs.getString("postdate");
				dto = new QnaDTO(num, 0, id, nickname, context, postdate);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public QnaDTO getBoardNum(QnaDTO dto) {
		conn = JDBCUtil.getConnection();
		sql = "SELECT num, nickname, title, context, file_id, file_name, postdate, update_date, visit_count FROM post WHERE num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				int file_id = rs.getInt("file_id");
				String file_name = rs.getString("file_name");
				String postdate = rs.getString("postdate");
				String updateDate = rs.getString("update_date");
				int visitCount = rs.getInt("visit_count");
				
				if (updateDate != null) dto = new QnaDTO(num, file_id, visitCount, nickname, title, context, file_name, updateDate, postdate);
				else dto = new QnaDTO(num, file_id, visitCount, nickname, title, context, file_name, "0", postdate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return dto;
	}

	@Override
	public int getPostNum(QnaDTO dto) {
		int result = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT num FROM (SELECT num FROM post WHERE category = '질문' AND id = ? ORDER BY num DESC) WHERE ROWNUM <= 1";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			
			rs = pstmt.executeQuery();
			if (rs.next()) result = rs.getInt("num");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return result;
	}
	
	@Override
	public int visitCnt(QnaDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "UPDATE post SET visit_count = (visit_count + 1) WHERE num = ?";
		
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
	
	@Override
	public int writeQuestion(QnaDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "INSERT INTO post (id, num, nickname, title, context, category) VALUES (?, post_idx.NEXTVAL, ?, ?, ?, '질문')";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContext());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	
	@Override
	public int writeAnswer(QnaDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "INSERT INTO post (id, num, nickname, title, context, category, quest_num) VALUES (?, post_idx.NEXTVAL, ?, ?, ?, '답변', ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContext());
			pstmt.setInt(5, dto.getNum());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	
	@Override
	public int deleteBoard(QnaDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "DELETE FROM post WHERE num = ? OR quest_num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			pstmt.setInt(2, dto.getNum());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	@Override
	public int updateBoard(QnaDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "UPDATE post SET title = ?, context = ?, update_date = SYSDATE WHERE num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContext());
			pstmt.setInt(3, dto.getNum());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	@Override
	public int writeReply(QnaDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "INSERT INTO reply (id, num, post_num, nickname, context) VALUES (?, reply_idx.NEXTVAL, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setInt(2, dto.getNum());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getContext());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	@Override
	public int deleteReply(QnaDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "DELETE FROM reply WHERE num = ?";
		
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

	@Override
	public int getBoardCount() {
		int result = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT COUNT(*) AS cnt FROM post WHERE category = '질문'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			if(rs.next()) result = rs.getInt("cnt");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return result;
	}

	@Override
	public int getBoardTitleCount(QnaDTO dto) {
		int result = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT COUNT(*) AS cnt FROM post WHERE category = '질문' AND title LIKE ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + dto.getTitle() + "%");
			
			rs = pstmt.executeQuery();
			if(rs.next()) result = rs.getInt("cnt");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return result;
	}

	@Override
	public int getBoardContextCount(QnaDTO dto) {
		int result = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT COUNT(*) AS cnt FROM post WHERE category = '질문' AND context LIKE ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + dto.getContext() + "%");
			
			rs = pstmt.executeQuery();
			if(rs.next()) result = rs.getInt("cnt");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return result;
	}

	@Override
	public int getBoardNicknameCount(QnaDTO dto) {
		int result = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT COUNT(*) AS cnt FROM post WHERE category = '질문' AND nickname LIKE ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + dto.getNickname() + "%");
			
			rs = pstmt.executeQuery();
			if(rs.next()) result = rs.getInt("cnt");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return result;
	}
}
