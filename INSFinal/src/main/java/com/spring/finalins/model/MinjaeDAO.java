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

	// ========================================================== PROJECTBUTTON ========================================================================================
	// header : 로그인한 userid의 팀의 리스트를 얻음
	@Override
	public List<TeamVO> getTeamList(String userid) {
		
		List<TeamVO> teamList = sqlsession.selectList("mj.getTeamList", userid);
		
		System.out.println("DAO teamList" + teamList);
		
		return teamList;
	}

	// header : 해당 user의 팀에 해당하는 프로젝트 리스트를 얻음
	@Override
	public List<ProjectVO> getProjectList(HashMap<String, String> map) {
		
		List<ProjectVO> projectList = sqlsession.selectList("mj.getProjectList", map);
				
		return projectList;
	}

	// ========================================================== SEARCH ========================================================================================
	// header : 검색을 위해 teamList 를 얻음
	@Override
	public List<TeamVO> getSearch_team(String search_input) {
		
		List<TeamVO> teamList = sqlsession.selectList("mj.getSearch_team", search_input);
		
		return teamList;
	}

	/*@Override
	public List<ProjectVO> getSearch_project(HashMap<String, String> map) {
	
		List<ProjectVO> projectList = sqlsession.selectList("mj.getSearch_project", map);
		
		return projectList;
	}

	@Override
	public List<ListVO> getSearch_list(HashMap<String, String> map) {
		
		List<ListVO> listList = sqlsession.selectList("mj.getSearch_list", map);
		
		return listList;
	}

	@Override
	public List<CardVO> getSearch_card(HashMap<String, String> map) {
		
		List<CardVO> cardList = sqlsession.selectList("mj.getSearch_card", map);
		
		return cardList;
	}*/
}
