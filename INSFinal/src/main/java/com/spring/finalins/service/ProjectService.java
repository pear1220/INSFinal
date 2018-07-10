package com.spring.finalins.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finalins.model.InterProjectDAO;
import com.spring.finalins.model.MemberVO;

@Service
public class ProjectService implements InterProjectService{

	@Autowired
	private InterProjectDAO dao;

	//로그인처리를 하는 메소드
	@Override
	public MemberVO getLogin(HashMap<String, String> map) {
		MemberVO mvo = dao.getLogin(map);
		return mvo;
	} // end of getLogin(HashMap<String, String> map)

	
	//로그인 한 유저의 팀리스트를 가져오는 메소드
	@Override
	public List<HashMap<String, String>> getTeamList(String userid) {
		List<HashMap<String, String>> teamList = dao.getTeamList(userid);
		return teamList;
	} // end of getTeamList(String userid)
	
	
	//회원가입 요청을 처리하는 메소드  
	@Override
	public int signupEnd(MemberVO mvo) {
		int n = dao.signupEnd(mvo);
		return n;
	} // end of signupEnd(MemberVO mvo)


	//아이디 중복체크를 하는 메소드
	@Override
	public int idcheck(String useridCheck) {
		int n = dao.idcheck(useridCheck);
		return n;
	} // end of idcheck(String useridCheck)


	//팀의 노출값을 가져오는 메소드
	@Override
	public HashMap<String, String> getTeamVS(HashMap<String, String> userInfo) {
		HashMap<String, String> teamInfo = dao.getTeamVS(userInfo);
		return teamInfo;
	} // end of getTeamVS(String teamIDX)

 
	//프로젝트를 생성하는 메소드
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED,rollbackFor= {Throwable.class})
	public int insertProject(HashMap<String, String> project_info) {
		int result = 0;
		int n = 0;
		int m = 0;
		
		n = dao.insertProject(project_info);
		
		if(n==1) {
			String projectIDX = dao.getProjectIDX(project_info);
			project_info.put("projectIDX", projectIDX);
			
/*			System.out.println("projectIDX값 확인용: " + project_info.get("projectIDX"));
			System.out.println("userid값 확인용: " + project_info.get("userid"));
			System.out.println("project_name값 확인용: " + project_info.get("project_name"));
			System.out.println("pjst값 확인용: " + project_info.get("pjst"));
			System.out.println("team_idx값 확인용: " + project_info.get("team_idx"));
			*/
			m = dao.insertProjectMember(project_info);
		}
		result = n + m;
		return result;
	} // end of insertProject(HashMap<String, String> project_info)


	//로그인 한 유저의 프로젝트리스트를 가져오는 메소드
	@Override
	public List<HashMap<String, String>> getProjectList(String userid) {
		List<HashMap<String, String>> projectList = dao.getProjectList(userid);
		return projectList;
	} // end of getProjectList(String userid)


	//유저가 접속한 프로젝트의 정보를 가져오는 메소드
	@Override
	public HashMap<String, String> getProjectInfo(HashMap<String, String> map) {
		HashMap<String, String> projectInfo = dao.getProjectInfo(map);
		return projectInfo;
	} // end of getProjectInfo(HashMap<String, String> map)


	//프로젝트의 즐겨찾기 상태를 변경하는 메소드
	@Override
	public int updateFavoriteStatus(HashMap<String, String> map) {
		int result = dao.updateFavoriteStatus(map);

		return result;
	} // end of updateFavoriteStatus(HashMap<String, String> map)


	

}
