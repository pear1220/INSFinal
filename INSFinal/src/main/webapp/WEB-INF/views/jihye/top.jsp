<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%
   String ctxpath = request.getContextPath();
%>


<%-- 스마트 에디터 구현 시작(no frame 사용시) --%>
 
<link href="<%=ctxpath%>/resources/smarteditor/css/smart_editor2.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="<%=ctxpath%>/resources/smarteditor/js/lib/jindo2.all.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=ctxpath%>/resources/smarteditor/js/lib/jindo_component.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=ctxpath%>/resources/smarteditor/js/SE2M_Configuration.js" charset="utf-8"></script>   <!-- 설정 파일 -->
<script type="text/javascript" src="<%=ctxpath%>/resources/smarteditor/js/SE2BasicCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=ctxpath%>/resources/smarteditor/js/smarteditor2.min.js" charset="utf-8"></script> 


<!-- 사진첨부샘플  --> 
<script type="text/javascript" src="<%=ctxpath%>/resources/smarteditor/sample/js/plugin/hp_SE2M_AttachQuickPhoto.js" charset="utf-8"></script> 

 <%-- 스마트 에디터 구현 끝(no frame 사용시) --%>        
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>

<%-- 스마트 에디터 구현 시작(iframe 사용시) --%>  
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>  
<%-- 스마트 에디터 구현 끝(iframe 사용시) --%>  


<link href="resources/jihye/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" type="text/css" href="resources/jihye/checkout.css"> 
<link rel="stylesheet" type="text/css" href="resources/jihye/checkout_responsive.css"> 

<link rel="stylesheet" type="text/css" href="resources/jihye/cart.css"> 
<link rel="stylesheet" type="text/css" href="resources/jihye/cart_responsive.css">





<style>

 ul {
  list-style: none;
  margin-left: 0;
 }
 ul > li {
  display: inline-block;
 }
 ul > li > a {
  color: #fff;
  text-decoration: none;
  display: block;
  padding: 5px 10px;
  background-color: #888;
 }
 ul > li:hover > a,
 ul > li:focus > a,
 ul > li:active > a,
 ul > li.active >a {
  color: yellow;
  background-color: #000;
 }







.grid-container {
  display: grid;
  /* grid-gap: 10px; */
 /*  background-color: #2196F3; */
  padding: 10px;
  width: 50%;
/*   border: 3px solid black; */
  margin:0 auto;
}

.grid-item {
 /*  background-color: rgba(255, 255, 255, 0.8); */
 /*  text-align: center; */
  padding: 20px;
  font-size: 20px;
/*   border: 3px solid red; */
}

.item1 {
  
  text-align: center; 
  grid-column: 1; /* grid-column: 오른쪽에서 부터 순서 / grid-row: 열의 순서  /span: 컬럼 합친 갯수*/
  grid-row: 1 / span 2;
}
.item2 {
  grid-column: 2 / span 2;
  grid-row: 1 / span 2;
}

/* .item3{
  grid-column: 2 / span 2;
  grid-row: 2 ;
} */
/* .item5 {
 text-align: center;
  grid-column: 1 / span 3;
  grid-row: 3;
} */


.avatar2 {
    vertical-align: middle;
    width: 200px;
    height: 200px; 
    border-radius: 70%; 
    border: 3px solid gold;
}

 .abc {
      /*  border: 3px solid gold;  */
      padding-left:40%;
     padding-right:35%;   
}

/* 
.tablink {
     background-color: #555; 
    color: white;
    float: left;
     border: none; 
    outline: none;
    cursor: pointer;
     padding: 10px 16px; 
    font-size: 15px;
     width: 100%; 
}  */

.tab-content{
  padding-left:10%;
  padding-right:10%;
}

.activity {
    border-bottom: 1px solid #e2e4e6;
    margin-left: 40px;
    min-height: 32px;
    padding: 12px 0;
    position: relative;
   
}

.attach1{
  position: absolute;

   /*  top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); */
  /*    background: rgba(0,0,0,.5);
    bottom: 0;
    color: #fff;
    display: none;
    height: 40px;
    line-height: 30px;
    right: 0;
    width: 100%;
    z-index: 3; */
}  

.hilight {
  

   background: #2e3b46;

    color: #fff;

    display: block;
    }
    
    
    	#orgFile {
	 display:none;
	}
	#newFile {
	 background-color:black;
	 color:white;
	 cursor:pointer;
	}
</style>

<script>

/*  $(document).ready(function(){
	 
	 var sBtn = $(".ccc > li");    //  ul > li 이를 sBtn으로 칭한다. (클릭이벤트는 li에 적용 된다.)
	  sBtn.find("a").click(function(){   // sBtn에 속해 있는  a 찾아 클릭 하면.
	   sBtn.removeClass("active");     // sBtn 속에 (active) 클래스를 삭제 한다.
	   $(this).parent().addClass("active"); // 클릭한 a에 (active)클래스를 넣는다.
	  }); */
	  

	/**이벤트 발생 (크롬,파이어폭스,사파이어 OK!) **/
	function eventOccur(evEle, evType){
		 if (evEle.fireEvent) {
		 evEle.fireEvent('on' + evType);
		 } else {
		 //MouseEvents가 포인트 그냥 Events는 안됨~ ??
		 var mouseEvent = document.createEvent('MouseEvents');
		 /* API문서 initEvent(type,bubbles,cancelable) */
		 mouseEvent.initEvent(evType, true, false);
		 var transCheck = evEle.dispatchEvent(mouseEvent);
		 if (!transCheck) {
		 //만약 이벤트에 실패했다면
		 console.log("클릭 이벤트 발생 실패!");
		 }
		 }
		}
		/** 대체버튼 클릭시 강제 이벤트 발생**/
		
		function check(){
		 eventOccur(document.getElementById('orgFile'),'click');
		 /* alert(orgFile.value); 이벤트 처리가 끝나지 않은 타이밍이라 값 확인 안됨! 시간차 문제 */
	
		}
		
		
		function goModal(){
			
	      	
		}
		
		
		/* function goImg(){
			 var frm = document.orgFile;
			 frm.action= "/finalins/image/upload.action"; 
			 frm.method="post";
			 frm.submit();	
		
		} */
		
	

</script>





<div class="grid-container" style="border: 0px solid black; margin_bottom: 100px;">
  <div class="grid-item item1"> <!--grid-item  -->
     <div class="avatar2" style="border: 3px solid black;" onclick="goModal();"> 
     <!--  <form name="orgFile" enctype="multipart/form-data">
       <input type="file" id="orgFile" name="attach">
      </form> -->
     <img src="<%= request.getContextPath() %>/resources/jihye/KakaoTalk_20180710_122630078.jpg" alt="Avatar2"  class="avatar2">
       
      </div> 
  </div>
  <div class="grid-item item2">
    <input type="hidden" value="${sessionScope.loginuser.userid}" />
    
     이  름 : ${sessionScope.loginuser.name}</br></br>
     이메일 : ${sessionScope.loginuser.email}</br></br>
     닉네임 : ${sessionScope.loginuser.nickname}</br></br>
          
  </div> 
  <div>
  </div>
 </div>  


 <%-- 상단에 탭메뉴이다. 탭을 클릭하면 링크타고 페이지 이동한다. --%> 
<div class="navtab" align="center">        
    <ul class="nav nav-tabs abc">
        <c:if test="${sessionScope.loginuser.userid.equals('admin') }">  
            <li><a id="ccc"data-toggle="tab5" href="<%= request.getContextPath() %>/managementMember.action">Management</a></li> 
       </c:if>
       <c:if test="${!sessionScope.loginuser.userid.equals('admin') }">  
	       <li><a id="ccc" data-toggle="tab1" href="<%= request.getContextPath() %>/mypage.action">Profile</a></li>
	       <li><a id="ccc"data-toggle="tab4" href="<%= request.getContextPath() %>/edit.action">Edit</a></li> 
       </c:if> 
       
	       <li><a id="ccc"  data-toggle="tab2" href="<%= request.getContextPath() %>/qna.action">Q&A</a></li>
	       <li><a id="ccc" data-toggle="tab3" href="<%= request.getContextPath() %>/setting.action">Setting</a></li>
  
    
   </ul>   
</div>  
 


    
 <button type="button" onClick="goImg();" >등록</button> <!-- value="summit버튼" -->
 
 
 
<!--  <form action="upload.action" method="post" enctype="multipart/form-data">
		 <input type="file" multiple id="orgFile" name="userfile">
 </form>


<input type="submit" value="summit버튼" -->>









<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  


<style>

.grid-container {
  display: grid;
  /* grid-gap: 10px; */
 /*  background-color: #2196F3; */
  padding: 10px;
  width: 50%;
/*   border: 3px solid black; */
  margin:0 auto;
}

.grid-item {
 /*  background-color: rgba(255, 255, 255, 0.8); */
 /*  text-align: center; */
  padding: 20px;
  font-size: 20px;
/*   border: 3px solid red; */
}

.item1 {
  
  text-align: center; 
  grid-column: 1; /* grid-column: 오른쪽에서 부터 순서 / grid-row: 열의 순서  /span: 컬럼 합친 갯수*/
  grid-row: 1 / span 2;
}
.item2 {
  grid-column: 2 / span 2;
  grid-row: 1 / span 2;
}

/* .item3{
  grid-column: 2 / span 2;
  grid-row: 2 ;
} */
/* .item5 {
 text-align: center;
  grid-column: 1 / span 3;
  grid-row: 3;
} */


.avatar2 {
    vertical-align: middle;
    width: 200px;
    height: 200px; 
    border-radius: 70%; 
    border: 3px solid gold;
}

 .abc {
      /*  border: 3px solid gold;  */
      padding-left:40%;
     padding-right:35%;   
}

/* 
.tablink {
     background-color: #555; 
    color: white;
    float: left;
     border: none; 
    outline: none;
    cursor: pointer;
     padding: 10px 16px; 
    font-size: 15px;
     width: 100%; 
}  */

.tab-content{
  padding-left:10%;
  padding-right:10%;
}

.activity {
    border-bottom: 1px solid #e2e4e6;
    margin-left: 40px;
    min-height: 32px;
    padding: 12px 0;
    position: relative;
   
}

.attach1{
  position: absolute;

   /*  top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); */
  /*    background: rgba(0,0,0,.5);
    bottom: 0;
    color: #fff;
    display: none;
    height: 40px;
    line-height: 30px;
    right: 0;
    width: 100%;
    z-index: 3; */
}  



</style>

<script>
/* function changeImg(){
	alert("클릭하셨습니다.");
}
 */

</script>



<div class="grid-container" style="border: 0px solid black; margin_bottom: 100px;">
  <div class="grid-item item1"> <!--grid-item  -->
     <div class="avatar2" style="border: 3px solid black;"> <!-- 이미지가 있을 div 공간을 동그랗게 만드는 방법 -->
        <img src="<%= request.getContextPath() %>/resources/img/Spain.png" alt="Avatar2"  class="avatar2">
      이미지를 라운드 크기로 만드는 방법 
        <img src="<%= request.getContextPath() %>/resources/img/Spain.png" alt="Avatar" class="avatar">
       <div class="attach1" style="3px solid red; " >
       <a type="file" onclick="changeImg();" ><span > 사진첨부하세요</span></a> 
       </div>
      </div> 
  </div>
  <div class="grid-item item2">
    <input type="hidden" value="${sessionScope.loginuser.userid}" />
    
     이  름 : ${sessionScope.loginuser.name}</br></br>
     이메일 : ${sessionScope.loginuser.email}</br></br>
     닉네임 : ${sessionScope.loginuser.nickname}</br></br>
          
  </div> 
  <div>
  </div>
 </div>  

<!-- 
<h2 style="text-align:center">User Profile Card</h2>

<div class="card">
  <img src="/w3images/team2.jpg" alt="John" style="width:100%">
  <h1>John Doe</h1>
  <p class="title">CEO & Founder, Example</p>
  <p>Harvard University</p>
  <div style="margin: 24px 0;">
    <a href="#"><i class="fa fa-dribbble"></i></a> 
    <a href="#"><i class="fa fa-twitter"></i></a>  
    <a href="#"><i class="fa fa-linkedin"></i></a>  
    <a href="#"><i class="fa fa-facebook"></i></a> 
 </div>
 <p><button>Contact</button></p>
</div> -->
  


 


     --%>