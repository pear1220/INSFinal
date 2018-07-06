package com.spring.finalins.model;

import java.util.HashMap;
import java.util.List;

public interface InterMinjaeDAO {

	List<TeamVO> getTeamList(String userid); // header : 로그인한 userid의 팀의 리스트를 얻음

	List<ProjectVO> getProjectList(HashMap<String, String> map); // header : 해당 user의 팀에 해당하는 프로젝트 리스트를 얻음

}
