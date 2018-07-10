package com.spring.finalins.service;

import java.util.HashMap;
import java.util.List;

import com.spring.finalins.model.MemberVO;


public interface InterProjectService {

	//로그인 처리를 하는 메소드
	MemberVO getLogin(HashMap<String, String> map);
	
	//로그인 한 유저의 팀리스트를 가져오는 메소드
	List<HashMap<String, String>> getTeamList(String userid);

	//회원가입 요청을 처리하는 메소드  
	int signupEnd(MemberVO mvo);

	//아이디 중복체크를 하는 메소드
	int idcheck(String useridCheck);

	//팀의 노출값을 가져오는 메소드
	HashMap<String, String> getTeamVS(HashMap<String, String> userInfo);

	//프로젝트를 생성하는 메소드
	int insertProject(HashMap<String, String> project_info);

	//로그인 한 유저의 프로젝트리스트를 가져오는 메소드
	List<HashMap<String, String>> getProjectList(String userid);

	//유저가 접속한 프로젝트의 정보를 가져오는 메소드
	HashMap<String, String> getProjectInfo(HashMap<String, String> map);

	//프로젝트의 즐겨찾기 상태를 변경하는 메소드
	int updateFavoriteStatus(HashMap<String, String> map);


}
