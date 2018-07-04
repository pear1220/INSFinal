<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript">
 	$(document).ready(function(){
 	//	console.log("홈페이지 로딩되었습니다.");
		 
	 	 $("#btnLogin").click(function(){
	 	 	goLogin(event); 
		}); // end of $("#btnLogin").click
		 
		$("#pwd").keydown(function(event){
			if(event.keyCode == 13){ //keyCode == 13이 엔터
				goLogin(event);	
			}	 
		}); // end of $("#pwd").keydown 
	

	//	$("#team-visible").hide();
		$(".dropdown-toggle").dropdown();
		
		$(".dropdown-menu li a").click(function(){
			  var selText = $(this).text();
			  console.log("select값 확인: " + selText);
			  $(this).parents('.btn-group').find('.dropdown-toggle').html(selText+' <span class="caret"></span>');
			});

	}); // end of $(document).ready()---------------------------	 

	
	 function goLogin(event){  //로그인처리 함수
		if(${sessionScope.loginuser != null}){ //이미 로그인 된 상태라면
    		alert("이미 로그인 된 상태입니다.");
    		$("#userid").val("");
    		$("#pwd").val("");
    		$("#userid").focus();
    		event.preventDefault(); //event 발생을 막는다.
    		return;
    	}
		
    	var userid = $("#userid").val();
    	var pwd = $("#pwd").val(); 
    //	console.log("userid확인용: " + $("#userid").val() + " / pwd확인용: " + $("#pwd").val());
    	
    	if(userid.trim() == ""){
			alert("아이디를 올바르게 입력해주세요!");
    		$("#userid").val("");
    		$("#userid").focus();
    		event.preventDefault(); 
    		return;
    	}
    	
    	if(pwd.trim() == ""){
    		alert("암호를 올바르게 입력해주세요!");
    		$("#pwd").val("");
    		$("#pwd").focus();
    		event.preventDefault(); 
    		return;
    	}
    	
    	//로그인하지 않은 상태이고, 아이디와 암호를 올바르게 입력한 경우
    	var frm = document.loginFrm;
    	<%-- frm.action = "<%=request.getContextPath()%>/loginEnd.action"; --%>
     	frm.action = "loginEnd.action"; 
    	frm.method = "POST";
    	frm.submit();
	} // end of goLogin
	
	
	function goSignup(){ //회원가입처리함수
		location.href=$("#myModal2")
	} // end of goSignup

     function openNav() {
   	    document.getElementById("mySidenav").style.width = "300px";
   	   
   	}

    
   	function closeNav() {
   	    document.getElementById("mySidenav").style.width = "0";
   	}
      
</script>

<style type="text/css">
.myModal{
  width: 200px;
	position: relative;
	margin: auto;
	/* right: 0;
	left: 0; */
    bottom: 20px;
	z-index: 9999;
}
 .modal-content.modal-fullsize {
  height: auto;
  min-height: 100%;
  border-radius: 0; 
}



</style>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="Creative - Bootstrap 3 Responsive Admin Template">
  <meta name="author" content="GeeksLabs">
  <meta name="keyword" content="Creative, Dashboard, Admin, Template, Theme, Bootstrap, Responsive, Retina, Minimal">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="shortcut icon" href="img/favicon.png">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>  

	 	
<body class="login-img3-body">

  <div class="container">
	
		
    <form class="login-form" name="loginFrm">
      <c:if test="${sessionScope.loginuser == null}">
      <div style="padding: auto; margin: auto;" class="login-wrap">
        <p class="login-img"><i class="icon_lock_alt"></i></p>
        <div class="input-group">
          <span class="input-group-addon"><i class="icon_profile"></i></span>
          <input type="text" name="userid" id="userid" class="form-control" placeholder="Username" autofocus>
        </div>
        <div class="input-group">
          <span class="input-group-addon"><i class="icon_key_alt"></i></span>
          <input type="password" name="pwd" id="pwd" class="form-control" placeholder="Password">
        </div>
        <label class="checkbox">
                <input type="checkbox" value="remember-me"> Remember me
                <span class="pull-right"> <a href="#"> Forgot Password?</a></span>
            </label>
        <button class="btn btn-primary btn-lg btn-block" type="button" id="btnLogin">Login</button> 
        <!-- <button class="btn btn-info btn-lg btn-block" type="button" onClick="goSignup();">Sign up</button> -->
        <button type="button" class="btn btn-info btn-lg btn-block" data-toggle="modal" data-target="#myModal2">Sign up</button>

      </div>
      </c:if>
      <c:if test="${sessionScope.loginuser != null}">
      	<div style="padding-top: 15px; padding-bottom: 10px;">
      		<p>${sessionScope.loginuser.name} 님 로그인을 환영합니다!</p>
      	</div>
      	<button class="btn btn-info btn-lg btn-block" type="button" onClick="location.href='<%=request.getContextPath()%>/logout.action'">Logout</button>
      </c:if>
    </form>
    
    <div class="text-right">
      <div style="text-align: center; color: gray; margin-top: 10px;">
       <c:if test="${sessionScope.loginuser != null}">
      	<a data-toggle="modal" href="#myModal" style="font-size: 14pt; color: white; font-weight: bold;">Create Project...</a>
      	</c:if>
      </div>
      <div class="credits">
          Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
      <!--  class="closebtn"  -->
	 <div id="mySidenav" class="sidenav">
		  <a href="javascript:void(0)"onclick="closeNav();"><span style="color: white;">&times;</span></a>
		  <a href="#">About</a>
		  <a href="#">Services</a>
		  <a href="#">Clients</a>
		  <a href="#">Contact</a>
	  </div>
	  <span style="font-size:30px;cursor:pointer" onclick="openNav();">&#9776; open</span> 
    </div>

<!-- 프로젝트 생성 Modal -->
  <div class="modal fade" id="myModal" role="dialog" style="padding-right: 50%; border: 0px solid yellow; margin-right: 50%;" >
    <div class="modal-dialog modal-lg" >
      <div class="modal-content" style="padding-right: 50%; border: 0px solid yellow;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Create New Project!!</h4>
        </div>
        <div class="modal-body">
		  
		  <form action="/output/" name="loginFrm" method="post">
		  <div class="form-group">
		      <label for="usr">Project title:</label>
		      <!-- 프로젝트 타이틀 -->
		      <input type="text" class="form-control" id="project_name" name="project_name">
		    </div>
    	  	<div class="input-prepend input-append">
	        	<!-- 팀 선택 -->
	        	<div class="btn-group">
		            <button class="btn btn-default dropdown-toggle" name="recordinput" data-toggle="dropdown">select Team
		            <span class="caret"></span>
		            </button>
		            <ul class="dropdown-menu"><!-- 팀멤버테이블에서 유저아이디로 팀리스트select해온다 -->
		                  <li><a href="#">A</a></li>
		                  <li><a href="#">CNAME</a></li>
		            </ul>
	        	</div>
	        	
	        	<!-- 팀 노출도 선택 / ajax처리 -->
	        	<div class="btn-group" id="team-visible">
		            <button class="btn btn-default dropdown-toggle" name="recordinput" data-toggle="dropdown">Team Visible
		            <span class="caret"></span>
		            </button>
		            <ul class="dropdown-menu"><!-- 팀멤버테이블에서 유저아이디로 팀리스트select해온다 -->
		                  <li><a href="#">Private</a></li>
		                  <li><a href="#">Public</a></li>
		            </ul>
	        	</div>
	        	
   			</div>
		 </form>
        </div>
        
        <!-- modal footer -->
         <div class="modal-footer">
          <button type="button" class="btn btn-default" id="btn-create">create</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
        </div> 
      </div>
    </div>
  </div>
  
  <!-- ----------------------------------------------------------------------------------- -->
<!-- 회원가입 Modal -->
  <div class="modal fade" id="myModal2" role="dialog" style="padding-right: 50%; border: 0px solid yellow; margin-right: 50%;" >
    <div class="modal-dialog modal-lg" >
      <div class="modal-content" style="padding-right: 50%; border: 0px solid yellow;">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Join Us!!</h4>
        </div>
        <div class="modal-body">
		  <!-- <form action="/output/" name="registFrm" method="post">
		  <div class="form-group">
		      <label for="usr">userid: </label>
		      <input type="text" class="form-control" id="" name="userid">
		      <label for="usr">pwd: </label>
		      <input type="text" class="form-control" id="" name="pwd">
		      <label for="usr">name: </label>
		      <input type="text" class="form-control" id="" name="name">
		      <label for="usr">nickname: </label>
		      <input type="text" class="form-control" id="" name="nickname">
		    </div>
    	  	<div class="input-prepend input-append">
	        	팀 선택
	        	tel: 
	        	<div class="btn-group">
	        		
		            <button class="btn btn-default dropdown-toggle" name="recordinput" data-toggle="dropdown">select
		            <span class="caret"></span>
		            </button>
		            <ul class="dropdown-menu">팀멤버테이블에서 유저아이디로 팀리스트select해온다
		                  <li><a href="#">010</a></li>
		                  <li><a href="#">011</a></li>
		                  <li><a href="#">017</a></li>
		                  <li><a href="#">016</a></li>
		                  <li><a href="#">070</a></li>
		            </ul>
		            <input type="text" style="width: 25%; padding-left: 20px; padding-right: 20px;" class="form-control" id="" name="">
		            <input type="text" style="width: 25%;" class="form-control" id="" name="">
	        	</div>
   			</div>
		 </form> -->
		 <!-- edit-profile -->
                  <div  id="edit-profile" class="tab-pane">
                    <section class="panel">
                      <div class="panel-body bio-graph-info" style="padding-top: 10%; margin-top: 10%;">
                        <h1> Insert Your Info</h1>
                        <form class="form-horizontal" role="form">
                          <div class="form-group">
                            <label class="col-lg-2 control-label">userid</label>
                            <div class="col-lg-6">
                              <input type="text" class="form-control" id="f-name" placeholder=" ">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">password</label>
                            <div class="col-lg-6">
                              <input type="password" class="form-control" id="l-name" placeholder=" ">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">name</label>
                            <div class="col-lg-6">
                              <input type="text" class="form-control" id="b-day" placeholder=" ">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">nickname</label>
                            <div class="col-lg-6">
                              <input type="text" class="form-control" id="email" placeholder=" ">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">Mobile</label>
                            <div class="col-lg-6">
                              <input type="text" class="form-control" id="mobile" placeholder=" ">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">job</label>
                            <div class="col-lg-6">
                              <select class="selectpicker" data-width="fit" data-height="100px">
								 <option>Mustard</option>
								 <option>Ketchup</option>
								 <option>Relishghggggggggggggggggggg</option>
							  </select>

                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">birthday</label>
                            <div class="col-lg-6">
                              <input type="text" class="form-control" id="birthday" placeholder=" ">
                            </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label">image</label>
                            <div class="col-lg-6">
                              <input type="text" class="form-control" id="image" placeholder=" ">
                            </div>
                          </div>
                        </form>
                      </div>
                    </section>
                  </div>
        </div>
        <!-- modal footer -->
         <div class="modal-footer">
          <button type="button" class="btn btn-default" id="btn-create">save</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
        </div> 
      </div>
    </div>
  </div>
</body>

</html>
