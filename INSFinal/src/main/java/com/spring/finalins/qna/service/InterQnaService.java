package com.spring.finalins.qna.service;

import java.util.HashMap;
import java.util.List;

import com.spring.finalins.qna.model.QnaVO;

import com.spring.finalins.model.MemberVO;

public interface InterQnaService {

	List<String> getImgfilenameList(); // 이미지 파일명 가져 오기

	MemberVO getLoginMember(HashMap<String, String> map); // 로그인 여부 알아오기

	int add(QnaVO qnavo); // 글쓰기(파일첨부가 없는 글쓰기)

	List<QnaVO> boardList(); // 글목록 보기 페이지 요청(검색어가 없는 전체 글목록 보여주기)

	QnaVO getView(String seq, String userid);
	// 조회수(readCount) 증가한 후에 글1개를 가져오는 것.
	// 단, 자신이 쓴 글을 자신이 읽을시에는 조회수가 증가되지 않고 ,
	// 다른 사람이 쓴 글이어야 조회수가 증가되도록 해야 한다.
	// 로그인 하지 않은 상태에서 글을 읽을 때 조회수 증가가 일어나지 않도록 한다.

	QnaVO getViewWithNoReadCount(String seq);  // 조회수 1증가 없이 그냥 글 1개를 가져오는 것 

	int edit(QnaVO qnavo); // 한 개의 글을 수정하기

	int del(HashMap<String, String> map) throws Throwable; // 글 1개 삭제하기(댓글이 없을 경우)  // 글 1개 있을 때는 throws Throwable 이것이 없었는데 나중에 생각하고 수정하자
//	int del(HashMap<String, String> map) throws Throwable; // 1개글 삭제하기(댓글이 있을 경우)

//	int addComment(CommentVO commentvo) throws Throwable; // 댓글쓰기

//	List<CommentVO> listComment(String seq); //댓글 내용 보여주기

	
	List<QnaVO> boardList2(HashMap<String, String> map); // 글목록 보여주기(검색어가 있는 경우)

	List<QnaVO> boardList(HashMap<String, String> map); // 글목록 보여주기(검색어가 없는 경우)

	
	int getTotalCount2(HashMap<String, String> map); // 검색어가 있는 총 게시물 건수

	int getTotalCount(); // 검색어가 없는 총 게시물 건수

	int add_withFile(QnaVO qnavo); // 파일첨부가 있는 글쓰기(답변형 게시판)






}
