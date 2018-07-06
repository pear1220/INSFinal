<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
   table, th, td {border: solid 1px gray;}
   
   /* ==== #143. 파일첨부가 되었으므로 테이블의 가로폭 늘이기 ==== */
	#table {board-collapse: collapse; width: 920px;}
   
   #table th, #table td {padding: 5px;}
   
   #table th {background-color: #DDDDDD; }
   
   a{text-decoration: none;}
   
   .subjectstyle {font-weight : bold;
                  color: navy;
                  cursor: pointer;}
</style>

    
<script type="text/javascript">
	
	$(document).ready(function(){   
		
		// 마우스오버 마우스 아웃 ==> hover
		$(".subject").hover(function(event){
			                  var $target = $(event.target);
			                  $target.addClass("subjectstyle");   // addClass가 css 효과를 준다.
			                  
		                   }, function(event){
		                	   var $target = $(event.target);
		                	  $target.removeClass("subjectstyle"); // 마우스 아웃되면 removeClass가 css 효과를 없앤다.
		                   });
		
		
		
	   searchkeep();	
	
	}); // end of $(document).ready(function()
			
	function goView(seq){ // 파라미터 글 번호 == seq
	
		frm = document.goViewFrm;
	    frm.seq.value = seq; // form 에 value값 넣어주기
		
	    frm.action = "view.action"; // 글 한 개 보기
		frm.method = "get";
		frm.submit();
	}// end of function goView()
	
	
	function goSearch(){ // 검색창
		
		var frm = document.searchFrm;
	<%--
	   // 유효성 검사로 검색어를 입력할 수 있게 하였다/ 
	    var searchval = $("#search").val().trim();
		
	    if(searchval == ""){
	    	alert("검색어를 입력하세요!!");
	    	return;
	    }
	    else { //검색어를 입력했을 경우
	    	frm.action = "<%= request.getContextPath() %>/list.action";
	        frm.method = "GET";
	        frm.submit();
	    }
	--%>
	
	   frm.action = "<%= request.getContextPath() %>/list.action";
	   frm.method = "GET";
	   frm.submit();
	
	} 
	
	
	function searchkeep(){ // 평상시에 안뜨고 검색했을 경우에만 이 function이 작동해야 한다.
		<c:if test="${ (colname != 'null' && not empty colname) && (search != 'null' && not empty search) }">
		    $("#colname").val("${colname}");
		    $("#search").val("${search}");
	    </c:if>
	}
	
	
</script>	

<div style="padding-left: 10%;">
   <h1 style="margin-bottom: 30px;">글목록</h1>
   
   <table id="table">
   
      <thead>
        <tr>
            <th  style="width: 70px; text-align: center;">글번호</th>
            <th  style="width: 360px; text-align: center;">제목</th>
            <th  style="width: 70px; text-align: center;">성명</th>
            <th  style="width: 180px; text-align: center;">날짜</th>
            <th  style="width: 70px; text-align: center;">조회수</th>
            
            <!-- ==== #144. 파일과 크기를 보여주도록 수정 ==== -->
            <th  style="width: 70px; text-align: center;">파일</th>
            <th  style="width: 100px; text-align: center;">크기(bytes)</th>
            
        </tr>
      </thead>
      <tbody>
          <c:forEach var="boardvo" items="${boardList}">
             <tr>
                 <td align="center" >${boardvo.seq}</td>
                 <td>
                 <%-- <span class="subject" onClick="goView('${boardvo.seq}');">${boardvo.subject}</span> --%> <!-- 글자에 span태그를 걸어 링크를 걸어두가나 클릭하면 이동하는 걸로 설정하자 -->
                 <%-- ==== #104. 글제목에 댓글의 갯수를 붙이도록 한다. --%>
                <%--  <c:if test="${boardvo.commentCount > 0}">
                     <span class="subject" onClick="goView('${boardvo.seq}');">${boardvo.subject}<span style="color: red; font-size: 5px; font-style: italic; font-size: smaller; vertical-align: sub;">[${boardvo.commentCount}]</span></span>
                     </c:if>
	                 <c:if test="${boardvo.commentCount == 0}">
	                     <span class="subject" onClick="goView('${boardvo.seq}');">${boardvo.subject}</span>
	                 </c:if> --%>
                 
                 
                 <%-- ==== #128. 글제목에 댓글의 갯수를 붙이도록 한다. 
                                                          답변글인 경우  제목 앞에 공백(여백)과 함께 Re 라는 글자를 붙인다.  --%>
                 <%-- 답변글이 아닌 원글인 경우 --%>     
                 <c:if test="${boardvo.fk_seq == 0}"> 
                    <c:if test="${boardvo.commentCount > 0}">
                     <span class="subject" onClick="goView('${boardvo.seq}');">${boardvo.subject}<span style="color: red; font-size: 5px; font-style: italic; font-size: smaller; vertical-align: sub;">[${boardvo.commentCount}]</span></span>
	                 </c:if>
	                 <c:if test="${boardvo.commentCount == 0}">
	                     <span class="subject" onClick="goView('${boardvo.seq}');">${boardvo.subject}</span>
	                 </c:if>  
                 </c:if>
   
                 <%-- 답변글인 경우 --%> 
                 <c:if test="${boardvo.fk_seq > 0}">
                    <c:if test="${boardvo.commentCount > 0}">
                     <span class="subject" onClick="goView('${boardvo.seq}');"><span style="color: red; font-style: italic; padding-left: ${boardvo.depthno * 20}px;">└Re&nbsp;&nbsp;</span> ${boardvo.subject}<span style="color: red; font-size: 5px; font-style: italic; font-size: smaller; vertical-align: sub;">[${boardvo.commentCount}]</span></span>
	                 </c:if>
	                 <c:if test="${boardvo.commentCount == 0}">
	                     <span class="subject" onClick="goView('${boardvo.seq}');"><span style="color: red; font-style: italic; padding-left: ${boardvo.depthno * 20}px;">└Re&nbsp;&nbsp;</span> ${boardvo.subject}</span>
	                 </c:if>   
                 </c:if>
                 
                
                
                 </td>
                 <td align="center">${boardvo.name}</td>
                 <td>${boardvo.regDate}</td>
                 <td align="center" >${boardvo.readCount}</td>  
                 
                 <%-- ==== #145. 첨부파일 여부 표시하기 ==== --%>
                 <td align="center" >
                     <c:if test="${not empty boardvo.fileName}">
                        <img src="<%= request.getContextPath() %>/resources/images/disk.gif">
                     </c:if>   
                 </td> 
                 <td align="center" >
                      <c:if test="${not empty boardvo.fileSize}">
                        ${boardvo.fileSize}
                     </c:if>   
                  </td>        
             </tr>
          </c:forEach>
      </tbody>
     
   </table>
   
   <form name="goViewFrm">
      <input type="hidden" name="seq" />
   </form>
   
   
   <%-- #117. 페이지바 보여주기 --%>
   <div align="center" style="width: 70%; margin-top: 20px; margin-left: -180px; margin-right: auto;">
       ${pagebar}
   </div>
   
   
   <!-- ==== #105. 글검색 폼 추가하기 : 글제목, 글내용, 글쓴이로 검색하도록 한다. ==== -->
   <div style="margin-top: 30px;">
   <form name="searchFrm">
      <select name="colname"  id="colname"" style="height: 26px;">
          <option value="subject">제목</option>   
          <option value="content">내용</option>
          <option value="name">글쓴이</option>    
      </select>
      <input type="text" name="search" id="search" size="40"/>
      <button type="button" onClick="goSearch();">검색</button>
   </form>
   </div>

</div>


