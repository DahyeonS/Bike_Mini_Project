package jhBoard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import control.JDBCUtil;

public class jhBoardDAO {

	public int boardCount() {

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount = 0;

		String sql = "SELECT COUNT(*) FROM POST WHERE CATEGORY ='일반'";

		try {
			pstmt = conn.prepareStatement(sql);
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
		
	public int boardCount(String searchWord, String searchField) {

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount = 0;

		String sql = "SELECT COUNT(*) FROM POST WHERE CATEGORY ='일반'";
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
	
	

	public int QBoardCount(String searchWord, String searchField) {

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int totalCount = 0;

		String sql = "SELECT COUNT(*) FROM POST WHERE CATEGORY ='질문'";
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

	public List<jhBoardDTO> boardList(int pageNum, int listNum) {

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<jhBoardDTO> jhList = new ArrayList<jhBoardDTO>();
		String sql = "SELECT * FROM (SELECT tb.*, rownum AS rnum FROM (select * from post WHERE category = '일반' ORDER BY num DESC) tb) WHERE rnum BETWEEN ? AND ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (pageNum-1)*listNum + 1);
			pstmt.setInt(2, (pageNum)*listNum);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				int num = rs.getInt("num");
				String postdate = rs.getString("postdate");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				int visitCount = rs.getInt("visit_count");
				jhBoardDTO jhDTO = new jhBoardDTO(num, postdate, nickname, title, visitCount);
				jhList.add(jhDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return jhList;
	}

	public List<jhBoardDTO> QBoardList(int pageNum, int listNum) {

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<jhBoardDTO> jhList = new ArrayList<jhBoardDTO>();
		String sql = "SELECT * FROM (SELECT tb.*, rownum AS rnum FROM (select * from post WHERE category = '질문' ORDER BY num DESC) tb) WHERE rnum BETWEEN ? AND ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (pageNum-1)*listNum + 1);
			pstmt.setInt(2, (pageNum)*listNum);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int num = rs.getInt("num");
				String postdate = rs.getString("postdate");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				int visitCount = rs.getInt("visit_count");
				jhBoardDTO jhDTO = new jhBoardDTO(num, postdate, nickname, title, visitCount);
				jhList.add(jhDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		System.out.println(jhList);
		return jhList;
	}
	
	public jhBoardDTO qGetBoard(int num) {

		jhBoardDTO dto = new jhBoardDTO();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM POST WHERE NUM = ? ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {	
				String id = rs.getString("id");	
				dto = new jhBoardDTO(num, id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return dto;
	}

	public List<jhBoardDTO> ABoardList(int qNum) {

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<jhBoardDTO> jhList = new ArrayList<jhBoardDTO>();

		String sql = "SELECT * FROM POST WHERE CATEGORY = '답글' and quest_num = ? ORDER BY num DESC";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, qNum);
			rs = pstmt.executeQuery();

			while (rs.next()) {

				int num = rs.getInt("num");
				String postdate = rs.getString("postdate");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				int visitCount = rs.getInt("visit_count");
				jhBoardDTO jhDTO = new jhBoardDTO(num, postdate, nickname, context, title, visitCount);
				jhList.add(jhDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return jhList;
	}

	public List<jhBoardDTO> searchBoard(String searchWord, String searchField, int listNum, int pageNum) {

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<jhBoardDTO> jhList = new ArrayList<jhBoardDTO>();

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
				pstmt.setString(1, "%" + searchWord + "%");
				pstmt.setInt(2, (pageNum-1)*listNum + 1);
				pstmt.setInt(3, (pageNum)*listNum);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					int num = rs.getInt("num");
					String postdate = rs.getString("postdate");
					String nickname = rs.getString("nickname");
					String title = rs.getString("title");
					int visitCount = rs.getInt("visit_count");
					jhBoardDTO jhDTO = new jhBoardDTO(num, postdate, nickname, title, visitCount);
					jhList.add(jhDTO);
				}

			} catch (Exception e) {
				e.printStackTrace();

			} finally {
				JDBCUtil.close(rs, pstmt, conn);
			}
			return jhList;
	}

	public List<jhBoardDTO> QsearchBoard(String searchWord, String searchField, int listNum, int pageNum) {
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<jhBoardDTO> jhList = new ArrayList<jhBoardDTO>();
		
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
				pstmt.setString(1, "%" + searchWord + "%");
				pstmt.setInt(2, (pageNum-1)*listNum + 1);
				pstmt.setInt(3, (pageNum)*listNum);
				rs = pstmt.executeQuery();

				while (rs.next()) {
					int num = rs.getInt("num");
					String postdate = rs.getString("postdate");
					String nickname = rs.getString("nickname");
					String title = rs.getString("title");
					int visitCount = rs.getInt("visit_count");
					jhBoardDTO jhDTO = new jhBoardDTO(num, postdate, nickname, title, visitCount);
					jhList.add(jhDTO);
				}

			} catch (Exception e) {
				e.printStackTrace();

			} finally {
				JDBCUtil.close(rs, pstmt, conn);
			}
			return jhList;
	}

	public int writeUpload(jhBoardDTO jhDTO) {

		System.out.println(jhDTO.getContext());
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;
		String sql = "insert into post (id, num, nickname, title, context, category, file_id, file_name, postdate, visit_count) values(?, post_idx.nextval, ?, ?, ?, '일반', file_idx.nextval, null, sysdate, 0)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, jhDTO.getId());
			pstmt.setString(2, jhDTO.getNickname());
			pstmt.setString(3, jhDTO.getTitle());
			pstmt.setString(4, jhDTO.getContext());
			rs = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	public int QWriteUpload(jhBoardDTO jhDTO) {

		System.out.println(jhDTO.getContext());
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;
		String sql = "insert into post (id, num, nickname, title, context, category, file_id, file_name, postdate, visit_count) values(?, post_idx.nextval, ?, ?, ?, '질문', file_idx.nextval, null, sysdate, 0)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, jhDTO.getId());
			pstmt.setString(2, jhDTO.getNickname());
			pstmt.setString(3, jhDTO.getTitle());
			pstmt.setString(4, jhDTO.getContext());
			rs = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	public int AWriteUpload(jhBoardDTO jhDTO) {

		System.out.println(jhDTO.getContext());
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;
		String sql = "insert into post (id, num, nickname, title, context, category, file_id, file_name, postdate, visit_count, quest_num) values(?, post_idx.nextval, ?, ?, ?, '답글', file_idx.nextval, null, sysdate, 0, ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, jhDTO.getId());
			pstmt.setString(2, jhDTO.getNickname());
			pstmt.setString(3, jhDTO.getTitle());
			pstmt.setString(4, jhDTO.getContext());
			pstmt.setInt(5, jhDTO.getNum());
			rs = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}

	public jhBoardDTO selectView(int num) {

		jhBoardDTO dto = new jhBoardDTO();

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM POST WHERE NUM = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {

				int file_id = rs.getInt("file_id");
				int visit_count = rs.getInt("visit_count");
				String id = rs.getString("id");
				String nickname = rs.getString("nickname");
				String title = rs.getString("title");
				String context = rs.getString("context");
				String category = rs.getString("category");
				String file_name = rs.getString("file_name");
				String postdate = rs.getString("postdate");
				dto = new jhBoardDTO(num, file_id, visit_count, id, nickname, title, context, category, file_name,
						postdate);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return dto;
	}

	public int editBoard(int num, String title, String context) {

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;

		String sql = "UPDATE POST SET TITLE = ?, CONTEXT = ?, POSTDATE=SYSDATE WHERE NUM = ?";

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

		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;

		String sql = "DELETE FROM POST WHERE NUM = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
		}
		return rs;
	}
	
	public int beforeBoard(int num) {
		int before = 0;
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select num from (select num from post where num < ? AND CATEGORY ='일반' order by num desc) where rownum = 1";
		
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

		String sql = "select num from (select num from post where num < ? AND CATEGORY = '질문' order by num desc) where rownum = 1";

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

		String sql = "select num from (select num from post where num > ? AND CATEGORY ='일반' order by num) where rownum = 1";

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

		String sql = "select num from (select num from post where num > ? AND CATEGORY = '질문' order by num) where rownum = 1";

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
	
	public int visitCount(int num) {
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		int rs = 0;

		String sql = "update post set visit_count = visit_count + 1 where num = ?";

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
