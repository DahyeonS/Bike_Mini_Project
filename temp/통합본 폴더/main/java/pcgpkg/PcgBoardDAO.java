package pcgpkg;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import board.BoardDAO;
import board.BoardDTO;
import control.JDBCUtil;

public class PcgBoardDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	String sql = "";

	public List<PcgBoardDTO> pcggetBoardList() {
		List<PcgBoardDTO> list = new ArrayList<PcgBoardDTO>();

		conn = JDBCUtil.getConnection();
		sql = "select * from post order by NUM desc ";

		try {
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {

				int num = rs.getInt("NUM");
				String id = rs.getString("ID");
				;
				String nickname = rs.getString("NICKNAME");
				String title = rs.getString("TITLE");
				String context = rs.getString("CONTEXT");
				String category = rs.getString("CATEGORY");
				int fileID = rs.getInt("FILE_ID");
				String fileName = rs.getString("FILE_NAME");
				String postdate = rs.getString("POSTDATE");
				int visitCount = rs.getInt("VISIT_COUNT");

				PcgBoardDTO dto = new PcgBoardDTO(num, fileID, visitCount, id, nickname, title, context, category,
						fileName, postdate);
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}
		return list;
	}

	public List<PcgBoardDTO> pcggetBoardListSearchData(PcgBoardDTO dto) {
		List<PcgBoardDTO> list = new ArrayList<PcgBoardDTO>();

		conn = JDBCUtil.getConnection();
		String src = dto.getTitle();
		sql = "select * from post where title like ? ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + src + "%");

			rs = pstmt.executeQuery();
			while (rs.next()) {

				int num = rs.getInt("NUM");
				String id = rs.getString("ID");
				;
				String nickname = rs.getString("NICKNAME");
				String title = rs.getString("TITLE");
				String context = rs.getString("CONTEXT");
				String category = rs.getString("CATEGORY");
				int fileID = rs.getInt("FILE_ID");
				String fileName = rs.getString("FILE_NAME");
				String postdate = rs.getString("POSTDATE");
				int visitCount = rs.getInt("VISIT_COUNT");

				PcgBoardDTO retdto = new PcgBoardDTO(num, fileID, visitCount, id, nickname, title, context, category,
						fileName, postdate);
				list.add(retdto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}

		return list;
	}

	public PcgBoardDTO pcggetNumSearchData(PcgBoardDTO dto) {
		PcgBoardDTO list = new PcgBoardDTO();
		PcgBoardDTO retdto = null;
		conn = JDBCUtil.getConnection();
		int src = dto.getNum();
		sql = "select * from post where num = ? ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, src);

			rs = pstmt.executeQuery();
			while (rs.next()) {

				int num = rs.getInt("NUM");
				String id = rs.getString("ID");
				;
				String nickname = rs.getString("NICKNAME");
				String title = rs.getString("TITLE");
				String context = rs.getString("CONTEXT");
				String category = rs.getString("CATEGORY");
				int fileID = rs.getInt("FILE_ID");
				String fileName = rs.getString("FILE_NAME");
				String postdate = rs.getString("POSTDATE");
				int visitCount = rs.getInt("VISIT_COUNT");

				retdto = new PcgBoardDTO(num, fileID, visitCount, id, nickname, title, context, category, fileName,
						postdate);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(rs, pstmt, conn);
		}

		return retdto;
	}

	public int pcgInsertboard(PcgBoardDTO dto) {
		int rs = 0;

		conn = JDBCUtil.getConnection();

		String id = dto.getId();
		String nickname = dto.getNickname();
		String title = dto.getTitle();
		String context = dto.getContext();
		String category = dto.getCategory();

		sql = "Insert into POST (ID,NUM,NICKNAME,TITLE,CONTEXT,CATEGORY,FILE_ID,FILE_NAME,POSTDATE,VISIT_COUNT) values ( ? , POST_IDX.NEXTVAL , ? , ? , ? , ? ,null,null,SYSDATE,0) ";

		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setString(2, nickname);
			pstmt.setString(3, title);
			pstmt.setString(4, context);
			pstmt.setString(5, category);

			rs = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
			;
		}

		return rs;
	}

	public int pcgDeleteboard(PcgBoardDTO dto) {
		int rs = 0;
		conn = JDBCUtil.getConnection();
		String id = dto.getId();
		int num = dto.getNum();

		sql = "DELETE FROM POST" + " WHERE ID = ? AND NUM = ? ";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, num);

			rs = pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(pstmt, conn);
			;
		}

		return rs;
	}
	
	public PcgBoardDTO pcggetNumSearchView(String num) {
		PcgBoardDTO dto=new PcgBoardDTO();
		
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
	
	public int pcgUpDate(PcgBoardDTO dto) {
		int result=0;
		String get = dto.getTitle();
		int getnum = dto.getNum();
		System.out.println(get);
		System.out.println(getnum);
		
		
		Connection conn=JDBCUtil.getConnection();
		PreparedStatement pstmt = null;
		String sql="update post set title= ? , context= ?  where num=? ";
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContext());
			pstmt.setInt(3, dto.getNum());
			result=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtil.close(pstmt, conn);
		}
		return result;
	}
	
	public List<PcgBoardDTO> pcggetBoardListPaging(int pageNum, int listNum) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<PcgBoardDTO> list = new ArrayList<PcgBoardDTO>();
	    
	    int start_rownum = (pageNum - 1) * listNum + 1 ;
	    int end_rownum = pageNum * listNum ;
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        
	        String sql = "";
	        sql +=	"SELECT * FROM ( SELECT  po.*,  ROWNUM AS rnum  FROM ( ";
	        sql +=	"SELECT * FROM POST ORDER BY num desc ) po ";
	        sql +=	"WHERE ROWNUM <= ? ) ";
	        sql +=	"WHERE rnum BETWEEN ? AND ? ";
	        		
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setInt(1, end_rownum);
	        pstmt.setInt(2, start_rownum);
	        pstmt.setInt(3, end_rownum);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            int num = rs.getInt("NUM");
	            String id = rs.getString("ID");
	            String nickname = rs.getString("NICKNAME");
	            String title = rs.getString("TITLE");
	            String context = rs.getString("CONTEXT");
	            String category = rs.getString("CATEGORY");
	            int fileID = rs.getInt("FILE_ID");
	            String fileName = rs.getString("FILE_NAME");
	            String postdate = rs.getString("POSTDATE");
	            int visitCount = rs.getInt("VISIT_COUNT");
	    
	            PcgBoardDTO dto = new PcgBoardDTO(num, fileID, visitCount, id, nickname, title, context, category,fileName, postdate);
	            list.add(dto);
	        }
	        
	        return list;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null; // 예외 처리 로직 추가 필요
	    } finally {
	        JDBCUtil.close(rs, pstmt, conn);
	    }
	}
	
	public List<PcgBoardDTO> pcggetBoardListPaging(int pageNum, int listNum,String categorySelect,String textInputValue,String Selecttext) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    //여기까지 연결 선언
	    
	    int start_rownum = (pageNum - 1) * listNum + 1 ;
	    int end_rownum = pageNum * listNum ;
	    // 여기까지 페이징
	    System.out.println("카테고리 선택:"+categorySelect+"/검색할값:"+textInputValue+"/검색위치:"+Selecttext+"//dao잘왔는지 체크");
	    
	    String cg = "";
	    String st = "";
	    String sertit = "";
	    String sercont = "";
	    String sernick = "";
//	    String tiv =  Selecttext; //검색분류
	    
	    if(!(categorySelect.equals(""))){
	    	cg=	categorySelect; //검색 카테고리
	    };

	    
	    st=	textInputValue; // 검색할내용
	    
	    // 어떤 검색 인지 if
	    if(Selecttext.equals("title_value")) {
	    	 sertit = st;
	    }else if(Selecttext.equals("context_value")){
	    	 sercont = st;
	    	
	    }else if(Selecttext.equals("nickname_value")){
	    	 sernick = st;
	    }
	    System.out.println("검색값이 잘들어갔는지 체크//"+"cg:"+cg+"sertit:"+sertit+"sercont:"+sercont+"sernick:"+sernick);
	    
	    List<PcgBoardDTO> list = new ArrayList<PcgBoardDTO>();
	    try {
	        conn = JDBCUtil.getConnection();
	        
	        String sql = "";
	        sql +=	 " SELECT * FROM ( SELECT  po.*,  ROWNUM AS rnum  FROM (  ";
	        sql +=	 " SELECT * FROM POST where 1=1 ";
	        sql +=	 " and CATEGORY LIKE '%'|| ? ||'%' ";
	        sql +=	 " and TITLE LIKE '%'|| ? ||'%' ";
	        sql +=	 " and CONTEXT LIKE '%'|| ? ||'%' ";
	        sql +=	 " and NICKNAME LIKE '%'|| ? ||'%' ";
	        sql +=	 " ORDER BY num desc ) po   ";
	        sql +=	 " WHERE ROWNUM <= ? )   ";
	        sql +=	 " WHERE rnum BETWEEN ? AND ?  ";
//	        sql = "SELECT * FROM POST";
	        		
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, cg);
	        pstmt.setString(2, sertit);
	        pstmt.setString(3, sercont);
	        pstmt.setString(4, sernick);
	        pstmt.setInt(5, end_rownum);
	        pstmt.setInt(6, start_rownum);
	        pstmt.setInt(7, end_rownum);
	        
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            int num = rs.getInt("NUM");
	            String id = rs.getString("ID");
	            String nickname = rs.getString("NICKNAME");
	            String title = rs.getString("TITLE");
	            String context = rs.getString("CONTEXT");
	            String category = rs.getString("CATEGORY");
	            int fileID = rs.getInt("FILE_ID");
	            String fileName = rs.getString("FILE_NAME");
	            String postdate = rs.getString("POSTDATE");
	            int visitCount = rs.getInt("VISIT_COUNT");
	    
	            PcgBoardDTO dto = new PcgBoardDTO(num, fileID, visitCount, id, nickname, title, context, category,fileName, postdate);
	            list.add(dto);
	        }
	        return list;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null; // 예외 처리 로직 추가 필요
	    } finally {
	        JDBCUtil.close(rs, pstmt, conn);
	    }
	}
	
	public int pcgtotalCount(int pageNum, int listNum,String categorySelect,String textInputValue,String Selecttext) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int totalCount = 0;
	    //여기까지 연결 선언
	    System.out.println("검색페이징 카운트");
	    
	    int start_rownum = (pageNum - 1) * listNum + 1 ;
	    int end_rownum = pageNum * listNum ;
	    // 여기까지 페이징
	    System.out.println("카테고리 선택:"+categorySelect+"/검색할값:"+textInputValue+"/검색위치:"+Selecttext+"//dao잘왔는지 체크");
	    
	    String cg = "";
	    String st = "";
	    String sertit = "";
	    String sercont = "";
	    String sernick = "";
//	    String tiv =  Selecttext; //검색분류
	    
	    if(!(categorySelect.equals(""))){
	    	cg=	categorySelect; //검색 카테고리
	    };

	    
	    st=	textInputValue; // 검색할내용
	    
	    // 어떤 검색 인지 if
	    if(Selecttext.equals("title_value")) {
	    	 sertit = st;
	    }else if(Selecttext.equals("context_value")){
	    	 sercont = st;
	    	
	    }else if(Selecttext.equals("nickname_value")){
	    	 sernick = st;
	    }
	    System.out.println("검색값이 잘들어갔는지 체크//"+"cg:"+cg+"sertit:"+sertit+"sercont:"+sercont+"sernick:"+sernick);
	    
	    List<PcgBoardDTO> list = new ArrayList<PcgBoardDTO>();
	    try {
	        conn = JDBCUtil.getConnection();
	        
	        String sql = "";
	        sql +=	 "SELECT count(*) FROM ( SELECT  po.*,  ROWNUM AS rnum  FROM (  ";
	        sql +=	 "SELECT * FROM POST where 1=1 ";
	        sql +=	 "and CATEGORY LIKE '%'|| ? ||'%' ";
	        sql +=	 "and TITLE LIKE '%'|| ? ||'%'  ";
	        sql +=	 "and CONTEXT LIKE '%'|| ?||'%' ";
	        sql +=	 "and NICKNAME LIKE '%'|| ? ||'%' ";
	        sql +=	 "ORDER BY num desc ) po) ";
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, cg);
	        pstmt.setString(2, sertit);
	        pstmt.setString(3, sercont);
	        pstmt.setString(4, sernick);
	        
	        rs = pstmt.executeQuery();
	        
	        while (rs.next()) {
	            totalCount = rs.getInt("count(*)");
	        }
	        System.out.println(totalCount);
	        return totalCount;
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        JDBCUtil.close(rs, pstmt, conn);
	    }
	    return totalCount; // 예외 처리 로직 추가 필요
	}
	
	public int pcgtotalCount() {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    int totalCount = 0;
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        // 페이징 정보 계산
	        String countSql = "select count(*) from post ";
	        pstmt = conn.prepareStatement(countSql);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            totalCount = rs.getInt(1);
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        JDBCUtil.close(rs, pstmt, conn);
	    }
	    return totalCount;
	}
	
	public List<String> pcgTotalCATEGORY() {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<String> totalcategory = new ArrayList<String>();
	    String str ="";
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        // 페이징 정보 계산
	        String countSql = "SELECT DISTINCT CATEGORY FROM post order by CATEGORY desc";
	        pstmt = conn.prepareStatement(countSql);
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	        	str = rs.getString("CATEGORY");
	        	totalcategory.add(str);
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        JDBCUtil.close(rs, pstmt, conn);
	    }
	    return totalcategory;
	}

	public int insertFile(PcgBoardDTO dto) {
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    List<String> totalcategory = new ArrayList<String>();
	    int applyResult =0;
	    
	    try {
	        conn = JDBCUtil.getConnection();
	        // 페이징 정보 계산
	        String countSql = "INSERT INTO POST (NUM,NAME,TITLE,CATE,OFILE,SFILE) VALUES(POST_IDX.NEXTVAL,?,?,?,?,?) ";
	        pstmt = conn.prepareStatement(countSql);
	        
	        pstmt.setString(1, dto.getNickname());
	        pstmt.setString(2, dto.getTitle());
	        pstmt.setString(3, dto.getCategory());
	        pstmt.setString(4, dto.getFileName());
	        pstmt.setInt(5, dto.getFileID());
	        
	        applyResult = pstmt.executeUpdate();
	        
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        JDBCUtil.close(rs, pstmt, conn);
	    }
	    return applyResult;
	}
	
}




