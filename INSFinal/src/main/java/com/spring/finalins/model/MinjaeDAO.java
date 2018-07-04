package com.spring.finalins.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MinjaeDAO implements InterMinjaeDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	@Override
	public List<String> getTeamList(String userid) {
List<String> teamList = sqlsession.selectList("mj.getTeamList", userid);
		
		return teamList;
	}

	/*@Override
	public List<String> getTeamList(MemberVO loginuser) {
		
		List<String> teamList = sqlsession.selectList("mj.getTeamList", loginuser);
		
		return teamList;
	}*/
}
