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

	
</script>


<body>
	 <div id="mySidenav" class="sidenav">
	 	  <span style="font-size: 40pt; font-weight: bold;">&#9776; menu</span>
	 	  <a href="javascript:void(0)"onclick="closeNav();"><span style="padding-left: 80%; ">&times;</span></a>
	 	  <span style="cursor:pointer" onclick="openNav2();">Search in PROJECT</span> 
		  <span style=" cursor: pointer;" onclick="location.href='<%= request.getContextPath()%>/leaveProject.action'">Leave PROJECT</span> 
		  <span style=" cursor: pointer; ">Delete PROJECT</span>
		  <hr style="border: solid 1px gray;"> 
		  <span>Activity</span>
	  </div>
	  
	  
	  <div id="mySidesearch" class="sidenav" style="border: 0px solid yellow;">     
	  	  <span style="font-size: 40pt; font-weight: bold; cursor: pointer; " onclick="closeNav2();">&#9776; menu</span>
		  <a href="javascript:void(0)" onclick="closeNav();"><span style="padding-left: 80%; font-size: 20pt;">&times;</span></a>
		  <span>&nbsp;&nbsp;&nbsp;Search in PROJECT</span>             
		  <div class="container" style="border: 0px solid yellow;" >
			  <form>
			    <div class="form-group" style="padding-left:18pt; padding-top: 10pt; width: 120px; border: 0px solid yellow;">
			      <select class="form-control" id="sel1">    
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
	
	  
</body>
</html>