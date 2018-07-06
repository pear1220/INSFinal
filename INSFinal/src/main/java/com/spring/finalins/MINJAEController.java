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
	
	
	// mj_project.jsp 페이지를 여는 메소드
	@RequestMapping(value="/mj_project.action", method= {RequestMethod.GET})
	public String mj_project(HttpServletRequest req,  HttpServletResponse res) {
		
		return "minjae/mj_project.tiles";
				
	}
	
	// 유저의 teamlist를 json 으로 불러 오는 메소드
	@RequestMapping(value="/teamlist.action", method= {RequestMethod.GET})
	public String teamlist(HttpServletRequest req,  HttpServletResponse res) {
		
		System.out.println("list.action 확인>>>>>>>>>>>>>>>>");
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		System.out.println("controller loginuser : " + loginuser.getUserid());
		
		// 로그인한 userid의 팀의 목록을 갖고 옴
		List<TeamVO> teamList = service.getTeamList(loginuser.getUserid());
		
		for(int i=0; i<teamList.size(); i++) {
			System.out.println(teamList.get(i).getTeam_name());
		}
		
		JSONArray jsonArr = new JSONArray();
		
		if(teamList.size() > 0) {
			for(TeamVO teamvo:teamList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("team_idx", teamvo.getTeam_idx());
				jsonObj.put("admin_userid", teamvo.getAdmin_userid());
				jsonObj.put("team_name", teamvo.getTeam_name());
				jsonObj.put("team_delete_status", teamvo.getTeam_delete_status());
				jsonObj.put("team_visibility_status", teamvo.getTeam_visibility_status());
				jsonObj.put("team_image", teamvo.getTeam_image());
				
				jsonArr.put(jsonObj);
				
			}
		}
		
		String str_jsonArr = jsonArr.toString();
		req.setAttribute("str_jsonArr", str_jsonArr);
		
		return "teamlist.notiles";
		
	}
	
	// 유저의 projectlist를 json 으로 불러 오는 메소드
	@RequestMapping(value="/projectlist.action", method= {RequestMethod.GET})
	public String header(HttpServletRequest req,  HttpServletResponse res) {
		
		System.out.println("projectlist.action 확인>>>>>>>>>>>>>>>>");
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		System.out.println("controller loginuser : " + loginuser.getUserid());
		
		String fk_team_idx = req.getParameter("fk_team_idx");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("fk_team_idx", fk_team_idx);
		map.put("userid", loginuser.getUserid());
		
		// 해당하는 팀의 프로젝트 목록을 갖고 옴
		List<ProjectVO> projectList = service.getProjectList(map);
		
		for(int i=0; i<projectList.size(); i++) {
			System.out.println(projectList.get(i).getProject_name());
		}
		
		JSONArray jsonArr = new JSONArray();
		
		if(projectList.size() > 0) {
			for(ProjectVO projectvo:projectList) {
				JSONObject jsonObj = new JSONObject();
				
				jsonObj.put("project_idx", projectvo.getProject_idx());
				jsonObj.put("fk_team_idx", projectvo.getFk_team_idx());
				jsonObj.put("project_name", projectvo.getProject_name());
				jsonObj.put("project_visibility_st", projectvo.getProject_visibility_st());
				jsonObj.put("project_delete_status", projectvo.getProject_delete_status());
				jsonObj.put("project_favorite_status", projectvo.getProject_favorite_status());
				jsonObj.put("project_profilejpg", projectvo.getProject_profilejpg());
				jsonObj.put("fk_project_image_idx", projectvo.getFk_project_image_idx());
				
				jsonArr.put(jsonObj);
				
			}
		}
		
		String str_jsonArr = jsonArr.toString();
		System.out.println("project jsonArr ::::::::::::::::: " + str_jsonArr);
		
		req.setAttribute("str_jsonArr", str_jsonArr);
		
		
		return "projectlist.notiles";
		
	}
	
	@RequestMapping(value="/test.action", method= {RequestMethod.GET})
	public String test(HttpServletRequest req,  HttpServletResponse res) {
	
		return "test.notiles";
	}
	

}
