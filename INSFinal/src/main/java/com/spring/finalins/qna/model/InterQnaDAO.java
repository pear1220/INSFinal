package com.spring.finalins.qna.model;

import java.util.HashMap;
import java.util.List;

import com.spring.finalins.model.MemberVO;

// ====== model단 (DAO)의 인터페이스 생성 ======
public interface InterQnaDAO {
	
	
	
	List<QnaVO> getQnaList(String userid); // QnA목록 보여주기
	
	
	
	
	
	
	
	
	
	
	

/*	List<String> getImgfilenameList(); // 이미지 파일명 가져 오기
*/
	

	int add(QnaVO qnavo); // 글쓰기(파일첨부가 없는 글쓰기)
/*
	List<QnaVO> boardList(); // 글목록 보기 페이지 요청(검색어가 없는 전체 글목록 보여주기)

	QnaVO getView(String seq); // 글 1개를 보여주기
	
	void setAddReadCount(String seq); //글 1개 보여줄때 조회수(readCount) 1증가 시키기

	boolean checkPw(HashMap<String,String> map); // 글수정 및 글 삭제시 암호일치 여부 알아오기

	int updateContent(QnaVO qnavo); // 글 1개 수정하기

	int deleteContent(HashMap<String, String> map); // 글 1개 삭제하기

	
	
	 qna에 댓글쓰기 기능이 없다.
	 int addComment(CommentVO commentvo); // 댓글쓰기
	int updateCommentCount(String parentSeq); // 댓글쓰기 이후에 댓글의 갯수(commentCount 컬럼) 1증가 시키기

	List<CommentVO> listComment(String seq); // 댓글 내용 보여주기

	boolean isExistsComment(HashMap<String, String> map); //원게시글에서 딸린 댓글이 있는지 없는지를 확인하기
	int deleteComment(HashMap<String, String> map); //원게시글에 달린 댓글들 삭제하기

	List<QnaVO> boardList(HashMap<String, String> map); // 글목록 보여주기(검색어가 있는 경우)
	List<QnaVO> boardList2(HashMap<String, String> map); // 글목록 보여주기(검색어가 없는 경우)

	int getTotalCount2(HashMap<String, String> map); // 검색어가 있는 총 게시물 건수
	int getTotalCount(); // 검색어가 없는 총 게시물 건수

	int getGroupMaxno(); // tblBoard 테이블의 groupno 의 max값 알아오기

	int add_withFile(QnaVO qnavo); // 파일첨부가 있는 글쓰기(답변형 게시판)
*/


	

	
	

}
