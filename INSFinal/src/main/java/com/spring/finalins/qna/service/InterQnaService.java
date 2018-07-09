package com.spring.finalins.qna.service;

import java.util.HashMap;
import java.util.List;

import com.spring.finalins.qna.model.QnaVO;

import com.spring.finalins.model.MemberVO;

public interface InterQnaService {
	
	
	 List<QnaVO> qnaList(String userid); // QnA목록 보여주기
	
	 int write(QnaVO qnavo);// 글쓰기(파일첨부가 없는 글쓰기)

	 int write_withFile(QnaVO qnavo); // 파일첨부가 있는 글쓰기(답변형 게시판)

	 QnaVO getView(String qna_idx);// 조회수 카운트 안하고 글 보여주기

	 int editQna(QnaVO qnavo); // 글 1개 수정하기

	int del(String qna_idx); // 글 1개 삭제하기
	




}
