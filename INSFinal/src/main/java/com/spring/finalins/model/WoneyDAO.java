package com.spring.finalins.model;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.SystemPropertyUtils;

//===== DAO 선언 =====
@Repository
public class WoneyDAO implements InterWoneyDAO {

	
	// ===== #29. 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired
	private SqlSessionTemplate sqlsession;

	// 카드 정보 받아오기
	@Override
	public HashMap<String, String> getCardInfo(String cardIdx) {
		HashMap<String, String> CardMap = sqlsession.selectOne("woney.getCardInfo", cardIdx);
		return CardMap;
	}
	
	// 카드 상세 정보 받아오기
	@Override
	public HashMap<String, String> getCardDetailInfo(String cardIdx) {
		HashMap<String, String> cardDetailMap = sqlsession.selectOne("woney.getCardDetailInfo", cardIdx);
		return cardDetailMap;
	}
		
	// 프로젝트 멤버 체크
	@Override
	public int getProjectMember(HashMap<String, String> map) {
		int n = sqlsession.selectOne("woney.getProjectMember", map);
		return n;
	}

	// 카드 제목 수정
	@Override
	public int setCardTitleUpdate(HashMap<String, String> map) {
		int n = sqlsession.update("woney.setCardTitleUpdate", map);
		return n;
	}
	
	// 카드 Description 존재 여부 체크
	@Override
	public int cardDescriptionCNT(String cardIdx) {
		int cnt = sqlsession.selectOne("woney.cardDescriptionCNT", cardIdx);
		return cnt;
	}

	// 카드 Description 입력
	@Override
	public int setcardDescriptionInsert(String cardIdx) {
		int n = sqlsession.insert("woney.setcardDescriptionInsert", cardIdx);
		return n;
	}

	// 카드 Description 수정
	@Override
	public int setcardDescriptionUpdate(HashMap<String, String> map) {
		int n = sqlsession.update("woney.setcardDescriptionUpdate", map);
		return n;
	}

	// 파일첨부
	@Override
	public int add_withFile(CardVO cardvo) {
		System.out.println("카드첨부 DAO");
		System.out.println("byte: " + cardvo.getCard_byte());
		System.out.println("Card_filename: " + cardvo.getCard_filename());
		System.out.println("Card_orgfilename: " + cardvo.getCard_orgfilename());
		System.out.println("idx : "+ cardvo.getFk_card_idx());
		int n = sqlsession.update("woney.add_withFile", cardvo);		
		return n;
	}

	


	

	

	
}
