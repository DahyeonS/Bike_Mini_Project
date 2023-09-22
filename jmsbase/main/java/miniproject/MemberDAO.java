package miniproject;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

public class MemberDAO {

	
	public MemberDTO getMember(MemberDTO dto) {
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO retDto = null;
		
		try {
			
			String sql = "select * from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String id = dto.getId();
				String pw = rs.getString("pass");
				String name = rs.getString("name");
				String regidate = rs.getString("regidate");
				
				
				retDto = new MemberDTO(id, pw, name, regidate);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return retDto;
	} // End
	
	public int insert(MemberDTO dto) {
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			
			String sql = "insert into member(id, pass, name, regidate) values (?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPass());
			pstmt.setString(3, dto.getName());
			pstmt.setDate(4, getSysdate());
			System.out.println(getSysdate());
			rs = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return rs;
	} // End
	
	public int update(MemberDTO dto) {
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			
			String sql = "update member set pass = ?, name = ? where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getPass());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getId());
			
			rs = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return rs;
	}
	
	public int delete(MemberDTO dto) {
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;
		
		try {
			
			String sql = "delete from member where id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			
			rs = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, pstmt);
		}
		return rs;
	}
	
	public Date getSysdate (){
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;      

		Date date = null;

		try {
			

			String query = "SELECT SYSDATE FROM DUAL"; // 쿼리문
			pstmt=conn.prepareStatement(query);
			rs = pstmt.executeQuery(); // 쿼리실행


			if (rs.next()) {
				date = rs.getDate("SYSDATE"); 
			}

		} catch (Exception e) {
			System.out.println("Test / 오류 : " + e);
		} finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return date;
	}
	
}
