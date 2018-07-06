package com.spring.finalins.model;

import java.util.HashMap;

public interface InterProjectDAO {

	//로그인 처리를 하는 메소드
	MemberVO getLogin(HashMap<String, String> map);

	//회원가입 요청을 처리하는 메소드 (멤버테이블에 insert)
	int signupEnd(MemberVO mvo);

	//아이디 중복체크하는 메소드(멤버테이블에 select)
	int idcheck(String useridCheck);

}
