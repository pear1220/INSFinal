package com.spring.finalins.model;

import java.util.HashMap;
import java.util.List;

public interface InterMinjaeDAO {

	List<TeamVO> getTeamList(String userid); // header : 로그인한 userid의 팀의 리스트를 얻음

	List<ProjectVO> getProjectList(HashMap<String, String> map); // header : 해당 user의 팀에 해당하는 프로젝트 리스트를 얻음

	List<TeamVO> getSearch_team(String search_input); // header : 검색을 위해 teamList 를 얻음
/*
	List<ProjectVO> getSearch_project(HashMap<String, String> map); // header : 검색을 위해 projectList 를 얻음

	List<ListVO> getSearch_list(HashMap<String, String> map);

	List<CardVO> getSearch_card(HashMap<String, String> map);*/

}
