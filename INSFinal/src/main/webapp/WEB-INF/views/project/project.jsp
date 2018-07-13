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
	//	$('[data-toggle="popover"]').popover();  
		$("#mycontent").addClass("example1"); //프로젝트 배경이미지 노출
		
		if(${listvo == null || listvo.size() == 0}){
			$(".col-sm-2").hide();
			
			$("#list0").show();
			$("#list0").click(function(){
				$("#list1").show();
				$("#list1").addClass("colStyle");
			}); 
			
			$("#list1").click(function(){
				$("#list2").show();
				$("#list2").addClass("colStyle");
			});
			
			$("#list2").click(function(){
				$("#list3").show();
				$("#list3").addClass("colStyle");
			});
			
			$("#list3").click(function(){
				$("#list4").show();
				$("#list4").addClass("colStyle");
			});
		}
		else{
			$(".col-sm-2").show();
		}
 		
		
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
  overflow-y: auto; 
  width: auto; 
 }
 
 .panel {
  margin-bottom: 20px;
  background-color: #ffffff;
  border: 0px solid transparent;  
  -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
  box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
  margin-left: 10px;
  margin-right: 10px;
}
 
 .colStyle{cursor: pointer;}
 
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

	  <nav class="navbar navbar-inverse" style="width: 100%; margin-top: 30px;">
		  <div class="container-fluid" >
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
		    
		    <button class="btn btn-default" type="button" id="menu1" style=" background-color: black; margin-top: 5px; margin-bottom: 5px; color: black; border-color: black;"> 
	    		<span style="font-size: 13pt; color: yellow;">...Show Menu</span>
	   		</button>
		  </div>
	</nav>

 <!-- 	<div class="form-group has-success" style="min-height: 5%; width: 12%; margin-left: 1%;">
		<input type="text" class="form-control" id="disabledInput" style="width: 100%;" placeholder=" + add a list..">
    	<input type="text" class="form-control" id="inputSuccess" style="width: 100%;" placeholder="add a list..">
	</div>  -->
	
<!--  	<div class="row" style="margin-left: 1%;" id="project_content">
	    <div class="col-sm-2" id="list1" style="cursor: pointer;">
	      <h3>Column 1</h3>
	      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
	      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
	    </div>
	</div>  -->
	
	<c:if test="${listvo == null || listvo.size() == 0}">
		<div class="row" style="margin-left: 1%;">
		    <div class="col-sm-2 panel" id="list0">
		        	<h4>add another list...</h4>        
	    		</div>
		    <div class="col-sm-2" id="list1" style="cursor: pointer;">
		      <h3>Column 1</h3>
		      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
		    </div>
		    <div class="col-sm-2" id="list2">
		      <h3>Column 2</h3>
		      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
		    </div>
		    <div class="col-sm-2" id="list3">
		      <h3>Column 3</h3>        
		      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
		    </div>
		    <div class="col-sm-2" id="list4">
		      <h3>Column 4</h3>
		      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
		    </div>
		    <div class="col-sm-2" id="list5">
		      <h3>Column 5</h3>
		      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
		    </div>
		    <div class="col-sm-2" id="list6">
		      <h3>Column 6</h3>        
		      <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit...</p>
		      <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris...</p>
		    </div>
		</div>
	</c:if>
	
	<c:if test="${listvo != null || listvo.size() != 0}">
		<c:forEach items="${listvo}" var="vo" varStatus="status">
			<div class="col-sm-2" id="list${status.count}">
		      <h4>${vo.list_name}</h4>        
	    	</div>
	    	<c:if test="${status.count == listvo.size()}">
	    		<div class="col-sm-2 assign-to-team-create-content" id="list${status.count}">
		        	<h4>add another list...</h4>        
	    		</div>
	    	</c:if>
		</c:forEach>
	</c:if>
	
<form name="updateFavorite">
	<input type="hidden" name="userid" value="${projectInfo.member_id}">
	<input type="hidden" name="favorite_status" value="${projectInfo.project_favorite}" id="favorite_status">
	<input type="hidden" name="project_idx" value="${projectInfo.project_idx}">
</form>