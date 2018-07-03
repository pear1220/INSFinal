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
		
		$("#btn-cancel").click(function(){
			$('#myModal').modal('hide');
		});

	}); // end of $(document).ready()---------------------------	 

	
	 function goLogin(event){  
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
	position: absolute;
	margin: 0 auto;
	right: 0;
	left: 0;
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
       <!--  <button class="btn btn-primary btn-lg btn-block" type="button" onClick="goLogin()">Login</button> -->
        <button class="btn btn-info btn-lg btn-block" type="button" onClick="goSignup();">Signup</button>
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
          <!-- <p>This is a large modal.</p> -->
          <form>
		    <div class="form-group">
		      <label for="usr">Project title:</label>
		      <input type="text" class="form-control" id="project_name" name="project_name">
		    </div>
		    <div class="dropdown" style="margin-bottom: 10px;">
			    <button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">Team
			    <span class="caret"></span></button>
				    <ul class="dropdown-menu">
				      <li><a href="#">HTML</a></li>
				      <li><a href="#">CSS</a></li>
				      <li><a href="#">JavaScript</a></li>
				    </ul>
			</div>
		  </form>
        </div>
         <div class="modal-footer">
          <button type="button" class="btn btn-default" id="btn-create">create</button>
          <button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
        </div> 
      </div>
    </div>
  </div>

</body>

</html>
