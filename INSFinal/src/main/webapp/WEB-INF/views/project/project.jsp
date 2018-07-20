<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    


<script type="text/javascript">
	$(document).ready(function(){
		if(${sessionScope.loginuser == null}){
			alert("로그인이 필요합니다.");
			location.href = "<%=request.getContextPath()%>/index.action";
			return;
		}
		
		
	    if(${projectInfo.project_favorite} == 0) { //초기화면에서 즐겨찾기 노출
	    	$(".clickA").text("즐겨찾기에 추가하기");
	    }
	    else {
	    	$(".clickA").text("즐겨찾기");
	    } 
	   
	    $(".div-listname").hide();
	   
	    //addlist 클릭시 인풋창
	    $("#addList").click(function(event){
	    	$("#addListstyle").hide();
	    	$(".div-listname").show();
	    	$("#listname").focus();
	 		$("#addList").removeClass("list-hover");
	 		$("#addList").css("opacity", "1.0");
	    }); 

	   
	  /*    $("#listname").blur(function(){
	    //	alert("확인!!!");
	    	$("#liststyle").show();
	    	$(".div-listname").hide();
	    	$("#addList").addClass("list-hover");
	    //	$("#addList").css("opacity", "0.1");
	    }); */
	    

	    //리스트명 인풋창에서 엔터키를 누르는 경우 함수 호출
		$("#listname").keydown(function(event){
			if(event.keyCode == 13){
				insertList();
			}
		}); 	 

	    
	/*     //리스트제목 클릭시 인풋창 스타일 변경, 제목 변경
	    $(".well").click(function(){
	  //  	var contentid = $(this).attr("id"); //클릭한 리스트 아이디
	  //  	var oldval = $(this).children('input').val();
	  //  	var newval = $(this).children('.newval').val();
	    	var oldval = $(this).children('.oldval').val();
	    	
	    	 $(this).keydown(function(event){
	    		if(event.keyCode == 13){
	    			;
	    			alert("new: " + newval + "   /  old: " + oldval);
	    			//	alert("리스트명 수정할까");
				//	var editList = 
				}
	    	}); 
	    }); */
	    
	    
		$("#mycontent").addClass("example1"); //프로젝트 배경이미지 노출
		
		$(".clickA").click(function(event){ //즐겨찾기 클릭시 즐겨찾기status값 update 
			event.preventDefault(); // href로 연결해 주지 않고 단순히 click에 대한 처리를 하도록 해준다.
			var form_data = $("form[name=updateFavorite]").serialize();
	
			$.ajax({
				url: "updateFavoriteStatus.action",
				type: "POST",
				data: form_data,    
				dataType: "JSON",
				success: function(data){
					if(data.project_favorite == "1") {
						$(".clickA").text("즐겨찾기");
						$("#favorite_status").val(data.project_favorite);
					}
					else {
					    $(".clickA").text("즐겨찾기에 추가하기");
						$("#favorite_status").val(data.project_favorite);
					} 
				},
				error: function(request, status, error){ 
					alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
				}
			}); // end of $.ajax  
		}); // end of $(".clickA").click
	/* 	
		$(".navbar").hide();
		$(".header").addClass("navbar"); */
	}); // end of $(document).ready
	
	
	function insertList(){ //리스트를 추가하는 함수
		var list_name = $("#listname").val().trim();
		var project_idx = "${projectInfo.project_idx}";
		var userid = "${sessionScope.loginuser.userid}";
		
		if(list_name == ""){
			alert("리스트 이름은 공백으로 할 수 없습니다.");
			$("#listname").val("");
			$("#listname").focus();
			return;
		}
		else{
			var form_data = {"list_name" : list_name, "project_idx" : project_idx, "userid" : userid};
			
			$.ajax({
				url: "addList.action",
				type: "POST",
				data: form_data,
				dataType: "JSON",
				success: function(data){
					if(data.result == 1){
						alert("리스트가 생성되었습니다.");
						location.reload();
					}
					else{
						alert("리스트 생성에 실패했습니다.");
					}
				},
				error: function(request, status, error){ 
			         alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
			    }
			}); // end of $.ajax
		}
	} // end of insertList
</script>

<style type="text/css">

 #mycontainer	{height:inherit;}
 
 .example1{ 
  background-image: url("./resources/images/${project_image_name}"); 
  background-color: white;
  background-size: cover;
  background-attachment: fixed;
  background-repeat: repeat-x;
  height: inherit; 
 }
 
 
 .list-hover{opacity: 0.1;}
 .list-hover:hover{opacity: 1.0;}
 
 .colStyle{cursor: pointer;}
 
 .list-wrapper{
 	white-space:nowrap;
 	overflow-x: auto;
 	overflow-y: hidden;
 	height:inherit;
 	padding-top: 40px;
 	padding-left: 20px;
 	padding-right: 10px;
 }
 
 .list-wrapper .well {
 	margin-right:10px;
 }
 
 .well{margin-top: 50px;
 	   opacity: 0.8;}
 
 .list-wrap{
 width: 272px;
 margin: 0 4px;
 height: 100%;
 /* box-sizing: border-box; */
 vertical-align: top;
 white-space: nowrap;
 }
 
  
 .list-title{
 display: block;
  width: 270px;
  height: 34px;
  padding: auto;
  font-size: 14px;
  line-height: 1.428571429;
  color: #8e8e93;
  vertical-align: middle;
/*   background-color: #ffffff; */
 /*  border: 1px solid #c7c7cc; */
  border: none;
  border-radius: 4px;  
  -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
 }
 
 .assign-to-team-list-item-content, .assign-to-team-create-content {
  cursor: pointer;
  &:hover {
    background: @light-gray-300;
  }
  border-radius: 4px;

  &.disabled {
    color: @quietcolor;
    cursor: default;
  }
}

</style>

	   <nav class="navbar navbar-inverse" style="width: 100%; margin-top: 20px; height: 30px; position: fixed; opacity: 0.5;">
		  <div class="container-fluid">
		    <div class="navbar-header" >
		      <a class="navbar-brand" href="#" ><span style="color: yellow;">${projectInfo.project_name}</span></a>
		    </div>
		    <ul class="nav navbar-nav">
	      	    <li id="favorite"><a class="clickA" href="#"></a></li>

		      	<c:if test="${projectInfo.project_visibility == '0'}">
		      		<li><a href="#">team visibility</a></li>
		      	</c:if>
		      	<c:if test="${projectInfo.project_visibility == '1'}">
		      		<li><a href="#">private</a></li>
		      	</c:if>
		      	<c:if test="${projectInfo.project_visibility == '2'}">
		      		<li><a href="#">public</a></li>
		      	</c:if>
		    </ul>
		    <p align="right">
		    <button class="btn btn-default" type="button" id="menu1" style=" background-color: black; margin-top: 5px; margin-bottom: 5px; color: black; border-color: black; "> 
	    		<span style="font-size: 13pt; color: yellow;">...Show Menu</span>
	   		</button></p>
		  </div>
	</nav> 

	<div class="list-wrapper">
	<c:if test="${listvo == null || listvo.size() == 0}">
		<div id="addList" class="well list-hover" style="width: 300px; display: inline-block; vertical-align: top;">
			<label for="addListstyle">
				<span style="font-size: 14pt; color: gray; font-weight: bold;" id="addListstyle"><i class="fa fa-plus"></i>&nbsp;add another list...</span>
			</label>
			<div class="div-listname">
				<input type='text' class='list-title' id="listname" placeholder="Enter list title..." maxlength="30">
				<button class="btn btn-default" style="margin-top: 10px;" onClick="insertList();">add List</button>
			</div>
		</div>
	</c:if>
	
	<c:if test="${listvo.size() != 0}">
		<c:forEach items="${listvo}" var="vo" varStatus="status">
		<div id="list${status.count}" class="well list-hover" style="width:300px;display:inline-block;">
			<%-- <h3>${vo.list_name}</h3> --%>
			<%-- <span style="font-size: 14pt; color: gray; font-weight: bold;" id="liststyle">${vo.list_name}</span> --%>
			<input type="text" class="project_listname newval" value="${vo.list_name}" style="background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;"/>
 			<input type="hidden" class="project_listname oldval" value="${vo.list_name}" style="background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;"/>
			<div class="card-wrapper" style="max-height:500px;overflow-y:auto;">
				<div class="panel panel-default">
					<div class="panel-body">카드 내용</div>
				</div>
				<!-- <div class="panel panel-default">
					<div class="panel-body">카드 내용</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-body">카드 내용</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-body">카드 내용</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-body">카드 내용</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-body">카드 내용</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-body">카드 내용</div>
				</div>
				<div class="panel panel-default">
					<div class="panel-body">카드 내용</div>
				</div> -->
				<div>
					<span style="font-size: 12pt; color: gray;" id="addCardstyle${status.count}"><i class="fa fa-plus"></i>&nbsp;add another list...</span>
				</div>
			</div> 
	    </div>
		</c:forEach>
		<!-- 2018.07.20 addcard작업중 -->
		<div id="addList" class="well list-hover" style="width: 300px; display: inline-block; vertical-align: top;">
			<label for="addListstyle">
				<i class="fa fa-plus"></i><span style="font-size: 14pt; color: gray; font-weight: bold; padding-bottom: 10%;" id="addListstyle">&nbsp;add another list...</span>
			</label>
			<div class="div-listname">
				<input type='text' class='list-title' id="listname" placeholder="Enter list title..." maxlength="30">
				<button class="btn btn-default" style="margin-top: 10px;" onClick="insertList();">add List</button>
			</div>
		</div>
	</c:if>
	</div>
	
<form name="updateFavorite">
	<input type="hidden" name="userid" value="${projectInfo.member_id}">
	<input type="hidden" name="favorite_status" value="${projectInfo.project_favorite}" id="favorite_status">
	<input type="hidden" name="project_idx" value="${projectInfo.project_idx}">
</form>