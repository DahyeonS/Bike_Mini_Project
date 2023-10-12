package khBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.JDBCUtil;

public class khBoardDAO {
	
	
	public int selectCount(String searchWord, String searchField) {

		int totalCount = 0;
		
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT COUNT(*) FROM POST WHERE CATEGORY = '일반' ";
		if(searchWord != null) {
			sql += "AND " + searchField + " LIKE ? ";
		}

		try {
			pstmt = conn.prepareStatement(sql);
			if(searchWord != null) {
				pstmt.setString(1, "%" + searchWord + "%");
			}
			rs = pstmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		
		return totalCount;
	}
	
	public int qSelectCount(String searchWord, String searchField) {

		int totalCount = 0;
		
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT COUNT(*) FROM POST WHERE CATEGORY = '질문' ";
		if(searchWord != null) {
			sql += "AND " + searchField + " LIKE ? ";
		}

		try {
			pstmt = conn.prepareStatement(sql);
			if(searchWord != null) {
				pstmt.setString(1, "%" + searchWord + "%");
			}
			rs = pstmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		
		return totalCount;
	}
	
	public int iSelectCount(String searchWord, String searchField) {

		int totalCount = 0;
		
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT COUNT(*) FROM POST WHERE CATEGORY = '사진' ";
		if(searchWord != null) {
			sql += "AND " + searchField + " LIKE ? ";
		}

		try {
			pstmt = conn.prepareStatement(sql);
			if(searchWord != null) {
				pstmt.setString(1, "%" + searchWord + "%");
			}
			rs = pstmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		
		return totalCount;
	}


	public List<khBoardDTO> boardList(int listNum, int pageNum) {
		System.out.println(2222);

		List<khBoardDTO> list = new ArrayList<khBoardDTO>();
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM (SELECT tb.*, rownum AS rnum FROM (select * from post WHERE category = '일반' ORDER BY num DESC) tb) WHERE rnum BETWEEN ? AND ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (pageNum-1)*listNum + 1);
			pstmt.setInt(2, (pageNum)*listNum);
			rs = pstmt.executeQuery();

			while(rs.next()) {

				String id = rs.getString("id");
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				String postdate = rs.getString("postdate");
				int visit_count = rs.getInt("visit_count");

				khBoardDTO dto = new khBoardDTO(id, num, title, nickname, postdate, visit_count);
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}

		return list;
	}

	public List<khBoardDTO> qBoardList() {

		List<khBoardDTO> list = new ArrayList<khBoardDTO>();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM POST WHERE CATEGORY = '질문' ORDER BY num DESC";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while(rs.next()) {

				String id = rs.getString("id");
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				String postdate = rs.getString("postdate");
				int visit_count = rs.getInt("visit_count");

				khBoardDTO dto = new khBoardDTO(id, num, title, nickname, postdate, visit_count);
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}

		return list;
	}
	
	public List<khBoardDTO> aBoardList(int qNum) {

		List<khBoardDTO> list = new ArrayList<khBoardDTO>();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM POST WHERE CATEGORY = '답변' and quest_num = ? ORDER BY num DESC";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qNum);
			rs = pstmt.executeQuery();

			while(rs.next()) {

				int num = rs.getInt("num");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				String postdate = rs.getString("postdate");

				khBoardDTO dto = new khBoardDTO(num, nickname, context, postdate, title);
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		System.out.println(list);
		return list;
	}
	
	public List<khBoardDTO> searchList(String searchWord, String searchField, int listNum, int pageNum) {

		List<khBoardDTO> list = new ArrayList<khBoardDTO>();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM (SELECT tb.*, rownum AS rnum FROM (select * from post WHERE category = '일반' ";
		if(searchField != null) {
			if(searchField.equals("title")) {
				sql += "AND title LIKE ? ";
			}	
			else if (searchField.equals("nickname")) {
				sql += "AND nickname LIKE ? ";
			}
			sql +=  " ORDER BY num DESC) tb) WHERE rnum BETWEEN ? AND ? ";
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + searchWord +"%");
			pstmt.setInt(2, (pageNum-1)*listNum + 1);
			pstmt.setInt(3, (pageNum)*listNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String id = rs.getString("id");
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				String postdate = rs.getString("postdate");
				int visit_count = rs.getInt("visit_count");
				khBoardDTO dto = new khBoardDTO(id, num, title, nickname, postdate, visit_count);
				list.add(dto);
			}

			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public List<khBoardDTO> qSearchList(String searchWord, String searchField, int listNum, int pageNum) {

		List<khBoardDTO> list = new ArrayList<khBoardDTO>();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM (SELECT tb.*, rownum AS rnum FROM (select * from post WHERE category = '질문' ";
		if(searchField != null) {
			if(searchField.equals("title")) {
				sql += "AND title LIKE ? ";
			}	
			else if (searchField.equals("nickname")) {
				sql += "AND nickname LIKE ? ";
			}
			sql +=  " ORDER BY num DESC) tb) WHERE rnum BETWEEN ? AND ? ";
		}
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + searchWord +"%");
			pstmt.setInt(2, (pageNum-1)*listNum + 1);
			pstmt.setInt(3, (pageNum)*listNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String id = rs.getString("id");
				int num = rs.getInt("num");
				String title = rs.getString("title");
				String nickname = rs.getString("nickname");
				String postdate = rs.getString("postdate");
				int visit_count = rs.getInt("visit_count");
				khBoardDTO dto = new khBoardDTO(id, num, title, nickname, postdate, visit_count);
				list.add(dto);
			}

			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public List<khBoardDTO> iSearchList(String searchWord, String searchField, int listNum, int pageNum) {

		List<khBoardDTO> list = new ArrayList<khBoardDTO>();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM (SELECT tb.*, rownum AS rnum FROM (select * from post WHERE category = '사진' ";
		if(searchField != null) {
			if(searchField.equals("title")) {
				sql += "AND title LIKE ? ";
			}	
			else if (searchField.equals("nickname")) {
				sql += "AND nickname LIKE ? ";
			}
			sql +=  " ORDER BY num DESC) tb) WHERE rnum BETWEEN ? AND ? ";
		}
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + searchWord +"%");
			pstmt.setInt(2, (pageNum-1)*listNum + 1);
			pstmt.setInt(3, (pageNum)*listNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int num = rs.getInt("num");
				int file_id = rs.getInt("file_id");
				int visit_count = rs.getInt("visit_count");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				String file_name = rs.getString("file_name");
				String postdate = rs.getString("postdate");
				khBoardDTO dto = new khBoardDTO(num, file_id, visit_count, id, nickname, title, context, file_name, postdate);
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		
		return list;
	}
	
	public int insertWrite(String title, String context, String id, String nickname) {

		int rs = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO post (num, title, context, id, nickname, category, file_id, visit_count) ";
		sql += "values (post_idx.nextval, ?, ?, ?, ?, '일반', file_idx.nextval, 0)";


		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, context);
			pstmt.setString(3, id);
			pstmt.setString(4, nickname);

			rs = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	
	public int qInsertWrite(String title, String context, String id, String nickname) {

		int rs = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO post (num, title, context, id, nickname, category, file_id, visit_count) ";
		sql += "values (post_idx.nextval, ?, ?, ?, ?, '질문', file_idx.nextval, 0)";


		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, context);
			pstmt.setString(3, id);
			pstmt.setString(4, nickname);

			rs = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	
	public int aInsertWrite(String title, String context, String id, String nickname, int num) {

		int rs = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO post (num, title, context, id, nickname, category, file_id, visit_count, quest_num) ";
		sql += "values (post_idx.nextval, ?, ?, ?, ?, '답변', file_idx.nextval, 0, ?)";


		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, context);
			pstmt.setString(3, id);
			pstmt.setString(4, nickname);
			pstmt.setInt(5, num);

			rs = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	
	public int upload(khBoardDTO dto) {

		int rs = 0;
		System.out.println(dto);
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql = "insert into post (id, num, nickname, title, context, category, file_id, file_name, postdate) values ";
		sql += "(?, post_idx.nextval, ?, ?, ?, '사진', file_idx.nextval, ?, sysdate)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getNickname());
			pstmt.setString(3, dto.getTitle());
			pstmt.setString(4, dto.getContext());
			pstmt.setString(5, dto.getFile_name());

			rs = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	public khBoardDTO getBoard(int num) {

		khBoardDTO dto = new khBoardDTO();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM POST WHERE NUM = ? AND CATEGORY = '일반' ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {

				int file_id = rs.getInt("file_id");
				int visit_count = rs.getInt("visit_count");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				String category = rs.getString("category");
				String file_name = rs.getString("file_name");
				String postdate = rs.getString("postdate");
				dto = new khBoardDTO(num, file_id, visit_count, id, nickname, title, context, category, file_name, postdate);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}

		return dto;
	}
	
	public khBoardDTO qGetBoard(int num) {

		khBoardDTO dto = new khBoardDTO();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM POST WHERE NUM = ? AND CATEGORY = '질문' ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {

				int file_id = rs.getInt("file_id");
				int visit_count = rs.getInt("visit_count");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				String category = rs.getString("category");
				String file_name = rs.getString("file_name");
				String postdate = rs.getString("postdate");
				dto = new khBoardDTO(num, file_id, visit_count, id, nickname, title, context, category, file_name, postdate);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return dto;
	}
	
	public khBoardDTO iGetBoard(int num) {

		khBoardDTO dto = new khBoardDTO();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM POST WHERE NUM = ? AND CATEGORY = '사진' ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {

				int file_id = rs.getInt("file_id");
				int visit_count = rs.getInt("visit_count");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				String category = rs.getString("category");
				String file_name = rs.getString("file_name");
				String postdate = rs.getString("postdate");
				dto = new khBoardDTO(num, file_id, visit_count, id, nickname, title, context, category, file_name, postdate);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return dto;
	}
	

	public int updateBoard(int num, String title, String context) {
		int rs = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;

		String sql = "UPDATE post SET title = ?, context = ?, postdate=sysdate WHERE num = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, context);
			pstmt.setInt(3, num);
			rs = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}

		return rs;
	}

	public int deleteBoard(int num) {
		int rs = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;

		String sql = "DELETE FROM post WHERE num = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	public int beforeBoard(int num) {
		int before = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select num from (select num from post where num > ? AND CATEGORY = '일반' order by num) where rownum = 1";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				before = rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return before;
	}
	public int qBeforeBoard(int num) {
		int before = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select num from (select num from post where num > ? AND CATEGORY = '질문' order by num) where rownum = 1";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				before = rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return before;
	}
	
	public int iBeforeBoard(int num) {
		int before = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select num from (select num from post where num > ? AND CATEGORY = '사진' order by num) where rownum = 1";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				before = rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return before;
	}
	public int nextBoard(int num) {
		int next = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select num from (select num from post where num < ? AND CATEGORY = '일반' order by num desc) where rownum = 1";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				next = rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return next;
	}
	public int qNextBoard(int num) {
		int next = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select num from (select num from post where num < ? AND CATEGORY = '질문' order by num desc) where rownum = 1";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				next = rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return next;
	}
	public int iNextBoard(int num) {
		int next = 0;

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select num from (select num from post where num < ? AND CATEGORY = '사진' order by num desc) where rownum = 1";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				next = rs.getInt("num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return next;
	}
	public int visit_count_plus(int num) {
	
		int rs = 0;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;

		String sql = "update post set visit_count=visit_count+1 where num = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
		
	}


}
