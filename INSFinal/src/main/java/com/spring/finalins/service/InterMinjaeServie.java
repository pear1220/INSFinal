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

	/*	List<HashMap<String, String>> getSearch_team(HashMap<String, String> map); // header : 검색을 위해 teamList 를 얻음

	List<HashMap<String, String>> getSearch_project(HashMap<String, String> map); // header : 검색을 위해 projectList 를 얻음

	List<HashMap<String, String>> getSearch_list(HashMap<String, String> map);// header : 검색을 위해 listList 를 얻음

	List<HashMap<String, String>> getSearch_card(HashMap<String, String> map);// header : 검색을 위해 cardList 를 얻음
*/
	List<HashMap<String, String>> getSearch_member(HashMap<String, String> map); // header : 검색을 위해 memberList 를 얻음

	/*	int getSearch_team_count(String search_input); // header : 더보기를 위해 검색된 team 의 수를 얻어오는 함수
	int getSearch_project_count(HashMap<String, String> map); // header : 더보기를 위해 검색된 project 의 수를 얻어오는 함수
	int getSearch_list_count(HashMap<String, String> map); // header : 더보기를 위해 검색된 list 의 수를 얻어오는 함수
	int getSearch_card_count(HashMap<String, String> map); // header : 더보기를 위해 검색된 card 의 수를 얻어오는 함수*/
	int getSearch_member_count(String search_input); // header : 더보기를 위해 검색된 member 의 수를 얻어오는 함수

	

	
	

	 
}
