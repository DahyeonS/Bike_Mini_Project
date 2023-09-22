package miniproject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class BoardDAO {
	
	
	public int selectCount(Map<String, Object> map) {
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalcount=0;
		String sql="select count(*) from board ";
		if(map.get("serchWord")!=null) {
			sql+=" where "+map.get("serchField")+" "
			+ " like '%" + map.get("serchWord") + "%'";
		}
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totalcount=rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return totalcount;
	}
	

	
	public List<BoardDTO> selectListPage(Map<String,Object> map){
		List<BoardDTO> bbs = new ArrayList<BoardDTO>();
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="SELECT * FROM ( ";
		sql+="	SELECT Tb.*, rownum rNum FROM (";
		sql+="		SELECT * FROM board";
		if(map.get("serchWord")!=null) {
			sql+=" where "+map.get("serchField")
			+ " Like '%"+map.get("serchWord")+"%' ";
		}
		sql+=" ORDER BY num Desc	) Tb";
		sql+=" ) ";
		sql+=" WHERE rNum BETWEEN ? AND ?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, map.get("start").toString());
			pstmt.setString(2, map.get("end").toString());
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO dto =new BoardDTO();
				dto.setNum(rs.getString("num"));
				dto.setId(rs.getString("id"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setTitle(rs.getString("title"));
				dto.setVisitcount(rs.getString("visitcount"));
				bbs.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return bbs;
	}
	
	public int insertWrite(BoardDTO dto) {
		int result=0;
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="insert into board(";
		sql+="num,title,content,id,visitcount)";
		sql+="values ( seq_board_num.nextval,?,?,?,0)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getId());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return result;
	}
	public BoardDTO selectView(String num) {
		BoardDTO dto=new BoardDTO();
		
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="select B.*,M.name ";
		sql+="from member M inner join board B ";
		sql+="on M.id=B.id where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getString(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString(6));
				dto.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt, rs);
		}
		return dto;
	}
	
	public void updateVisitCount(String num) {
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="update board set visitcount";
		sql+="=visitcount+1 where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
	}
	
	public int updateEdit(BoardDTO dto) {
		int result=0;
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="update board set title";
		sql+="=?, content=? where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getNum());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return result;
	}
	
	public int deletePost(BoardDTO dto) {
		int result=0;
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="delete from board where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getNum());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, pstmt);
		}
		return result;
	}
}
