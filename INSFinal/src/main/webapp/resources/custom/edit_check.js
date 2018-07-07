
function goLogin()
{ // 로그인 처리
		var loginuserid = $("#UserId").val().trim();
		var loginPwd = $("#UserPwd").val().trim();
		
		if(loginuserid == "")
		{
			alert("아이디를 입력하세요");
			$("#UserId").focus();
			event.preventDefault();
			return;
			
		}else if(loginPwd == "")
		{
			alert("패스워드를 입력하세요");
			$("#UserPwd").focus();
			event.preventDefault();
			return;
		}else
		{
			var frm = document.loginFrm;
			frm.method="post";
			frm.action="loginEnd.do";
			frm.submit();
		}// end of if~else--------------------
	}// end of goLogin()-----------------------


function goCheck() // id 중복체크
{
		
		var userid = $("#userid").val().trim();
		
		if(userid == ""){
			 $("#error").show();
			 $("#userid").val("");
			 $("#userid").focus();
			 return;
		}else{	
		$("#error").hide();
		var frm = document.frmIdcheck;
		frm.method = "post";
		frm.action= "idDuplicateCheck.do";
		
		frm.submit();
		}
	}

$(document).ready(function(){
			
	    	$("#userid").focusout(function(){
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			 $("#error_userid").text("*아이디을 입력하세요!");
	        	}
	        	else
	        	{
	        		$(this).css("border-color", "#2eb82e");
	        		$('#submit').attr('disabled',false);
	        		$("#error_userid").text("");

	        	}
	       });
	    	$("#password").focusout(function(){
	    		var passwd = $(this).val().trim(); // 패스워드 값을 넣는다.
				
				var regexp_passwd = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
				// 패스워드를 검사해주는 정규표현식 객체 생성
				var bool = regexp_passwd.test(passwd); 
				
				
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			 $("#error_password").text("* 비밀번호를 입력하세요.");
	        	}
	    		else if(!bool)
	    			{
	    			$(this).css("border-color", "#FF0000");
        			$('#submit').attr('disabled',true);
        			 $("#error_password").text("* 비밀번호는 영문 대,소문자와 특수문자를 포함한 8~15자 입니다.");
	    			}
	        	else
	        	{
	        		$(this).css("border-color", "#2eb82e");
	        		$('#submit').attr('disabled',false);
	        		$("#error_password").text("");

	        	}
	       });
	    	
	    	$("#passwordchk").focusout(function(){
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			 $("#error_passwordchk").text("* 비밀번호를 한번 더 입력하세요.");
	        	}
	    		
	    		else if($(this).val()!=$("#password").val()){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			 $("#error_passwordchk").text("* 비밀번호와 다르게 입력하셨습니다.");
	        	}
	        	else
	        	{
	        		$(this).css("border-color", "#2eb82e");
	        		$('#submit').attr('disabled',false);
	        		$("#error_passwordchk").text("");

	        	}
	       });
	    				
	        $("#dob").focusout(function(){
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_dob").text("* 생년월일을 입력하세요.");
	        	}
	        	else
	        	{
	        		$(this).css("border-color", "#2eb82e");
	        		$('#submit').attr('disabled',false);
	        		$("#error_dob").text("");
	        	}
	       });
	        $("#myemail").focusout(function(){
	        	var email = $("#myemail").val().trim();
	        	var regexp_email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	        	var bool = regexp_email.test(email);
	        	
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_email").text("* E-Mail을 입력하세요.");
	        	}
	    		else if(!bool)
	    			{
	    			$(this).css("border-color", "#FF0000");
        			$('#submit').attr('disabled',true);
        			$("#error_email").text("* E-Mail을 올바르게 입력하세요.");	    			 
	   	         // e메일을 검사해주는 정규표현식 객체 생성
	    			}
	        	else
	        	{
	        		$(this).css("border-color", "#2eb82e");
	        		$('#submit').attr('disabled',false);
	        		$("#error_email").text("");
	        	}
	       });
	        
	        $("#gender").focusout(function(){
	        	$(this).css("border-color", "#2eb82e");
	       
	       });
	        
	        $("#myName").focusout(function(){
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_myName").text("* 이름을 입력하세요.");
	        	}
	        	else
	        	{
	        		$(this).css("border-color", "#2eb82e");
	        		$('#submit').attr('disabled',false);
	        		$("#error_myName").text("");
	        	}
	       });
	        $("#age").focusout(function(){
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_age").text("* 나이를 입력하세요.");
	        	}
	        	else
	        	{
	        		$(this).css({"border-color":"#2eb82e"});
	        		$('#submit').attr('disabled',false);
	        		$("#error_age").text("");

	        	}
	        	});
	        $("#address2").focusout(function(){
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_address").text("* 상세 주소를 입력하세요.");
	        	}
	        	else
	        	{
	        		$(this).css({"border-color":"#2eb82e"});
	        		$('#submit').attr('disabled',false);
	        		$("#error_address").text("");

	        	}
	        	});
	        
	        
	        $("#mobile2").focusout(function(){
	        	var tel2 = $(this).val().trim();
	        	var regexp_tel2 = /\d{3,4}/g; 
				// 3~4자리 숫자 입력 정규표현식
				var bool = regexp_tel2.test(tel2);
				
	            $pho =$("#phone").val();
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_phone").text("* 모바일 번호를 입력하세요.");
	        	}
	        	else if (!bool)
	        	{   
	                    $(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_phone").text("* 모바일 번호를 입력하세요.");
	        	}
	        	
	        	else{
	        		$(this).css({"border-color":"#2eb82e"});
	        		$('#submit').attr('disabled',false);
	        		$("#error_phone").text("");
	        	}

	    	});
	        $("#mobile3").focusout(function(){
	        	var tel3 = $(this).val().trim();
	        	var regexp_tel3 = /\d{3,4}/g; 
				// 3~4자리 숫자 입력 정규표현식
				var bool = regexp_tel3.test(tel3);
				
	            $pho =$("#phone").val();
	    		if($(this).val()==''){
	        		$(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_phone").text("* 모바일 번호를 입력하세요.");
	        	}
	        	else if (!bool)
	        	{   
	                    $(this).css("border-color", "#FF0000");
	        			$('#submit').attr('disabled',true);
	        			$("#error_phone").text("* 모바일 번호를 입력하세요.");
	        	}
	        	
	        	else{
	        		$(this).css({"border-color":"#2eb82e"});
	        		$('#submit').attr('disabled',false);
	        		$("#error_phone").text("");
	        	}

	    	});

	        //Focus out End
	        
	        ///////////////// Submit ///////////////////////
	   		$( "#submit" ).click(function() 
	   		{
	   			
	   			var bool = true;
	   			
	   			if($("#userid" ).val()=='')
	   			{
	        		$("#userid").css("border-color", "#FF0000");
	        		$("#error_userid").text("*아이디를 입력하세요!");
	        		
	        		bool = false;
	        	}	        	
	   				   		
				
	   			if($("#password").val().trim()=='')
	   			{
	   				$("#password").css("border-color", "#FF0000");	
        			$("#error_password").text("* 비밀번호를 입력하세요.");
        			
        			 bool = false;
	        	}
	
	   			
	   			
	   			if($("#passwordchk").val().trim()=='')
	   			{
	   				$("#passwordchk").css("border-color", "#FF0000");			
        			$("#error_passwordchk").text("* 비밀번호를 한번 더 입력하세요.");
        			
        			bool = false;
	        	}
	   			if($("#passwordchk").val() != $("#password").val())
	   			{
	        		$("#passwordchk").css("border-color", "#FF0000");
	        		$("#error_passwordchk").text("* 비밀번호와 다르게 입력하셨습니다.");
	        		
	        		bool = false;
	        	}
	   			
	   			
	   			if($("#dob").val()=='')
	   			{
	   				$("#dob").css("border-color", "#FF0000");
        			$("#error_dob").text("* 생년월일을 입력하세요.");
        			
        			bool = false;
	        	}
	   		
	   			if($("#myemail").val()=='')
	   			{
	   				$("#myemail").css("border-color", "#FF0000");
	   				$("#error_email").text("* E-Mail을 입력하세요.");
        			
        			bool = false;
	        	}
	 			if($("#myName").val()=='')
	   			{
	   				$("#myName").css("border-color", "#FF0000");
        			$("#error_myName").text("* 이름을 입력하세요.");
        			
        			bool = false;
	        	}
	   		
	 			
	   			if($("#age").val()=='')
	   			{
	   				$("#age").css("border-color", "#FF0000");
	   				$("#error_age").text("* 나이를 입력하세요.");
        			
        			bool = false;
	        	}
	   			
	   			if($("#address1" ).val()=='')
	   			{
	   				$("#address1").css("border-color", "#FF0000");
	   				$("#error_address").text("* 주소를 입력하세요.");
        			
        			bool = false;
	        	}
	   			
	   			if($("#address2").val()=='')
	   			{
	   				$("#address2").css("border-color", "#FF0000");
	   				$("#error_address").text("* 주소를 입력하세요.");
        			
        			bool = false;
	        	}
	   			
	   			if($("#postcode").val()=='')
	   			{
	   				$("#postcode").css("border-color", "#FF0000");
	   				$("#error_address").text("* 상세주 소를 입력하세요.");
        			
        			bool = false;
	        	}
	   		
	   			if($("#mobile2").val()=='')
	   			{
	   				$("#mobile2").css("border-color", "#FF0000");
	   				$("#error_phone").text("* 모바일 번호를 입력하세요.");
        			
        			bool = false;
	        	}
	   				   			
	  				
	   			if($("#mobile3").val()=='')
	   			{
	   				$("#mobile3").css("border-color", "#FF0000");
	   				$("#error_phone").text("* 모바일 번호를 입력하세요.");
        			
        			bool = false;
	        	}
	   			
	   		if(bool)
	   		{	
	   			var frm = document.registerFrm;
	   			frm.method = "post";
	   			frm.action = "memberEditEnd.do";
	   			frm.submit();	   		
	   		}
	   			
				});//submit end;
	   		
	   		
		});