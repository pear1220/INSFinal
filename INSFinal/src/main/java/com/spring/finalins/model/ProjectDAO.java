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
}
