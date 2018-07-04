package com.spring.finalins;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.finalins.model.MemberVO;
import com.spring.finalins.service.InterMinjaeServie;
import com.spring.finalins.service.MinjaeService;

@Controller
@Component
public class MINJAEController {

	@Autowired
	private InterMinjaeServie service;
	
	@RequestMapping(value="/mj_project.action", method= {RequestMethod.GET})
	public String mj_project(HttpServletRequest req,  HttpServletResponse res) {
		
		return "minjae/mj_project.tiles";
				
	}
	
	/*@RequestMapping(value="/list.action", method= {RequestMethod.GET})
	public void header(HttpServletRequest req,  HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		// 로그인한 userid의 팀의 목록을 갖고 옴
		List<String> teamList = service.getTeamList(loginuser);
		
		// 해당하는 팀의 프로젝트 목록을 갖고 옴
		List<HashMap<String, String>> projectList = service.getProjectInTeam();
		
		req.setAttribute("teamList", teamList);
				
	}*/
	

}
