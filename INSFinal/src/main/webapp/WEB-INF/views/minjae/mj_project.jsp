<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>project</title>

<style type="text/css">
 body {
	    font-family: "Lato", sans-serif;
	}
	
	.sidenav {
	    height: 100%;
	    width: 0;
	    position: fixed;
	    z-index: 2; 
	    top: 0;
	    left: 0;
	    background-color: #111;
	    overflow-x: hidden;
	    transition: 0.5s;
	    padding-top: 100px;
	}
	
	.sidenav span {
	    padding: 8px 8px 8px 32px;
	    text-decoration: none;
	    font-size: 25px;
	    color: #818181;
	    display: block;
	    transition: 0.3s;
	    /* cursor: pointer; */
	}
	
	.sidenav span:hover {
	    color: #f1f1f1;
	}
	
	.sidenav .closebtn {
	    position: absolute;
	    top: 0;
	    right: 25px;
	    font-size: 36px;
	    margin-left: 50px;
	}
	
	@media screen and (max-height: 450px) {
	  .sidenav {padding-top: 15px;}
	  .sidenav a {font-size: 15px;} 
	}
	


</style>

</head>



<script type="text/javascript">
	
	function openNav() {
	
	    document.getElementById("mySidenav").style.width = "400px";
	    
	<%-- 	var sel1 = $("#sel1").val();
		
		var frm = document.project_idxFrm;
		/* frm.fk_project_idx.value = "3";  */
		frm.sel1Val.value = sel1;
		frm.method = "get";
		frm.action = "<%=request.getContextPath() %>/projectRecordView.action";
		frm.submit(); --%>
	   
	}

	function openNav2() {
	    document.getElementById("mySidesearch").style.width = "400px";
	    document.getElementById("mySidenav").style.width = "0";
	}
	
	
	function closeNav() {
	    document.getElementById("mySidenav").style.width = "0";
	    document.getElementById("mySidesearch").style.width = "0";
	}

	function closeNav2() {
	    document.getElementById("mySidesearch").style.width = "0";
	    document.getElementById("mySidenav").style.width = "400px";
	}

	
	function leaveProject(){
		
		var fk_project_idx = "31";
		
		var frm = document.project_idxFrm;
		frm.fk_project_idx.value = fk_project_idx;// input 의 value 값에 fk_projcet_idx를 받아 입력해야 한다.
				
		frm.method = "GET";
		frm.action = "<%= request.getContextPath() %>/leaveProject.action";
		frm.submit();
		
	}

	
	function deleteProject(){
		
		var fk_project_idx = "31";
		
		var frm = document.project_idxFrm;
		frm.fk_project_idx.value = fk_project_idx;// input 의 value 값에 fk_projcet_idx를 받아 입력해야 한다.
				
		frm.method = "GET";
		frm.action = "<%= request.getContextPath() %>/deleteProject.action";
		frm.submit();
		
	}
	
 	/* $(document).ready(function(){
		
	}); 
	 */
	
		
		<%-- var sel1 = $("#sel1").val();
		
		var frm = document.project_idxFrm;
		frm.fk_project_idx.value = "3";
		frm.sel1Val.value = sel1;
		frm.method = "get";
		frm.action = "<%=request.getContextPath() %>/projectRecordView.action";
		// frm.submit(); --%>
		
		
		<%-- var frm = document.sel1Frm;
		
		frm.action = "<%= request.getContextPath() %>/sel1.action";
		frm.method = "get"; --%>
	
	function Activity(){
	
		var form_data = {fk_project_idx: "3",/* $("#fk_project_idx").val() */
				         sel1Val: $("#sel1").val()}
		
		$.ajax({
			
			url: "projectRecordView.action",
			type: "get",
			data: form_data,
			dataType: "json",
			success: function(json){
				
				var html = "";
				
				$.each(json, function(entryIndex, entry){
					
					html += "<tr>";
    				html += "<td colspan='3'><img src='<%=request.getContextPath()%>/resources/img/avatar1.jpg'
						  alt="Avatar" class="avatar" /><%-- ${map.org_filename} --%></td>
</tr>
<tr>
	<td>${map.userid}&nbsp;&nbsp;${map.project_record_time} </td>
	<td>${map.record_dml_status}</td>
	<td>${map.card_title} in ${map.list_name}</td>
</tr>
					
				});
				
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
		    }
			
		});
		
	}
	
</script>





<body>
	 <div id="mySidenav" class="sidenav">
	 	  <span style="font-size: 40pt; font-weight: bold;" onclick="Activity();">&#9776; menu</span>
	 	  <a href="javascript:void(0)"onclick="closeNav();"><span style="padding-left: 80%; ">&times;</span></a>
	 	  <span style="cursor:pointer" onclick="openNav2();">Search in PROJECT</span> 
		  <span style=" cursor: pointer;" onclick="location.href='<%= request.getContextPath()%>/leaveProject.action'" onclick="leaveProject();">Leave PROJECT</span> 
		  
		  
		  <span style="cursor: pointer;" onclick="location.href='<%= request.getContextPath() %>/deleteProject.action'" onclick="deleteProject();" >Delete PROJECT</span>
		 
		  <hr style="border: solid 1px gray; background-color: gray;"> 
		  <!-- <span>Activity</span> -->
		    <div class="form-group" style="padding-left:18pt; padding-top: 10pt; width: 120px; border: 0px solid yellow;">
		      <select class="form-control" id="sel1" name="sel1" onclick="sel1();">    
		        <option selected value="수정">CARD EDIT</option>
		        <option value="삭제">CARD DELETE</option>
		        <option value="추가">CARD ADD</option>
		        <option value="생성">LIST CREATE</option>
		      </select>
		    </div>           
		  
		  <div class="container" style="background-color: white;">
			  <h2>Activity</h2>           
			  <table class="table">
			    
			    	<c:if test="${projectRecordList != null  || projectRecordList.size() > 0 }"></c:if>
				    	<c:forEach var="map" items="${projectRecordList}">
					    	<c:if test="${sel1Val == '수정'}">
					    		
					    			<tr>
					    				<td colspan="3"><img src="<%=request.getContextPath()%>/resources/img/avatar1.jpg"
															  alt="Avatar" class="avatar" /><%-- ${map.org_filename} --%></td>
					    			</tr>
					    			<tr>
					    				<td>${map.userid}&nbsp;&nbsp;${map.project_record_time} </td>
					    				<td>${map.record_dml_status}</td>
					    				<td>${map.card_title} in ${map.list_name}</td>
					    			</tr>
				    			
				    		</c:if>
			    		</c:forEach>
				    		<%-- <c:if test="${sel1Val == '수정'}">
					    		<td>${map.org_filename}</td>
					    		<td>${map.userid}</td>
					    		<td>${map.project_record_idx}</td>
					    		<td>${map.fk_project_idx}</td>
					    		<td>${map.project_record_time}</td>
					    		<td>${map.fk_list_idx}</td>
					    		<td>${map.list_name}</td>
					    		<td>${map.fk_card_idx}</td>
					    		<td>${map.card_title}</td>
					    		<td>${map.record_dml_status}</td>
				    		</c:if>
				    		<c:if test="${sel1Val == '수정'}">
					    		<td>${map.org_filename}</td>
					    		<td>${map.userid}</td>
					    		<td>${map.project_record_idx}</td>
					    		<td>${map.fk_project_idx}</td>
					    		<td>${map.project_record_time}</td>
					    		<td>${map.fk_list_idx}</td>
					    		<td>${map.list_name}</td>
					    		<td>${map.fk_card_idx}</td>
					    		<td>${map.card_title}</td>
					    		<td>${map.record_dml_status}</td>
				    		</c:if> --%>
				    		
				    	
				    	
				    	
			    	
			    	<c:if test="${projectRecordList == null }">
			    		<td>프로젝트에서 활동한 기록이 없습니다.</td>
			    	</c:if>
			  </table>
		  </div>
		    
	  </div>
	  
	  
	  <div id="mySidesearch" class="sidenav" style="border: 0px solid yellow;">     
	  	  <span style="font-size: 40pt; font-weight: bold; cursor: pointer; " onclick="closeNav2();">&#9776; menu</span>
		  <a href="javascript:void(0)" onclick="closeNav();"><span style="padding-left: 80%; font-size: 20pt;">&times;</span></a>
		  <span>&nbsp;&nbsp;&nbsp;Search in PROJECT</span>             
		  <div class="container" style="border: 0px solid yellow;" >
			  <form>
			    <div class="form-group" style="padding-left:18pt; padding-top: 10pt; width: 120px; border: 0px solid yellow;">
			      <select class="form-control" id="sel2">    
			        <option selected value="list">LIST</option>
			        <option value="card">CARD</option>
			      </select>
			    </div>             
			  </form>
			  
			  <!--  search form start -->
		      <div class="nav search-row" id="top_menu" style="float: left; width: 300px; border: 0px solid orange;">
		      <form class="navbar-form" style="border: 0px solid yellow;">
		         <input class="form-control" placeholder="Search" type="text" style="float:left; hight: 500px; width: 300px; border: 0px solid yellow;"> 
		      </form>                        
		        <!--  search form start -->
		        <!-- <ul class="nav top-menu"> 
		          <li>
		            
		          </li>
		        </ul>  -->
		        <!--  search form end -->
		      </div>
		  </div>
	  </div>
                           
	  <div style="float: left;">                     
		<br/>
		<span style="font-size:30px; cursor:pointer;" onclick="openNav();">&#9776; menu</span>
	  </div>
	
		
	
	  <form name="project_idxFrm">
	  	<input type="text" name="fk_project_idx" value="31" /><%-- value="${project_membervo.fk_project_idx}" --%>
	  	<input type="text" name="sel1Val" />
	  </form>
	  
	  <%-- <c:forEach items="${adminList}" var="map">
		  	<c:if test="project_member_userid.equals('${sessionScope.loginuser.userid}')">
		  		<span style="cursor: pointer;" onclick="location.href='<%= request.getContextPath() %>/deleteProject.action'" onclick="deleteProject();" >Delete PROJECT</span>
		  		<input type="text" value="집에가고 싶다"/>
		  	</c:if>
		</c:forEach> --%>
	  <form name="sel1Frm">
	  	
	  </form>
	  <input type="text" value="집에가고 싶다22222222"/>
</body>
</html>