<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script type="text/javascript">
	$(document).ready(function(){
		if(${sessionScope.loginuser == null}){
			alert("로그인이 필요합니다.");
			location.href = "<%=request.getContextPath()%>/index.action";
		}
		$('[data-toggle="popover"]').popover();  
		
		
		$(".clickA").click(function(event){
			event.preventDefault(); // href로 연결해 주지 않고 단순히 click에 대한 처리를 하도록 해준다.
			
			var form_data = $("form[name=updateFavorite]").serialize();
	/* 		var queryString = $("form[name=updateFavorite]").serialize() ;
			console.log("queryString테스트: " + queryString); */
			
		 	$.ajax({
				url: "updateFavoriteStatus.action",
				type: "POST",
				data: form_data,    
				dataType: "JSON",
				success: function(data){
					
					var html = "";
										
					if(data.project_favorite == "1"){
						alert("1입니다.");
						html = "<a class='clickA' href='#'>즐겨찾기 1</a>";
						$("#favorite1").empty();
						$("#favorite1").append(html);
						$("#favorite_status").val(data.project_favorite);
					}
					else {
						alert("0입니다.");
						html = "<a class='clickA' href='#'>즐겨찾기 0</a>";
						$("#favorite0").empty();
						$("#favorite0").append(html);
						$("#favorite_status").val(data.project_favorite);
					}
					/*
					if(entry.SESSIONUSERID == entry.CARDCOMMENTUSERID){
                  html += "<button type='button' class='btn btn-default' style='font-weight: bold;' onClick=\"goCommentEdit('"+entry.CARDCOMMENTIDX+"','"+entry.CARDCOMMENTCONTENT+"');\"><i class='fa fa-pencil-square-o'></i></i>Edit</button>";
                  html += "<button type='button' class='btn btn-default' style='font-weight: bold;' onClick=\"goCommentDelete('"+entry.FKCARDIDX+"','"+entry.CARDCOMMENTIDX+"')\"><i class='fa fa-trash'></i>Delete</button>";
					*/
					
					/* $("#favorite").html(html); */
				},
				error: function(request, status, error){ 
					alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
				}
			}); // end of $.ajax  
		}); // end of $(".clickA").click
		
	});
</script>

<title>Insert title here</title>
</head>
<body>
    <header class="header" style="margin-top: 2%;">
	  <nav class="navbar navbar-inverse" style="width: 100%;">
		  <div class="container-fluid" >
		    <div class="navbar-header" >
		      <%-- <a class="navbar-brand" href="#" ><span style="color: yellow;">${project_name}</span></a> --%>
		      <a class="navbar-brand" href="#" ><span style="color: yellow;">${projectInfo.project_name}</span></a>
		    </div>
		    <ul class="nav navbar-nav">
		    	<c:if test='${projectInfo.project_favorite == "0"}'>
		      		<li id="favorite0"><a class="clickA" href="#">즐겨찾기 0</a></li>
		      	</c:if>
		      	<c:if test='${projectInfo.project_favorite == "1"}'>
		      		<li id="favorite1"><a class="clickA" href="#">즐겨찾기 1</a></li>
		      	</c:if>
		        
		        
		      	<c:if test="${projectInfo.project_visibility == '0'}">
		      		<li><a href="#">team visibility</a></li>
		      	</c:if>
		      	<c:if test="${projectInfo.project_visibility == '1'}">
		      		<li><a href="#">private</a></li>
		      	</c:if>
		      	<c:if test="${projectInfo.project_visibility == '2'}">
		      		<li><a href="#">public</a></li>
		      	</c:if>
		      	
		      	
		      </li>
		      <li><a href="#" title="visibility" data-toggle="popover" data-placement="bottom" data-content="하핫?">Bottom</a></li>
		    </ul>
		    
		    <button class="btn btn-default" type="button" id="menu1" style=" background-color: black; margin-top: 5px; margin-bottom: 5px; color: black; border-color: black;"> 
	    	<span style="font-size: 13pt; color: yellow;">...Show Menu</span>
	   </button>
		  </div>
		  
		  
	  </nav>
</header>	

	<div class="container" style="margin-top: 30%;">
		<h3>Navbar With Dropdown</h3>
		<p>This example adds a dropdown menu for the "Page 1" button in the navigation bar.<i class="icomoon icon-star"></i></p>
		
	</div>	
<form name="updateFavorite">
	<input type="text" name="userid" value="${projectInfo.member_id}">
	<input type="text" name="favorite_status" value="${projectInfo.project_favorite}" id="favorite_status">
	<input type="text" name="project_idx" value="${projectInfo.project_idx}">
</form>
</body>
</html>