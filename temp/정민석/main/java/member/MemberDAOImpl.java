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
		sql = "SELECT idx, id, pw, nickname, grade, regdate FROM member";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				int idx = rs.getInt("idx");
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String nickname = rs.getString("nickname");
				String grade = rs.getString("grade");
				String regdate = rs.getString("regdate");
				MemberDTO dto = new MemberDTO(idx, id, pw, nickname, grade, regdate);
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
		sql = "SELECT id, pw, nickname FROM member WHERE id = ? OR nickname = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getNickname());
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				String id = rs.getString("id");
				String pw = rs.getString("pw");
				String nickname = rs.getString("nickname");
				
				dto = new MemberDTO(id, pw, nickname);
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
}
