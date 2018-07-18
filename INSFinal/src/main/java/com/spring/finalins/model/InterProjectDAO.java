package com.spring.finalins.model;

import java.util.HashMap;
import java.util.List;

public interface InterProjectDAO {

	//로그인 처리를 하는 메소드
	MemberVO getLogin(HashMap<String, String> map);

	//회원가입 요청을 처리하는 메소드 (멤버테이블에 insert)
	int signupEnd(MemberVO mvo);

	//아이디 중복체크하는 메소드(멤버테이블에 select)
	int idcheck(String useridCheck);

	//로그인 한 유저의 팀리스트를 가져오는 메소드
	List<HashMap<String, String>> getTeamList(String userid);

	//팀의 노출값을 가져오는 메소드
	HashMap<String, String> getTeamVS(HashMap<String, String> userInfo);

	//프로젝트 테이블에 새로운 프로젝트 insert
	int insertProject(HashMap<String, String> project_info);

	//새로 생성된 프로젝트idx에 프로젝트멤버 insert
	int insertProjectMember(HashMap<String, String> project_info);

	//생성된 프로젝트idx를 select
	String getProjectIDX(HashMap<String, String> project_info);

	//로그인 한 유저의 프로젝트리스트를 가져오는 메소드
	List<HashMap<String, String>> getProjectList(String userid);

	//유저가 접속한 프로젝트의 정보를 가져오는 메소드
	HashMap<String, String> getProjectInfo(HashMap<String, String> map);

	//프로젝트의 즐겨찾기 상태를 변경하는 메소드
	int updateFavoriteStatus(HashMap<String, String> map);

	//project_idx로 배경이미지 테이블에서 프로젝트의 배경이미지명을 가져오는 메소드
	String getBackgroundIMG(String project_idx);

	//프로젝트의 리스트 목록을 가져오는 메소드
	List<ListVO> getListInfo(String project_idx);

	//비밀번호찾기에서 이메일과 id로 일치하는 회원이 있는지 확인하는 메소드
	int emailCheck(HashMap<String, String> map);

	//회원가입 폼에서 이메일 중복체크하는 메소드
	int signupEmailcheck(String emailCheck);

	//email로 가입된 유저의 아이디를 가져오는 메소드
	String getuserID(String emailCheck);

	//배경이미지테이블의 데이터를 가져오는 메소드
	List<HashMap<String, String>> getProjectImg();

}
