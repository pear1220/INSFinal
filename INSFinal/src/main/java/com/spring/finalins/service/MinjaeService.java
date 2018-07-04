package com.spring.finalins.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalins.model.InterMinjaeDAO;
import com.spring.finalins.model.MemberVO;

@Service
public class MinjaeService implements InterMinjaeServie {

	@Autowired
	private InterMinjaeDAO dao;

	/*@Override
	public List<String> getTeamList(MemberVO loginuser) {
		
		List<String> teamList = dao.getTeamList(loginuser);
		
		return teamList;
	}*/
	
}
