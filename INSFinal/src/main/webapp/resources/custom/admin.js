 
  $(document).ready(function(){
	
	  $("#searchType").val("${searchType}"); 
	  
	  $("#searchWord").val("${searchWord}");
	   
	  $("#period").val("${period}");
	  
	  $("#sizePerPage").val("${sizePerPage}");

	  $("#sizePerPage").bind("change", function(){
		 var frm = document.memberFrm;
		 frm.method = "get";
		 frm.action = "memberList.do";
		 frm.submit();
	  });
	  
	  $("#period").bind("change", function(){
		 var frm = document.memberFrm;
		 frm.method = "get";
		 frm.action = "memberList.do";
		 frm.submit();
	  });
	  
		  
	  $("#searchWord").bind("keydown", function(event){
		  var keyCode = event.keyCode;
		  if(keyCode == 13) {
			  goSearch();
		  }
	  }); 
	  
	  $(".name").bind("mouseover", function(event){
		  var $target = $(event.target);
		  $target.addClass("namestyle");
	  });

	  $(".name").bind("mouseout", function(event){
		  var $target = $(event.target);
		  $target.removeClass("namestyle");
	  });
	  
  });// end of $(document).ready()----------------------------------

  function goDetail(userid, goBackURL) {
	  
	    var frm = document.useridFrm;
	    frm.userid.value = userid;
	    frm.goBackURL.value = goBackURL;
	
	    frm.method = "get";
	    frm.action = "memberDetail.do";
	    frm.submit();
	  
  }// end of function goDetail()--------------------------------------
  
  function goEdit(userid,goBackURL){
	  
	  var frm =document.useridFrm;
	  frm.userid.value= userid;
	  frm.goBackURL.value=goBackURL;
	  frm.method="post";
	  frm.action= "memberEdit.do";
	  frm.submit();
		  
	  
  }// end of goDel(userid,goBackURL)-----------
	
  function goDel(userid,goBackURL){
	  var bool = confirm(userid + "님의 회원정보를 정말로 삭제하시겠습니까?"); 
	  if(bool){
		  var frm =document.useridFrm;
		  frm.userid.value=userid;
		  frm.goBackURL.value=goBackURL;
		  frm.method="post";
		  frm.action= "memberDelete.do";
		  frm.submit();
	  }
  }// end of goDel(userid,goBackURL)-----------
  
  function goRecover(userid,goBackURL){
	  var frm =document.useridFrm;
	  frm.userid.value= userid;
	  frm.goBackURL.value=goBackURL;
	  frm.method="post";
	  frm.action= "memberRecover.do";
	  frm.submit();
  }// end of goRecover()----------------------
  
  function goSearch() {
			  
     if( $("#searchWord").val().trim() == "") {
 		// 검색어가 공백으로만 되었다면 
 		   alert("검색어를 입력하세요!!");
 		   $("#searchWord").val("");
 		   $("#searchWord").focus();
 		   return;
 		 /*
 		     javascript:history.go(-1); ==> 뒤로가기
 		     javascript:history.go(1);  ==> 앞으로가기
 		     javascript:history.go(0);  ==> 새로고침
 		     
 		     javascript:history.back();    ==> 뒤로가기
 		     javascript:history.forward(); ==> 앞으로가기
 		  */
 	  }
 	  else {
 		  	var frm = document.memberFrm;
 		  	frm.method="get";
 		  	frm.action="memberList.do";
 		  	frm.submit();
 	  }
  }// end of function goSearch()-----------------------------------