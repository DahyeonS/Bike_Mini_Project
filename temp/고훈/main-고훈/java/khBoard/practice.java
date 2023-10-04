package khBoard;

public class practice {
	
	public static void main(String[] args) {
		
		khBoardDAO dao = new khBoardDAO();
		khBoardDTO dto = new khBoardDTO();
		for(int i=1; i<=100; i++) {
			dto.setId("id2");
			dto.setNickname("일반2");
			dto.setTitle(i +"번째 글");
			dto.setContext(i +"번째 글의 내용 입니다");
			dao.insertWrite(dto.getTitle(), dto.getContext(), dto.getId(), dto.getNickname());
		}		
	}
}
