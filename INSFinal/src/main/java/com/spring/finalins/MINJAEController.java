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

import com.spring.finalins.model.CardVO;
import com.spring.finalins.model.ListVO;
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
				jsonObj.put("fk_project_image_idx", projectvo.getFk_project_image_idx());
				
				jsonArr.put(jsonObj);
				
			}
		}
		
		String str_jsonArr = jsonArr.toString();
		System.out.println("project jsonArr ::::::::::::::::: " + str_jsonArr);
		
		req.setAttribute("str_jsonArr", str_jsonArr);
		
		
		return "projectlist.notiles";
		
	}
	
	/*@RequestMapping(value="/test.action", method= {RequestMethod.GET})
	public String test(HttpServletRequest req,  HttpServletResponse res) {
	
		return "test.notiles";
	}
	*/
	
/*	@RequestMapping(value="/totalSearch.action", method= {RequestMethod.GET})
	public String totalSearch(HttpServletRequest req,  HttpServletResponse res) {
	
		return "totalSearch.notiles";

	}
	*/
	// header : 검색을 위해 teamList 를 얻음
	/*	@RequestMapping(value="/teamSearch.action", method= {RequestMethod.GET})
	public String teamSearch(HttpServletRequest req,  HttpServletResponse res) {
		
		
		String search_input = req.getParameter("search_input");
		String start = req.getParameter("start");
		String len = req.getParameter("len");
		
		
		
		System.out.println("search_input >>>>>>>>>>>>>>>>>>>>" + search_input);
		System.out.println("start>>>>>>>>>>>>>>>>>>>>" + start);
		System.out.println("len>>>>>>>>>>>>>>>>>>>>>>" + len);
		
		
		if(start == null || start.trim().isEmpty()) {
			start = "1";
		}
		if(len == null || len.trim().isEmpty()) {
			len = "2";
		}
		
		
		int int_startRno = Integer.parseInt(start);
		int int_endRno = int_startRno + Integer.parseInt(len) -1;
		
		if(!search_input.trim().isEmpty()) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("search_input", search_input);
			map.put("startRno", String.valueOf(int_startRno));
			map.put("endRno",String.valueOf(int_endRno));
			
			List<HashMap<String, String>> teamList = service.getSearch_team(map);
			
			JSONArray jsonArr = new JSONArray();
			
			if(teamList != null && teamList.size() > 0) {
				for(HashMap<String, String> teammap :teamList) {
				
					JSONObject jsonObj = new JSONObject();
					
					jsonObj.put("rno", teammap.get("rno"));
					jsonObj.put("team_idx", teammap.get("team_idx"));
					jsonObj.put("admin_userid", teammap.get("admin_userid"));
					jsonObj.put("team_name", teammap.get("team_name"));
					jsonObj.put("team_delete_status", teammap.get("team_delete_status"));
					jsonObj.put("team_visibility_status", teammap.get("team_visibility_status"));
					jsonObj.put("team_image", teammap.get("team_image"));
					
					jsonArr.put(jsonObj);
					
				}
			}
			
			
			
			
			String str_jsonArr = jsonArr.toString();
			req.setAttribute("str_jsonArr", str_jsonArr);
	
		}
	
		return "teamSearch.notiles";

	}
	
	// header : 검색을 위해 projectList 를 얻음
	@RequestMapping(value="/projectSearch.action", method= {RequestMethod.GET})
	public String projectSearch(HttpServletRequest req,  HttpServletResponse res) {
	
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String search_input = req.getParameter("search_input");
		String start = req.getParameter("start");
		String len = req.getParameter("len");
		
		
		if(start == null || start.trim().isEmpty()) {
			start = "1";
		}
		if(len == null || len.trim().isEmpty()) {
			len = "2";
		}
		
		
		int int_startRno = Integer.parseInt(start);
		int int_endRno = int_startRno + Integer.parseInt(len) -1;
		
		
		
		if(!search_input.trim().isEmpty()) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("userid", loginuser.getUserid());
			map.put("search_input", search_input);
			map.put("startRno", String.valueOf(int_startRno));
			map.put("endRno",String.valueOf(int_endRno));
			
			List<HashMap<String, String>> projectList = service.getSearch_project(map);
			
			JSONArray jsonArr = new JSONArray();
			
			if(projectList != null && projectList.size() > 0) {
				for(HashMap<String, String> projectmap :projectList) {
				
					JSONObject jsonObj = new JSONObject();
					
					jsonObj.put("rno", projectmap.get("rno") );
					jsonObj.put("project_idx", projectmap.get("project_idx"));
					jsonObj.put("fk_team_idx", projectmap.get("fk_team_idx"));
					jsonObj.put("project_name", projectmap.get("project_name"));
					jsonObj.put("project_visibility_st", projectmap.get("project_visibility_st"));
					jsonObj.put("project_delete_status", projectmap.get("project_delete_status"));
					jsonObj.put("project_favorite_status", projectmap.get("project_favorite_status"));
					jsonObj.put("fk_project_image_idx", projectmap.get("fk_project_image_idx"));
					
					jsonArr.put(jsonObj);
					
				}
			}
		
			String str_jsonArr = jsonArr.toString();
			req.setAttribute("str_jsonArr", str_jsonArr);
	
		}
	
		return "projectSearch.notiles";

	}
	
	@RequestMapping(value="/listSearch.action", method= {RequestMethod.GET})
	public String listSearch(HttpServletRequest req,  HttpServletResponse res) {
	
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String search_input = req.getParameter("search_input");
		String start = req.getParameter("start");
		String len = req.getParameter("len");
		
		
		if(start == null || start.trim().isEmpty()) {
			start = "1";
		}
		if(len == null || len.trim().isEmpty()) {
			len = "2";
		}
		
		
		int int_startRno = Integer.parseInt(start);
		int int_endRno = int_startRno + Integer.parseInt(len) -1;
		
		
		if(!search_input.trim().isEmpty()) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("search_input", search_input);
			map.put("userid", loginuser.getUserid());
			map.put("startRno", String.valueOf(int_startRno));
			map.put("endRno",String.valueOf(int_endRno));
			
			List<HashMap<String, String>> listList = service.getSearch_list(map);
		
			JSONArray jsonArr = new JSONArray();
			
			if(listList != null && listList.size() > 0) {
				
				for(HashMap<String, String> listmap :listList) {
					
					JSONObject jsonObj = new JSONObject();
					
					jsonObj.put("rno", listmap.get("rno"));
					jsonObj.put("list_idx", listmap.get("list_idx"));
					jsonObj.put("fk_project_idx", listmap.get("fk_project_idx"));
					jsonObj.put("list_name", listmap.get("list_name"));
					jsonObj.put("list_delete_status", listmap.get("list_delete_status"));
					
					jsonArr.put(jsonObj);
					
				}
				
			}
			
			String str_jsonArr = jsonArr.toString();
			req.setAttribute("str_jsonArr", str_jsonArr);
			
		}
		
		return "listSearch.notiles";

	}
	
	@RequestMapping(value="/cardSearch.action", method= {RequestMethod.GET})
	public String cardSearch(HttpServletRequest req,  HttpServletResponse res) {
	
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String search_input = req.getParameter("search_input");
		String start = req.getParameter("start");
		String len = req.getParameter("len");
		
		
		if(start == null || start.trim().isEmpty()) {
			start = "1";
		}
		if(len == null || len.trim().isEmpty()) {
			len = "2";
		}
		
		
		int int_startRno = Integer.parseInt(start);
		int int_endRno = int_startRno + Integer.parseInt(len) -1;
		
		
		if(!search_input.trim().isEmpty()) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("search_input", search_input);
			map.put("userid", loginuser.getUserid());
			map.put("startRno", String.valueOf(int_startRno));
			map.put("endRno",String.valueOf(int_endRno));
			
			List<HashMap<String, String>> cardList = service.getSearch_card(map);
		
			JSONArray jsonArr = new JSONArray();
			
			if(cardList != null && cardList.size() > 0) {
				
				for(HashMap<String, String> cardmap :cardList) {
					
					JSONObject jsonObj = new JSONObject();
					
					jsonObj.put("rno", cardmap.get("rno"));
					jsonObj.put("card_idx", cardmap.get("card_idx"));
					jsonObj.put("fk_list_idx", cardmap.get("fk_list_idx"));
					jsonObj.put("card_userid", cardmap.get("card_userid"));
					jsonObj.put("card_title",cardmap.get("card_title"));
					jsonObj.put("card_commentcount", cardmap.get("card_commentcount"));
					jsonObj.put("card_date", cardmap.get("card_date"));
					jsonObj.put("card_delete_status", cardmap.get("card_delete_status"));
					
					jsonArr.put(jsonObj);
					
				}
				
			}
			
			String str_jsonArr = jsonArr.toString();
			req.setAttribute("str_jsonArr", str_jsonArr);
			
		}
		
		return "cardSearch.notiles";

	}*/
	
	
	@RequestMapping(value="/memberSearch.action", method= {RequestMethod.GET})
	public String memberSearch(HttpServletRequest req,  HttpServletResponse res) {
		/*
		
		String search_input = req.getParameter("search_input");
		String startRno = req.getParameter("startRno");
		String endRno = req.getParameter("endRno");
		
		*/
		
		String start = req.getParameter("start");
		String search_input = req.getParameter("search_input");
		String len = req.getParameter("len");
		
		if(start == null || start.trim().isEmpty()) {
			start = "1";
		}
		if(len == null || len.trim().isEmpty()) {
			len = "2";
		}
		
		
		System.out.println("controller memberSearch.action >>>>>>>>>>" + start);
		System.out.println("controller memberSearch.action >>>>>>>>>>" + len);
		
		int startRno = Integer.parseInt(start);
		// 시작행 번호		 1				4				7
		
		int endRno = startRno + Integer.parseInt(len) - 1;
		// 끝행 번호 공식!! 1+3-1=3			4+3-1=6			7+3-1=9
		
		
		if(!search_input.trim().isEmpty()) {
						
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("search_input", search_input);
			
			List<HashMap<String, String>> memberList = service.getSearch_member(map);
		
			JSONArray jsonArr = new JSONArray();
			
			if(memberList != null && memberList.size() > 0) {
				
				for(HashMap<String, String> memberListmap :memberList) {
					
					JSONObject jsonObj = new JSONObject();
					
					jsonObj.put("userid", memberListmap.get("userid"));
					jsonObj.put("name", memberListmap.get("name"));
					jsonObj.put("nickname", memberListmap.get("nickname"));
					jsonObj.put("profilejpg", memberListmap.get("profilejpg"));
					
					jsonArr.put(jsonObj);
					
				}
				
			}
			
			String str_jsonArr = jsonArr.toString();
			req.setAttribute("str_jsonArr", str_jsonArr);
			
		}
		
		int memberListCount = service.getSearch_member_count(search_input);
		
		HttpSession session = req.getSession();
		session.setAttribute("memberListCount", memberListCount);
		
		return "memberSearch.notiles";

	}
	
	/*@RequestMapping(value="/btnMore.action", method= {RequestMethod.GET})
	public void getMemberSearchCNT(HttpServletRequest req) {
		
		String search_input = req.getParameter("search_input");
		
		int teamListCount = service.getSearch_team_count(search_input);
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search_input", search_input);
		map.put("loginuser", loginuser.getUserid());
		
		int projectListCount = service.getSearch_project_count(map);
		int listListCount = service.getSearch_list_count(map);
		int cardListCount = service.getSearch_card_count(map);
		int memberListCount = service.getSearch_member_count(search_input);
		System.out.println("btnMore.actin 확인>>>>>>>>>>>>>>>>>>>" + search_input);
		
		HttpSession session = req.getSession();
		session.setAttribute("teamListCount", teamListCount);
		session.setAttribute("projectListCount", projectListCount);
		session.setAttribute("listListCount", listListCount);
		session.setAttribute("cardListCount", cardListCount);
		session.setAttribute("memberListCount", memberListCount);
		
	}*/
	
	
	
	
	
}
