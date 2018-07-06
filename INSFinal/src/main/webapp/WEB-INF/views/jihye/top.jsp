<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  


<style>

.grid-container {
  display: grid;
  /* grid-gap: 10px; */
 /*  background-color: #2196F3; */
  padding: 10px;
  width: 50%;
/*   border: 3px solid black; */
  margin:0 auto;
}

.grid-item {
 /*  background-color: rgba(255, 255, 255, 0.8); */
 /*  text-align: center; */
  padding: 20px;
  font-size: 20px;
/*   border: 3px solid red; */
}

.item1 {
  
  text-align: center; 
  grid-column: 1; /* grid-column: 오른쪽에서 부터 순서 / grid-row: 열의 순서  /span: 컬럼 합친 갯수*/
  grid-row: 1 / span 2;
}
.item2 {
  grid-column: 2 / span 2;
  grid-row: 1 / span 2;
}

/* .item3{
  grid-column: 2 / span 2;
  grid-row: 2 ;
} */
/* .item5 {
 text-align: center;
  grid-column: 1 / span 3;
  grid-row: 3;
} */


.avatar {
    vertical-align: middle;
    width: 200px;
    height: 200px; 
    border-radius: 70%; 
    border: 3px solid gold;
}

 .abc {
      /*  border: 3px solid gold;  */
      padding-left:40%;
     padding-right:35%;   
}

/* 
.tablink {
     background-color: #555; 
    color: white;
    float: left;
     border: none; 
    outline: none;
    cursor: pointer;
     padding: 10px 16px; 
    font-size: 15px;
     width: 100%; 
}  */

.tab-content{
  padding-left:10%;
  padding-right:10%;
}

.activity {
    border-bottom: 1px solid #e2e4e6;
    margin-left: 40px;
    min-height: 32px;
    padding: 12px 0;
    position: relative;
   
}

.attach1{
  position: absolute;

   /*  top: 50%;
    left: 50%;
    transform: translate(-50%, -50%); */
  /*    background: rgba(0,0,0,.5);
    bottom: 0;
    color: #fff;
    display: none;
    height: 40px;
    line-height: 30px;
    right: 0;
    width: 100%;
    z-index: 3; */
}  



</style>

<script>
function changeImg(){
	alert("클릭하셨습니다.");
}


</script>



<div class="grid-container" style="border: 0px solid black; margin_bottom: 100px;">
  <div class="grid-item item1"> <!--grid-item  -->
     <div class="avatar" style="border: 3px solid black;"> <!-- 이미지가 있을 div 공간을 동그랗게 만드는 방법 -->
        <img src="<%= request.getContextPath() %>/resources/img/Spain.png" alt="Avatar"  class="avatar">
     <%--  이미지를 라운드 크기로 만드는 방법 
        <img src="<%= request.getContextPath() %>/resources/img/Spain.png" alt="Avatar" class="avatar"> --%>
       <div class="attach1" style="3px solid red; " >
       <a type="file" onclick="changeImg();" ><span > 사진첨부하세요</span></a> 
       </div>
      </div> 
  </div>
  <div class="grid-item item2">
    <input type="hidden" value="${sessionScope.loginuser.userid}" />
    
     이  름 : ${sessionScope.loginuser.name}</br></br>
     이메일 : ${sessionScope.loginuser.email}</br></br>
     닉네임 : ${sessionScope.loginuser.nickname}</br></br>
          
  </div> 
  <div>
  </div>
 </div>  

<!-- 
<h2 style="text-align:center">User Profile Card</h2>

<div class="card">
  <img src="/w3images/team2.jpg" alt="John" style="width:100%">
  <h1>John Doe</h1>
  <p class="title">CEO & Founder, Example</p>
  <p>Harvard University</p>
  <div style="margin: 24px 0;">
    <a href="#"><i class="fa fa-dribbble"></i></a> 
    <a href="#"><i class="fa fa-twitter"></i></a>  
    <a href="#"><i class="fa fa-linkedin"></i></a>  
    <a href="#"><i class="fa fa-facebook"></i></a> 
 </div>
 <p><button>Contact</button></p>
</div> -->
  


 


    