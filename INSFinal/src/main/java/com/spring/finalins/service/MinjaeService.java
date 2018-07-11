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
	@Override
	public List<TeamVO> getSearch_team(String search_input) {
		
		List<TeamVO> teamList = dao.getSearch_team(search_input);
		
		return teamList;
	}

	@Override
	public List<ProjectVO> getSearch_project(HashMap<String, String> map) {
		
		List<ProjectVO> projectList = dao.getSearch_project(map);
		
		return projectList;
	}
	
	@Override
	public List<ListVO> getSearch_list(HashMap<String, String> map) {
		
		List<ListVO> listList = dao.getSearch_list(map);
		
		return listList;
	}

	@Override
	public List<CardVO> getSearch_card(HashMap<String, String> map) {
		
		List<CardVO> cardList = dao.getSearch_card(map);
		
		return cardList;
	}

	@Override
	public List<HashMap<String, String>> getSearch_member(String search_input) {

		List<HashMap<String, String>> memberList = dao.getSearch_member(search_input);
		
		return memberList;
	}

	@Override
	public int leaveProject(String userid) {
		
		int n = dao.leaveProject(userid);
		
		return n;
	}
	
	
	
}
