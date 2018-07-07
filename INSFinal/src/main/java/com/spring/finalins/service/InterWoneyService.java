package com.spring.finalins.service;

import java.util.HashMap;

import com.spring.finalins.model.CardVO;

//=== Service단 인터페이스 선언 ===
public interface InterWoneyService {

	HashMap<String, String> getCardInfo(String cardIdx); // 카드정보 받아오기
	
	HashMap<String, String> getCardDetailInfo(String cardIdx); // 카드 상세 정보 받아오기
	
	String getProjectMember(HashMap<String, String> map); // 프로젝트 멤버 체크
	
	int setCardTitleUpdate(HashMap<String, String> map);	// 카드 제목 수정

	String getCardInfoJSON(String cardIdx);	// 카드 정보 JSON으로 받아오기

	int cardDescriptionCNT(String cardIdx); // 카드 Description 존재 여부 체크
	
	int setcardDescriptionInsert(String cardIdx); // 카드 Description 입력

	int setcardDescriptionUpdate(HashMap<String, String> map); // 카드 Description 수정
 
	String getCardDescriptionInfoJSON(String cardIdx); // 카드 Description 정보 JSON으로 받아오기

	int add_withFile(CardVO cardvo); // 파일첨부





	


	

}
