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
	/*		@Override
	public List<HashMap<String, String>> getSearch_team(HashMap<String, String> map) {
		
		List<HashMap<String, String>> teamList = sqlsession.selectList("mj.getSearch_team", map);
		
		return teamList;
	}

	// header : 검색을 위해 projectList 를 얻음
@Override
	public List<HashMap<String, String>> getSearch_project(HashMap<String, String> map) {
	
		List<HashMap<String, String>> projectList = sqlsession.selectList("mj.getSearch_project", map);
		
		return projectList;
	}

	// header : 검색을 위해 listList 를 얻음
	@Override
	public List<HashMap<String, String>> getSearch_list(HashMap<String, String> map) {
		
		List<HashMap<String, String>> listList = sqlsession.selectList("mj.getSearch_list", map);
		
		return listList;
	}

	// header : 검색을 위해 cardList 를 얻음
	@Override
	public List<HashMap<String, String>> getSearch_card(HashMap<String, String> map) {
		
		List<HashMap<String, String>> cardList = sqlsession.selectList("mj.getSearch_card", map);
		
		return cardList;
	}*/

	// header : 검색을 위해 memberList 를 얻음
	@Override
	public List<HashMap<String, String>> getSearch_member(HashMap<String, String> map) {
		
		List<HashMap<String, String>> memberList = sqlsession.selectList("mj.getSearch_member", map);
			
		return memberList;
	}

	
	// header : 더보기를 위해 검색된 team 의 수를 얻어오는 함수
	/*	@Override
	public int getSearch_team_count(String search_input) {
		
		int teamListCount = sqlsession.selectOne("mj.getSearch_team_count", search_input);
		
		return teamListCount;
	}

	// header : 더보기를 위해 검색된 project 의 수를 얻어오는 함수
	@Override
	public int getSearch_project_count(HashMap<String, String> map) {
		
		int projectListCount = sqlsession.selectOne("mj.getSearch_project_count", map);
		
		return projectListCount;
	}

	// header : 더보기를 위해 검색된 list 의 수를 얻어오는 함수
	@Override
	public int getSearch_list_count(HashMap<String, String> map) {
		
		int listListCount = sqlsession.selectOne("mj.getSearch_list_count", map);
		
		return listListCount;
	}

	// header : 더보기를 위해 검색된 card 의 수를 얻어오는 함수
	@Override
	public int getSearch_card_count(HashMap<String, String> map) {

		int cardListCount = sqlsession.selectOne("mj.getSearch_card_count", map);
		
		return cardListCount;
	}*/
	
	// header : 더보기를 위해 검색된  member의 수를 얻어오는 함수
	@Override
	public int getSearch_member_count(String search_input) {
		
		int memberListCount = sqlsession.selectOne("mj.getSearch_member_count", search_input);
		
		return memberListCount;
	}

	
}
