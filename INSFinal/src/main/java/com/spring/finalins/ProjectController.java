package com.spring.finalins;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.JsonObject;
import com.spring.finalins.model.MemberVO;
import com.spring.finalins.service.InterProjectService;

@Controller
@Component
/* XML에서 빈을 만드는 대신에 클래스명 앞에 @Component 어노테이션을 적어주면
     해당 클래스는 bean으로 자동 등록된다.
     그리고 bean의 이름(첫글자는 소문자)은 해당 클래스명(지금은 BoardController)이 된다.
     지금은 bean의 이름은 boardController 이 된다. */
public class ProjectController {
	
	@Autowired
	private InterProjectService service;


	//로그인 처리를 하는 메소드
	@RequestMapping(value="loginEnd.action", method= {RequestMethod.POST})
	public String loginEnd(HttpServletRequest request) {
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("userid", userid);
		map.put("pwd", pwd);
		
		MemberVO loginuser = service.getLogin(map);
		
		if(loginuser != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginuser", loginuser);
		}
		return "login/loginEnd.tiles";
	} // end of loginEnd(HttpServletRequest request)
	
	
	//로그아웃 처리를 하는 메소드 logout.action
	@RequestMapping(value="logout.action", method= {RequestMethod.GET})
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate(); //세션에 저장된 모든 데이터를 삭제하고 세션 초기화
		return "login/logout.tiles";
	} // end of logout(HttpServletRequest request)
		
	
	//회원가입 폼을 띄우는 메소드
	@RequestMapping(value="signup.action", method= {RequestMethod.GET})
	public String signup() {
		return "login/signup.tiles";
	} // end of signup() 
	
	 
	//회원가입 요청을 처리하는 메소드  
	@RequestMapping(value="signupEnd.action", method= {RequestMethod.POST})
	public String signupEnd(HttpServletRequest request, MemberVO mvo) {
		/*String bday = mvo.getBirthday();
		System.out.println("생일값 확인: " + bday);*/
		
		int n = service.signupEnd(mvo);
		
		request.setAttribute("n", n);
		return "login/signupEnd.tiles";
	} // end of signupEnd(HttpServletRequest request)
	
	
	//아이디 중복체크하는 함수 
	@RequestMapping(value="idcheck.action", method= {RequestMethod.GET})
	public String idcheck(HttpServletRequest request) {
		String useridCheck = request.getParameter("useridCheck");
		
		String msg = "";
		int n = service.idcheck(useridCheck);
		if(n != 0) {
			msg = "*이미 사용중인 아이디입니다.";
		}
		else if(n == 0) {
			msg = "*사용 가능한 아이디입니다.";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("msg", msg);
		jsonObj.put("n", n);
		jsonObj.put("useridCheck", useridCheck);
		
		String str_jsonObj = jsonObj.toString();
		request.setAttribute("str_jsonObj", str_jsonObj);
		request.setAttribute("n", n);
		request.setAttribute("useridCheck", useridCheck);
		System.out.println("확인용: " + str_jsonObj);
		return "login/idcheckJSON";
	} // end of idcheck(HttpServletRequest request)
	
	
	//
	public String requireLogin_getTeamList(HttpServletRequest request, HttpServletResponse respons) {
		
		return "";
	}
}
