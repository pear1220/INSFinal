package com.spring.finalins.qna.service;

import java.util.HashMap;
import java.util.List;

import org.apache.tools.ant.util.SymbolicLinkUtils;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finalins.model.MemberVO;
import com.spring.finalins.qna.model.InterQnaDAO;
import com.spring.finalins.qna.model.QnaVO;



// ====== #30. Service 선언
@Service
public class QnaService implements InterQnaService {

	// ======= #31. 의존객체 주입하기(DI: Dependency Injection)
	@Autowired
	private InterQnaDAO dao;

	
	// ====== #41. 메인페이지용 이미지 파일이름을 가져오는 서비스단 getImgfilenameList() 메소드 생성하기 ======
	/*@Override
	public List<String> getImgfilenameList() {
		
		List<String> imgfilenameList = dao.getImgfilenameList();
		
		return imgfilenameList;
	}*/


	// ====== #54. 글쓰기(파일첨부가 없는 글쓰기) ======
	@Override
	public int add(QnaVO qnavo) {
		
		// ==== #123. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여
		//            tblBoard 테이블에 insert 를 해줘야 한다.
		//            원글쓰기 라면 tblBoard 테이블의 groupno 컬럼의 값은
		//            max값 +1 로 해야 하고,
		//            답변글쓰기 라면 넘겨 받은 값을 그대로 insert 해줘야 한다.
		
		// 원글쓰기인, 답변글쓰기인지 구분하기
		if(qnavo.getQna_fk_idx() == null ||qnavo.getQna_fk_idx().trim().isEmpty()) { // 원글을 쓸 경우!
			// 원글쓰기인 경우
		   // int groupno = dao.getGroupMaxno()+1;  //(groupno는 max+1)	
			//qnavo.setQna_groupno(String.valueOf(groupno));// db에서 읽어와서 qnavo에 set을 해줬다. 그래서 board.xml에서 글쓰기 add를 할 때 qnavo에 있는 getGroupno를 넣어주면 된다.
		}

		
		int n = dao.add(qnavo);
		return n;
	}


	/*// ======= #58. 글목록 보여주기(검색어가 없는 전체 글목록 보여주기)
	@Override
	public List<QnaVO> boardList() {
		List<QnaVO> boardList = dao.boardList();
		return boardList;
	}


	// 조회수(readCount) 증가한 후에 글1개를 가져오는 것.
	// 단, 자신이 쓴 글을 자신이 읽을시에는 조회수가 증가되지 않고 ,
	// 다른 사람이 쓴 글이어야 조회수가 증가되도록 해야 한다.
	// 로그인 하지 않은 상태에서 글을 읽을 때 조회수 증가가 일어나지 않도록 한다.
	
	// ====== #62. 조회수(readCount) 증가한 후에 글 1개를 가져오는 것 =====
	//             단, 다른 사람의 글일때만 조회수 1증가 시킨다.
	@Override
	public QnaVO getView(String seq, String userid) {
		
        QnaVO qnavo = dao.getView(seq);  // 글 한개만 읽어오는 것. sql구문에서 where절에 seq만 넣는 것
 	
		if(userid != null && !qnavo.getFk_userid().equals(userid)) { //  qnavo.getUserid().equals(userid); // 읽어온 글에서 userid가 로그인한 유저와 글쓴이인지 비교할 것이다.
			dao.setAddReadCount(seq);  // 조회수를 카운트하니까 update
			
			// 트랜잭션 처리는 아니다. DML밖에 없으니까?
			qnavo = dao.getView(seq);
		}
		
		return qnavo;
	}


	// ====== #69. 조회수(readCount) 증가없이 글 1개를 가져오는 것 =====
	@Override
	public QnaVO getViewWithNoReadCount(String seq) {
		 QnaVO qnavo = dao.getView(seq); 
		return qnavo;
	}

    // ==== #72. 1개글 수정하기 ====
	@Override
	public int edit(QnaVO qnavo) {
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("seq",qnavo.getQna_idx());
		// seq를 qna_idx로
	//	map.put("seq", qnavo.getQna_idx());
	//	map.put("pw", qnavo.getPw());
		
		boolean checkPw = dao.checkPw(map
				);
		// 글번호에 대한 암호가 일치하면 true 반환, 
		// 글번호에 대한 암호가 일치하지 않으면 false 반환. 
		
		int n = 0;
		
		if(checkPw) 
			n = dao.updateContent(qnavo); // 글 1개 수정하기
		
		
		return n;
	}


	// ==== #79. 글 1개 삭제하기 ====
//	@Override
//	public int del(HashMap<String, String> map) {
	
	
	// ===== #96. 트랜잭션 처리를 위해서 먼저 위의 줄을 주석처리를 하고 아래와 같이 한다.
	@Override
	@Transactional( propagation=Propagation.REQUIRED,  isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})   // 트랜잭션 처리를 위해 @Transactional를 한다.
	public int del(HashMap<String, String> map) throws Throwable {
		
		boolean checkPw = dao.checkPw(map);
		// 글번호에 대한 암호가 일치하면 true 반환, 
	    // 글번호에 대한 암호가 일치하지 않으면 false 반환.  
		
		int result1 =0, result2=0, n = 0;	
		boolean bool = false;
		
		if(checkPw) { // 패스워드가 일치하면 true값을 받는다.
			
			// ===== #97. 원게시글에서 딸린 댓글들이 있는지 없는지를 확인하기(복수개)
			//            댓글이 있으면 bool은 true/ 댓글이 없으면 bool은 false
			bool = dao.isExistsComment(map); 
			
			result1 = dao.deleteContent(map);  // map에 글번호가 들어있다. // 글 1개 삭제하기
			
			if(bool) { // ===== #98. 원게시글에 달린 댓글들 삭제하기(복수개)
				result2 = dao.deleteComment(map);
			}
		}
		
		
		if( (bool == true && result1 == 1 && result2 > 0) ||  // 원게시글에 댓글이 있고 게시글 삭제도 성공하고, 댓글 삭제도 성공했을 경우 n에 1값을 준다.
		    (bool == false && result1 == 1 && result2 == 0)	) // 원게시글에 댓글이 없고 게시글 삭제를 성공했을 때 n값에 1을 주겠다. 
			n=1; 
		          
		
		return n;
	}

	
	
	
    // ===== #86. 댓글쓰기
	
	  tblComment 테이블에 insert 된 다음에
	  tblBoard 테이블에 commentCount 컬럼의 값이 1증가(update) 하도록 요청한다.
	   즉, 2개 이상의 DML 처리를 해야 하므로 Transaction 처리를 해야 한다. 
	
	   >>>> 트랜잭션처리를 해야 할 메소드에 @Transactional 어노테이션을 설정하면 된다. 
	   rollbackFor= {Throwable.class} 은 롤백을 해야 할 범위를 말한다.
	   Throwable.class 은 error 및 exception 을 포함한 최상위 루트이다.
	     즉, 해당 메소드 실행시 발생하는 모든 error 및 exception 에 대해서 롤백을 하겠다.
	     
	   isolation=Isolation.READ_COMMITTED  커밋되어진다.
    
	@Override
	@Transactional( propagation=Propagation.REQUIRED,  isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})   // 트랜잭션 처리를 위해 @Transactional를 한다.
	// 체크제약에 위배되면 throws throwable한다. 던져버린 것을 spring container가 처리하고 이것을 여기서...
	public int addComment(CommentVO commentvo) throws Throwable {
		
		int result = 0;
		
		int n = 0;
		 n = dao.addComment(commentvo);
		 // tblComment 테이블에 insert
		
		if(n ==1) {  // tblComment 테이블에 insert가 성공했다면이라고 가정
			
			result = dao.updateCommentCount(commentvo.getParentSeq()); // 댓글에 포함되어진 부모글의 글번호 commentvo.getParentSeq()
			// tblBoard 테이블에 commentCount 컬럼의 값이 1증가(update) 
		}
		

		return result;
	}


	// ===== #92. 댓글내용 보여주기
	@Override
	public List<CommentVO> listComment(String seq) {
		List<CommentVO> list = dao.listComment(seq);
		return list;
	}

	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // ===== #107. 글목록 보여주기(검색어가 없는 것) =====
	@Override
	public List<QnaVO> boardList2(HashMap<String, String> map) {

		List<QnaVO> boardList = dao.boardList2(map);
	
		return boardList;
		
	}

	// ===== #107. 글목록 보여주기(검색어가 있는 것) =====
	@Override
	public List<QnaVO> boardList(HashMap<String, String> map) {
		List<QnaVO> boardList =  dao.boardList(map);
		return boardList;
	}
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// ===== #114.   검색어가 있는 총 게시물 건수   =====
	@Override
	public int getTotalCount2(HashMap<String, String> map) {
		int totalCount = dao.getTotalCount2(map);
		return totalCount;
	}


	// ===== #114.   검색어가 없는 총 게시물 건수   =====
	@Override
	public int getTotalCount() {
		int totalCount = dao.getTotalCount();
		return totalCount;
	}
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////


	// ===== #139. 파일첨부가 있는 글쓰기(답변형 게시판)   =====
	@Override
	public int add_withFile(QnaVO qnavo) {
		
		// ==== #123. 글쓰기가 원글쓰기인지 아니면 답변글쓰기인지를 구분하여
		//            tblBoard 테이블에 insert 를 해줘야 한다.
		//            원글쓰기 라면 tblBoard 테이블의 groupno 컬럼의 값은
		//            max값 +1 로 해야 하고,
		//            답변글쓰기 라면 넘겨 받은 값을 그대로 insert 해줘야 한다.
		
		// 원글쓰기인, 답변글쓰기인지 구분하기
		if(qnavo.getQna_fk_idx() == null || qnavo.getQna_fk_idx().trim().isEmpty()) { // 원글을 쓸 경우!
			// 원글쓰기인 경우
		    int groupno = dao.getGroupMaxno()+1;  //(groupno는 max+1)	
			qnavo.setQna_groupno(String.valueOf(groupno));// db에서 읽어와서 qnavo에 set을 해줬다. 그래서 board.xml에서 글쓰기 add를 할 때 qnavo에 있는 getGroupno를 넣어주면 된다.
		}
		
		int n = dao.add_withFile(qnavo);
		return n;
	}

	*/
	
	

}
