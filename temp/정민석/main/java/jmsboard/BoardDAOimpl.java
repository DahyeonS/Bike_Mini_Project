package jmsboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import control.JDBCUtil;

public class BoardDAOimpl implements BoardDAO{
	
	
	public int selectCount(Map<String, Object> map) {
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalcount=0;
		String sql="select count(*) from post ";
		sql+=" WHERE category NOT IN ('질문','답변') ";
		if(map.get("serchWord")!=null) {
			sql+=" and "+map.get("serchField")+" "
			+ " like '%" + map.get("serchWord") + "%'";
		}
		System.out.println(sql);
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			rs.next();
			totalcount=rs.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
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
		sql+="		SELECT * FROM post ";
		sql+=" WHERE category NOT IN ('질문','답변') ";
		if(map.get("serchWord")!=null) {
			sql+=" and "+map.get("serchField")
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
				dto.setNum(rs.getInt("num"));
				dto.setId(rs.getString("id"));
				dto.setNickname(rs.getString("nickname"));
				dto.setContext(rs.getString("context"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setTitle(rs.getString("title"));
				dto.setVisitCount(rs.getInt("visit_count"));
				bbs.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt, conn);
		}
		return bbs;
	}
	
	public int insertWrite(BoardDTO dto) {
		int result=0;
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="insert into post(";
		sql+="num,title,context,id,nickname,category,file_id,file_name)";
		sql+="values ( post_idx.nextval,?,?,?,?,?,file_idx.nextval,?)";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContext());
			pstmt.setString(3, dto.getId());
			pstmt.setString(4, dto.getNickname());
			pstmt.setString(5, dto.getCategory());
			pstmt.setString(6, dto.getFileName());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt, conn);
		}
		return result;
	}
	public BoardDTO selectView(String num) {
		BoardDTO dto=new BoardDTO();
		
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql="select P.*,M.nickname ";
		sql+="from member M inner join post P ";
		sql+="on M.id=P.id where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContext(rs.getString("context"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitCount(rs.getInt("visit_count"));
				dto.setNickname(rs.getString("nickname"));
				dto.setFileName(rs.getString("file_name"));
				dto.setFileID(rs.getInt("file_id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return dto;
	}
	
	public void updateVisitCount(String num) {
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="update post set visit_count";
		sql+="=visit_count+1 where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			pstmt.executeQuery();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt, conn);
		}
	}
	
	public int updateEdit(BoardDTO dto) {
		int result=0;
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="update post set title";
		sql+="=?, context=?, file_name=? where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContext());
			pstmt.setString(3, dto.getFileName());
			pstmt.setInt(4, dto.getNum());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt, conn);
		}
		return result;
	}
	
	public int deletePost(BoardDTO dto) {
		int result=0;
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="delete from post where num=?";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt, conn);
		}
		return result;
	}
	
	@Override
	public List<BoardDTO> getReplyList(BoardDTO dto) {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		PreparedStatement pstmt = null;
		Connection conn = JDBCUtil.getConnection();
		String sql = "SELECT num, id, nickname, context, postdate FROM reply WHERE post_num = ? ORDER BY num";
		ResultSet rs = null;
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
				dto = new BoardDTO(num,id, nickname, context, postdate);
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int writeReply(BoardDTO dto) {
		int rs = 0;
		PreparedStatement pstmt = null;
		Connection conn = JDBCUtil.getConnection();
		String sql = "INSERT INTO reply (id, num, post_num, nickname, context) VALUES (?, reply_idx.NEXTVAL, ?, ?, ?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setInt(2, dto.getNum());
			pstmt.setString(3, dto.getNickname());
			pstmt.setString(4, dto.getContext());
			
			rs = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	@Override
	public int deleteReply(BoardDTO dto) {
		int rs = 0;
		PreparedStatement pstmt = null;
		Connection conn = JDBCUtil.getConnection();
		String sql = "DELETE FROM reply WHERE num = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getNum());
			
			rs = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
}
	
