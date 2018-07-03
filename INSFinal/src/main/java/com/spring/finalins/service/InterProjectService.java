package com.spring.finalins.service;

import java.util.HashMap;

import com.spring.finalins.model.MemberVO;


public interface InterProjectService {

	//로그인 처리를 하는 메소드
	MemberVO getLogin(HashMap<String, String> map);

}
