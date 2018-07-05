package com.spring.finalins;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.finalins.model.MemberVO;
import com.spring.finalins.model.ProjectVO;
import com.spring.finalins.model.TeamVO;
import com.spring.finalins.service.InterMinjaeServie;

@Controller
@Component
public class MINJAEController {

	@Autowired
	private InterMinjaeServie service;
	
	@RequestMapping(value="/mj_project.action", method= {RequestMethod.GET})
	public String mj_project(HttpServletRequest req,  HttpServletResponse res) {
		
		return "minjae/mj_project.tiles";
				
	}
	
	@RequestMapping(value="/list.action", method= {RequestMethod.GET})
	public String header(HttpServletRequest req,  HttpServletResponse res) {
		
		System.out.println("list.action 확인>>>>>>>>>>>>>>>>");
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		System.out.println("controller loginuser : " + loginuser.getUserid());
		
		// 로그인한 userid의 팀의 목록을 갖고 옴
		List<TeamVO> teamList = service.getTeamList(loginuser.getUserid());
		
		for(int i=0; i<teamList.size(); i++) {
			System.out.println(teamList.get(i).getTeam_name());
		}
		
		/*TeamVO teamvo = new TeamVO();
		String fk_team_idx = teamvo.getTeam_idx();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fk_team_idx", fk_team_idx);
		map.put("userid", loginuser.getUserid());
		
		// 해당하는 팀의 프로젝트 목록을 갖고 옴
		List<ProjectVO> projectList = service.getProjectInTeam(map);*/
		
		session.setAttribute("teamList", teamList);
//		session.setAttribute("projectList", projectList);
		
		return "list.notiles";
		
	}
	

}
