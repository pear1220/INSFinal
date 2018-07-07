package com.spring.finalins.service;

import java.util.HashMap;
import java.util.List;

import com.spring.finalins.model.CardVO;
import com.spring.finalins.model.ListVO;
import com.spring.finalins.model.MemberVO;
import com.spring.finalins.model.ProjectVO;
import com.spring.finalins.model.TeamVO;

public interface InterMinjaeServie {

	List<TeamVO> getTeamList(String userid); // header : 로그인한 userid의 팀의 리스트를 얻음

	List<ProjectVO> getProjectList(HashMap<String, String> map); // header : 해당 user의 팀에 해당하는 프로젝트 리스트를 얻음

	List<TeamVO> getSearch_team(String search_input); // header : 검색을 위해 teamList 를 얻음

	/*List<ProjectVO> getSearch_project(HashMap<String, String> map); // header : 검색을 위해 projectList 를 얻음

	List<ListVO> getSearch_list(HashMap<String, String> map);// header : 검색을 위해 listList 를 얻음

	List<CardVO> getSearch_card(HashMap<String, String> map);// header : 검색을 위해 cardList 를 얻음
*/
	 
}
