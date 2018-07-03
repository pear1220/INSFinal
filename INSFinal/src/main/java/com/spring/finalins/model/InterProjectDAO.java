package com.spring.finalins.model;

import java.util.HashMap;

public interface InterProjectDAO {

	//로그인 처리를 하는 메소드
	MemberVO getLogin(HashMap<String, String> map);

}
