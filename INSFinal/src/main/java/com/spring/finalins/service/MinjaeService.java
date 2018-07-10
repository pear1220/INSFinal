package com.spring.finalins.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalins.model.CardVO;
import com.spring.finalins.model.InterMinjaeDAO;
import com.spring.finalins.model.ListVO;
import com.spring.finalins.model.MemberVO;
import com.spring.finalins.model.ProjectVO;
import com.spring.finalins.model.TeamVO;

@Service
public class MinjaeService implements InterMinjaeServie {

	@Autowired
	private InterMinjaeDAO dao;

	// ========================================================== PROJECTBUTTON ========================================================================================
	// header : 로그인한 userid의 팀의 리스트를 얻음
	@Override
	public List<TeamVO> getTeamList(String userid) {
		
		List<TeamVO> teamList = dao.getTeamList(userid);
		
		System.out.println("service teamList" + teamList);
		
		return teamList;
	}
	
	// header : 해당 user의 팀에 해당하는 프로젝트 리스트를 얻음
	@Override
	public List<ProjectVO> getProjectList(HashMap<String, String> map) {
		
		List<ProjectVO> projectList = dao.getProjectList(map);
		
		for(int i=0; i<projectList.size(); i++) {
			System.out.println("서비스단" + projectList.get(i).getProject_name());
		}
		
		return projectList;
	}

	// ========================================================== SEARCH ========================================================================================
	// header : 검색을 위해 teamList 를 얻음
	/*	@Override
	public List<HashMap<String, String>> getSearch_team(HashMap<String, String> map) {
		
		List<HashMap<String, String>> teamList = dao.getSearch_team(map);
		
		return teamList;
	}
	
	// header : 검색을 위해 projectList 를 얻음
	@Override
	public List<HashMap<String, String>> getSearch_project(HashMap<String, String> map) {
		
		List<HashMap<String, String>> projectList = dao.getSearch_project(map);
		
		return projectList;
	}

	// header : 검색을 위해 listList 를 얻음
	@Override
	public List<HashMap<String, String>> getSearch_list(HashMap<String, String> map) {
		
		List<HashMap<String, String>> listList = dao.getSearch_list(map);
		
		return listList;
	}

	// header : 검색을 위해 cardList 를 얻음
	@Override
	public List<HashMap<String, String>> getSearch_card(HashMap<String, String> map) {
		
		List<HashMap<String, String>> cardList = dao.getSearch_card(map);
		
		return cardList;
	}*/

	// header : 검색을 위해 memberList 를 얻음
	@Override
	public List<HashMap<String, String>> getSearch_member(HashMap<String, String> map) {
		
		List<HashMap<String, String>> memberList = dao.getSearch_member(map);
		
		return memberList;
	}

	// header : 더보기를 위해 검색된 team 의 수를 얻어오는 함수
	/*	@Override
	public int getSearch_team_count(String search_input) {
		
		int teamListCount = dao.getSearch_team_count(search_input);
		
		return teamListCount;
	}

	// header : 더보기를 위해 검색된 project 의 수를 얻어오는 함수
	@Override
	public int getSearch_project_count(HashMap<String, String> map) {

		int projectListCount = dao.getSearch_project_count(map);
		
		return projectListCount;
	}

	// header : 더보기를 위해 검색된 list 의 수를 얻어오는 함수
	@Override
	public int getSearch_list_count(HashMap<String, String> map) {

		int listListCount = dao.getSearch_list_count(map);
		
		return listListCount;
	}

	// header : 더보기를 위해 검색된 card의 수를 얻어오는 함수
	@Override
	public int getSearch_card_count(HashMap<String, String> map) {

		int cardListCount = dao.getSearch_card_count(map);
		
		return cardListCount;
	}*/
	
	// header : 더보기를 위해 검색된 member 의 수를 얻어오는 함수
	@Override
	public int getSearch_member_count(String search_input) {
		
		int memberListCount = dao.getSearch_member_count(search_input);
		
		return memberListCount;
	}

	
}
