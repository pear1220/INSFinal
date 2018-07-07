package com.spring.finalins.service;

import java.util.HashMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalins.model.CardVO;
import com.spring.finalins.model.InterWoneyDAO;

@Service
public class WoneyService implements InterWoneyService{

	// ===== #31. 의존객체 주입하기(DI: oDependency Injection) =====
	@Autowired
	private InterWoneyDAO dao;

	// 카드정보 받아오기
	@Override
	public HashMap<String, String> getCardInfo(String cardIdx) {
		HashMap<String, String> CardMap = dao.getCardInfo(cardIdx);
		return CardMap;
	}

	// 카드 상세 정보 받아오기
	@Override
	public HashMap<String, String> getCardDetailInfo(String cardIdx) {
		HashMap<String, String> cardDetailMap = dao.getCardDetailInfo(cardIdx);
		return cardDetailMap;
	}

	
	// 프로젝트 멤버 체크
	@Override
	public String getProjectMember(HashMap<String, String> map) {
		int n = dao.getProjectMember(map);
		
		String str_jsonobj = null;
		JSONObject jsonObj =  new JSONObject();
		jsonObj.put("CNT", n);
		str_jsonobj = jsonObj.toString();
		
		return str_jsonobj;
	}
	
	// 카드 제목 수정
	@Override
	public int setCardTitleUpdate(HashMap<String, String> map) {
		int n = dao.setCardTitleUpdate(map);
		System.out.println("cardIdx1 : " +map.get("cardIdx"));
		System.out.println("cardUpdateTitle1 : "+ map.get("cardUpdateTitle"));
		return n;
	}

	// 카드 정보 JSON으로 받아오기
	@Override
	public String getCardInfoJSON(String cardIdx) {
		HashMap<String, String> CardMap = dao.getCardInfo(cardIdx);
		
		String str_jsonobj = null;
		if(CardMap !=null) {
		JSONObject jsonObj =  new JSONObject();
		jsonObj.put("CARDIDX", CardMap.get("CARDIDX"));
		jsonObj.put("CARDTITLE", CardMap.get("CARDTITLE"));
		
		str_jsonobj = jsonObj.toString();
		System.out.println("str_jsonobj :"+str_jsonobj);
		}
		return str_jsonobj;
		
	}
	
	// 카드 Description 존재 여부 체크
	@Override
	public int cardDescriptionCNT(String cardIdx) {
		int cnt = dao.cardDescriptionCNT(cardIdx);
		return cnt;
	}

	// 카드 Description 입력
	@Override
	public int setcardDescriptionInsert(String cardIdx) {
		int n = dao.setcardDescriptionInsert(cardIdx);
		return n;
	}

	// 카드 Description 수정
	@Override
	public int setcardDescriptionUpdate(HashMap<String, String> map) {
		int n = dao.setcardDescriptionUpdate(map);
		return n;
	}

	// 카드 Description 정보 JSON으로 받아오기
	@Override
	public String getCardDescriptionInfoJSON(String cardIdx) {
		HashMap<String, String> cardDetailMap = dao.getCardDetailInfo(cardIdx);
		
		String str_jsonobj = null;
		if(cardDetailMap !=null) {
		JSONObject jsonObj =  new JSONObject();
		jsonObj.put("FKCARDIDX", cardDetailMap.get("FKCARDIDX"));
		jsonObj.put("DESCRIPTION", cardDetailMap.get("DESCRIPTION"));
		
		str_jsonobj = jsonObj.toString();
		System.out.println("str_jsonobj :"+str_jsonobj);
		}
		return str_jsonobj;
	}

	// 파일첨부
	@Override
	public int add_withFile(CardVO cardvo) {
		int n = dao.add_withFile(cardvo);
		return n;
		}

	
}
