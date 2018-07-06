<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
   table, th, td {border: solid 1px gray;}
   
   #table, #table2 {width: 1000px; border-collapse: collapse;}
   
   #table th, #table td {padding: 5px;}
   
   #table th {width: 120px; background-color: #DDDDDD; }
   #table td {width: 860px;}
   
   a{text-decoration: none;}
   
  
</style>

    
<script type="text/javascript">


		
   // name, content, regDate
	function goWrite() {
			
		<%-- var frm = document.addWriteFrm;
		var contentval = frm.content.value.trim();
	
		if(contentval == ""){
			alert("댓글 내용을 입력하세요!!");
			return;
		}
		
		frm.action ="<%= request.getContextPath() %>/addComment.action";
		frm.method = "post";
		frm.submit(); --%>
		
		// 유효성 검사
		var frm = document.addWriteFrm;
		
		var nameval = frm.name.value.trim();
		
		if(nameval == "") {
			alert("로그인을 하세요!!!");
			return;
		}
		
		
		var contentval = frm.content.value.trim();
	
		if(contentval == "") {
			alert("댓글 내용을 입력하세요!!");
			return;
		}

		
		

		
		var data_form = {userid : frm.userid.value,
				         name : frm.name.value,
				         content: contentval,
				         parentSeq: frm.parentSeq.value};
		
		$.ajax({
			url:"<%= request.getContextPath() %>/addComment.action",
			data: data_form,
			type: "POST",
			dataType: "JSON",
			success: function(json) {
				var html = "";
				$.each(json, function(entryIndex, entry){
					
					html +=   "<tr>"
					html +=   "<td style='text-align: center;'>"+entry.name+"</td>";
					html +=   "<td>"+entry.content+"</td>";
					html +=   "<td style='text-align: center;'>"+entry.regDate+"</td>";
					html +=   "</tr>"
					
					$("#commentDisplay").prepend(html);
				});
				
							
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
		
	}	
	  
</script>	

<div style="padding-left: 10%;">
   <h1 style="margin-bottom: 30px;">글 내용 보기</h1>
   
   <table id="table">

        <tr>
            <th  style="width: 70px; text-align: center;">글번호</th>
            <td>${boardvo.seq}</td>
        </tr>     
        <tr>
            <th  style="width: 70px; text-align: center;">성명</th>
            <td>${boardvo.name}</td>
        </tr>          
        <tr>
            <th  style="width: 70px; text-align: center;">제목</th>
            <td>${boardvo.subject}</td>
        </tr>       
        <tr>
            <th  style="width: 70px; text-align: center;">내용</th>
            <td >${boardvo.content}</td>
        </tr>       
        <tr>
            <th  style="width: 70px; text-align: center;">조회수</th>
            <td>${boardvo.readCount}</td>
        </tr>       
        <tr>
            <th  style="width: 70px; text-align: center;">날짜</th>
            <td>${boardvo.regDate}</td>
        </tr>
        <%-- ==== #147.첨부파일 이름 및 파일크기를 보여주고 첨부파일 다운받게 만들기 --%>
        <tr>
            <th>첨부파일</th>
            <td>
                <c:if test="${sessionScope.loginuser != null}">
                   <a href="<%= request.getContextPath() %>/download.action?seq=${boardvo.seq}">${boardvo.orgFilename}</a>
                </c:if>
                <c:if test="${sessionScope.loginuser == null}">
                   ${boardvo.orgFilename}
                </c:if>
            </td>
        </tr>
         <tr>
            <th>파일크기(bytes)</th>
            <td>
               ${boardvo.fileSize}
            </td>
        </tr>
   </table>
   
   
   <br/>
   <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/list.action'">목록보기</button>
   <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/edit.action?seq=${boardvo.seq}'">수정</button>  
   <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/del.action?seq=${boardvo.seq}'">삭제</button>
   
   <br/>
   <br/>
   
   
   <!-- ==== #120. 답변글쓰기 버튼 추가하기(현재 보고 있는 글이 작성하려는 답변글의 원글(부모글)이 된다. ) ==== -->
   <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/add.action?fk_seq=${boardvo.seq}&groupno=${boardvo.groupno}&depthno=${boardvo.depthno}'">답변글쓰기</button>
                                                                                                       <!--  부모글의 값을 받기 때문에 boardvo를 불러서 넣는다. 그리고 fk_seq는 참조키가 아닌 seq랑 같은 것이기 때문에 seq를 넣음. -->
   <br/>
   
   <p style="margin-top: 3%; font-size: 16pt;">댓글쓰기</p>
   
   <!-- ==== #84. 댓글쓰기 form 추가 ====  -->
   <form name="addWriteFrm" action="">
      <input type="hidden" name="userid" id="userid" value="${sessionScope.loginuser.userid}" readOnly/>
          성명: <input type="text" name="name" id="name" value="${sessionScope.loginuser.name}" readOnly/>
          댓글내용:  <input type="text" name="content" id="content" size="90"/>
          
          <!-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) -->
          <input type="hidden" name="parentSeq" id="parentSeq" value="${boardvo.seq}"/>
          
          <button type="button" onclick="goWrite();">쓰기</button>
   </form>
   
   
   
   <!-- ===== #95. 댓글 내용 보여주기(댓글 있을 때만 보여주기) ==== -->
  
       <table id="table2" style="margin-top: 2%;">
          <tr>
              <th style="width: 15%; text-align: center;">댓글작성자</th>
              <th style="width: 67%; text-align: center;">내용</th>
              <th style="text-align: center;">작성일자</th>
          </tr>
    
        <tbody id="commentDisplay"></tbody>  
          <c:if test="${not empty commentList}">
             <c:forEach var="commentvo"  items="${commentList}">
                 <tr>
	                 <td style="text-align: center;">${commentvo.name}</td>
	                 <td>${commentvo.content}</td>
	                 <td style="text-align: center;">${commentvo.regDate}</td>
                 </tr>  
             </c:forEach>
          </c:if>  
          
       </table>
       
   
</div>


