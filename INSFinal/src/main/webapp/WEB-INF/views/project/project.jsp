<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


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
	    
	    $("#list1").click(function(event){
	    	
	    	
	    	
	    	var html = "<div class='col-sm-2' style='cursor: pointer; float: left;'>"
		      		 + "<h3>add List...</h3>"
		      		 + "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>"
				     + "<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>"
				     + "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>"
				     + "<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>"
				     + "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>"
				     + "<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>"
				     + "<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>"
				     + "<p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>"
		    		 + "</div>";
	    	$(this).prepend(html);
	    });
	
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
		
		
		
	}); // end of $(document).ready
</script>

<style type="text/css">
/*  .example1{ 
  background-image: url("./resources/images/basic.jpg"); 
  background-color: white;
  background-size: cover;
  
  height: 100%;
  text-align: center;
  width: 100%;
  position: absolute;
   overflow: hidden;
  display: flex;
  flex-direction: column;
 } */
 .example1{ 
  background-image: url("./resources/images/${project_image_name}"); 
  background-color: white;
  background-size: cover;
  width: 100%;
  height: 100%; 
  overflow-x: visible;
  overflow-y: hidden;
 }
 
 .colStyle{cursor: pointer;}
 
 .list-wrap{
 width: 272px;
 margin: 0 4px;
 height: 100%;
 /* box-sizing: border-box; */
 vertical-align: top;
 white-space: nowrap;
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

	  <nav class="navbar navbar-inverse" style="width: 100%; margin-top: 30px; height: 50px;">
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
		      <!-- 	<li><a href="#" title="visibility" data-toggle="popover" data-placement="bottom" data-content="하핫?">Bottom</a></li> -->
		    </ul>
		    <p align="right">
		    <button class="btn btn-default" type="button" id="menu1" style=" background-color: black; margin-top: 5px; margin-bottom: 5px; color: black; border-color: black; "> 
	    		<span style="font-size: 13pt; color: yellow;">...Show Menu</span>
	   		</button></p>
		  </div>
	</nav>

	
	<c:if test="${listvo == null || listvo.size() == 0}">
		<div class="row" style="margin-left: 1%;" id="list1">
		    <div class="col-sm-2"  style="cursor: pointer;">
		      <h3>add List...</h3>
		      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
		    </div>
		</div>
	</c:if>
	
	<c:if test="${listvo != null || listvo.size() != 0}">
		<c:forEach items="${listvo}" var="vo" varStatus="status">
			<div class="col-sm-2 list-wrap" id="list${status.count}" >
		      <h4>${vo.list_name}</h4> 
		      <h4>리스트사이즈: ${status.count}</h4>       
	    	</div>
	    	<c:if test="${status.count == listvo.size()}">
	    		<div class="col-sm-2 assign-to-team-create-content" id="list${status.count}">
		        	<h4>add another list...</h4>   
		        	<h4>리스트사이즈${listvo.size()+1}</h4>        
	    		</div>
	    	</c:if>
		</c:forEach>
	</c:if>
	
<form name="updateFavorite">
	<input type="hidden" name="userid" value="${projectInfo.member_id}">
	<input type="hidden" name="favorite_status" value="${projectInfo.project_favorite}" id="favorite_status">
	<input type="hidden" name="project_idx" value="${projectInfo.project_idx}">
</form>