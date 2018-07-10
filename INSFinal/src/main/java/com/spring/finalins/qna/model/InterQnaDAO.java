package com.spring.finalins.qna.model;

import java.util.HashMap;
import java.util.List;

import com.spring.finalins.model.MemberVO;

// ====== model단 (DAO)의 인터페이스 생성 ======
public interface InterQnaDAO {
	
	
	// QnA목록 보여주기
	List<QnaVO> getQnaList(String userid); // 회원인 경우
	List<QnaVO> getQnaList(); // admin인 경우
	
   int write(QnaVO qnavo);// 글쓰기(파일첨부가 없는 글쓰기)

   int write_withFile(QnaVO qnavo);// 글쓰기(파일첨부가 있는 글쓰기)
   
   int getGroupMaxno(); // ins_QnA 테이블의 groupno 의 max값 알아오기

   QnaVO getView(String qna_idx);  // 글 1개를 보여주기

	int editQna(QnaVO qnavo); // 글 1개 수정하기

	int del(String qna_idx); // 글 1개 삭제하기

	


	

	
	

}
