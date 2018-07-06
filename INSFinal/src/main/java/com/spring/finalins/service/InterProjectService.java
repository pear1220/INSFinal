package com.spring.finalins.service;

import java.util.HashMap;

import com.spring.finalins.model.MemberVO;


public interface InterProjectService {

	//로그인 처리를 하는 메소드
	MemberVO getLogin(HashMap<String, String> map);

	//회원가입 요청을 처리하는 메소드  
	int signupEnd(MemberVO mvo);

	//아이디 중복체크를 하는 메소드
	int idcheck(String useridCheck);

}
