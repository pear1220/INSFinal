package com.spring.finalins.model;

import java.util.HashMap;

//===== model단(DAO)의 인터페이스 생성 =====
public interface InterWoneyDAO {

	HashMap<String, String> getCardInfo(String cardIdx); // 카드 정보 받아오기
	
	HashMap<String, String> getCardDetailInfo(String cardIdx); // 카드 상세 정보 받아오기

	int getProjectMember(HashMap<String, String> map); // 프로젝트 멤버 체크

	int setCardTitleUpdate(HashMap<String, String> map); // 카드 제목 수정
	
	int cardDescriptionCNT(String cardIdx); // 카드 Description 존재 여부 체크

	int setcardDescriptionInsert(String cardIdx); // 카드 Description 입력

	int setcardDescriptionUpdate(HashMap<String, String> map); // 카드 Description 수정

	int add_withFile(CardVO cardvo); // 파일첨부

	

	

}
