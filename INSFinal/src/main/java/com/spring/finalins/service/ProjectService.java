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
}
