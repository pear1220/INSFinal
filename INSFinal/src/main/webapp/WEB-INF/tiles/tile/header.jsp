<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">



<style type="text/css">

	.teamname {
		font-size: 15pt;
		font-weight: bold;     
	}

</style>





<%  
	//==== #177. (웹채팅관련9) ====//
    // === 서버 IP 주소 알아오기 === //
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress(); 
	int portnumber = request.getServerPort();
	
	String serverName = "http://"+serverIP+":"+portnumber;

%>

<script type="text/javascript">

	

	$(document).ready(function(){
		
		 $("#menu1").click(function(){
			
			 teamlistButton();
			
		}); 
		
		
	});

	function teamlistButton(){
		
		$("#dropdown").empty();
		
		$.ajax({
			url: "<%= request.getContextPath()%>/teamlist.action",
			type: "get",
			dataType: "json",
			success: function(json){
				
				var html = "";
				
				if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
												
						html += "<li><span style='padding-left: 10px; color: yellow;'><a href='#'>"+entry.team_name+"<span style='float: right; padding-right: 10px;'>"+entry.admin_userid+"</span></a></span></li>";
															
						html += "<li id='teamlist"+entryIndex+"'></li>";
					
						var form_data = {"fk_team_idx": entry.team_idx}
						
						$.ajax({
							
							url: "<%= request.getContextPath() %>/projectlist.action",
							type: "get",
							data: form_data,
							dataType: "json",
							success: function(json){
								
								var html2 = "";
								
								if(json.length > 0){
														
									$.each(json, function(entryIndex2, entry){
																				
										html2 += "<ul><li><span style='color: blue;'>"+entry.project_name+"</span></li></ul>";
																				
										$("#teamlist"+entryIndex).html(html2);
									});
										
								}
								else{
									html2 += "<li><span style='color: black;'>등록된 프로젝트가 없습니다.</span></li>";
									
									$("#teamlist"+entryIndex).html(html2);
								}
								
							},
							error: function(request, status, error){
								alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
							}
							
							
							
						}); // end of ajax({}) ----------------------------------------
						
						html += "<li class='divider'></li>";
												
					});
									
				}
				else{
					
					html += "<li><span style='color: #ff9900; padding-left: 20%;'>가입한 팀이 없습니다.</span></li>";
					$("#dropdown").html(html);
				}
								
				$("#dropdown").html(html);		
				$(".dropdown").show(html);
				
				
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
			}
			
		});
		
		
	}
	

 
</script>


<body>
  <!-- container section start -->
  <section id="container" class="">
  
 <c:if test="${sessionScope.loginuser == null }"> 
	 <header class="header dark-bg">

	  
	  <div style="padding-left: 50%; border: 0px solid red;">   
	  <!-- logo start -->
      <a href="index.action" class="logo" style="font-size: 20pt;"> FINAL <span class="lite">INS</span></a>
      <!-- logo end -->	 
	  </div> 
	    
    </header>
 </c:if> 
  

 <c:if test="${sessionScope.loginuser != null }"> 

    <header class="header dark-bg">      
     
	   <div class="container" style="border: 0px solid yellow; width: 150px; float: left;  padding-top: 2px; margin-bottom: ">                                  
		  <div class="dropdown" style="border: 0px solid yellow;">
		  	 	  	 
		     <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown" style=" background-color: black; margin-top:1px; color: black; border-color: black;"> 
	    	 	<span class="icon_cloud-upload_alt logo" style="margin-right: 10px; font-size: 20pt; color: #ffc61a;"></span><span style="font-size: 16pt;" class="lite">Project</span>
	   		 </button>  
	   		    
		     <ul class="dropdown-menu" id="dropdown" style="width: 300px;">
		     
		     </ul> 
		     
		  </div>
	    </div>      
	  
	  	<%-- <c:if test="${sessionScope.teamList == null }" >
		    		<li><span style="color: #ff9900;">${sessionScope.loginuser.userid} 님의 가입한 팀이 없습니다.</span></li>
		    	</c:if>
		    	
		    	<c:if test="${not empty sessionScope.teamList}"> 
			    	<c:forEach var="teamvo" items="${sessionScope.teamList}"> 
				      
				      <li><span style="padding-left: 10px; color: yellow;"><a href="#">${teamvo.team_name}<span style="float: right; padding-right: 10px;">${teamvo.admin_userid}</span> </a></span></li>
				      
				      <c:if test="${sessionScope.projectList == null }">
				      	 <li><span style="color: yellow;">${teamvo.team_name}에  프로젝트가 없습니다.</span></li>		      
				      </c:if>
				      
				      <c:if test="${sessionScope.projectList != null && (teamvo.team_idx).equals(session.projectList.fk_team_idx)}">
				      		<c:forEach var="projectvo" items="${sessionScope.projectList}">
				      			<li>&nbsp;&deg;${projectvo.project_name}</li>
				      		</c:forEach>
				      </c:if>
				      
				      <li class="divider"></li>
				      		      
			      	</c:forEach>
		      	</c:if> --%>
	  
	  
	       
	    
	  <!--  search form start -->
      <div class="nav search-row" id="top_menu" style="float: left; padding-top: 1px; padding-left: 1px; padding-bottom: 2px; width: 500px; border: 0px solid yellow; ">
        <!--  search form start -->
        <ul class="nav top-menu">
          <li>
            <form class="navbar-form">
              <input class="form-control" placeholder="Search" type="text" style="height: 40px;"> 
            </form>
          </li>
        </ul> 
        <!--  search form end -->
      </div>
	  
	  <div style="padding-left: 50%;">  
	  <!--logo start--> 
      <a href="index.action" class="logo"> FINAL <span class="lite">INS</span></a>
      <!--logo end-->
      <a href="mj_project.action" class="logo">mj_project</a>	 
	  </div>	
		
	  <div class="top-nav notification-row">
	
        <!-- notificatoin dropdown start-->
        <ul class="nav pull-right top-menu">
	
	      <!-- inbox notificatoin start-->
          <li id="mail_notificatoin_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <i class="icon-envelope-l"></i>
                            <!-- <span class="badge bg-important">5</span> -->
                        </a>
            <ul class="dropdown-menu extended inbox">
              <div class="notify-arrow notify-arrow-blue"></div>
              <li>
                <p class="blue">You have 5 new messages</p>
              </li>
              <li>
                <a href="#">
                                    <span class="photo"><img alt="avatar" src="./img/avatar-mini.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Greg  Martin</span>
                                    <span class="time">1 min</span>
                                    </span>
                                    <span class="message">
                                        I really like this admin panel.
                                    </span>
                                </a>
              </li>
              <li>
                <a href="#">
                                    <span class="photo"><img alt="avatar" src="./img/avatar-mini2.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Bob   Mckenzie</span>
                                    <span class="time">5 mins</span>
                                    </span>
                                    <span class="message">
                                     Hi, What is next project plan?
                                    </span>
                                </a>
              </li>
              <li>
                <a href="#">
                                    <span class="photo"><img alt="avatar" src="./img/avatar-mini3.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Phillip   Park</span>
                                    <span class="time">2 hrs</span>
                                    </span>
                                    <span class="message">
                                        I am like to buy this Admin Template.
                                    </span>
                                </a>
              </li>
              <li>
                <a href="#">
                                    <span class="photo"><img alt="avatar" src="./img/avatar-mini4.jpg"></span>
                                    <span class="subject">
                                    <span class="from">Ray   Munoz</span>
                                    <span class="time">1 day</span>
                                    </span>
                                    <span class="message">
                                        Icon fonts are great.
                                    </span>
                                </a>
              </li>
              <li>
                <a href="#">See all messages</a>
              </li>
            </ul>
          </li>
          <!-- inbox notificatoin end -->
          
          
          
          <!-- alert notification start-->
          <li id="alert_notificatoin_bar" class="dropdown">
   <!--           <div class="dropdown" style="width: 5%; padding-left:0.2px; padding-top: 7px; float: left;">
	             <a data-toggle="dropdown" class="dropdown-toggle" id="menu1" href="#">           
	                                         
	                            <i class="icon-bell-l"></i>         
	                            <span class="badge bg-important" style="margin-left: 30pt;">7</span>
	             </a>			 
	                   
		         <ul class="dropdown-menu extended notification" >     
				    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown" style=" background-color: black; margin-top:1px; color: black; border-color: black;"> 
				    	<span class="icon_cloud-upload_alt logo" style="margin-right: 10px; font-size: 20pt; color: #ffc61a;"></span><span style="font-size: 16pt;" class="lite">Project</span>
				    <span class="caret"></span></button>
				    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1" style="width: 500px;">
				      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">프로젝트이름</a></li>
				      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">CSS</a></li>
				      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">JavaScript</a></li>
				      <li role="presentation" class="divider"></li> 
				      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">About Us</a></li>
				 	</ul>
				 </ul>
			 
	 		</div>  -->
	 		
	 			   <div class="dropdown" style="width: 5%; padding-left:0.2px; padding-top: 7px; float: left; border: 0px solid yellow;"> 
	 			   	     
					    <!-- <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown" style=" background-color: black; margin-top:1px; color: black; border-color: black;"> 
					    	<span class="icon_cloud-upload_alt logo" style="margin-right: 10px; font-size: 20pt; color: #ffc61a;"></span><span style="font-size: 16pt;" class="lite">Project</span>
					    <span class="caret"></span></button> -->
					    
					    <a data-toggle="dropdown" class="dropdown-toggle" id="menu1" href="#">               
	                                         
	                            <i class="icon-bell-l"></i>         
	                            <!-- <span class="badge bg-important" style="margin-left: 30pt;">7</span> -->
	             		</a>	
					       <div class="dropdown" style="border: 1px solid yellow; ">                        
							    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1" style="width: 500px;">
							      <c:forEach var="team" items="${teamList}">
							      	<li role="presentation"><a role="menuitem" tabindex="-1">${team}</a></li>
							      		<%-- <c:forEach items="">
							      			<c:if test="${team != null}">
							      				&nbsp;<li role="presentation"><a role="menuitem" tabindex="-1" href="#">project name</a></li>
							      			</c:if test="${team == null}">
							      			<c:if test="">
							      				&nbsp;<li role="presentation"><a role="menuitem" tabindex="-1">no project</a></li>
							      			</c:if>
							      		</c:forEach> --%>
							      </c:forEach>						      
							    </ul>
					   		</div>
					</div> 
	 		
          </li>                       
          <!-- alert notification end-->     
         
          <!-- user login dropdown start-->         
          <li class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="profile-ava">
                                <img alt="" src="img/avatar1_small.jpg">
                            </span>
                            <span class="username">${sessionScope.loginuser.userid}</span> 
                            <b class="caret"></b>
            </a>
            <ul class="dropdown-menu extended logout">
              <div class="log-arrow-up"></div>
              <li class="eborder-top">
                <a href="#"><i class="icon_profile"></i> My Profile</a>
              </li>
              <li>
                <a href="login.html"><i class="icon_key_alt"></i> Log Out</a>
              </li>
            </ul>
          </li> 
          
          <li>
          <img src="<%=request.getContextPath() %>/resources/img/avatar1.jpg" alt="Avatar" class="avatar" />
          </li>
          <!-- user login dropdown end -->
                    <!-- task notificatoin start -->
<!--           <li id="task_notificatoin_bar" class="dropdown">
            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <i class="icon-task-l"></i>
                            <span class="badge bg-important">6</span>
            </a>
            <ul class="dropdown-menu extended tasks-bar">
              <div class="notify-arrow notify-arrow-blue"></div>
              <li>
                <p class="blue">You have 6 pending letter</p>
              </li>
              <li>
                <a href="#">
                  <div class="task-info">
                    <div class="desc">Design PSD </div>
                    <div class="percent">90%</div>
                  </div>
                  <div class="progress progress-striped">
                    <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width: 90%">
                      <span class="sr-only">90% Complete (success)</span>
                    </div>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="task-info">
                    <div class="desc">
                      Project 1
                    </div>
                    <div class="percent">30%</div>
                  </div>
                  <div class="progress progress-striped">
                    <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width: 30%">
                      <span class="sr-only">30% Complete (warning)</span>
                    </div>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="task-info">
                    <div class="desc">Digital Marketing</div>
                    <div class="percent">80%</div>
                  </div>
                  <div class="progress progress-striped">
                    <div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">
                      <span class="sr-only">80% Complete</span>
                    </div>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="task-info">
                    <div class="desc">Logo Designing</div>
                    <div class="percent">78%</div>
                  </div>
                  <div class="progress progress-striped">
                    <div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="78" aria-valuemin="0" aria-valuemax="100" style="width: 78%">
                      <span class="sr-only">78% Complete (danger)</span>
                    </div>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="task-info">
                    <div class="desc">Mobile App</div>
                    <div class="percent">50%</div>
                  </div>
                  <div class="progress progress-striped active">
                    <div class="progress-bar" role="progressbar" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100" style="width: 50%">
                      <span class="sr-only">50% Complete</span>
                    </div>
                  </div>

                </a>
              </li>
              <li class="external">
                <a href="#">See All Tasks</a>
              </li>
            </ul>
          </li> -->
          <!-- task notificatoin end -->
          
        </ul>
        <!-- notificatoin dropdown end-->
      </div>
    </header>
    </c:if>  
    <!--header end-->
	