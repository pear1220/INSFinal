package com.spring.finalins.qna.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalins.model.MemberVO;

// ===== #.28 DAO 선언
@Repository
public class QnaDAO implements InterQnaDAO {

	// ===== #29. 의존객체 주입하기(DI: Dependency Injection)
	// root-context.xml 의 의존객체 설정하기에서 어떤 클래스에 주입할지 알 수 있음
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// ====== #42. 메인페이지용 이미지 파일이름을 가져오는 모델단 getImgfilenameList() 메소드 생성하기 ======
	@Override
	public List<String> getImgfilenameList() {
		
		List<String> imgfilenameList = sqlsession.selectList("board.getImgfilenameList");
		
		return imgfilenameList;
	}

	
	// ====== #47. 로그인 여부 알아오기 ======
	@Override
	public MemberVO getLoginMember(HashMap<String, String> map) {
		
		MemberVO loginuser = sqlsession.selectOne("board.getLoginMember", map);
		
		return loginuser;
	}


	// ====== #55. 글쓰기(파일첨부가 없는 글쓰기) ====== 
	@Override
	public int add(QnaVO qnavo) {
		//mybatis
		int n = sqlsession.insert("board.add", qnavo);
		return n;
	}


	// ======= #59. 글목록 보여주기(검색어가 없는 전체 글목록 보여주기) =====
	@Override
	public List<QnaVO> boardList() {
		//mybatis
		List<QnaVO> boardList = sqlsession.selectList("board.boardList");
		return boardList ;
	}

	// ======= #63. 글 1개 보여주기 =====
	@Override
	public QnaVO getView(String seq) {
		
		System.out.println("seq:"+seq);
		
		//mybatis
		QnaVO qnavo = sqlsession.selectOne("board.getView", seq);
		return qnavo;
	}

	// ======= #64. 글 1개 보여줄때 조회수(readCount) 1증가 시키기 =====
	@Override
	public void setAddReadCount(String seq) {
		//mybatis
		sqlsession.update("board.setAddReadCount",seq);
	}

    // ====== #73. 글수정 및 글 삭제시 암호일치 여부 알아오기 ======
	@Override
	public boolean checkPw(HashMap<String,String> map) {
		//mybatis
		int n = sqlsession.selectOne("board.checkPw", map);
		boolean result = false;
		
		if(n ==1)
			result = true;
		
		return result;
	}

    // ====== #74. 글 1개 수정하기 ======
	@Override
	public int updateContent(QnaVO qnavo) {
		//mybatis
		int n = sqlsession.update("board.updateContent", qnavo);
	    return n;
	}


	// ====== #80. 글 1개 삭제하기 ======
	@Override
	public int deleteContent(HashMap<String, String> map) {
		
		int n = sqlsession.update("board.deleteContent", map);  // 부모글이 없어지면 자식글이 다 사라지기 때문에 delete가 아닌 update로 처리한다.
		                                                               // 비방용 글을 삭제하면 나중에 조사할 때 어려울 수 있다는 가정하에 delete가 아닌 update처리로 글을 남겨둔다.
		
		return n;
	}


	/////////////////////////////////////////////////////////////////////////////////////////////////////
	// ====== #87. 댓글쓰기 ======
/*	@Override
	public int addComment(CommentVO commentvo) {
	    int n = sqlsession.insert("board.addComment", commentvo);
	    
	   
		return n;
	}

	
	// ====== #88. 댓글쓰기 이후에 댓글의 갯수(commentCount 컬럼) 1증가 시키기 ======
	@Override
	public int updateCommentCount(String parentSeq) {
		 int n = sqlsession.update("board.updateCommentCount", parentSeq);
		 return n;
	}
    /////////////////////////////////////////////////////////////////////////////////////////////////////


	// ===== #93. 댓글내용 보여주기
	@Override
	public List<CommentVO> listComment(String seq) {
		List<CommentVO> list = sqlsession.selectList("board.listComment", seq);
		return list;
	}

	
	// ===== #99. 원게시글에서 딸린 댓글이 있는지 없는지를 확인하기
	@Override
	public boolean isExistsComment(HashMap<String, String> map) {
		int count = sqlsession.selectOne("board.isExistsComment", map);
		if(count > 0) 
			return true;
		else
		   return false;
	}


	// ===== #100. 원게시글에 달린 댓글들 삭제하기
	@Override
	public int deleteComment(HashMap<String, String> map) {
		int n= sqlsession.update("board.deleteComment", map);
		return n ;
	}*/

    ///////////////////////////////////////////////////////////////////////////////////////
	// 컬럼네임은 ${} 데이터는 #{}이다!!!!
	
	
	// ===== #108. 글목록 보여주기(검색어가 있는 것) =====
	@Override
	public List<QnaVO> boardList2(HashMap<String, String> map) {
		List<QnaVO> boardList = sqlsession.selectList("board.boardList2", map);
		return boardList ;
	}
	
	// ===== #108. 글목록 보여주기(검색어가 없는 것) =====
	@Override
	public List<QnaVO> boardList(HashMap<String, String> map) {
		List<QnaVO> boardList = sqlsession.selectList("board.boardList", map);
		return boardList ;
	}
    ///////////////////////////////////////////////////////////////////////////////////////


	/////////////////////////////////////////////////////////////////////////////////////////
	// ===== #115. 검색어가 있는 총 게시물 건수 =====
	@Override
	public int getTotalCount2(HashMap<String, String> map) {
		int totalCount = sqlsession.selectOne("board.getTotalCount2", map);
		return totalCount;
	}


	// ===== #115. 검색어가 없는 총 게시물 건수 =====
	@Override
	public int getTotalCount() {
		int totalCount = sqlsession.selectOne("board.getTotalCount");
		return totalCount;
	}
	////////////////////////////////////////////////////////////////////////////////////////////////


	
	// ===== #124. tblBoard 테이블의 groupno 의 max값 알아오기 ===== 
	@Override
	public int getGroupMaxno() {
		int max = sqlsession.selectOne("board.getGroupMaxno");
		return max;
	}


	// ===== #140. 파일첨부가 있는 글쓰기(답변형 게시판) ===== 
	@Override
	public int add_withFile(QnaVO qnavo) {
		int n = sqlsession.insert("board.add_withFile", qnavo);
		return n;
	}


	@Override
	public boolean isExistsComment(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public int deleteComment(HashMap<String, String> map) {
		// TODO Auto-generated method stub
		return 0;
	}


   
	
}
