package khBoard;

public class practice {
	
	public static void main(String[] args) {
		
		khBoardDAO dao = new khBoardDAO();
		khBoardDTO dto = new khBoardDTO();
		for(int i=1; i<=70; i++) {
			dto.setId("admin");
			dto.setNickname("관리자");
			dto.setTitle(i +"번째 질문 글입니다");
			dto.setContext(i +"번째 질문 글의 내용 입니다 내용은 길게 적어볼게요");
			dao.qInsertWrite(dto.getTitle(), dto.getContext(), dto.getId(), dto.getNickname());
		}
		

			
	}
}
