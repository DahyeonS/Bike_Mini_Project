package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import control.JDBCUtil;

public class MemberDAOImpl implements MemberDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	String sql = "";
	
	@Override
	public List<MemberDTO> getMemberList() {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT idx, id, nickname, grade, regdate FROM member";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int idx = rs.getInt("idx");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String grade = rs.getString("grade");
				if (grade.equals("MANAGER")) grade = "매니저";
				else if (grade.equals("ASSOCIATE")) grade = "부매니저";
				else if (grade.equals("STAFF")) grade = "스탭";
				else grade = "일반회원";
				String regdate = rs.getString("regdate");
				MemberDTO dto = new MemberDTO(idx, id, nickname, grade, regdate);
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
	public MemberDTO getMember(MemberDTO dto) {
		MemberDTO retDto = null;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT id, pw, nickname, grade FROM member WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String nickname = rs.getString("nickname");
				String grade = rs.getString("grade");
				
				retDto = new MemberDTO(id, pw, nickname, grade);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return retDto;
	}

	@Override
	public MemberDTO getMemberNickname(MemberDTO dto) {
		MemberDTO retDto = null;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT id, pw, nickname, grade FROM member WHERE nickname = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNickname());
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String nickname = rs.getString("nickname");
				String grade = rs.getString("grade");
				
				retDto = new MemberDTO(id, pw, nickname, grade);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return retDto;
	}
	
	@Override
	public MemberDTO memberSearch(MemberDTO dto) {
		conn = JDBCUtil.getConnection();
		sql = "SELECT id, pw, nickname, grade FROM member WHERE id = ? OR nickname = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getNickname());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String nickname = rs.getString("nickname");
				String grade = rs.getString("grade");
				
				dto = new MemberDTO(id, pw, nickname, grade);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return dto;
	}
	
	@Override
	public int insert(MemberDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "INSERT INTO member(idx, id, pw, nickname) VALUES (member_idx.NEXTVAL, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getNickname());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	@Override
	public int update(MemberDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "UPDATE member SET pw = ?, nickname = ? WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getId());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	@Override
	public int delete(MemberDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "DELETE FROM member WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	@Override
	public int updateAdmin(MemberDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "UPDATE member SET nickname = ?, grade = ? WHERE id = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNickname());
			pstmt.setString(2, dto.getGrade());
			pstmt.setString(3, dto.getId());
			
			rs = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	@Override
	public List<MemberBoardDTO> getBoardList(MemberBoardDTO dto, int pageNum) {
		List<MemberBoardDTO> list = new ArrayList<MemberBoardDTO>();
		int offSet = (pageNum - 1) * 10;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT * FROM (SELECT num, title, category, visit_count, postdate, ROWNUM AS offset FROM "
				+ "(SELECT * FROM post WHERE id = ? AND title LIKE ? AND context LIKE ? AND category LIKE ? "
				+ "ORDER BY num DESC)) WHERE offset > ? AND ROWNUM <= 10";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, "%" + dto.getTitle() + "%");
			pstmt.setString(3, "%" + dto.getContext() + "%");
			pstmt.setString(4, "%" + dto.getCategory() + "%");
			pstmt.setInt(5, offSet);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String category = rs.getString("category");
				int visitCount = rs.getInt("visit_count");
				String postdate = rs.getString("postdate");
				dto = new MemberBoardDTO(num, visitCount, title, null, category, postdate);
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
	public int getBoardCount(MemberBoardDTO dto) {
		int result = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "SELECT COUNT(*) AS cnt FROM post WHERE id = ? AND title LIKE ? AND context LIKE ? AND category LIKE ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, "%" + dto.getTitle() + "%");
			pstmt.setString(3, "%" + dto.getContext() + "%");
			pstmt.setString(4, "%" + dto.getCategory() + "%");
			
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
	public int deleteBoard(MemberBoardDTO dto) {
		int rs = 0;
		
		conn = JDBCUtil.getConnection();
		sql = "DELETE FROM post WHERE num = ?";
		
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
}
