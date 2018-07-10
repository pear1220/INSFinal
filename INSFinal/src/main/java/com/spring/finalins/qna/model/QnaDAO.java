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
		
	
		
		// 회원인 경우  QnA목록 보여주기
		@Override
		public List<QnaVO> getQnaList(String userid) {
			List<QnaVO> qnaList= sqlsession.selectList("qna.getQnaList", userid);
			return qnaList;
		}
		// admin인 경우 QnA목록 보여주기
		@Override
		public List<QnaVO> getQnaList() {
			List<QnaVO> qnaList= sqlsession.selectList("qna.getQnaListAll");
			return qnaList;
		}
	
		 // ======  글쓰기(파일첨부가 없는 글쓰기) ====== 
	    @Override
	    public int write(QnaVO qnavo) {;
	      //mybatis
	      int n = sqlsession.insert("qna.write", qnavo);
	      return n;
	    }

	   // =====  ins_QnA 테이블의 groupno 의 max값 알아오기 ===== 
	   @Override
	   public int getGroupMaxno() {
	      int max = sqlsession.selectOne("qna.getGroupMaxno");
	      return max;
	   }
	   
	   
	   // =====  파일첨부가 있는 글쓰기(답변형 게시판) ===== 
	   @Override
	   public int write_withFile(QnaVO qnavo) {
	      int n = sqlsession.insert("qna.write_withFile", qnavo);
	      return n;
	   }


	   // =======  글 1개 보여주기 =====
	   @Override
	   public QnaVO getView(String qna_idx) {
	      QnaVO qnavo = sqlsession.selectOne("qna.getView", qna_idx);
	      return qnavo;
	   }

	   // 글 1개 수정하기
		@Override
		public int editQna(QnaVO qnavo) {
		    int n = sqlsession.update("qna.editQna", qnavo);
			return n;
		}

		// 글 1개 삭제하기
		@Override
		public int del(String qna_idx) {
			int n = sqlsession.delete("qna.del", qna_idx);
			return n;
		}


	
}
