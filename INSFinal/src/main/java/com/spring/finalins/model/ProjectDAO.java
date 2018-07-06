package com.spring.finalins.model;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectDAO implements InterProjectDAO{
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	//로그인 처리를 하는 메소드
	@Override
	public MemberVO getLogin(HashMap<String, String> map) {
		MemberVO mvo = sqlsession.selectOne("dasom.getLogin", map);
		return mvo;
	} // end of getLogin(HashMap<String, String> map) 

	
	//회원가입 요청을 처리하는 메소드 (멤버테이블에 insert)
	@Override
	public int signupEnd(MemberVO mvo) {
		int n = sqlsession.insert("dasom.signupEnd", mvo);
		return n;
	} // end of signupEnd(MemberVO mvo)


	//아이디 중복체크하는 메소드(멤버테이블에 select)
	@Override
	public int idcheck(String useridCheck) {
		int n = sqlsession.selectOne("dasom.idcheck", useridCheck);
		return n;
	} // end of idcheck(String useridCheck) 
}
