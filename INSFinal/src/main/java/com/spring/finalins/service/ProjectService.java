package com.spring.finalins.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalins.model.InterProjectDAO;
import com.spring.finalins.model.MemberVO;

@Service
public class ProjectService implements InterProjectService{

	@Autowired
	private InterProjectDAO dao;

	//로그인처리를 하는 메소드
	@Override
	public MemberVO getLogin(HashMap<String, String> map) {
		MemberVO mvo = dao.getLogin(map);
		return mvo;
	} // end of getLogin(HashMap<String, String> map)

	
	//회원가입 요청을 처리하는 메소드  
	@Override
	public int signupEnd(MemberVO mvo) {
		int n = dao.signupEnd(mvo);
		return n;
	} // end of signupEnd(MemberVO mvo)


	//아이디 중복체크를 하는 메소드
	@Override
	public int idcheck(String useridCheck) {
		int n = dao.idcheck(useridCheck);
		return n;
	} // end of idcheck(String useridCheck)
}
