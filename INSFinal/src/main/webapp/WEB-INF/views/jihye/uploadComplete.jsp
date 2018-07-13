<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<title>업로드 결과 페이지</title>
<style type="text/css">
	.failed {
		color: red;
		font-style: bold;
		font-size: x-large;
	}
</style>
>
	<c:choose>
		<c:when test="${membervo.org_filename != null }">
		<%-- 파일 업로드 완료
		<ul>
			
			<li>저장된 파일 이름 : ${membervo.org_filename}</li>
			<li>파일 길이 : ${membervo.file_size}</li>
			<li>MIME 타입 : ${membervo.contentType}</li>
		</ul>
		 --%>
		<%-- <img src="<%= request.getContextPath() %>/resources/jihye/${membervo.org_filename}"> --%>
		 첨부하시겠습니까?
		 
		 
		</c:when> 
		<c:otherwise>
		<span class="failed">파일 업로드 실패</span>		
		</c:otherwise>
	</c:choose>
