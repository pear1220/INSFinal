<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
 
<jsp:include page="top.jsp" /> 
<!-- <link rel="stylesheet" type="text/css" href="resources/jihye/bootstrap4/bootstrap.min.css">  -->
<link href="resources/jihye/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" type="text/css" href="resources/jihye/checkout.css"> 
<link rel="stylesheet" type="text/css" href="resources/jihye/checkout_responsive.css"> 

<link rel="stylesheet" type="text/css" href="resources/jihye/cart.css"> 
<link rel="stylesheet" type="text/css" href="resources/jihye/cart_responsive.css"> 
 
<style>

.btn-dark{color:white; background-color:#343a40; border-color:#343a40}
.btn-dark:hover{color:#fff;background-color:#23272b;border-color:#1d2124}  
 


.btn-dark.focus,.btn-dark:focus{box-shadow:0 0 0 .2rem rgba(52,58,64,.5)} 
/* .btn-dark.disabled,.btn-dark:disabled{background-color:#343a40;border-color:#343a40}
.btn-dark:not([disabled]):not(.disabled).active,.btn-dark:not([disabled]):not(.disabled):active,.show>.btn-dark.dropdown-toggle{color:#fff;background-color:#1d2124;border-color:#171a1d;box-shadow:0 0 0 .2rem rgba(52,58,64,.5)}  
 */
/*  .btn:active,
.btn.active {
  background-image: none;
  outline: 0;
  -webkit-box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
          box-shadow: inset 0 3px 5px rgba(0, 0, 0, .125);
}


.btn:focus,
.btn:active:focus,
.btn.active:focus,
.btn.focus,
.btn:active.focus,
.btn.active.focus {
  outline: 5px auto -webkit-focus-ring-color;
  outline-offset: -2px;
} */
</style> 
   
<script type="text/javascript"> 

var status = "'1','0'";

$(document).ready(function(){

 /*  displayQnAList("1", status);  */
 
  
  $("#qna_status").bind("change", function(){
	   
	   $("#count").text("0");
	   
	   $("#QnAListResult").empty();
	   
	       var frm = document.statusFrm;
	       
      status = frm.qna_status.value;
   
      displayQnAList("1", status);
      
  });
  
  $("#btnMore").bind("click", function(){
	   
		   if($(this).text() == "처음으로"){   
			   
		      $("#QnAListResult").empty();
		        displayQnAList("1", status);
		       $(this).text("더보기");
		   }
		   else{
			    displayQnAList($(this).val(), status);// 버튼의 value값을 넣는다 
		   }
		   
	    });//end of btnMore.bind(click)
	  
  	
 });//end of $(document).ready(function())
 
 var length = 10;

/*  function displayQnAList(start, status){
	  
	 
	  var form_data = {"start" : start
    		           ,"len" : length
   	               ,"status" : status};
	  
	  $.ajax({
		       url:"getQnAListJSON.do",
		       type:"GET",
		       data:form_data,
		       dataType:"JSON",
		       success: function(json){
		    	   
		    	   var html = "";
		    	   
		    	   if(json.length == 0){
		    		// 작성된 QnA가 없는경우   
		    		   html += "<tr><td>작성된 QnA가 없습니다.</td></tr>";
		    		   
		    		   $("#QnAListResult").html(html);
		    		   
		    		   $("#btnMore").attr("disable", true);
		    		   $("#btnMore").css("cursor", "not-allowed");
		    	   }
		    	   else if(json.length > 0){
                         
		    	   // 작성된 QnA가 있는 경우   
		    	          $.each(json, function(entryindex, entry){
   		    			  
   		    			  html += "<tr>";
   		    			  html += "<td>"+entry.rno+"</td>";
   		    			  html += "<td>"+entry.qna_category+"</td>";
   		    			  html += "<td><a href='javascript:showDetail(\""+entry.qna_no+"\",\""+entry.qna_userid+"\");'>"+entry.qna_title+"</a></td>"; 
   		    			  html += "<td>"+entry.qna_date+"</td>";
   		    			  html += "<td>"+entry.qna_userid+"</td>";
   		    			  html += "<td>"+entry.qna_status+"</td>";
   		    			  html += "</tr>"; 
   		    			      
   		    		      $("#totalCount").text(entry.totalCount);
   		    		      
		    			   });//end of each   
		    			           		    	          
		    	     $("#QnAListResult").append(html);  
		    			  
		    			   
		    		 if($("#totalCount").text() < 10 ){
		    			 $("#btnMore").hide();
		    		 }	   
		    		 else{
		    			 $("#btnMore").show();
		    			 $("#btnMore").text("더보기");
		    		 }//totalCount가 10보다 작아서 더보기가 필요없을때 
		    		 
		    	     $("#btnMore").val(parseInt(start)+length); 
		    	     
		    	     
		    	     $("#count").text(parseInt($("#count").text()) + json.length);
		    	     
		    	     if($("#count").text() == $("#totalCount").text() ){
	    	       		$("#btnMore").text("처음으로");
	    	       		$("#count").text($("#totalCount").text());
		    	     }   
		    	     
		    	   }//end of else 
		    	   
		    	  
		       },
		       error: function(request, status, error){
  	     	      alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  	           }
          
		  
		  
	  });//end of ajax
	  
	  
	  
 }//end of displayQnAList
  */
 
/* function showDetail(qna_no, qna_userid)
 {
	  if(${(sessionScope.loginuser) == null})
		{
		 swal('로그인해야 볼 수 있습니다.');
		 
		 return;
		}
	 
		var url = "showQnADetail.do?qna_no="+qna_no+"&qna_userid="+qna_userid;
		
		window.open(url, "showQnADetail",
				    "left=350px, top=100px, width=700px, height=630px");
	 
	
	 
}   */


function goWrite(userid){
	 
	var url = "goWriteQnA.do?userid="+userid;
	
		window.open(url, "goWriteQnA",
				    "left=350px, top=100px, width=700px, height=500px");
		
}// end of MyQnA

/* function showMine(userid){
	 
	  var frm = document.WriteFrm;
	  
	  frm.method = "POST";
	  frm.action = "myqnaList.do";
	  frm.submit();
	  
} */

   
   
   
   
   
   
</script>  

 
 <%-- 상단에 탭메뉴이다. 탭을 클릭하면 링크타고 페이지 이동한다. --%> 
<div class="navtab" align="center">        
	 <ul class="nav nav-tabs abc">
		 <li><a data-toggle="tab1" href="<%= request.getContextPath() %>/mypage.action">Profile</a></li>
		 <li class="active"><a data-toggle="tab1" href="<%= request.getContextPath() %>/qna.action">Q&A</a></li>
		 <li ><a data-toggle="tab1" href="<%= request.getContextPath() %>/setting.action">Setting</a></li>
		 <li ><a data-toggle="tab1" href="<%= request.getContextPath() %>/edit.action">Edit</a></li> 
	</ul>   
</div>     
   
   



<!-- QnA 게시판 -->
<div class="super_container">
	
	<div class="cart_container" style="padding-top: 20px;">
		<div class="container" >
			<div class="row" >
				<div class="col" >
				
					<div class="row" >
						<div class="col">				
							<div class="cart_title">QnA 게시판</div>
							<br/>
						</div>
					</div>		
					
					 <form name="WriteFrm">
					   <div align="right" style="margin-bottom:15px;">
					   	<div>
					     <c:if test="${(sessionScope.loginuser).userid != 'admin' }">
					      <button type="button" class="btn btn-dark btn-sm"  onClick="goWrite('${(sessionScope.loginuser).userid}');">Q&A 글쓰기</button>
					     <%--  <button type="button" class="btn btn-dark btn-sm"  onClick="showMine('${(sessionScope.loginuser).userid}');">나의 글 보기</button> --%>
					 	 </c:if>
					 	 </div>
					   </div>
					 </form>  
					 <form name="statusFrm">
					     <c:if test="${(sessionScope.loginuser).userid == 'admin' }">
						      <select name="qna_status" id="qna_status">
						        <option value="'1','0'" selected>전체보기</option>
						        <option value="0">답변미완료</option>
						        <option value="1">답변완료</option>
						      </select>
						 </c:if> 
					  </form>
					   
					 <div style="border: 0px solid gold;"> 
					 <table class="table table-hover" style="border-bottom: 0.5px solid gray;  border-top:0.5px solid gray;">
					    <thead>
						      <tr>
						        <th style="text-align: center; white-space: pre;" >글번호</th>
						        <th style="text-align: center; white-space: pre;" >카테고리</th>
						        <th style="text-align: center; white-space: pre;" >제목</th>
						        <th style="text-align: center; white-space: pre;" >작성일자</th>
						        <th style="text-align: center; white-space: pre;" >작성자</th>
						        <th style="text-align: center; white-space: pre;" >답변상태</th>
						      </tr>
					    </thead>   
					    
					   <tbody id="QnAListResult" style="width:100%;">
						     <c:if test="${qnaList.size() == 0}">
						       	<tr><td colspan="6" style="text-align: center;">작성된 QnA가 없습니다.</td></tr><!-- align="center"  -->
						     </c:if> 
						     
					         <c:if test="${qnaList.size() > 0}">  
						        <c:forEach var="qnavo" items="${qnaList}">
									    <tr style="text-align: center;">
					        		    <td>${qnavo.qna_idx}</td>
					        		 <c:if test="${qnavo.fk_qna_category_idx == 1}">  
					        		    <td>기술문의</td>
					        		 </c:if>   
					        		 <c:if test="${qnavo.fk_qna_category_idx == 2}"> 
					        		    <td>기타</td>
					        		 </c:if>   
					        		    <td><a href='javascript:showDetail(\""+${qnavo.qna_depthno}+"\",\""+${qnavo.fk_userid}+"\");'>${qnavo.qna_title}</a></td>
					        		    <td>${qnavo.qna_date}</td>
					        		    <td>${qnavo.fk_userid}</td>
					        		  <c:if test="${qnavo.qna_depthno == 0}">
					        		    <td><span style="color: blue; ">대기중</span></td>
					        		  </c:if>
					        		  <c:if test="${qnavo.qna_depthno == 1}">
					        		    <td><span style="color: red; text-size: bold;">답변완료</span></td>
					        		  </c:if>
					        		    </tr>
				        		    </c:forEach>
	 			             </c:if>  
					   </tbody>
					</table>
					</div>
					
					
					<!-- 페이징 처리하기 -->
					<div style="margin-top: 20px; margin-bottom:20px; text-align:center;">
					 <%--  <button type="button" class="btn btn-dark btn-sm" id="btnMore" value="">더보기..</button>
					  <br/>
					  <span id="count" style="color:red; font-weight: bold;">0</span>/ <!-- 현재 내가 물건제품을 몇개만큼 받아왔는지 알아보기 위해  count변수사용 -->
					  <span id="totalCount" style="font-weight: bold;">${totalCount}</span> <!-- 총 물건갯수(totalHITCOUNT)보다 많아지면 더보기버튼을 안보여주기 위해 사용 -->
					   --%>
					</div>
					
				</div>
			</div>
		</div>
	</div>
	
	
	
</div>	 

<script src="resources/jihye/bootstrap4/popper.js"></script> 
<script src="resources/jihye/bootstrap4/bootstrap.min.js"></script>
<script src="resources/jihye/plugins/easing/easing.js"></script>
<script src="resources/jihye/plugins/parallax-js-master/parallax.min.js"></script>
<script src="resources/jihye/checkout_custom.js"></script>


