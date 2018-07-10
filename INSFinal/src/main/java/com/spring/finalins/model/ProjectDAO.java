package com.spring.finalins.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectDAO implements InterProjectDAO{
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	//로그인 처리를 하는 메소드
	@Override
	public MemberVO getLogin(HashMap<String, String> map) {
		MemberVO mvo = sqlsession.selectOne("dasom.getLogin", map);
		return mvo;
	} // end of getLogin(HashMap<String, String> map) 

	
	//로그인 한 유저의 팀리스트를 가져오는 메소드
	@Override
	public List<HashMap<String, String>> getTeamList(String userid) {
		List<HashMap<String, String>> teamList = sqlsession.selectList("dasom.getTeamList", userid);
		return teamList;
	} // end of getTeamList(String userid)
		
		
	//회원가입 요청을 처리하는 메소드 (멤버테이블에 insert)
	@Override
	public int signupEnd(MemberVO mvo) {
		int n = sqlsession.insert("dasom.signupEnd", mvo);
		return n;
	} // end of signupEnd(MemberVO mvo)


	//아이디 중복체크하는 메소드(멤버테이블에 select)
	@Override
	public int idcheck(String useridCheck) {
		int n = sqlsession.selectOne("dasom.idcheck", useridCheck);
		return n;
	} // end of idcheck(String useridCheck) 


	//팀의 노출값을 가져오는 메소드
	@Override
	public HashMap<String, String> getTeamVS(HashMap<String, String> userInfo) {
		HashMap<String, String> teamInfo = sqlsession.selectOne("dasom.getTeamVS", userInfo);
		return teamInfo;
	} // end of getTeamVS(String teamIDX)


	//프로젝트 테이블에 새로운 프로젝트 insert
	@Override
	public int insertProject(HashMap<String, String> project_info) {
		int n = sqlsession.insert("dasom.insertProject", project_info);
		return n;
	}

	//새로 생성된 프로젝트idx에 프로젝트멤버 insert
	@Override
	public int insertProjectMember(HashMap<String, String> project_info) {
		int n = sqlsession.insert("dasom.insertProjectMember", project_info);
		return n;
	} // end of insertProject(HashMap<String, String> project_info)


	//생성된 프로젝트idx를 select
	@Override
	public String getProjectIDX(HashMap<String, String> project_info) {
		String projectIDX = sqlsession.selectOne("dasom.getProjectIDX", project_info);
		return projectIDX;
	} // end of getProjectIDX(HashMap<String, String> project_info)


	//로그인 한 유저의 프로젝트리스트를 가져오는 메소드
	@Override
	public List<HashMap<String, String>> getProjectList(String userid) {
		List<HashMap<String, String>> projectList = sqlsession.selectList("dasom.getProjectList", userid);
		return projectList;
	} // end of getProjectList(String userid)


	//유저가 접속한 프로젝트의 정보를 가져오는 메소드
	@Override
	public HashMap<String, String> getProjectInfo(HashMap<String, String> map) {
		HashMap<String, String> projectInfo = sqlsession.selectOne("dasom.getProjectInfo", map);
		return projectInfo;
	} // end of getProjectInfo(HashMap<String, String> map)


	//프로젝트의 즐겨찾기 상태를 변경하는 메소드
	@Override
	public int updateFavoriteStatus(HashMap<String, String> map) {
		int result = sqlsession.update("updateFavoriteStatus", map);
		return result;
	} // end of updateFavoriteStatus(HashMap<String, String> map)


	
}
