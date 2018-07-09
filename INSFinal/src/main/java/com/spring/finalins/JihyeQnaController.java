package com.spring.finalins;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.finalins.common.FileManager;
import com.spring.finalins.model.MemberVO;
import com.spring.finalins.model.PhotoVO;
import com.spring.finalins.qna.model.QnaVO;
import com.spring.finalins.qna.service.InterQnaService;

//====== #32. 컨트롤러 선언 ======
@Controller
@Component // 해당클래스를 bean으로 만들어 줌
public class JihyeQnaController {
	
	// ====== . 의존객체 주입하기(DI: Dependency Injection) ========
	@Autowired
	private InterQnaService service;
	
		
    // ====== 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) ========
    /*
     * 이전에 파일 업로드는 cos.jar를 사용하였지만 이제부터 FileManager.java를 사용할 것이다. smart editor에서
     * 사용할 것이다.
     */
    @Autowired
    private FileManager fileManager;	


	// 회원 - qna 페이지
	@RequestMapping(value="/qna.action", method= {RequestMethod.GET})
	public String requireLogin_qna(HttpServletRequest req, HttpServletResponse res) {

		// 1. Qna 페이지를 보면 qna리스트를 보여주고 없으면 글쓰기 버튼 클릭해서 스마트 에디트를 보여준다.
		HttpSession session = req.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String userid = null;
		List<QnaVO> qnaList = null;

		if (loginuser != null) {
			userid = loginuser.getUserid();	
        	qnaList = service.qnaList(userid);  //QnA목록 보여주기
		}
		
		req.setAttribute("qnaList", qnaList);
		
		return "jihye/qna.tiles";
	}
	
		
	  // 글쓰기 페이지 요청하기
      @RequestMapping(value="/goWrite.action", method={RequestMethod.GET})
      public String requireLogin_writeQna(HttpServletRequest req, HttpServletResponse res) {
         
         // 처음에 글쓰기(원글)은 아래 fk_seq/groupno/depthno 값이 없다.
         // 원글일 경우 뷰단에서 값을 넘기는 것은 DB에 insert가 아니기 때문에 null이다.
         // 그러나 답변 글쓰기 경우 위의 세가지 값을 뷰단에서 받아서 컨트롤러로 넘긴다.
      //   System.out.println("확인용입니다.");

         // ===== #121. 답변글쓰기 추가 되었으므로 아래와 같이 한다(시작). =======
         String fk_qna_category_idx = req.getParameter("fk_qna_category_idx");
         String qna_groupno = req.getParameter("qna_groupno");
         String qna_depthno = req.getParameter("qna_depthno");

         req.setAttribute("fk_qna_category_idx", fk_qna_category_idx);
         req.setAttribute("qna_groupno", qna_groupno);
         req.setAttribute("qna_depthno", qna_depthno);

         // ==== 답변글쓰기 추가 되었으므로 아래와 같이 한다(끝).
         
         return "jihye/qnaWrite.tiles";
         
      }

		
      // =======  글쓰기 완료 요청 =======
      @RequestMapping(value = "/writeEnd.action", method = { RequestMethod.POST })
      public String writeEnd(QnaVO qnavo,MultipartHttpServletRequest req,  HttpSession session, HttpServletResponse res) {
	  //requireLogin_
    	  
    	  
          MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
          String userid = null;
          if (loginuser != null) {
             userid = loginuser.getUserid();   
                qnavo.setFk_userid(userid);
          }
    	  
    	  if (loginuser != null) {
    			if (!qnavo.getFk_userid().equals(loginuser.getUserid())) {

    				String msg = "다른 사용자의 글은 수정이 불가합니다.";
    				String loc = "qna.action";

    				req.setAttribute("msg", msg);
    				req.setAttribute("loc", loc);

    				return "msg.notiles";
    			
    			} else { // 자신의 글을 수정함
    						// 가져온 1개의 글을 request 영역에 저장시켜서 view 단 페이지로 넘긴다.
    				 // HttpServletRequest는 파일첨부를 하지 못한다. 그래서 HttpServletRequest 를 지우고
    		         // MultipartHttpServletRequest를 한다.

    		         // =======  사용자가 쓴 글에 파일이 첨부가 된 것인지 아니면 파일첨부가 안 된 것인지 구분지어야 한다.
    		         // ************* 첨부파일이 있으면 파일업로드 하기 시작 ******************************
    		         if (!qnavo.getAttach().isEmpty()) {
    		            // attach 가 비어있지 않다면 (즉, 청부파일이 있는 경우라면 )

    		            /*
    		             * 1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 경로 폴더에 저장해 줘야 한다. >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
    		             * 우리는 WAS(톰캣)의 webapp/resources/files 라는 폴더로 지정해주겠다. // files 명은 바꿔도 된다.
    		             */

    		            // WAS(톰캣)의 webapp 의 절대경로를 알아와야 한다.
    		            String root = session.getServletContext().getRealPath("/"); // /는 첫번째 경로를 말한다. 확장자.java //
    		                                                         // session.getServletContext().getRealPath("/");
    		                                                         // == 절대경로
    		            String path = root + "resources" + File.separator + "files";
    		            // File.separator ==> 운영체제가 Windows 라면 "\" 이고,
    		            // ==> 운영체제가 UNIX, Linux 이라면 "/" 이다.

    		            System.out.println("root >>" + root);
    		            // C:\INSFinal\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\INSFinal\
    		            System.out.println("path>>" + path);
    		            // C:\INSFinal\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\INSFinal\resources\files

    		            /*
    		             * 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일 올리기
    		             */
    		            
    		            String newFileName = "";
    		            // WAS(톰캣) 디스크에 저장할 파일명.

    		            byte[] bytes = null;
    		            // 첨부파일을 WAS(톰캣) 디스크에 저장할 때 사용되는 용도. 실제파일이다.

    		            long qna_byte =0;
    		            //long fileSize = 0;
    		            // 파일크기를 읽어오기 위한 용도.

    		            // FileManager에 있는 doFileUpload 가 throws Exception을 하였기 때문에 try-catch
    		            try {
    		               bytes = qnavo.getAttach().getBytes(); // 실제 파일의 내용물들을 읽어온 것. 리턴타입은 byte[]
    		               // getBytes() 는 첨부된 파일을 바이트 단위로 파일을 다 읽어오는 것이다.

    		               newFileName = fileManager.doFileUpload(bytes, qnavo.getAttach().getOriginalFilename(), path);
    		               // getOriginalFilename() 은 우리가 만든 것이 아니라 MultipartFile에서 제공해주는 것이다.
    		               // 파일을 업로드 한 후 현재시간 + 나노타임. 확장자로 되어진 파일명을
    		               // 리턴받아 newFileName 으로 저장한다.
    		               // qnavo.getAttach().getOriginalFilename() 은 첨부된 파일의 실제 파일명(문자열)을 얻어 오는 것이다.

    		               System.out.println("qna_filename: " + newFileName);

    		               qnavo.setQna_filename(newFileName);
    		               // newFileName이 WAS(톰캣)에 저장될 파일명(

    		               
    		             
    		               
    		               qnavo.setQna_orgfilename(qnavo.getAttach().getOriginalFilename());
    		               // qnavo.getAttach().getOriginalFilename() 은 진짜 파일명(강아지.png);
    		               // 사용자가 파일을 다운로드할 때 사용되어지는 파일명

    		          
    		               
    		               qna_byte = qnavo.getAttach().getSize();
    		               //filesieze
    		               // qnavo.getAttach().getSize() 은 첨부한 파일의 크기를 말한다.

    		               qnavo.setQna_byte(String.valueOf(qna_byte));

    		            } catch (Exception e) {

    		            }

    		         }
    		         // ************* 첨부파일이 있으면 파일업로드 하기 끝 ******************************

    		         // VO를 사용하면 편함
    		         String qna_content = qnavo.getQna_content().replaceAll("\r\n", "<br/>");
    		         qnavo.setQna_content(qna_content);

    		         int n = 0;

    		         if (qnavo.getAttach().isEmpty()) {
    		            // 파일첨부가 없다면
    		            n = service.write(qnavo); // insert니까 리턴타입은 int
    		         }      
    		         if (!qnavo.getAttach().isEmpty()) {
    		            // 파일첨부가 있다면
    		           n = service.write_withFile(qnavo); // insert니까 리턴타입은 int
    		         }

    		         req.setAttribute("n", n);
    		        
    		         return "writeEnd.notiles";

    			}

    		} else {
    			
    			session.invalidate();
    			
    			String msg = "문의 하려면 로그인을 해주세요";
    			String loc = "index.action";

    			req.setAttribute("msg", msg);
    			req.setAttribute("loc", loc);

    			return "msg.notiles";
    		}
        
      }
      
      
      
      // ======= #61. 글 1개를 보여주는 페이지 요청하기 =====
      @RequestMapping(value = "/view.action", method = { RequestMethod.GET})
      public String requireLogin_view(HttpServletRequest req,  HttpServletResponse res) {

        HttpSession session = req.getSession();
   		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

   	    String qna_idx = req.getParameter("qna_idx"); // 글번호 받아오기
   	   QnaVO qnavo = service.getView(qna_idx);
   		
   			if (!qnavo.getFk_userid().equals(loginuser.getUserid())) {

   				String msg = "경로가 잘못되었습니다.(다른 사용자의 문의 글을 볼 수 없습니다.";
   				String loc = "javascript:history.back();";

   				req.setAttribute("msg", msg);
   				req.setAttribute("loc", loc);

   				return "msg.notiles";
   			
   			} else { 

   	         // 조회수 1증가 없이 그냥 글 1개를 가져오는 것
   	         qnavo = service.getView(qna_idx);// 조회수 증가가 필요없으니까 userid가 필요하지 않다.

   	         req.setAttribute("qnavo", qnavo);
   	   
   	         return "jihye/view.tiles"; // sideinfo 가 없이 만든다.

   			}
      
      }

      
      
  	// ====== #70. 글수정 페이지 요청 =====
  	@RequestMapping(value = "/editQna.action", method = { RequestMethod.GET })
  	public String requiredLogin_editQna(HttpServletRequest req, HttpServletResponse res) { // LoginCheck.java에서 로그인 유무 검사할
  																						// 때 파라미터가 2개라서 지금 이 메소드에도 파라미터
  																						// 2개 넣은 것임.

  		String qna_idx = req.getParameter("qna_idx");// 수정해야할 글번호 가져오기

  		// 수정해야할 글 전체 내용가져오기
  		// 조회수 1증가 없이 그냥 글을 가져오는 것
  		QnaVO qnavo = service.getView(qna_idx);

  		HttpSession session = req.getSession();
  		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

  			if (!qnavo.getFk_userid().equals(loginuser.getUserid())) {

  				String msg = "다른 사용자의 글은 수정이 불가합니다.";
  				String loc = "javascript:history.back();";

  				req.setAttribute("msg", msg);
  				req.setAttribute("loc", loc);

  				return "msg.notiles";
  			
  			} else { // 자신의 글을 수정함
  						// 가져온 1개의 글을 request 영역에 저장시켜서 view 단 페이지로 넘긴다.
  				req.setAttribute("qnavo", qnavo);

  				return "jihye/editQna.tiles";
  				// /Board/src/main/webapp/WEB-INF/views2/board/edit.jsp 파일을 생성한다.
  			}



  	}

  	// ====== #71. 글수정 페이지 완료하기=====
  	@RequestMapping(value = "/editQnaEnd.action", method = { RequestMethod.POST })
  	public String editQnaEnd(QnaVO qnavo, HttpServletRequest req,  HttpServletResponse res) {


  		HttpSession session = req.getSession();
  		 MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
   
   	    if (loginuser != null) {
   			
   				String qna_content = qnavo.getQna_content().replaceAll("\r\n", "<br/>");
   		  		qnavo.setQna_content(qna_content);
   		  		/*
   		  		 * 글 수정을 하려면 원본 글의 암호화 수정시 입력해주는 암호가 일치할 때만 글수정이 가능하도록 해야 한다.
   		  		 */
   		  		int n = service.editQna(qnavo);
   		  		// n 이 1이면 update 성공
   		  		// n 이 0이면 update 실패(암호가 틀리므로)
   		  	
   		  		
   		  		  req.setAttribute("n", n);
   		  		   req.setAttribute("qna_idx", qnavo.getQna_idx());
   		  	      return "jihye/editQnaEnd.tiles";
   	    }	
		 else {
			
			session.invalidate();
			
			String msg = "글을 수정하려면 로그인을 해주세요";
			String loc = "index.action";
	
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
	
			return "msg.notiles";
		 }
  		
  	}
  	
  	
 // ====== #77. 글삭제 페이지 요청 =====
 	@RequestMapping(value = "/del.action", method = { RequestMethod.POST})
 	public String requiredLogin_del(HttpServletRequest req, HttpServletResponse res) { // LoginCheck.java 체크할때 파라미터가
 																						// 두개였었다.

 		// 삭제해야할 글번호 가져오기
 		String qna_idx = req.getParameter("qna_idx"); // view.jps페이지에서 boardvo seq 글번호

 		// 삭제할 글은 자신이 작성한 글이어야만 가능하다.
 		// 삭제할 글 내용을 읽어오면 작성자를 알 수 있다.
 		QnaVO qnavo = service.getView(qna_idx);

 		HttpSession session = req.getSession();
 		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");

 		if (loginuser != null) {

 			if (!loginuser.getUserid().equals(qnavo.getFk_userid())) {
 				String msg = "다른 사용자의 글은 삭제가 불가합니다.";
 				String loc = "javascript:history.back()";

 				req.setAttribute("msg", msg);
 				req.setAttribute("loc", loc);

 				return "msg.notiles";
 			} else { // 삭제해야할 글번호 유저아이디와 로그인한 유저아이디가 같을 경우 삭제할 수 있다.
 				
 				// 삭제해야할 글번호를 request 영역에 저장시켜서 view단 페이지로 옮긴다.
 				req.setAttribute("qna_idx", qna_idx);

 				// 글삭제시 글장석지 입력한 암호를 다시 입력 받아 암호의 일치여부를 알아보도록
 				// view단 페이지 del.jsp 로 넘긴다.

 				int n = service.del(qna_idx);
 		 		// 넘겨받은 값이 1(원게시글 및 댓글까지 삭제 성공)이면 글삭제 성공,
 		 		// 넘겨받은 값이 2(댓글이 없는 원게시글 삭제 성공)이면 글삭제 성공,
 		 		// 넘겨받은 값이 0이면 글삭제 실패(암호가 틀리므로)

 		 		req.setAttribute("n", n);

 		 		return "jihye/delEnd.tiles";
 			}
 		} else {
 			String msg = "글을 삭제하려면 로그인을 해주세요";
 			String loc = "javascript:history.back();";

 			req.setAttribute("msg", msg);
 			req.setAttribute("loc", loc);

 			return "msg.notiles";
 		}

 	}

/* 	// ====== #78. 글삭제 페이지 완료하기 =====
 	@RequestMapping(value = "/delEnd.action", method = { RequestMethod.POST })
 	public String requiredLogin_delEnd(HttpServletRequest req, HttpServletResponse res) throws Throwable {

 		
 		 * 글 삭제를 하려면 원본 글의 암호와 삭제시 입력된 암호가 일치할때만 삭제가 가능하도록 해야 한다. 서비스단에서 글삭제를 처리한 결과를
 		 * int타입으로 받아오겠다.
 		 
 		String qna_idx = req.getParameter("qna_idx");
 	
 		
 	}
*/
      

      
	
   // ==== #148. 첨부파일 다운로드 받기 =====
  	@RequestMapping(value = "/download.action", method = { RequestMethod.GET })
  	public void requiredLogin_download(HttpServletRequest req, HttpServletResponse res) {
  		// 다운만 받으면 끝나기 때문에 페이지 이동도 없고 리턴타입이 없다. 그냥 void

  		String qna_idx = req.getParameter("qna_idx");  // get방식 주소창에 seq로 받았으니까 받는 것도seq이다!!
  		// 첨부파일이 있는 글번호

  	//	System.out.println(">>>>>>>>>>" + qna_idx);

  		QnaVO qnavo = service.getView(qna_idx);

  		String qna_filename = qnavo.getQna_filename();
  		String qna_orgfilename = qnavo.getQna_orgfilename();

  		// WAS(톰캣)의 webapp 의 절대경로를 알아와야 한다.
  		HttpSession session = req.getSession(); // 파라미터에 HttpSession session을 넣어도 되고 이런식으로 불러와도 된다. 상관없다.

  		String root = session.getServletContext().getRealPath("/"); // /는 첫번째 경로를 말한다. 확장자.java //
  																	// session.getServletContext().getRealPath("/"); ==
  																	// 절대경로
  		String path = root + "resources" + File.separator + "files"; // path 는 업로드 되는 곳
  		// File.separator ==> 운영체제가 Windows 라면 "\" 이고,
  		// ==> 운영체제가 UNIX, Linux 이라면 "/" 이다.

  		boolean bool = false;

  		bool = fileManager.doFileDownload(qna_filename, qna_orgfilename, path, res);
  		// 다운로드가 성공이면 true를 반납하고,
  		// 다운로드가 실패면 false를 반납한다.

  		if (!bool) { // !bool == true 라는 뜻
  			// 다운로드가 실패할 경우 메시지를 띄어준다.
  			res.setContentType("text/html; charset=UTF-8");
  			PrintWriter writer = null; // PrintWriter는 웹상에서 쓰는 볼펜같은 역할이다.

  			try {
  				writer = res.getWriter();
  				// 웹브라우저상에 메시지를 쓰기 위한 객체생성.
  			} catch (IOException e) { // IO는 입출력을 뜻한다.
  				e.printStackTrace();
  			}

  			writer.println("<script type='text/javascript'>alert('파일 다운로드 실패!!')</script>");

  		}

  	}
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
  	
 
      
    // ************************************************************************************************************************************
  	// //
 	// ==== #스마트에디터1. 단일사진 파일업로드 ====
 	@RequestMapping(value = "/image/photoUpload.action", method = { RequestMethod.POST })
 	public String photoUpload(PhotoVO photovo, HttpServletRequest req) {

 		System.out.println("확인용 스마트 에디트");
 		
 		String callback = photovo.getCallback();
 		String callback_func = photovo.getCallback_func();
 		String file_result = "";

 		if (!photovo.getFiledata().isEmpty()) {
 			// 파일이 존재한다라면

 			/*
 			 * 1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기 우리는
 			 * WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
 			 */

 			// WAS 의 webapp 의 절대경로를 알아와야 한다.
 			HttpSession session = req.getSession();
 			String root = session.getServletContext().getRealPath("/");
 			String path = root + "resources" + File.separator + "photo_upload";
 			// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.

 			// System.out.println(">>>> 확인용 path ==> " + path);
 			// >>>> 확인용 path ==>
 			// C:\INSFinal\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\INSFinal\resources\photo_upload

 			// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기
 			String newFilename = "";
 			// WAS(톰캣) 디스크에 저장할 파일명

 			byte[] bytes = null;
 			// 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도

 			try {
 				bytes = photovo.getFiledata().getBytes();
 				// getBytes()는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다.
 				/*
 				 * 2-1. 첨부된 파일을 읽어오는 것 첨부한 파일이 강아지.png 이라면 이파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[]
 				 * 타입으로 변경해서 받아들인다.
 				 */
 				// 2-2. 이제 파일올리기를 한다.
 				String original_name = photovo.getFiledata().getOriginalFilename();
 				// photovo.getFiledata().getOriginalFilename() 은 첨부된 파일의 실제 파일명(문자열)을 얻어오는 것이다.
 				newFilename = fileManager.doFileUpload(bytes, original_name, path);

 				// System.out.println(">>>> 확인용 newFileName ==> " + newFileName);

 				int width = fileManager.getImageWidth(path + File.separator + newFilename);
 				// System.out.println("확인용 >>>>>>>> width : " + width);

 				if (width > 600)
 					width = 600;
 				// System.out.println("확인용 >>>>>>>> width : " + width);

 				String CP = req.getContextPath(); // board
 				file_result += "&bNewLine=true&sFileName=" + newFilename + "&sWidth=" + width + "&sFileURL=" + CP
 						+ "/resources/photo_upload/" + newFilename;

 			} catch (Exception e) {
 				e.printStackTrace();
 			}

 		} else {
 			// 파일이 존재하지 않는다라면
 			file_result += "&errstr=error";
 		}

 		return "redirect:" + callback + "?callback_func=" + callback_func + file_result;

 	}// end of String photoUpload(PhotoVO photovo, HttpServletRequest
 		// req)-------------------

 	// ==== #스마트에디터2. 드래그앤드롭을 사용한 다중사진 파일업로드 ====
 	@RequestMapping(value = "/image/multiplePhotoUpload.action", method = { RequestMethod.POST })
 	public void multiplePhotoUpload(HttpServletRequest req, HttpServletResponse res) {

 		/*
 		 * 1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다. >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기 우리는
 		 * WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
 		 */

 		// WAS 의 webapp 의 절대경로를 알아와야 한다.
 		HttpSession session = req.getSession();
 		String root = session.getServletContext().getRealPath("/");
 		String path = root + "resources" + File.separator + "photo_upload";
 		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다.

 		 System.out.println(">>>> 확인용 path ==> " + path);
 		// >>>> 확인용 path ==>
 		// C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload

 		File dir = new File(path);
 		if (!dir.exists())
 			dir.mkdirs();

 		String strURL = "";

 		try {
 			if (!"OPTIONS".equals(req.getMethod().toUpperCase())) {
 				String filename = req.getHeader("file-name"); // 파일명을 받는다 - 일반 원본파일명

 				// System.out.println(">>>> 확인용 filename ==> " + filename);
 				// >>>> 확인용 filename ==> berkelekle%ED%8A%B8%EB%9E%9C%EB%94%9405.jpg

 				InputStream is = req.getInputStream();
 				/*
 				 * 요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때, 혹은 이름 없이
 				 * 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. 이러한 형태의 값을 'payload body'라고 하는데 요청 바디에
 				 * 직접 쓰여진다 하여 'request body post data'라고도 한다.
 				 * 
 				 * 서블릿에서 payload body는 Request.getParameter()가 아니라 Request.getInputStream() 혹은
 				 * Request.getReader()를 통해 body를 직접 읽는 방식으로 가져온다.
 				 */
 				String newFilename = fileManager.doFileUpload(is, filename, path);

 				int width = fileManager.getImageWidth(path + File.separator + newFilename);

 				if (width > 600)
 					width = 600;

 				// System.out.println(">>>> 확인용 width ==> " + width);
 				// >>>> 확인용 width ==> 600
 				// >>>> 확인용 width ==> 121

 				String CP = req.getContextPath(); // board

 				strURL += "&bNewLine=true&sFileName=";
 				strURL += newFilename;
 				strURL += "&sWidth=" + width;
 				strURL += "&sFileURL=" + CP + "/resources/photo_upload/" + newFilename;
 			}

 			/// 웹브라우저상에 사진 이미지를 쓰기 ///
 			PrintWriter out = res.getWriter();
 			out.print(strURL);
 		} catch (Exception e) {
 			e.printStackTrace();
 		}

 	}// end of void multiplePhotoUpload(HttpServletRequest req, HttpServletResponse
 		// res)----------------
 
      
 	
 	
 	
 	
 	
 	
      
 }

	
	
	
	
	

