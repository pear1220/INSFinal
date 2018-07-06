package com.spring.finalins;



import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.finalins.model.MemberVO;
import com.spring.finalins.model.PhotoVO;
import com.spring.finalins.service.InterJihyeService;

@Controller
@Component // bean객체를 생성
public class JihyeController {
	
	// ======  의존객체 주입하기(DI: Dependency Injection) ========
	@Autowired
	private InterJihyeService service;


	// ====== #132. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) ========
	/*
	   이전에 파일 업로드는 cos.jar를 사용하였지만 
	   이제부터 FileManager.java를 사용할 것이다.
	  smart editor에서 사용할 것이다.
	 */
	/*@Autowired
	private FileManager fileManager;
	*/
	
	// my-1. 로그인을 해야만 마이페이지로 이동(requiredLogin)
	@RequestMapping(value="/mypage.action", method= {RequestMethod.GET})
	public String requireLogin_mypage(HttpServletRequest req, HttpServletResponse res) {
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = null;

		if (loginuser != null) {
			userid = loginuser.getUserid();
			
		}
		return "jihye/mypage.tiles";
	}
	
	
	// my-2. 개인정보 수정을 위한 (로그인한) 유저의 정보를 불러오기
	@RequestMapping(value="/edit.action", method= {RequestMethod.GET})
	public String requireLogin_edit(HttpServletRequest req, HttpServletResponse res) {

		// 1. 기본정보를 불러 온다. 패스워드 빼고는 전부 기본정보가 입력이 되어야 한다. 
	    // --> 그러기 위해선 로그인한 멤버의 정보를 우선적으로 불러오고 그것을 edit.jsp로 보내준다.
		// AOP 처리한 requriedLogin 붙여주기(로그인 확인여부)
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = null;

		if (loginuser != null) {
			userid = loginuser.getUserid();
		}
		
		MemberVO membervo = service.getMyProfile(userid);
		
		String goBackURL = "mypage.action";
		
		// 회원정보 수정시 생년월일만 글자를 잘라서 보내야 웹브라우저에 값이 나타난다.
		String birthday = membervo.getBirthday().substring(0, 10); 
		req.setAttribute("birthday", birthday);
		
		req.setAttribute("membervo", membervo);
		req.setAttribute("goBackURL", goBackURL);
		
		return "jihye/edit.tiles";
	}
	
	
	
	// my-3. 회원정보수정 업데이트 하기
    @RequestMapping(value="/memberEditEnd.action", method= {RequestMethod.POST})
	public String requireLogin_memberEditEnd(HttpServletRequest req, HttpServletResponse res) {
			
		// 1.불러온 정보를 업데이트(update) 해주기!! 변경한 회원정보만 update 해주면 되지만 
    	// loginuser에서 변경되지 않은 값도 동시에 보내줘야 하기때문에 변경되지 않은 정보도 보내줌.(update는 안함)
    	 String userid = req.getParameter("userid");
    	 String name = req.getParameter("name");
    	 String pwd = req.getParameter("pwd");
    	 String nickname = req.getParameter("nickname");
    	 String email = req.getParameter("email");
		 String tel1 = req.getParameter("tel1");
		 String tel2 = req.getParameter("tel2");
		 String tel3 = req.getParameter("tel3");
		 String job = req.getParameter("job");
		 
		 MemberVO membervo = new MemberVO();
		    membervo.setUserid(userid);
		    membervo.setName(name);
			membervo.setPwd(pwd);
			membervo.setNickname(nickname);
			membervo.setEmail(email);
			membervo.setTel1(tel1);
			membervo.setTel2(tel2);
			membervo.setTel3(tel3);
			membervo.setJob(job);
			
		int n = service.updateMyProfile(membervo);
		
		String msg = null;
		String loc = null;
		
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");	
		
		if(n==1) {// 회원정소 수정이 성공했다면 n은 1이다.
			
		// top.jsp에서 개인정보도 변경 시켜줘야 하기 때문에 loginuser에 속성값을 집어 넣어주었다.
	    // (top.jsp는 edit.action등 tap으로 링크되는 페이지에 include 되어있다.)
		loginuser.setNickname(nickname);
		loginuser.setPwd(pwd);
		loginuser.setTel1(tel1);
		loginuser.setTel2(tel2);
		loginuser.setTel3(tel3);
		loginuser.setJob(job);
						
		req.setAttribute("membervo", membervo);
		
		req.setAttribute("loginuser", loginuser);
		
		msg = "회원정보를 성공적으로 수정하였습니다,";
		loc = "mypage.action";
		
		}
		else {
			msg = "회원정보수정에 실패하였습니다.";
			loc = "mypage.action";
		}		
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
			
		// return 값에 바로 mypage.tiles를 주면 페이지 이동은 되지만 url에 memberEditEnd.action이 남기 때문에 
		// msg.notiles로 가서 msg를 띄우고 mypage.action 경로로 가는 것을 설정했따. 
		return "msg.notiles";
		 
	}
    
    
    
    // 회원정보 수정 페이지에서 회원 탈퇴를 누를 수 있다. 
    // 회원 탈퇴 버튼을 누르면 ins_member의 leave_status 값을 0에서 1로 바꾸어준다. 
    // 회원 탈퇴시 회원정보를 삭제하면 그 회원이 작성했던 모든 작업들이 삭제되기 때문에 그러면 오류가 발생하여 업데이트로 변경하였다. 
    
    // my_4. 회원탈퇴(leave_status 업데이트 하기)
    @RequestMapping(value="/memberDeleteAccount.action", method= {RequestMethod.POST})
   	public String requiredLogin_memberDelete(HttpServletRequest req, HttpServletResponse res) {
    	
    	HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");	
	
		String userid = loginuser.getUserid();
		
		int n = service.deleteMyAccount(userid);
		
		String msg = null;
		String loc = null;

		  if(n==1) {
			
		   // 세션에 저장해 놓은 모든 값을 없앤다.	
		   session.invalidate();
			  
			msg = "회원탈퇴 하셨습니다.";
			loc = "index.action";
		  }
		  else {
				msg = "회원탈퇴에 실패하셨습니다..";
				loc = "mypage.action";
		   }

		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
	
		return "msg.notiles";

    }
    
    
    
 
    
	
	@RequestMapping(value="/qna.action", method= {RequestMethod.GET})
	public String requireLogin_qna(HttpServletRequest req, HttpServletResponse res) {

		
		return "jihye/qna.tiles";
	}
	
	
	@RequestMapping(value="/setting.action", method= {RequestMethod.GET})
	public String requireLogin_setting(HttpServletRequest req, HttpServletResponse res) {
	
		
		
		
		return "jihye/setting.tiles";
	}
	
	
}
