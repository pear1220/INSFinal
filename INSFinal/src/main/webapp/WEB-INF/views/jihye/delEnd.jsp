<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<script type="text/javascript">
  
  if(${requestScope.n == 1}) {
	//  alert("글삭제 성공!!");
	  location.href="<%= request.getContextPath() %>/qna.action";
	  // 수정된 자신의 글을 보여주는 페이지로 이동
  }
  else {
	 // alert("글삭제 실패, 암호가 일치하지 않습니다.!!");
	  history.back(); // 이전 페이지로 이동  <script> 자체가 javascript이기 때문에 javascript: 은 생략가능하다
  }
</script>    
    