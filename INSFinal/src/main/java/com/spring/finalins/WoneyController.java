package com.spring.finalins;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.finalins.common.FileManager;
import com.spring.finalins.model.CardVO;
import com.spring.finalins.model.MemberVO;
import com.spring.finalins.service.InterWoneyService;



@Controller
@Component
public class WoneyController {
	
	// ===== #33. 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired// 의존객체주입(DI : Dependency Injection)
	private InterWoneyService service;
	
	// ===== #132. 파일업로드 및 다운로드 해주는 FileManger클래스 의존객체 주입하기(DI: Dependency Injection) =====
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/index.action", method= {RequestMethod.GET})
	public String index(HttpServletRequest request) {

		return "main/index.tiles";
	}
	
	// ===== 카드 상세 보여주기 requireLogin_ ===== 
	@RequestMapping(value="/carddetail.action", method= {RequestMethod.GET})
	public String crearddetail(HttpServletRequest request,HttpServletResponse response,HttpSession session) {
		
		HashMap<String, String> cardMap = service.getCardInfo("1"); // 카드정보 받아오기
		HashMap<String, String> cardDetailMap = service.getCardDetailInfo("1"); // 카드 상세 받아오기
		
		request.setAttribute("cardMap", cardMap);
		request.setAttribute("cardDetailMap", cardDetailMap);
		if(cardMap != null) {
			int cnt = service.cardDescriptionCNT("1"); // 카드 Description 존재 여부 체크
			if(cnt == 0) {
				int n = service.setcardDescriptionInsert("1"); // 카드 Description 입력
			}

			return "carddetail.tiles3";
		}else {
			
			return "main/index.tiles";
		}
	}
	
	// ===== 프로젝트 멤버 체크(AJAX 처리용) ===== 
	@RequestMapping(value="/projectMemberCheck.action", method= {RequestMethod.GET})
	public String projectMemberCheck(HttpServletRequest request) {
		String cardIdx = request.getParameter("cardidx");
		String userid = request.getParameter("userid");
		HashMap<String,String> map = new HashMap<String, String>();
		map.put("cardIdx", cardIdx);
		map.put("userid", userid);
		
		String str_jsonobj = service.getProjectMember(map);
		request.setAttribute("str_jsonobj", str_jsonobj);
	
		return "cardProjectMemberCheck.notiles";
	}// end of projectMemberCheck()--------------------------
	
	// ===== 카드 제목 수정(AJAX 처리용) ===== 
	@RequestMapping(value="/cardTitleUpdate.action", method= {RequestMethod.POST})
	public String cardTitleUpdate(HttpServletRequest request) {
		String cardIdx = request.getParameter("cardidx");
		String cardUpdateTitle = request.getParameter("cardtitle");

		HashMap<String,String> map = new HashMap<String, String>();
		map.put("cardIdx",cardIdx);
		map.put("cardUpdateTitle",cardUpdateTitle);
		
		int n = service.setCardTitleUpdate(map);
		if(n>0) {
			String str_jsonobj = service.getCardInfoJSON(cardIdx); // card 정보 json으로 담아준다.
			System.out.println("str_jsonobj:"+str_jsonobj);
			request.setAttribute("str_jsonobj", str_jsonobj);
		}
		return "cardTitleUpdateJSON.notiles";
		
	}// end of cardTitleUpdate()----------------------------
	
	// ===== 카드 Description 수정(AJAX 처리용) ===== 
	@RequestMapping(value="/cardDescriptionCange.action", method= {RequestMethod.POST})
	public String cardDescriptionCange(HttpServletRequest request) {
		String cardIdx = request.getParameter("cardidx");
		String cardDescription = request.getParameter("carddescription");

		HashMap<String,String> map = new HashMap<String, String>();
		map.put("cardIdx",cardIdx);
		map.put("cardDescription", cardDescription);
		
		System.out.println("cardDescription" + cardDescription);

		int n = service.setcardDescriptionUpdate(map);

		if(n>0) {
			String str_jsonobj = service.getCardDescriptionInfoJSON(cardIdx); // cardDescription 정보 json으로 담아준다.
			System.out.println("str_jsonobj:"+str_jsonobj);
			request.setAttribute("str_jsonobj", str_jsonobj);
		}
		return "cardDescriptionCangeJSON.notiles";
	}// end of cardDescriptionCange()----------------------------
	
	// ===== 카드 첨부파일 추가(AJAX 처리용) ===== 
	@RequestMapping(value="/cardAttachInsert.action", method= {RequestMethod.POST})
	public String cardAttachInsert(CardVO cardvo,MultipartHttpServletRequest request,HttpSession session) {
		System.out.println("카드 첨부 확인");

		
		// 사용자가 보낸 파일을 WAS의 특정 경로 폴더에 저장한다. => 파일이 업로드 될 특정경로(폴더) 지정하기
	    // 지금은 webapp/resources/files 폴더로 지정한다.
	    String root = session.getServletContext().getRealPath("/"); //1. WAS의 webapp의 절대경로를 얻어온다.
	    String path = root + "resources" + File.separator + "files"; //File.separator => 운영체제가 Windows라면 "\" 이고 UNIX, Linux라면 "/" 이다.
	    
	    System.out.println("확인용 path: " + path);
	    // 확인용 path: C:\finalINS\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\INSFinal\resources\files
	    
	    //2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기
        String newFileName = ""; //WAS 디스크에 저장될 파일명
        byte[] bytes = null; //첨부파일을 WAS 디스크에 저장할 때 사용되는 용도. 실제파일이 저장된다.
        long fileSize = 0; //파일크기를 읽어오기 위한 용도
        
        try {
            bytes = cardvo.getAttach().getBytes(); //getBytes()는 첨부된 파일을 바이트단위로 읽어오는 것이다.
            newFileName = fileManager.doFileUpload(bytes, cardvo.getAttach().getOriginalFilename(), path);
            // 파일을 업로드 한 후 현재시간+ 나노타임. 확장자로 되어진 파일명을
            //	리턴받아 nameFileName으로 저장한다.
            //	boardvo.getAttach().getOriginalFilename()은 첨부된 파일의 실제 파일명(문자열)을 얻어오는것이다.
            	
            	cardvo.setCard_filename(newFileName);
            	//newFileName 이 WAS(톰캣)에 저장될 파일명(201806283213123213213213.png)
            	cardvo.setCard_orgfilename(cardvo.getAttach().getOriginalFilename());
            	// boardvo.getAttach().getOriginalFilename() 은 진짜 파일명 (강아지.png)
            	// 사용자가 파일을 다운로드 할때 사용되어지는 파일명
            	fileSize = cardvo.getAttach().getSize();
            	// 첨부한 파일의 크기를 알아온다.
            	// 타입은 long이다.
            	
            	cardvo.setCard_byte(String.valueOf(fileSize));
        } catch (Exception e) {
        }
        ////////////=== 첨부파일이 있으면 파일업로드 하기 끝 === ////////////	
        
       int n = service.add_withFile(cardvo);
       
       return "cardAttachInsert.tiles3";
       
	}// end of cardAttachInsert()----------------------------
	
	
}
