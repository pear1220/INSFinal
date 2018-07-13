<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>      
<!DOCTYPE html >
<html>
<head>
<meta  charset="UTF-8">

 <title> HTML5AROUND.COM</title>
<style>
#orgFile {
 display:none;
}
#newFile {
 background-color:black;
 color:white;
 cursor:pointer;
}
</style>
<script>
/**이벤트 발생 (크롬,파이어폭스,사파이어 OK!) **/
function eventOccur(evEle, evType){
 if (evEle.fireEvent) {
 evEle.fireEvent('on' + evType);
 } else {
 //MouseEvents가 포인트 그냥 Events는 안됨~ ??
 var mouseEvent = document.createEvent('MouseEvents');
 /* API문서 initEvent(type,bubbles,cancelable) */
 mouseEvent.initEvent(evType, true, false);
 var transCheck = evEle.dispatchEvent(mouseEvent);
 if (!transCheck) {
 //만약 이벤트에 실패했다면
 console.log("클릭 이벤트 발생 실패!");
 }
 }
}
/** 대체버튼 클릭시 강제 이벤트 발생**/
function check(){
 eventOccur(document.getElementById('attach'),'click');
 /* alert(orgFile.value); 이벤트 처리가 끝나지 않은 타이밍이라 값 확인 안됨! 시간차 문제 */
 
}

function goImg(){
	
	     var bool = confirm("제출하시겠습니까?");
	
	     if(bool) {
	    	 var frm = document.goImg22;
			 frm.action= "/finalins/image/upload.action"; 
			 frm.method="post";
			 frm.submit();
			 return;
	     }
	     else {
	    	 self.close();
	    	 //여기서 self는 팝업창 자기자신을 말한다.
		     // 지금의 self는 upladod.jsp 페이지이다
	     }

}// end of goImg()
	 
function insertProfile(){
	var frm = document.divInsertImg;
	
	//frm.server_filename.value = server_filename;
	frm.action = "/finalins/image/insertProfile.action";
	frm.method ="post";
	frm.submit();
	
	//self.close();
	
}



</script>
</head>
<body>
<h3 style="color:blue">input type=file 대체버튼 만들기</h3>
<hr />
 <form name="goImg22" enctype="multipart/form-data">
 <input type="file" name="attach">
  <button type="button" onClick="goImg();" >등록</button> <!-- value="summit버튼" -->
 </form>
 
<c:if test="${membervo.org_filename != null}">
 <button type="button" onClick="insertProfile();">확인</button>
</c:if>


<form name="divInsertImg">
<input type="hidden" id="org_filename" name="org_filename" value="${membervo.org_filename}">
<input type="hidden" id="server_filename" name="server_filename" value="${membervo.server_filename}">
<input type="hidden" id="file_size" name="file_size" value="${membervo.file_size}">



</form>

</body>
</html>

    
    

