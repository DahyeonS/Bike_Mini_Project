package pcgpkg;

import java.util.ArrayList;
import java.util.List;

import board.BoardDAO;
import board.BoardDTO;

public class test {
	static PcgBoardDAO dao = new PcgBoardDAO() {
	};
	
	public static void main(String[] args) {
		
//		PcgBoardDAO dao = new PcgBoardDAO() {};
//		
//		List<PcgBoardDTO> list= dao.pcggetBoardList(); 
//		
//		
//		for(PcgBoardDTO d : list) {
//			System.out.println(d);
//		}
		
//		PcgBoardDAO dao = new PcgBoardDAO() {};
//		PcgBoardDTO dto = new PcgBoardDTO();
//		dto.setTitle("q");
//		List<PcgBoardDTO> list= dao.pcggetBoardListSearchData(dto); 
//		
//		for(PcgBoardDTO d : list) {
//			System.out.println(d);
//
//		}
		
		
//		String id = "test1";
//		String nickname ="테스트1";
//		String title = "테스트용";
//		String context = "test";
//		String category = "일반";
//		
//		PcgBoardDTO dto = new PcgBoardDTO();
//		
//		dto.setId(id);
//		dto.setNickname(nickname);
//		dto.setTitle(title);
//		dto.setContext(context);
//		dto.setCategory(category);
//
//		int rs = dao.pcgInsertboard(dto);
//		
//		System.out.println(rs);
		
		// 페이징 리스트값
//		int pageNum = 1;
//		int listNum =10;
//		PcgBoardDAO dao = new PcgBoardDAO();
//		List<PcgBoardDTO> list = dao.pcggetBoardListPaging(pageNum, listNum);
//		
//		for(PcgBoardDTO dto : list) {
//			String ti = dto.getTitle();
//			
//			System.out.println(ti);
//		}
		// 페이징 리스트값 end
		
//		int pageNum = 2;
//		int listNum =10;
//		int totalCount = 137;
//		int blockNum =10;
//		PcgBoardDAO dao = new PcgBoardDAO();
//		List<PcgBoardDTO> list = dao.pcggetBoardListPaging(pageNum, listNum);
//		
//		PagingDTO PagingDTO = new PagingDTO(totalCount, pageNum, listNum, blockNum);
//		PagingDTO.setPaging();	
//		
//			
//			System.out.println(PagingDTO);
		
//		int i =10;
//		int j =10;
//		System.out.println(i*j);
		
		List<String> categorylist = new ArrayList<String>();
		categorylist = dao.pcgTotalCATEGORY();
		System.out.println(categorylist.toString());
		
		
	}
	

}
	

