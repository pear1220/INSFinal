<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">



<style type="text/css">

#project_dropdown-default:hover{
	background-color: #e6f2ff;
}

.teamname {
	font-size: 15pt;
	font-weight: bold;
}

#drop1 {
	margin-left: 193px;
	width: 500px;
}

#drop2{
	margin-left: 193px;
	width: 500px;
}

input[type=text] {
	width: 130px;
	box-sizing: border-box;
	border: 2px solid #ccc;
	border-radius: 4px;
	font-size: 16px;
	background-color: white;
	background-image: url('searchicon.png');
	background-position: 10px 10px;
	background-repeat: no-repeat;
	padding: 12px 20px 12px 40px;
	-webkit-transition: width 0.4s ease-in-out;
	transition: width 0.4s ease-in-out;
}

input[type=text]:focus {
	width: 100%;
}


#team_name{
	font-family: 'Do Hyeon', sans-serif;
} 

/* #newMsgList{
	width: 300px;
} */

#newMsgList{
   width: 300px;
   overflow-x: hidden;
   overflow-y: auto;
   height: 400px;
}
/* 
.wrap{
	
} */

</style>





<%
	//==== #177. (웹채팅관련9) ====//
	// === 서버 IP 주소 알아오기 === //
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
	int portnumber = request.getServerPort();

	String serverName = "http://" + serverIP + ":" + portnumber;
%>

<script type="text/javascript">

/* $(document).click(function(event){
	 
	  if(!$(event.target).closet(".dropSearch").length){
		  
		  if($('#drop1').is(":visible")){
			  $("#drop1").hide();
		  }
		  else if($('#drop2').is(":visible")){
			  $("#drop2").hide();
		  }
	  }
	  
}); */

	$(document).ready(function(){
		
		 $("#project_button").click(function(){
			
			 teamlistButton();
			
		}); 
		 
		  $("#search_input").keyup(function(){
		
			  if($("#search_input").val().trim() != ""){
				  searchTotal(); 
			  }
			  else if($("#search_input").val().trim() == ""){
				  $("#drop1").hide();
			  }
			 
		   }); // $("#search_input").keyup()-------------------------------------------------------------------
		 
		   /* $("#")
		    */
		  function searchTotal(){
			 
			  dropShow1(); 
			   
			  var form_data = {search_input:$("#search_input").val()}
				 
				 $.ajax({
						
					 url: "<%=request.getContextPath()%>/teamSearch.action",
					 type: "get",
					 data: form_data,
					 dataType: "JSON",
					 success: function(json){
											  
						 var html = "";
						
						 if(json.length > 0){
							 
							 $("#team_drop1").show();  
									
							 html += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Teams</span>";
							 
							 $.each(json, function(entryIndex, entry){
								 												
								 var word = entry.team_name.trim();
								 // "ajax 프로그래밍"
									
								 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
								 
								 
								 var len = $("#search_input").val().length;
															
								 var str ="";
								
									 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
									
								if(json.length < 2){
									
									 html += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
									 
									 $("#team_drop1").html(html);
									
								}	  
								else{
									
									if(entryIndex < 2){
										html += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
										
									}
									
									$("#team_drop1").html(html);
								
								}
												 
							 }); // end of $.each()----------------------------------------------------------------------
							 
							 if(json.length > 2){ 
								 html += "<li><a class='btn btn-default btn-sm' id='btnMore1'>More</a></li>";
							 } 
							 
							 html += "<li class='divider'></li>";
							 
							 
							 $("#team_drop1").html(html);
								 
						 } // json.length > 0 if()-------------------------------------------------------------------------
						 else{
							 
							 $("#team_drop1").hide();
							 
				  		}// json.length > 0 else()--------------------------------------------------------------------------
				 	
				  		
				  		/* $("#drop1").html(html); */
				  		
					  	$("#btnMore1").click(function(){
							 
					  		/* $("#drop2").empty(); */
					  		
					  		 dropShow2();
					  		 
					  		
					  		
							 var html2 = "";
							 
							 html2 += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Teams</span>";
							 html2 += "<span id='backicon'><img src='<%=request.getContextPath() %>/resources/img/left-arrow.png' /></span>";
							 
							 $.each(json, function(entryIndex, entry){
								 				
								 var word = entry.team_name.trim();
								 // "ajax 프로그래밍"
									
								 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
								 
								 
								 var len = $("#search_input").val().length;
															
								 var str ="";
								
									 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
									
									 html2 += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
									 
								 $("#team_drop2").html(html2);
									 		 
							 }); // end of $.each()----------------------------------------------------------------------
							  
							 $("#team_drop2").html(html2);
							 
							
							 $("#backicon").click(function(){
									
									/* alert("확인용:::::::"); */ 
									dropShow1();
										 
							 });
							 
							 
						 }); // end of $("#btnMore").click()---------------------------------------------------------------------------
				 		

						 
						 
					 },
					 error: function(request, status, error){
							alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
					 }
					 						 
				 });  
				 
				 
				 
				 $.ajax({
						
					 url: "<%=request.getContextPath()%>/projectSearch.action",
					 type: "get",
					 data: form_data,
					 dataType: "JSON",
					 success: function(json){
						
						 var html = "";
						
						 if(json.length > 0){
							 
							 $("#project_drop1").show();  
									
							 html += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Projects</span>";
							 
							 $.each(json, function(entryIndex, entry){
								 												
								 var word = entry.project_name.trim();
								 // "ajax 프로그래밍"
									
								 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
								 
								 
								 var len = $("#search_input").val().length;
															
								 var str ="";
								
									 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
									
								if(json.length < 2){
									
									 html += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
									 
									 $("#project_drop1").html(html);
									
								}	  
								else{
									
									if(entryIndex < 2){
										html += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
										
									}
									$("#project_drop1").html(html);
								
								}
												 
							 }); // end of $.each()----------------------------------------------------------------------
							 
							 if(json.length > 2){ 
								 html += "<li><a class='btn btn-default btn-sm' id='btnMore2'>More</a></li>";
							 } 
							 
							 html += "<li class='divider'></li>";
							 
							 
							 $("#project_drop1").html(html);
								 
						 } // json.length > 0 if()-------------------------------------------------------------------------
						 else{
							 
							 $("#project_drop1").hide();
							 
				  		}// json.length > 0 else()--------------------------------------------------------------------------
				 	
				  		
				  		/* $("#drop1").html(html); */
				  		
					  	$("#btnMore2").click(function(){
							 
					  		/* $("#drop2").empty();
					  		 */
					  		 dropShow2();
					  		 
					  		
					  		
							 var html3 = "";
							 
							 html3 += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Projects</span>";
							 html3 += "<span id='backicon'><img src='<%=request.getContextPath() %>/resources/img/left-arrow.png' /></span>";
							 
							 $.each(json, function(entryIndex, entry){
								 				
								 var word = entry.project_name.trim();
								 // "ajax 프로그래밍"
									
								 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
								 
								 
								 var len = $("#search_input").val().length;
															
								 var str ="";
								
									 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
									
									 html3 += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
									 
								 $("#project_drop2").html(html3);
									 		 
							 }); // end of $.each()----------------------------------------------------------------------
							  
							 $("#project_drop2").html(html3);
							 
							
							 $("#backicon").click(function(){
									
									/* alert("확인용:::::::"); */ 
									dropShow1();
										 
							 });
							 
							 
						 }); // end of $("#btnMore").click()---------------------------------------------------------------------------
				 		

						 
						 
					 },
					 error: function(request, status, error){
							alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
					 }
					 						 
				 });  
				 
			 	 $.ajax({
					
				 url: "<%=request.getContextPath()%>/listSearch.action",
				 type: "get",
				 data: form_data,
				 dataType: "JSON",
				 success: function(json){
					
					 var html = "";
					
					 if(json.length > 0){
						 
						 $("#list_drop1").show();  
								
						 html += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Lists</span>";
						 
						 $.each(json, function(entryIndex, entry){
							 												
							 var word = entry.list_name.trim();
							 // "ajax 프로그래밍"
								
							 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
							 
							 
							 var len = $("#search_input").val().length;
														
							 var str ="";
							
								 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
								
							if(json.length < 2){
								
								 html += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
								 
								 $("#list_drop1").html(html);
								
							}	  
							else{
								
								if(entryIndex < 2){
									html += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
									
								}
								$("#list_drop1").html(html);
							
							}
											 
						 }); // end of $.each()----------------------------------------------------------------------
						 
						 if(json.length > 2){ 
							 html += "<li><a class='btn btn-default btn-sm' id='btnMore3'>More</a></li>";
						 } 
						 
						 html += "<li class='divider'></li>";
						 
						 
						 $("#list_drop1").html(html);
							 
					 } // json.length > 0 if()-------------------------------------------------------------------------
					 else{
						 
						 $("#list_drop1").hide();
						 
			  		}// json.length > 0 else()--------------------------------------------------------------------------
			 	
			  		
			  		/* $("#drop1").html(html); */
			  		
				  	$("#btnMore3").click(function(){
						
				  	/* 	$("#drop2").empty();
				  		 */
				  		 dropShow2();
				  		
				  		
				  		 
						 var html4 = "";
						 
						 html4 += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Lists</span>";
						 html4 += "<span id='backicon'><img src='<%=request.getContextPath() %>/resources/img/left-arrow.png' /></span>";
						 
						 $.each(json, function(entryIndex, entry){
							 				
							 var word = entry.list_name.trim();
							 // "ajax 프로그래밍"
								
							 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
							 
							 
							 var len = $("#search_input").val().length;
														
							 var str ="";
							
								 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
								
								 html4 += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
								 
							 $("#list_drop2").html(html4);
								 		 
						 }); // end of $.each()----------------------------------------------------------------------
						  
						 $("#list_drop2").html(html4);
						 
						
						 $("#backicon").click(function(){
								
								/* alert("확인용:::::::"); */ 
								dropShow1();
									 
						 });
						 
						 
					 }); // end of $("#btnMore").click()---------------------------------------------------------------------------
			 		

					 
					 
				 },
				 error: function(request, status, error){
						alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
				 }
				 						 
			 }); 
				 
			
			 $.ajax({
					
				 url: "<%=request.getContextPath()%>/cardSearch.action",
				 type: "get",
				 data: form_data,
				 dataType: "JSON",
				 success: function(json){
					
					 var html = "";
					
					 if(json.length > 0){
						 
						 $("#card_drop1").show();  
								
						 html += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Cards</span>";
						 
						 $.each(json, function(entryIndex, entry){
							 												
							 var word = entry.card_title.trim();
							 // "ajax 프로그래밍"
								
							 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
							 
							 
							 var len = $("#search_input").val().length;
														
							 var str ="";
							
								 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
								
							if(json.length < 2){
								
								 html += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
								 
								 $("#card_drop1").html(html);
								
							}	  
							else{
								
								if(entryIndex < 2){
									html += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
									
								}
								$("#card_drop1").html(html);
							
							}
											 
						 }); // end of $.each()----------------------------------------------------------------------
						 
						 if(json.length > 2){ 
							 html += "<li><a class='btn btn-default btn-sm' id='btnMore4'>More</a></li>";
						 } 
						 
						 html += "<li class='divider'></li>";
						 
						 
						 $("#card_drop1").html(html);
							 
					 } // json.length > 0 if()-------------------------------------------------------------------------
					 else{
						 
						 $("#card_drop1").hide();
						 
			  		}// json.length > 0 else()--------------------------------------------------------------------------
			 	
			  		
			  		/* $("#drop1").html(html); */
			  		
				  	$("#btnMore4").click(function(){
						 
				  	/* 	$("#drop2").empty(); */
				  		
				  		 dropShow2();
				  		 
				  		 
				  		
						 var html5 = "";
						 
						 html2 += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Cards</span>";
						 html2 += "<span id='backicon'><img src='<%=request.getContextPath() %>/resources/img/left-arrow.png' /></span>";
						 
						 $.each(json, function(entryIndex, entry){
							 				
							 var word = entry.card_title.trim();
							 // "ajax 프로그래밍"
								
							 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
							 
							 
							 var len = $("#search_input").val().length;
														
							 var str ="";
							
								 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
								
								 html5 += "<br/><a href='#'><span class='result'>"+str+"</span></a>";
								 
							 $("#card_drop2").html(html5);
								 		 
						 }); // end of $.each()----------------------------------------------------------------------
						  
						 $("#card_drop2").html(html5);
						 
						
						 $("#backicon").click(function(){
								
								/* alert("확인용:::::::"); */ 
								dropShow1();
									 
						 });
						 
						 
					 }); // end of $("#btnMore").click()---------------------------------------------------------------------------
			 		
	 
				 },
				 error: function(request, status, error){
						alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
				 }
				 						 
			 }); 
			 
			 
			 $.ajax({
					
				 url: "<%=request.getContextPath()%>/memberSearch.action",
				 type: "get",
				 data: form_data,
				 dataType: "JSON",
				 success: function(json){
					
					 var html = "";
					
					 if(json.length > 0){
						 
						 $("#member_drop1").show();  
								
						 html += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Members</span>";
						 
						 $.each(json, function(entryIndex, entry){
							 
							 var word = "";
							 
							 if( (entry.userid.trim()).indexOf($("#search_input").val()) != -1 ){
								 word = entry.userid.trim();
							 }
							 else if( (entry.nickname.trim()).indexOf($("#search_input").val()) != -1 ){
								 word = entry.nickname.trim();
							 }
							 else if( (entry.name.trim()).indexOf($("#search_input").val()) != -1 ){
								 word = entry.name.trim();
							 }
							 
							 
							 
							 
							 // "ajax 프로그래밍"
								
							 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
							 
							 
							 var len = $("#search_input").val().length;
														
							 var str ="";
							
								 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
								
							if(json.length < 2){
								
								html += "<br/><img src='<%=request.getContextPath()%>/resources/img/avatar1.jpg' class='avatar'/>";
								
								if( (entry.userid.trim()).indexOf($("#search_input").val()) != -1 ){
									html += "<a href='#'><span class='result'>"+str+"("+entry.nickname+")"+"--"+entry.name+"</span></a>";
								 }
								 else if( (entry.nickname.trim()).indexOf($("#search_input").val()) != -1 ){
									 html += "<a href='#'><span class='result'>"+entry.userid+"("+str+")"+"--"+entry.name+"</span></a>";
								 }
								 else if( (entry.name.trim()).indexOf($("#search_input").val()) != -1 ){
									 html += "<a href='#'><span class='result'>"+entry.userid+"("+entry.nickname+")"+"--"+str+"</span></a>";
								 }
														 
								 $("#member_drop1").html(html); 
								
							}	  
							else{
								
								if(entryIndex < 2){
									
									html += "<br/><img src='<%=request.getContextPath()%>/resources/img/avatar1.jpg' style='float: left;' class='avatar'/>";
									
									if( (entry.userid.trim()).indexOf($("#search_input").val()) != -1 ){
										html += "<a href='#'><span class='result'>"+str+"("+entry.nickname+")"+"--"+entry.name+"</span></a>";
									 }
									 else if( (entry.nickname.trim()).indexOf($("#search_input").val()) != -1 ){
										 html += "<a href='#'><span class='result'>"+entry.userid+"("+str+")"+"--"+entry.name+"</span></a>";
									 }
									 else if( (entry.name.trim()).indexOf($("#search_input").val()) != -1 ){
										 html += "<a href='#'><span class='result'>"+entry.userid+"("+entry.nickname+")"+"--"+str+"</span></a>";
									 }
								}
								
								 $("#member_drop1").html(html);
															
							
							}
							
							
							/* $("#member_drop1").html(html); */
											 
						 }); // end of $.each()----------------------------------------------------------------------
						 
						 if(json.length > 2){ 
							 html += "<li><a class='btn btn-default btn-sm' id='btnMore5'>More</a></li>";
						 } 
						 
						 html += "<li class='divider'></li>";
						 
						 
						 $("#member_drop1").html(html);
							 
					 } // json.length > 0 if()-------------------------------------------------------------------------
					 else{
						 
						 $("#member_drop1").hide();
						 
			  		}// json.length > 0 else()--------------------------------------------------------------------------
			 	
			  		
			  		/* $("#drop1").html(html); */
			  		
				  	$("#btnMore5").click(function(){
						 
				  		/* $("#drop2").empty(); */
				  		
				  		 dropShow2();
				  		
				  		
				  		 
						 var html2 = "";
						 
						 html2 += "<span class='lite' style='font-weight: bold; font-size: 15pt;'>Members</span>";
						 html2 += "<span id='backicon'><img src='<%=request.getContextPath() %>/resources/img/left-arrow.png' /></span>";
						 
						 $.each(json, function(entryIndex, entry){
							 
							 var word = "";
							 
							 if( (entry.userid.trim()).indexOf($("#search_input").val()) != -1 ){
								 word = entry.userid.trim();
							 }
							 else if( (entry.nickname.trim()).indexOf($("#search_input").val()) != -1 ){
								 word = entry.nickname.trim();
							 }
							 else if( (entry.name.trim()).indexOf($("#search_input").val()) != -1 ){
								 word = entry.name.trim();
							 }
								
							 var index = word.toLowerCase().indexOf( $("#search_input").val().toLowerCase() ); // 해당 문자열을 전부 다 소문자로 바꾸는 자바스크립트 함수 (toUpperCase())
							 
							 
							 var len = $("#search_input").val().length;
														
							 var str ="";
							
								 str += "<span class='first' style='color: gray;'>" + word.substr(0,index) + "</span>" + "<span class='second' style='color: #fed189; font-weight: bold;'>" +word.substr(index, len)+"</span>"+"<span class='third' style='color: gray;'>" + word.substr(index+len) + "</span>"; 
								
								 html += "<br/><img src='<%=request.getContextPath()%>/resources/img/avatar1.jpg' style='float: left;' class='avatar'/>";
								 
								 if( (entry.userid.trim()).indexOf($("#search_input").val()) != -1 ){
										html2 += "<a href='#'><span class='result'>"+str+"("+entry.nickname+")"+"--"+entry.name+"</span></a>";
								 }
								 else if( (entry.nickname.trim()).indexOf($("#search_input").val()) != -1 ){
									 html2 += "<a href='#'><span class='result'>"+entry.userid+"("+str+")"+"--"+entry.name+"</span></a>";
								 }
								 else if( (entry.name.trim()).indexOf($("#search_input").val()) != -1 ){
									 html2 += "<a href='#'><span class='result'>"+entry.userid+"("+entry.nickname+")"+"--"+str+"</span></a>";
								 }
								 
							 $("#member_drop2").html(html2);
								 		 
						 }); // end of $.each()----------------------------------------------------------------------
						  
						 $("#member_drop2").html(html2);
						 
						
						 $("#backicon").click(function(){
								
								/* alert("확인용:::::::"); */ 
								dropShow1();
									 
						 });
						 
						 
					 }); // end of $("#btnMore").click()---------------------------------------------------------------------------
			 		
	 
				 },
				 error: function(request, status, error){
						alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
				 }
				 						 
			 }); // end of $.ajax memberSearch.action-------------------------------------------------------------------
		 	 
		  
			$("#drop1").click(function(event){
				var word = "";
				
				var $target = $(event.target); // 무엇을 클릭하는지 알기 위해서 
				
				
				if($target.is(".first")){
					word = $target.text() + $target.next().text() + $target.next().next().text();
				}
				else if($target.is(".second")){
					word = $target.prev().text() + $target.text() + $target.next().text();
				}
				else if($target.is(".third")){
					word = $target.prev().prev().text() + $target.prev().text() + $target.text();
				}
				
				$("#search_input").val(word);
				// 텍스트 박스에 검색된 결과의 문자열을 입력해준다. 
				
				$("#drop1").hide();
				
				// goSearch(word);
				
				
			});
			 
			 
			 
			 
			$("#drop2").click(function(event){
				var word = "";
				
				var $target = $(event.target); // 무엇을 클릭하는지 알기 위해서 
				
				
				if($target.is(".first")){
					word = $target.text() + $target.next().text() + $target.next().next().text();
				}
				else if($target.is(".second")){
					word = $target.prev().text() + $target.text() + $target.next().text();
				}
				else if($target.is(".third")){
					word = $target.prev().prev().text() + $target.prev().text() + $target.text();
				}
				
				$("#search_input").val(word);
				// 텍스트 박스에 검색된 결과의 문자열을 입력해준다. 
				
				$("#drop2").hide();
				
				// goSearch(word);
				
				
			}); 
	   
		 
		   
		   
		   
		}	 
	 
	}); // $(document).ready()--------------------------------------------------------------------------------
		
	
	function dropShow1(){
		
	 $("#drop1").show();
	 $("#drop2").hide();
		
	}
	
	function dropShow2(){
		
		 $("#drop2").show();
		 $("#drop1").hide();
			
	}	
	

	// 팀 리스트와 프로젝트 리스트를 보여주는 함수
	function teamlistButton(){
		
		$("#project_dropdown").empty();
		
		$.ajax({
			url: "<%=request.getContextPath()%>/teamlist.action",
			type: "get",
			dataType: "json",
			success: function(json){
				
				var html = "";
				
				if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
												
						html += "<li><span id='team_name' style='padding-left: 10px; color: yellow;'><a href='#'>"+entry.team_name+"<span style='float: right; padding-right: 10px;'>"+entry.admin_userid+"</span></a></span></li>";
															
						html += "<li id='teamlist"+entryIndex+"'></li>";
					
						var form_data = {"fk_team_idx": entry.team_idx}
						
						$.ajax({
							
							url: "<%=request.getContextPath()%>/projectlist.action",
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
					$("#project_dropdown").html(html);
				}
								
				$("#project_dropdown").html(html);		
				$(".dropdown").show(html);
				
				
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
			}
			
		});
		
		
	}
	
	/*  $(document).click(function(event){
		 
		  if(!$(event.target).closet('#drop1').length){
			  
			  if($('#drop1').is(":visible")){
				  $('#drop1').hide();
			  }
			  
		  }
		  
	  }); 
	 
	 $(document).click(function(event){
		 
		  if(!$(event.target).closet('#drop2').length){
			  
			  if($('#drop2').is(":visible")){
				  $('#drop2').hide();
			  }
			  
		  }
		  
	  });  */
	
	function personalAlarm(){
		  
		$.ajax({
			
			url: "<%= request.getContextPath() %>/personalAlarm.action",
			type: "get",
			dataType: "JSON",
			success: function(json){
				
				var html = "";
				
				html += "<div class='notify-arrow notify-arrow-blue'></div>"; 
				html += "<li>";
				html += "<p class='blue'>You have "+${sessionScope.newmsg}+" new messages</p>";/* 처음 작동시 안 됨 */
				html += "</li>";
				/* html += "<li style='width: 300px;'>";
				html += "<p class='blue'>You have new messages</p>";
				html += "</li>"; */
				
				html += "<div class='wrap' style='border: 0px solid yellow; width: 300px;'>";
				
				if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
						
						html += "<input type='checkbox' id='select'"+entryIndex+ "class='checkbox'>";
						html += "<label for='select'"+entryIndex+ "class='input-label checkbox'>";
						html += "<span style='color: black;'>" + entry.record_dml_status + "</span><br/>";
						html += "<span style='color: black;'>프로젝트 "+entry.project_name+"&nbsp;&nbsp;";
						html += "리스트"+entry.list_name+"카드"+entry.card_title+"등록일자"+entry.project_record_time;
						html += "</label><br/>";
						html += "<li class='divider'></li>";
						
					});
					
					html += "</div>";
					
					
					$("#newMsgList").html(html);
					
				}
			
			
				
				
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


				<div style="padding-left: 47%; border: 0px solid red;">
					<!-- logo start -->
					  <a href="index.action" class="logo"> FINAL <span class="lite">INS</span></a>
					<!-- logo end -->
				</div>

			</header>
		</c:if>


		<c:if test="${sessionScope.loginuser != null }">

			<header class="header dark-bg">

				<div class="container"
					style="border: 0px solid yellow; width: 150px; float: left; padding-top: 2px;">
					<div class="dropdown" style="border: 0px solid yellow;">

						<!-- <button class="btn btn-default dropdown-toggle" type="button"
							id="project_button" data-toggle="dropdown"
							style="background-color: #B5D3DB; margin-top: 1px; color: black; border: 2px solid royalblue;">
							<span class="icon_cloud-upload_alt logo"
								style="margin-right: 10px; font-size: 20pt; color: #FF9C34;"></span><span
								style="font-size: 16pt; color: white; font-weight: bold;">Project</span>
						</button> -->
						
						 <button class="btn btn-default dropdown-toggle" type="button" id="project_button"
						  data-toggle="dropdown" style=" background-color:  #1a2732; margin-top:1px; color: black; border-color: black;"> 
         				 <span class="icon_cloud-upload_alt logo" style="margin-right: 10px; font-size: 20pt; color: #ffc61a;"></span>
         				 <span style="font-size: 16pt;" class="lite">Project</span>
       					<!-- <span class="caret"></span> --></button>
							
						<ul class="dropdown-menu" id="project_dropdown"
							style="width: 300px;">
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
				<div class="nav search-row" id="top_menu"
					style="float: left; padding-left: 1px; padding-bottom: 2px; width: 500px; border: 0px solid yellow;">
					<!--  search form start -->
					<ul class="nav top-menu">
						<li>
							<div style="border: 0px solid red; width: 300px;">
								<form class="navbar-form">
									<input class="form-control" id="search_input"
										name="search_input" data-toggle="dropdown"
										placeholder="Search" type="text" style="height: 35px;">
								</form>
							</div>
						</li>

						<!-- <div class="container">
		  <div class="list-group drop dropdown-menu" id="drop" style="border: 1px solid yellow;">
		    <span class='searchGroup' id='teamSearch'>Team<br/></span>
		  </div>
		</div> -->

		<div class="container dropSearch">
			<ul class="list-group drop dropdown-menu" id="drop1">
				<li id="team_drop1"></li>
				<li id="project_drop1"></li>
				<li id="list_drop1"></li>
				<li id="card_drop1"></li>
				<li id="member_drop1"></li>
			</ul>
		</div>
		<div class="container dropSearch">
			<ul class="list-group drop dropdown-menu" id="drop2">
				<li id="team_drop2"></li>
				<li id="project_drop2"></li>
				<li id="list_drop2"></li>
				<li id="card_drop2"></li>
				<li id="member_drop2"></li>
			</ul>
		</div>

						<!-- <a href="#" class="list-group-item">Second item</a>
		    <a href="#" class="list-group-item">Third item</a> -->
						<%-- <c:if test="${teamList != null}">
	     		<span class="searchGroup" id="teamSearch">Team<br/></span>
	     	</c:if> --%>
						<%-- <c:if test="${projectList != null}">
	     		<li>Project</li>
	     		<c:forEach var="projectvo" items="${projectList}" varStatus="status">
	     			<li id="projectSearch${status.index}"></li>
	     		</c:forEach>
	     	</c:if>
	     	<c:if test="${listList != null}">
	     		<li>List</li>
	     		<c:forEach var="listvo" items="${listList}" varStatus="status">
	     			<li id="listSearch${status.index}"></li>
	     		</c:forEach>
	     	</c:if>
	     	<c:if test="${cardList != null}">
	     		<li>Card</li>
	     		<c:forEach var="cardvo" items="${cardList}" varStatus="status">
	     			<li id="cardSearch${status.index}"></li>
	     		</c:forEach>
	     	</c:if>
	     	<c:if test="${memberList != null}">
	     		<li>Member</li>
	     		<c:forEach var="teamvo" items="${teamList}" varStatus="status">
	     			<li id="teamSearch${status.index}"></li>
	     		</c:forEach>
	     	</c:if> --%>


						<!-- <div class="container" style="border: 1px solid yellow; width: 150px; float: left;  padding-top: 2px;">                                   
		  	<div class="dropdown" id="dropdown_input" style="border: 1px solid yellow;">
		  	 <ul class="dropdown-menu" id="searchFrm_dropdown" style="width: 300px; border: 1px solid yellow;">
		  	  <li><span style="color: red;">부트스트랩 되는지 확인</span></li>
		  	  <li><span style="color: red;">부트스트랩 되는지 확인22222222222222</span></li>
		  	 </ul>	 -->

						<%-- <ul class="dropdown-menu" id="searchFrm_dropdown" style="width: 300px;">
		     	<c:if test="${teamList != null}">
		     		<li>Team</li>
		     		<c:forEach var="teamvo" items="${teamList}" varStatus="status">
		     			<li id="teamSearch${status.index}"></li>
		     		</c:forEach>
		     	</c:if>
		     	<c:if test="${projectList != null}">
		     		<li>Project</li>
		     		<c:forEach var="projectvo" items="${projectList}" varStatus="status">
		     			<li id="projectSearch${status.index}"></li>
		     		</c:forEach>
		     	</c:if>
		     	<c:if test="${listList != null}">
		     		<li>List</li>
		     		<c:forEach var="listvo" items="${listList}" varStatus="status">
		     			<li id="listSearch${status.index}"></li>
		     		</c:forEach>
		     	</c:if>
		     	<c:if test="${cardList != null}">
		     		<li>Card</li>
		     		<c:forEach var="cardvo" items="${cardList}" varStatus="status">
		     			<li id="cardSearch${status.index}"></li>
		     		</c:forEach>
		     	</c:if>
		     	<c:if test="${memberList != null}">
		     		<li>Member</li>
		     		<c:forEach var="teamvo" items="${teamList}" varStatus="status">
		     			<li id="teamSearch${status.index}"></li>
		     		</c:forEach>
		     	</c:if>     
		     </ul> --%>

						<!--  </div>
	   </div> -->

					</ul>
					<!--  search form end -->
				</div>

				<div style="padding-left: 47%; border: 0px solid red;">
					<!-- logo start -->
					  <a href="index.action" class="logo"> FINAL <span class="lite">INS</span></a>
					<!-- logo end -->
				</div>
				
				<div class="top-nav notification-row" >
					    <div class="scrollbar" id="style-2">
					      <div class="force-overflow"></div>
					    </div>
					<!-- notificatoin dropdown start-->
					<ul class="nav pull-right top-menu">

						<!-- inbox notificatoin start-->
						<li id="mail_notificatoin_bar" class="dropdown"><a
							data-toggle="dropdown" class="dropdown-toggle" onclick="personalAlarm();"> <i
								class="icon-envelope-l"></i> <!-- <span class="badge bg-important">5</span> -->
						</a>
							<ul class="dropdown-menu extended inbox" id="newMsgList">
								<!-- <div class="notify-arrow notify-arrow-blue"></div> -->
								<!-- <li>
									<p class="blue">You have 5 new messages</p>
								</li> -->
							
								
								
								<!-- 
								<li><a href="#"> <span class="photo"><img
											alt="avatar" src="./img/avatar-mini.jpg"></span> <span
										class="subject"> <span class="from">Greg Martin</span>
											<span class="time">1 min</span>
									</span> <span class="message"> I really like this admin panel.
									</span>
								</a></li>
								<li><a href="#"> <span class="photo"><img
											alt="avatar" src="./img/avatar-mini2.jpg"></span> <span
										class="subject"> <span class="from">Bob Mckenzie</span>
											<span class="time">5 mins</span>
									</span> <span class="message"> Hi, What is next project plan? </span>
								</a></li>
								<li><a href="#"> <span class="photo"><img
											alt="avatar" src="./img/avatar-mini3.jpg"></span> <span
										class="subject"> <span class="from">Phillip Park</span>
											<span class="time">2 hrs</span>
									</span> <span class="message"> I am like to buy this Admin
											Template. </span>
								</a></li>
								<li><a href="#"> <span class="photo"><img
											alt="avatar" src="./img/avatar-mini4.jpg"></span> <span
										class="subject"> <span class="from">Ray Munoz</span> <span
											class="time">1 day</span>
									</span> <span class="message"> Icon fonts are great. </span>
								</a></li>
								<li><a href="#">See all messages</a></li>-->
							</ul></li> 
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

						<!--	
							<div class="dropdown" style="width: 5%; padding-left: 0.2px; padding-top: 7px; float: left; border: 0px solid yellow;">
								 
								<button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown" style=" background-color: black; margin-top:1px; color: black; border-color: black;"> 
					    			<span class="icon_cloud-upload_alt logo" style="margin-right: 10px; font-size: 20pt; color: #ffc61a;"></span><span style="font-size: 16pt;" class="lite">Project</span>
					    			<span class="caret"></span>
					    		</button>  
					    		

								<a data-toggle="dropdown" class="dropdown-toggle" id="menu1" href="#"> 
									<i class="icon-bell-l"></i>
									<span class="badge bg-important" style="margin-left: 30pt;">7</span>
								</a> 
								
							</div> 
							
							-->
							
							
							
							<!-- <div class="dropdown" style="width: 5%; padding-left: 0.2px; padding-top: 7px; float: left; border: 1px solid yellow;">
							  <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Dropdown Example
							  <span class="caret"></span></button>
							  <a data-toggle="dropdown" class="dropdown-toggle" data-toggle="dropdown" id="menu1" href="#"> 
									<i class="icon-bell-l"></i>
									<span class="badge bg-important" style="margin-left: 30pt;">7</span>
							  </a>
							  
							  <ul class="dropdown-menu" style="border: 1px solid yellow; width: 400px; margin-left: 200px;">
							    <li><a href="#">HTML</a></li>
							    <li><a href="#">CSS</a></li>
							    <li><a href="#">JavaScript</a></li>
							  </ul>
							  
							  
							  <div class="dropdown-menu" style="width: 400px; margin-left: 50px;">
							   	<h2>Basic List Group</h2>
								  	<ul class="list-group">
								    	<li class="list-group-item">First item</li>
								    	<li class="list-group-item">Second item</li>
								    	<li class="list-group-item">Third item</li>
								  	</ul>
							  </div>
							   
							</div>
							 -->
							<!-- <div class="container">
								<div class="checkbox checkbox-warning">
			                        <input id="check2" type="checkbox" class="styled" checked>
			                        <label for="check2">
			                            Style 2
			                        </label>
			                    </div>
							</div> -->

						</li>
						<!-- alert notification end-->

						<!-- user login dropdown start-->
						<li class="dropdown"><a data-toggle="dropdown"
							class="dropdown-toggle" href="#"> <span class="profile-ava">
									<img alt="" src="img/avatar1_small.jpg">
							</span> <span class="username">${sessionScope.loginuser.userid}</span> <b
								class="caret"></b>
						</a>
							<ul class="dropdown-menu extended logout">
								<div class="log-arrow-up"></div>
								<li class="eborder-top"><a href="#"><i
										class="icon_profile"></i> My Profile</a></li>
								<li><a href="<%= request.getContextPath() %>/logout.action"><i class="icon_key_alt"></i>
										Log Out</a></li>
							</ul></li>

						<li><img src="<%=request.getContextPath()%>/resources/img/avatar1.jpg"
							alt="Avatar" class="avatar" /></li>
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