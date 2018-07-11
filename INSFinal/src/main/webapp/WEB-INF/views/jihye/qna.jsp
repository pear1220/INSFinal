

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<jsp:include page="top.jsp" /> 
 
 
<style>

.subjectstyle {font-weight : bold;
                  color: navy;
                  cursor: pointer;}




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


/* table, th, td, input, textarea {border: solid gray 1px;}



#table {border-collapse: collapse;
       width: 1000px;
       }
#table th, #table td{padding: 5px;}
#table th{width: 120px; background-color: #DDDDDD;}
#table td{width: 860px;}
.long {width: 470px;}
.short {width: 120px;}        
 */
</style> 
  
<script> 
$(document).ready(function(){   
   
   // 마우스오버 마우스 아웃 ==> hover
   $(".subject").hover(function(event){
                        var $target = $(event.target);
                        $target.addClass("subjectstyle");   // addClass가 css 효과를 준다.
                        
                      }, function(event){
                         var $target = $(event.target);
                        $target.removeClass("subjectstyle"); // 마우스 아웃되면 removeClass가 css 효과를 없앤다.
                      });
   

}); // end of $(document).ready(function()
		

 function goView(qna_idx){ // 파라미터 글 번호 == seq
   
   console.log(qna_idx);
   
   frm = document.goViewFrm;
    frm.qna_idx.value = qna_idx; // form 에 value값 넣어주기
   
    frm.action = "view.action"; // 글 한 개 보기
   frm.method = "POST";
   frm.submit();
} // end of function goView() 



function goWrite(){
	
  var frm = document.qnaWriteFrm;
      
    frm.action="goWrite.action";
    frm.method = "post";
    frm.submit();
}


</script>  

 
 
   
   



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
               
                <div align="right" style="margin-bottom:15px;">
	                   <div>
		                    <c:if test="${(sessionScope.loginuser).userid != 'admin' }">
		                     <button id="goWrite"type="button" class="btn btn-dark btn-sm"  onClick="goWrite();">Q&A 글쓰기</button>
		                    <%--  <button type="button" class="btn btn-dark btn-sm"  onClick="showMine('${(sessionScope.loginuser).userid}');">나의 글 보기</button> --%>
		                    </c:if>
	                   </div>
                 </div>
                
                
                <form name="statusFrm">
                    <c:if test="${(sessionScope.loginuser).userid == 'admin' }">
                        <select name="qna_status" id="qna_status">
                          <option value="'1','0'" selected>전체보기</option>
                          <option value="0">답변미완료</option>
                          <option value="1">답변완료</option>
                        </select>
                   </c:if> 
                 </form>
                  
                <div id="qnaList" style="border: 0px solid gold;"> 
                <table class="table table-hover" style="border-bottom: 0.5px solid gray;  border-top:0.5px solid gray;">
                   <thead>
                        <tr>
                          <th style="text-align: center; white-space: pre;" >글번호</th>
                          <th style="text-align: center; white-space: pre;" >카테고리</th>
                          <th style="text-align: center; white-space: pre;" >제목</th>
                          <th style="text-align: center; white-space: pre;" >작성일자</th>
                          <th style="text-align: center; white-space: pre;" >작성자</th>
                         <!--  <th style="text-align: center; white-space: pre;" >답변상태</th> -->
                          <!-- ==== #144. 파일여부를 보여주도록 수정 ==== -->
				          <th style="text-align: center; white-space: pre;">첨부파일</th>
<!-- 				          <th  style="width: 100px; text-align: center;">크기(bytes)</th> -->
				        
                        </tr>
                   </thead>   
                   
                  <tbody id="QnAListResult" style="width:100%;">
                       <c:if test="${qnaList.size() == 0}">
                            <tr><td colspan="6" style="text-align: center;">작성된 QnA가 없습니다.</td></tr>
                       </c:if> 
                       
                        <c:if test="${qnaList.size() > 0}">  
                             <c:forEach var="map" items="${qnaList}">
                                <tr style="text-align: center;">
                                      <td>${map.rno}</td>      
                                <c:if test="${map.fk_qna_category_idx == 1}">  
                                      <td>기술문의</td>
                                 </c:if>   
                                 <c:if test="${map.fk_qna_category_idx == 2}"> 
                                       <td>기타</td>
                                  </c:if>  
                                 <c:if test="${map.qna_fk_idx == 0}">   
                                       <%--  <td style="text-align: left; padding-left: 40px;"><a href='<%= request.getContextPath() %>/view.action?qna_idx=${map.qna_idx}'>${map.qna_title}</a></td>  --%>
                                    <td style="text-align: left; padding-left: 40px;"><span class="subject" onClick="goView('${map.qna_idx}');">${map.qna_title}
                                    <c:if test="">
                                    <span style="color: red; font-size: 5px; font-style: italic; font-size: smaller; vertical-align: sub;">답변완료</span>
                                    </c:if>
                                    </span></td> 
                                   </c:if>
                                   <!-- 답변글인 경우  -->
		                         <c:if test="${map.qna_fk_idx > 0}">
				                        <%--  <td style="text-align: left; padding-left: 40px;" ><a href='<%= request.getContextPath() %>/view.action?qna_idx=${map.qna_idx}'><span style="color: red; font-style: italic; padding-left: ${map.qna_depthno * 20}px;">└Re&nbsp;&nbsp;</span> ${map.qna_title}<span style="color: red; font-size: 5px; font-style: italic; font-size: smaller; vertical-align: sub;">답변완료</span></a> --%>
				                         <td style="text-align: left; padding-left: 40px;"><span class="subject" onClick="goView('${map.qna_idx}');"><span style="color: red; font-style: italic; padding-left: ${map.qna_depthno * 20}px;">└Re&nbsp;&nbsp;</span> ${map.qna_title}<span style="color: red; font-size: 5px; font-style: italic; font-size: smaller; vertical-align: sub;">답변완료</span></span></td> 
				                 </c:if>      
		                                <td>${map.qna_date}</td>
		                                <td>${map.fk_userid}</td>
		                                
		                                
	                            <%--   <c:if test="${map.qna_depthno == 0}">
	                                     <td><span style="color: blue; ">대기중</span></td>
	                              </c:if>
	                              <c:if test="${map.qna_depthno == 1}">
	                                     <td><span style="color: red; text-size: bold;">답변완료</span></td>
	                              </c:if> --%>
	                              
	                             <%-- ==== #145. 첨부파일 여부 표시하기 ==== --%>
				                 <td align="center" >
				                     <c:if test="${not empty map.qna_filename}">
				                        <img src="<%= request.getContextPath() %>/resources/jihye/disk.gif">
				                     </c:if>   
				                 </td> 
				              <%--    <td align="center" >
				                      <c:if test="${not empty map.qna_byte}">
				                        ${map.qna_byte}
				                     </c:if>   
				                  </td> 
	                               --%>
	                              
                                 </tr>
                              </c:forEach>
                          </c:if>  
                  </tbody>
               </table>
              
               
               
                
			   <%-- #117. 페이지바 보여주기 --%>
			   <div align="center" style="width: 70%; margin-top: 20px; margin-left: -180px; margin-right: auto;">
			       ${pagebar}
			   </div>
			   
			   <%-- ==== #105. 글검색 폼 추가하기 : 글제목, 글내용, 글쓴이로 검색하도록 한다. ==== --%> 
				<!-- <div style="margin-top: 30px;">
				<form name="searchFrm">
					<select name="colname" id="colname" style="height: 26px;"> 
						<option value="subject">글제목</option>
						<option value="content">글내용</option>
						<option value="name">글쓴이</option>
					</select>
					<input type="text" name="search" id="search" size="40" />
					<button type="button" onClick="goSearch();">검색</button>
				</form>
				</div> -->
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

<form name="goViewFrm">
    <input type="hidden" name="qna_idx" />
 </form>
 
 <%-- qna 글쓰기 --%>
 <form name="qnaWriteFrm">
  <input type="hidden" name="fk_qna_category_idx" value="${map.fk_qna_category_idx}" />
  <input type="hidden" name="qna_groupno" value="${map.qna_groupno}" />
  <input type="hidden" name="qna_depthno" value="${map.qna_depthno}" />
 <%--  <input type="hidden" name="qna_idx" value="${qna_idx}" /> --%>
</form>


