<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
.collapsible {

    background-color: #f5f5f5;
    color: #333333;
    cursor: pointer;
    padding: 10px 15px;
    width: 100%;
    border: 1px solid transparent;
    text-align: left;
    outline: none;
    font-size: 15px;
}

.content {
    padding: 0 18px;
    display: 1px soild gray;
    overflow: hidden;
    background-color: #fff;
}

#inputcss{
	/* //display: block; */
   /* // width: 100%; */
    font-weight:bold;
   	margin-left: 10px;
    height: 34px;
    padding: 6px 150px 10px 6px;
    font-size: 20px;
    line-height: 1.42857143;
    color: #777;
    background-color: #fff;
    background-image: none;
 	border: none;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
}

.attachBtn {
    background-color: DodgerBlue;
    border: none;
    color: white;
    padding: 12px 30px;
    cursor: pointer;
    font-size: 20px;
}

/* Darker background on mouse-over */
.attachBtn:hover {
    background-color: RoyalBlue;

</style>
<!-- jQuery -->
<script src="<%=request.getContextPath() %>/resources/card/vendor/jquery/jquery.min.js"></script>

<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script> --%>
<script type="text/javascript">
$(document).ready(function(){
	$(".content").hide();
	
/* 	if($("#inputcss").val().trim = ""){
		titleSelect();
	} */
	
	$("#inputcss").keydown(function(event) {	
		if (event.keyCode == 13) {
			titleUpdate();
		}
	}); // end of $("#inputcss").keydown()

	$('body').click(function(e) {
		if(!$('#titleInput').has(e.target).length) { 
			titleUpdate();
		}  
	});// end of $('body').click()------------------

});// end of $(document).ready()

// card 로그인 체크
function cardLoginCheck(){
	if(  ${sessionScope.loginuser.userid == null || sessionScope.loginuser.userid == "" || empty sessionScope.loginuser.userid }  ) {
    	alert("로그인이 필요한 메뉴입니다.");
    	location.href="/finalins/index.action";
    	return 0;
    } else {
    	var userid = "${sessionScope.loginuser.userid}";
    	var form_data = {cardidx :  "1",
    					userid : userid};
    	$.ajax({
    		url:"projectMemberCheck.action",
    		type:"GET",
    		data : form_data,
    		dataType: "JSON",
    		success: function(json) {
    			if(json.CNT == 0){
    				alert("프로젝트 멤버만 사용가능합니다.");
    		    	location.href="javascript:history.back();";
    		    	return 0;
    			}
    		}, 
    		error: function(request, status, error){ 
    			alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
    		}
    	});// end of $.ajax({})
    	
    	
    } // end of if~else------------------------------- 
} // end of LoginCheck()

// card 안 로그인 체크
function LoginCheck(){
	if(  ${sessionScope.loginuser.userid == null || sessionScope.loginuser.userid == "" || empty sessionScope.loginuser.userid }  ) {
    	location.href="/finalins/index.action";
    	return 0;
    } else {
    	var userid = "${sessionScope.loginuser.userid}";
    	var form_data = {cardidx :  "1",
    					userid : userid};
    	$.ajax({
    		url:"projectMemberCheck.action",
    		type:"GET",
    		data : form_data,
    		dataType: "JSON",
    		success: function(json) {
    			if(json.CNT == 0){
    		    	location.href="javascript:history.back();";
    		    	return 0;
    			}
    		}, 
    		error: function(request, status, error){ 
    			alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
    		}
    	});// end of $.ajax({})
    	
    	
    } // end of if~else------------------------------- 
} // end of LoginCheck()

// byte 수 계산
function getByteB(str) {
	var byte = 0;
	for (var i=0; i<str.length; ++i) {
	// 기본 한글 2바이트 처리
	(str.charCodeAt(i) > 127) ? byte += 3 : byte++ ;
	}
	return byte;
}


// 제목 수정
function titleUpdate(){
		
		var CNT = cardLoginCheck();
		if(CNT != 0){
			var cardtitle =  $("#inputcss").val().trim();
			var getbyte = getByteB(cardtitle);
			
			if(getbyte < 400 && cardtitle != ""){
		    	var form_data = {cardidx :  cardidx,// cardidx값 받아오면 넣어준다.
				                 cardtitle : $("#inputcss").val()} 
		
		    	$.ajax({
		    		url:"cardTitleUpdate.action",
		    		type:"POST",
		    		data : form_data,
		    		dataType: "JSON",
		    		success: function(json) {
		    		 		$("#inputcss").val(json.CARDTITLE);
		    		}, 
		    		error: function(request, status, error){ 
		    			alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
		    		}
		    	
		    	}); // end of ajax({})
			}else{
				alert("1~130자로 입력해주세요");
				location.href="javascript:history.go(0);"
			}
		}
 }// end of titleUpdate()

 // 설명 수정
 function goDescription(cardidx){

		var CNT = LoginCheck();
		if(CNT != 0){
		 var form_data = {cardidx :  cardidx,
						carddescription : $("#description").val()}
		 
			$.ajax({		
		 		url:"cardDescriptionCange.action",
		 		type:"POST",
		 		data : form_data,
		 		dataType: "JSON",
		 		success: function(json) {
		 			$("#description").val(json.DESCRIPTION);
		 		}, 
		 		error: function(request, status, error){ 
		 			alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
		 		}
		 	
		 	}); // end of ajax({})
		}
 }// end of goDescription()
 
 // 첨부파일 추가
 function goAttach(){
	 var Attach = $("#attach").val();
	 var CNT = LoginCheck();
		if(CNT != 0){
			if(Attach !=""){
				// form 전송하기
				var frm = document.fileFrm;
				frm.action="<%=request.getContextPath()%>/cardAttachInsert.action";
				frm.method ="post";
				frm.submit();
			}else{
				alert("파일이 없습니다.");
				location.href="javascript:history.go(0);"
			}
		}
 }
 
</script>
<body>
	<input type="hidden" id="cardidx" value="${cardMap.CARDIDX}"/>
    <div id="wrapper">
        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
             
              <span class="navbar-brand title" id="titleInput">
              	<i class="fa fa-columns"></i><input type="text"  id="inputcss" value="${cardMap.CARDTITLE}" /> 
              </span>
              
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                <li class="dropdown">
                    <a class="dropdown-toggle"  data-toggle="modal" href="#exampleModal">
                        <i class="fa fa-pencil-square-o fa-2x"></i>
                    </a>
                </li>
            </ul>
            <!-- /.navbar-top-links -->

        </nav>
 <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel" style="font-weight: bold;">Card Title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">Title</label>
            <input type="text" class="form-control" id="recipient-name">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Save</button>
      </div>
    </div>
  </div>
</div>

        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default" style="margin-top: 2%">
                        <div class="panel-heading">
                           <i class="fa fa-list-ul"></i> 
                           Description
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form role="form">
                                        <div class="form-group">
                                            <textarea class="form-control" id="description" rows="3" >${cardDetailMap.DESCRIPTION}</textarea>
                                        </div>
                                         <button type="button" class="btn btn-default" style="font-weight: bold;" onClick="goDescription('${cardMap.CARDIDX}')"><i class="fa fa-floppy-o"></i>Save</button>        
                                    </form>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /Description panel-body -->
                    </div>
                    <!-- /Description panel -->
                    
                     
                    <div class="panel panel-default" style="margin-top: 5%">
                        <div class="panel-heading">
                           <i class="fa fa-paperclip"></i>
                           Attachment
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form role="form" name="fileFrm" enctype="multipart/form-data">
                                        <div class="form-group">
                                        	<!-- 첨부파일 없으면 -->
                                        	<c:if test="${cardDetailMap.FILENAME == null && cardDetailMap.ORGFILENAME == null && cardDetailMap.BYTE == null}">
                                           	<!--  <label>File Uplode</label> -->
                                            <input name="attach" id="attach" type="file" />   
                                            <input type="hidden" name="fk_card_idx" value="${cardMap.CARDIDX}"/>                                
                                       	</div>  
	                                        <button type="button" class="btn btn-default" style="font-weight: bold;" onClick="goAttach('${cardMap.CARDIDX}')"><i class="fa fa-floppy-o"></i>Save</button>	                                       
	                                        </c:if>
	                                        <!-- 첨부파일이 있으면 -->
	                                        <c:if test="${not empty cardDetailMap.FILENAME}">
	                                        	${cardDetailMap.ORGFILENAME}
										</div> 
	                                    	    <button type="button" class="btn btn-default" style="font-weight: bold;" onClick="goAttach('${cardMap.CARDIDX}')"><i class="fa fa-download"></i>Download</button>
	                                    	    <button type="button" class="btn btn-default" style="font-weight: bold;" onClick="goAttach('${cardMap.CARDIDX}')"><i class="fa fa-trash"></i>Delete</button>
	                                    	   
	                                        </c:if>
                                    </form>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /Attachment panel-body -->        
                    </div>
                    <!-- /Attachment panel -->
                    
                    
                    <div class="panel panel-default" style="margin-top: 5%">
                        <div class="panel-heading">
                           <i class="fa fa-commenting"></i>
                           Comment
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form role="form">
                                        <div class="form-group">
                                            <textarea class="form-control" rows="3"></textarea>
                                        </div>
                                         <button type="button" class="btn btn-default" style="font-weight: bold;"><i class="fa fa-floppy-o"></i>Save</button>        
                                    </form>
                                </div>
                            </div>
                            <!-- /.row (nested) -->
                        </div>
                        <!-- /Comment panel-body -->        
                    </div>
                    <!-- /Comment panel -->
                    
  					<!-- /Activity button -->
					<button class="collapsible"> <i class="fa fa-list-alt"></i>
                           Activity</button>
					
					<div class="content">
					  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
					</div>
									
					<script>
					var coll = document.getElementsByClassName("collapsible");
					var i;
					
					for (i = 0; i < coll.length; i++) {
					    coll[i].addEventListener("click", function() {
					        this.classList.toggle("active");
					        var content = this.nextElementSibling;
					        if (content.style.display === "block") {
					           content.style.display = "none";
					           // content.style.display = "block";
					        } else {
					            content.style.display = "block";
					        }
					    });
					}
					</script>
					<!-- /Activity button -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->



    <!-- Bootstrap Core JavaScript -->
    <script src="<%=request.getContextPath() %>/resources/card/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="<%=request.getContextPath() %>/resources/card/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="<%=request.getContextPath() %>/resources/card/dist/js/sb-admin-2.js"></script>

</body>

</html>