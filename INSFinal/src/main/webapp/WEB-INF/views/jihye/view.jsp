<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="top.jsp" /> 

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
   // 유효성 검사
      var frm = document.addWriteFrm;
      
      var nameval = frm.name.value.trim();
      
      if(nameval == "") {
         alert("로그인을 하세요!!!");
         return;
      }
   }  
   
   
    function deletQna(qna_idx){
    	
    	
    	
    	
    	// 팝업창을 띄운 뒤 한 번 더 묻고 예/아니오 예라고 선택했을 때 del
    	var qna_idx = ${qnavo.qna_idx};
    	var frm = document.delFrm;
    	frm.qna_idx.value= qna_idx;;
    	frm.action = "del.action";
    	frm.method = "post";
    	frm.submit();
    	
    }
   
      
   
     
</script>   

<div style="padding-left: 10%;">
   <h1 style="margin-bottom: 30px;">글 내용 보기</h1>
   
   <table id="table">

        <tr>
            <th  style="width: 70px; text-align: center;">글번호</th>
            <td>${qnavo.qna_idx}</td>
        </tr>     
        <tr>
            <th  style="width: 70px; text-align: center;">성명</th>
            <td>${sessionScope.loginuser.name}</td>
        </tr>          
        <tr>
            <th  style="width: 70px; text-align: center;">제목</th>
            <td>${qnavo.qna_title}</td>
        </tr>       
        <tr>
            <th  style="width: 70px; text-align: center;">내용</th>
            <td >${qnavo.qna_content}</td>
        </tr>             
        <tr>
            <th  style="width: 70px; text-align: center;">날짜</th>
            <td>${qnavo.qna_date}</td>
        </tr>
        <%-- ==== #147.첨부파일 이름 및 파일크기를 보여주고 첨부파일 다운받게 만들기 --%>
        <tr>
            <th>첨부파일</th>
            <td>
                <c:if test="${sessionScope.loginuser != null}">
                   <a href="<%= request.getContextPath() %>/download.action?qna_idx=${qnavo.qna_idx}">${qnavo.qna_orgfilename}</a>
                </c:if>
                <c:if test="${sessionScope.loginuser == null}">
                   ${qnavo.qna_orgfilename}
                </c:if>
            </td>
        </tr>
         <tr>
            <th>파일크기(bytes)</th>
            <td>
               ${qnavo.qna_byte}
            </td>
        </tr>
   </table>
   
   
   <br/>
   <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/qna.action'">목록보기</button>
   <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/editQna.action?qna_idx=${qnavo.qna_idx}'">수정</button>  
   <button type="button" onClick="deletQna('${qnavo.qna_idx}')">삭제</button>
   
   <br/>
   <br/>
   
   
   <!-- ==== #120. 답변글쓰기 버튼 추가하기(현재 보고 있는 글이 작성하려는 답변글의 원글(부모글)이 된다. ) ==== -->
 <%--    <button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/goWrite.action">답변글쓰기</button> --%>
    <button id="goWrite"type="button" class="btn btn-dark btn-sm"  onClick="location.href='<%=request.getContextPath() %>/goWrite.action'">답변글쓰기</button>
                                                                                                       <!--  부모글의 값을 받기 때문에 qnavo를 불러서 넣는다. 그리고 fk_seq는 참조키가 아닌 seq랑 같은 것이기 때문에 seq를 넣음. -->
   <br/>
   
</div>

<script src="resources/jihye/bootstrap4/popper.js"></script> 
<script src="resources/jihye/bootstrap4/bootstrap.min.js"></script>
<script src="resources/jihye/plugins/easing/easing.js"></script>
<script src="resources/jihye/plugins/parallax-js-master/parallax.min.js"></script>
<script src="resources/jihye/checkout_custom.js"></script>


<form name="delFrm">
  <input type="hidden" name="qna_idx" />
</form>
