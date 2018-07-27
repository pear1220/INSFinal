<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    



<script type="text/javascript">
	$(document).ready(function(){
		if(${sessionScope.loginuser == null}){
			alert("로그인이 필요합니다.");
			location.href = "<%=request.getContextPath()%>/index.action";
			return;
		}
		
		var star = "<i class='fa fa-star'></i>";
		var star_empty = "<i class='fa fa-star-o'></i>";
	
		
	    if(${projectInfo.project_favorite} == 0) { //초기화면에서 즐겨찾기 노출
	    	$(".clickA").html(star_empty);
	    }
	    else {
	    	$(".clickA").html(star);
	    } 
	   
	    $(".div-listname").hide();
		$(".div-addcard").hide();
		
		//addcard 클릭시 인풋창
		$(".addCardstyle").click(function(event){
		//	alert("아이디 확인용:" + $(this).attr("id"));
			$(this).hide();
			$(this).prev().show();
		});
		
	    //addlist 클릭시 인풋창
	    $("#addList").click(function(event){
	    	$("#addListstyle").hide();
	    	$(".div-listname").show();
	    	$("#listname").focus();
	 		$("#addList").removeClass("list-hover");
	 		$("#addList").css("opacity", "1.0");
	    }); 

	    //리스트명 인풋창에서 엔터키를 누르는 경우 함수 호출
		$("#listname").keydown(function(event){
			if(event.keyCode == 13){
				insertList();
			}
		}); 	 

	    
	/*     //리스트제목 클릭시 인풋창 스타일 변경, 제목 변경
	    $(".well").click(function(){
	  //  	var contentid = $(this).attr("id"); //클릭한 리스트 아이디
	  //  	var oldval = $(this).children('input').val();
	  //  	var newval = $(this).children('.newval').val();
	    	var oldval = $(this).children('.oldval').val();
	    	
	    	 $(this).keydown(function(event){
	    		if(event.keyCode == 13){
	    			;
	    			alert("new: " + newval + "   /  old: " + oldval);
	    			//	alert("리스트명 수정할까");
				//	var editList = 
				}
	    	}); 
	    }); */
	    
	    
		$("#mycontent").addClass("example1"); //프로젝트 배경이미지 노출
		
		$(".clickA").click(function(event){ //즐겨찾기 클릭시 즐겨찾기status값 update 
			event.preventDefault(); // href로 연결해 주지 않고 단순히 click에 대한 처리를 하도록 해준다.
			var form_data = $("form[name=updateFavorite]").serialize();
	
			$.ajax({
				url: "updateFavoriteStatus.action",
				type: "POST",
				data: form_data,    
				dataType: "JSON",
				success: function(data){
					if(data.project_favorite == "1") {
						$(".clickA").html(star);
						$("#favorite_status").val(data.project_favorite);
					}
					else {
						$(".clickA").html(star_empty);
						$("#favorite_status").val(data.project_favorite);
					} 
				},
				error: function(request, status, error){ 
					alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
				}
			}); // end of $.ajax  
		}); // end of $(".clickA").click

		
		
		$(".btn-addcard").click(function(){ //addcard버튼 클릭시 카드 생성하는 이벤트
			var card_title = $(this).prev().prev().val().trim(); //카드 타이틀
			var card_title_length = $(this).prev().prev().val().length;
			var list_idx = $(this).next().val();//리스트idx
			var userid = "${sessionScope.loginuser.userid}";//유저 아이디
		
			if(card_title_length == 0){
				alert("카드 타이틀은 공백으로 할 수 없습니다.");
				$(this).prev().prev().val("");
				$(this).prev().prev().focus();
				return;
			}
			else if(card_title_length > 400){
				alert("카드 타이틀은 한글200자, 영문400자 이내로 입력해주세요.");
				$(this).prev().prev().val("");
				$(this).prev().prev().focus();
				return;
			}
			
		 	if(card_title != "" && userid != null && list_idx != "" && card_title_length <= 400){
				var addCard_data = {"userid" : userid, "list_idx" : list_idx, "card_title" : card_title};
				$.ajax({
					url: "addCard.action",
					type: "POST",
					data: addCard_data,
					dataType: "JSON",
					success: function(data){
						if(data.result == 1){
						//	alert("카드가 생성되었습니다.");
							location.reload();
						}
						else{
							alert("카드 생성에 실패했습니다.");
						}
					},
					error: function(request, status, error){ 
				         alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
				    }
				}); //end of $.ajax 
			}
		}); // end of $(".btn-addcard").click
		
////////////////////////////////////////////////// 민재 ///////////////////////////////////////////////////////////////////////////////		
		$("#listsearchINproject").keyup(function(){
			
			 // alert("실행성공이다222222222222");
			 
			  if(${sessionScope.loginuser == null}){
					alert("로그인이 필요합니다.");
					location.href = "<%=request.getContextPath()%>/index.action";
					return;
			  }
			
			  if($("#listsearchINproject").val().trim() != ""){
				  
				  if($("#sel3").val() == 'list'){
					
					  searchListINproject();
					  
				  }
				  else if($("#sel3").val() == 'card'){
					  
					  searchCardINproject();
					  
				  }
				   
				  
				// alert("실행성공이다");
			  }
			  
			  if($("#listsearchINproject").val().trim() == ""){
				 
				 	/* $(".list-wrapper").show(); */
				 	// return;
				 	//abortRequest();
				 	alert("널");
				 	projectINlistRe();
				 	
			  } 
			  
		   }); // $("#search_input").keyup()-------------------------------------------------------------------
		  
		
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		
	}); // end of $(document).ready
	
	
	function insertList(){ //리스트를 추가하는 함수
		var list_name = $("#listname").val().trim();
		var project_idx = "${projectInfo.project_idx}";
		var userid = "${sessionScope.loginuser.userid}";
		
		if(list_name == ""){
			alert("리스트 이름은 공백으로 할 수 없습니다.");
			$("#listname").val("");
			$("#listname").focus();
			return;
		}
		else{
			var form_data = {"list_name" : list_name, "project_idx" : project_idx, "userid" : userid};
			
			$.ajax({
				url: "addList.action",
				type: "POST",
				data: form_data,
				dataType: "JSON",
				success: function(data){
					if(data.result == 1){
						alert("리스트가 생성되었습니다.");
						location.reload();
					}
					else{
						alert("리스트 생성에 실패했습니다.");
					}
				},
				error: function(request, status, error){ 
			         alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
			    }
			}); // end of $.ajax
		}
	} // end of insertList
	
	
	////////////////////////////////////////////////////////
	
	///////////////////////////////////////////////////////// 민재 //////////////////////////////////////////////////////////////////////////////
		function openNav() {
	
	    document.getElementById("mySidenav").style.width = "400px";
	    
	   	// Activity();  
	    selVal(); 
	   
	}

	function openNav2() {
	    document.getElementById("mySidesearch").style.width = "400px";
	   /*  document.getElementById("mySidenav").style.width = "0"; */
	}
	
	
	function openNav3(){
		document.getElementById("mySideactivity").style.width = "400px";
		
		selVal();
		// sel2Val();
		// Activity(); 
		/* $("#cardEditbtn").click(){
			Activity();
		}
		$("#cardDeletebtn").click(){
			Activity();
		}
		
		$("#cardAddbtn").click(){
			Activity();
		}
		$("#listCreatebtn").click(){
			Activity();
		} */
		
	}
	
	function closeNav() {
	    document.getElementById("mySidenav").style.width = "0";
	    document.getElementById("mySidesearch").style.width = "0";
	}

	function closeNav2() {
	    document.getElementById("mySidesearch").style.width = "0";
	    document.getElementById("mySidenav").style.width = "400px";
	}
	
	function closeNav3() {
	    document.getElementById("mySideactivity").style.width = "0";
	    /* document.getElementById("mySidenav").style.width = "400px"; */
	}
	

	
	function leaveProject(){
		
		var fk_project_idx = "${projectInfo.project_idx}";
		
		var frm = document.project_idxFrm;
		frm.fk_project_idx.value = fk_project_idx;// input 의 value 값에 fk_projcet_idx를 받아 입력해야 한다.
				
		frm.method = "GET";
		frm.action = "<%= request.getContextPath() %>/leaveProject.action";
		frm.submit();
		
	}

	
	function deleteProject(){
		
		var fk_project_idx = "${projectInfo.project_idx}";
		
		var frm = document.project_idxFrm;
		frm.fk_project_idx.value = fk_project_idx;// input 의 value 값에 fk_projcet_idx를 받아 입력해야 한다.
				
		frm.method = "GET";
		frm.action = "<%= request.getContextPath() %>/deleteProject.action";
		frm.submit();
		
	}
	
	function Activity(val){
					
		// alert("실행 확인용"); 
		alert("확인용 >>>>> " + val);
		
		var form_data1 = {fk_project_idx: "${projectInfo.project_idx}", /* $("#fk_project_idx").val() */
				          sel1Val: val}
		
		
		
		$.ajax({
			
			url: "<%= request.getContextPath()%>/projectRecordView.action",
			type: "get",
			data: form_data1,
			dataType: "json",
			success: function(json){
				
				$("#activitylist").empty();
				
				$("#projectRecordListMoreTB").empty();
						
				var html = "";
				
				if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
						
						if(entryIndex < 10){ 
							 
							html += "<tr>";
							html += "<td rowspan='3' class='imgtd' style='size: 10px;'><img src='<%=request.getContextPath()%>/resources/img/avatar1.jpg'";
							html += " alt='Avatar' class='avatar' /></td>";
							html += "<td style='font-weight: bold;'>"+entry.userid+"&nbsp;&nbsp;"+entry.record_dml_status+"</td>";
							html += "</tr>";
							html += "<tr>";
							html += "<td  style='font-size: 8pt;'>&nbsp;"+entry.project_record_time+"</td>";
							html += "</tr>";
							html += "<tr>";
							html += "<td style='font-size: 8pt; color: #b3b3b3;'>"+entry.card_title+" in "+entry.list_name+"</td>"; 
							html += "</tr>";
							html += "<tr>";
							html += "<td colspan='2' style='border: 1px solid #fed189;'></td>";
							html += "</tr>";
							
						 }
						
						
					});
					
					$("#projectRecordListTB").html(html);
					
					 if(json.length > 10 ){  
						
						html += "<tr style='height: 50px; text-align:center; border: 1px solid red;' >";
						html += "<td colspan='2' style='padding-top: 15px;'>";
						html += "<a style='cursor: pointer; color: #00a0df;' id='viewallactivity' href='javascript:void(0);'>view all activity</a></td>"; 
						/* html += "<a href='javascript:void(0);' id='clickFUN'>클릭확인</a></td>" */
						html += "</tr>";
						
				 	 } 
					
					$("#projectRecordListTB").html(html);
					
					$("#activitylist").html(html);
					
					$("#viewallactivity").click(function(){
						
						var html2 = "";
						
						alert("viewallactivity 성공");
						
						openNav3();
						
						$.each(json, function(entryIndex, entry){
														
							html2 += "<tr>";
							html2 += "<td rowspan='3' class='imgtd' style='size: 10px;'><img src='<%=request.getContextPath()%>/resources/img/avatar1.jpg'";
							html2 += " alt='Avatar' class='avatar' /></td>";
							html2 += "<td style='font-weight: bold;'>"+entry.userid+"&nbsp;&nbsp;"+entry.record_dml_status+"</td>";
							html2 += "</tr>";
							html2 += "<tr>";
							html2 += "<td  style='font-size: 8pt;'>&nbsp;"+entry.project_record_time+"</td>";
							html2 += "</tr>";
							html2 += "<tr>";
							html2 += "<td style='font-size: 8pt; color: #b3b3b3;'>"+entry.card_title+" in "+entry.list_name+"</td>"; 
							html2 += "</tr>";
							html2 += "<tr>";
							html2 += "<td colspan='2' style='border: 1px solid #fed189;'></td>";
							html2 += "</tr>";
						
							
							$("#projectRecordListMoreTB").html(html2);
						
						}); // end of $.each(json)------------------------------------------------------------ 
					 							
							$("#activitylistMore").html(html2);
												
					});// end of $("#viewallactivity1").click()------------------------------------------------
					
				}
				else{
										
					html = "<h2>프로젝트 내 활동이 없습니다.</h2>";
					
				}
				
					
				$("#activitylist").html(html);
				
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
		    }
			
		});
		
	}
	
/* 	$("#listsearchINproject").keyup(function(){
		
		  alert("실행성공이다222222222222");
		
		  if($("#listsearchINproject").val().trim() != ""){
			  searchINproject();
			  
			  alert("실행성공이다");
		  }
		  else if($("#listsearchINproject").val().trim() == ""){
			  //
		  }
		 
	   }); // $("#search_input").keyup()-------------------------------------------------------------------
	  */
	
	/* 프로젝트 내 리스트를 검색하는 함수 */
	function searchListINproject(){
		   
		var listsearchINproject = $("#listsearchINproject").val();
		var sel = $("#sel3").val()
		/* 리스트 form */
		var form_data2 = {fk_project_idx: "${projectInfo.project_idx}",
				          sel3Val : $("#sel3").val(),
				          listsearchINproject: listsearchINproject}
		
		/* if($("#listsearchINproject").val().trim() == ""){
			 
		 	projectINlistre();
		 	
	  	} */


		
		$.ajax({
			
			url: "<%= request.getContextPath() %>/listsearchINproject.action",
			type: "get",
			data: form_data2,
			dataType: "json",
			success: function(json){
				
				// 우선은 리스트나 카드의 정보를 json 으로 받아서 css 처리를 한다. 
				var html = "";
				
				if($("#sel3").val() == 'list'){
							
					 $(".list-wrapper").empty();
					 var html = "";
					
					$.each(json, function(entryIndex, entry){
				
						/* 카드 form */
						var project_idx = ${projectInfo.project_idx}; 
						
						
	
					  	if(entry.list_delete_status != 0){ 
					  		
								html += "<input type='text' class='project_listname newval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
								html += "<div id='list"+entryIndex+"' class='well list-hover' style='width:300px;display:inline-block; vertical-align: top; border-radius: 1em;'>";
								html += "<input type='text' class='project_listname newval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
								html += "&nbsp;&nbsp;&nbsp;<i class='fa fa-align-justify' style='font-size:24px'></i>";
								html += "<input type='hidden' class='project_listname oldval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
								html += "<input type='hidden' class='project_listname oldval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
								html += "<div class='card-wrapper' style='max-height:500px;overflow-y:auto; margin-top: 5%;'>";
								
								var listidx = entry.list_idx
								// alert("listidx"+ listidx);
					 	        cardinfo(project_idx, sel,listsearchINproject,listidx);
					 
								
								html += "</div>";
								html += "<div class='div-addcard'>";
/* 								html += "<textarea rows='2' cols='33' placeholder=;'Enter card title...'></textarea><br/>"; 
								html += "<button class='btn btn-default btn-addcard' style='margin-top: 10px;' >add Card</button>";  */
								html += "<input type='hidden' value='"+entry.list_idx+"'>";
								html += "</div>";
								/* html += "<span style='font-size: 12pt; color: gray;' id='addCardstyle"+entryIndex+"' class='addCardstyle'><i class='fa fa-plus'></i>&nbsp;add another card...</span>"; */
								html += "</div>";
								html += "</div>";
								
						}
					  	
							
						
						
				
				});
			
					$(".list-wrapper").html(html);

					
	/////////////////////////////////////////for 문				
					
				
			    }
		
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
		    }
			
		});
		
		
	}
	   
	/* 프로젝트 내에서 리스트를 검색할 시 카드 리스트를 불러오는 함수 */   
  	function cardinfo(fk_project_idx,sel3Val,listsearchINproject,fk_list_idx){
		// alert("시작");
		
		var form_data = {fk_project_idx: fk_project_idx,
				          sel3Val : sel3Val,
				          listsearchINproject: listsearchINproject,
				          fk_list_idx : fk_list_idx}
		
		$.ajax({
			
			url: "<%= request.getContextPath() %>/listsearchINproject_card.action",
			type: "get",
			data: form_data,
			dataType: "json",
			success: function(json){
				
				html = "";
				
				if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
						
						html += "<div class='panel panel-default'>";
						html += "<div class='panel-body' onClick='window.open('carddetail.action?projectIDX="+entry.fk_project_idx+"&listIDX="+entry.fk_list_idx+"&cardIDX="+entry.card_idx+"','window_name','width=800,height=710,location=no,status=no,scrollbars=yes');'>"+entry.card_title+"</div>";
						html += "</div>";
					});
					
					
						
				}
				
				$(".card-wrapper").html(html);
				
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
		    }
			
		}); // $.ajax({searchCardINproject.action});
	}
		
	// 프로젝트 내에서 카드를 검색하는 함수 
	  function searchCardINproject(){
		
			// alert("실행 성공");
		  
			var cardsearchINproject = $("#listsearchINproject").val();
			var sel = $("#sel3").val()
			/* 리스트 form */
			
			var form_data = {fk_project_idx: "${projectInfo.project_idx}",
					          sel3Val : sel,
					          cardsearchINproject: cardsearchINproject}
			
			$(".list-wrapper").empty();
			
			// alert("cardsearchINproject"+cardsearchINproject);
			
			// 프로젝트 내에서 검색한 카드의 list_idx 를 갖고 온다. 
			$.ajax({
				
				url: "<%= request.getContextPath() %>/cardsearchINproject_list.action",
				type: "get",
				data: form_data,
				dataType: "json",
				success: function(json){
					
					var html = "";
					
					if($("#sel3").val() == 'card'){
						
						if(json.length > 0){
							
							$.each(json, function(entryIndex, entry){
								
								/* var project_idx = ${projectInfo.project_idx};  */
								
								if(entry.list_delete_status != 0){  
							  		
									html += "<input type='text' class='project_listname newval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
									html += "<div id='list"+entryIndex+"' class='well list-hover' style='width:300px;display:inline-block; vertical-align: top; border-radius: 1em;'>";
									html += "<input type='text' class='project_listname newval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
									html += "&nbsp;&nbsp;&nbsp;<i class='fa fa-align-justify' style='font-size:24px'></i>";
									html += "<input type='hidden' class='project_listname oldval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
									html += "<input type='hidden' class='project_listname oldval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
									html += "<div class='card-wrapper' style='max-height:500px;overflow-y:auto; margin-top: 5%;'>";
									
									var fk_list_idx = entry.fk_list_idx;
									alert("fk_list_idx"+ fk_list_idx);
									 
						 	        cardinfo2(fk_project_idx, sel, cardsearchINproject, fk_list_idx);
						  
									html += "</div>";
									html += "<div class='div-addcard'>";
		/* 							html += "<textarea rows='2' cols='33' placeholder=;'Enter card title...'></textarea><br/>"; 
									html += "<button class='btn btn-default btn-addcard' style='margin-top: 10px;' >add Card</button>";  */
									html += "<input type='hidden' value='"+entry.list_idx+"'>";
									html += "</div>";
									/* html += "<span style='font-size: 12pt; color: gray;' id='addCardstyle"+entryIndex+"' class='addCardstyle'><i class='fa fa-plus'></i>&nbsp;add another card...</span>"; */
									html += "</div>";
									html += "</div>";
									
								}
								
							});
						}
						
						 
						
					}
					
					$(".list-wrapper").html(html);
					
					//searchCardINproject();
	
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
		    }
			
		});
			
			
	}   
	
	function cardinfo2(fk_project_idx, sel, cardsearchINproject, fk_list_idx){
		alert("시작2222222");
		var form_data = {fk_project_idx: fk_project_idx,
				         sel3Val : sel,
				         cardsearchINproject: cardsearchINproject,
				         fk_list_idx : fk_list_idx}
		
		alert("fk_project_idx" + fk_project_idx );
		alert("sel3Val" + sel3Val);
		alert("cardsearchINproject" + cardsearchINproject);
		alert("fk_list_idx" + fk_list_idx);
		
		$.ajax({
			
			url: "<%= request.getContextPath() %>/cardsearchINproject_card.action",
			type: "get",
			data: form_data,
			dataType: "json",
			success: function(json){
				
				html = "";
				
				if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
						
						html += "<div class='panel panel-default'>";
						html += "<div class='panel-body' onClick='window.open('carddetail.action?projectIDX="+entry.fk_project_idx+"&listIDX="+entry.fk_list_idx+"&cardIDX="+entry.card_idx+"','window_name','width=800,height=710,location=no,status=no,scrollbars=yes');'>"+entry.card_title+"</div>";
						html += "</div>";
					});
					
					
						
				}
				
				$(".card-wrapper").html(html);
				
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
		    }
			
		}); // $.ajax({searchCardINproject.action});
	} 
	   

	var se1Val = "";
	
	function selVal(){
		
		if($("#sel1").val() == null){
			
			sel1Val = $("#sel1").val("수정");
			
		} 
				
		sel1Val = $("#sel1").val($("#sel").val());	
		
		sel1Val = $("#sel1").val();
		
		console.log("버튼확인::::::"+se1Val);
		
		Activity(sel1Val); 
				
	}
	
 /* 	function sel2Val(){
 		
 		console.log("버튼확인22222::::::"+se1Val);
		
		if($("#sel1").val() == null){
			
			sel1Val = $("#sel1").val("수정");
			
		} 
		
		sel1Val = $("#sel1").val($("#sel2").val());	
		
		
		sel1Val = $("#sel1").val();
		
		console.log("버튼확인::::::"+se1Val);
		
		Activity(sel1Val);
		 
	}  */
	
	
	
 	$(document).mouseup(function (e){
		
		if(!$(".sidenav").is(e.target) && $(".sidenav").has(e.target).length == 0 ){
			
			closeNav(); 
			
		}
				
	});
	
/* 	function abortRequest() {

		alert("ajax 실행 중단");
		
	    httpRequest.abort();

	    document.getElementById("text").innerHTML = "Ajax 요청을 취소했습니다.";

	} */
	
	
function projectINlistRe(){
		
		alert("값 : ${projectInfo.project_idx}" );
		
		var form_data = {project_idx : "${projectInfo.project_idx}"}
				
		$(".list-wrapper").empty();
		
		$.ajax({
			url: "<%= request.getContextPath()%>/projectRe_list.action",
			type: "get",
			dataType: "json",
			data: form_data,
			success: function(json){
				
				var html = "";
										
				if(json.length == 0){
					html += "<div id='addList' class='well list-hover' style='width: 300px; display: inline-block; vertical-align: top; border-radius: 1em;'>";
					html += "<label for='addListstyle'>";
					html += "<span style='font-size: 14pt; color: gray; font-weight: bold;' id='addListstyle'><i class='fa fa-plus'></i>&nbsp;add another list...</span>";
					html += "</label>";
					html += "<div class='div-listname'>";
					html += "<input type='text' class='list-title' id='listname' placeholder='Enter list title...' maxlength='30'>";
					html += "<button class='btn btn-default' style='margin-top: 10px;' onClick='insertList();'>add List</button>";
					html += "</div>";
					html += "</div>";
				}
				else if(json.length > 0){
					
					$.each(json, function(entryIndex, entry){
					
						if(entry.list_delete_status != 0){
							html += "<div id='list"+entryIndex+"' class='well list-hover' style='width:300px;display:inline-block; vertical-align: top; border-radius: 1em;'>";
							html += "<input type='text' class='project_listname newval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
							html += "&nbsp;&nbsp;&nbsp;<i class='fa fa-align-justify' style='font-size:24px'></i>";
							html += "<input type='hidden' class='project_listname oldval' value='"+entry.list_name+"' style='background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;'/>";
							html += "<div class='card-wrapper' style='max-height:500px;overflow-y:auto; margin-top: 5%;'>";
													
							var list_idx = entry.list_idx;
							var fk_project_idx = entry.fk_project_idx;
							
							cardlistRe(fk_project_idx);
							
							html += "</div>";
							html += "<div style='margin-top: 5%;'>";
							html += "<div class='div-addcard'>";
							html += "<textarea rows='2' cols='33' placeholder='Enter card title...'></textarea><br/>";
							html += "<button class='btn btn-default btn-addcard' style='margin-top: 10px;' >add Card</button>";
							html += "<input type='hidden' value='"+entry.list_idx+"'>";
							html += "</div>";
							html += "<span style='font-size: 12pt; color: gray;' id='addCardstyle"+entryIndex+"' class='addCardstyle'><i class='fa fa-plus'></i>&nbsp;add another card...</span>";
							html += "</div>";
							html += "</div>";
							
						}
						
					});
					
					
					html += "<div id='addList' class='well list-hover' style='width: 300px; display: inline-block; vertical-align: top; border-radius: 1em;'>";
					html += "<label for='addListstyle'>";
					html += "<span style='font-size: 14pt; color: gray; font-weight: bold; padding-bottom: 10%;' id='addListstyle'><i class='fa fa-plus'></i>&nbsp;add another list...</span>";
					html += "</label>";
					html += "<div class='div-listname'>";
					html += "<input type='text' class='list-title' id='listname' placeholder='Enter list title...' maxlength='30'>";
					html += "<button class='btn btn-default' style='margin-top: 10px;' onClick='insertList();'>add List</button>";
					html += "</div>";
					html += "</div>";
					
				}
				
				$(".list-wrapper").html(html);
				
								
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
		    }
			
		});
	}
	
	function cardlistRe(fk_project_idx){
		
		
		// alert("cardlistRE 호출됨");
		var form_data = {projectIDX : fk_project_idx}
	
		$.ajax({
			
			url: "<%= request.getContextPath()%>/projectRe_card.action",
			type: "get",
			dataType: "json",
			data: form_data,
			success: function(json){
				
				var html = "";
				
				if(json.length > 0 ){
					
					$.each(json, function(entryIndex, entry){
						
						html += "<div class='panel panel-default'>";
						html += "<div class='panel-body' onClick='window.open('carddetail.action?projectIDX="+entry.fk_project_idx+"&listIDX="+entry.card_idx+"&cardIDX="+entry.card_idx+"','window_name','width=800,height=710,location=no,status=no,scrollbars=yes');'>"+entry.card_title+"</div>";
						html += "</div>";
														
					});
										
				}
				
				$(".card-wrapper").html(html);
				
			},
			error: function(request, status, error){
				alert("code : " + request.status+"\n"+"message : "+request.responseText+"\n"+"error : "+ error); // 어디가 오류인지 알려줌
		    }
				
		});
		
	} 
	
</script>

<style type="text/css">

 #mycontainer	{height:inherit;}
 
 .fa-star{font-size:20px; color:yellow;}
 .fa-star-o{font-size:20px; color: yellow;}
 .panel-body{overflow-y: auto;}
 
 .example1{ 
  background-image: url("./resources/images/${project_image_name}"); 
  background-color: white;
  background-size: cover;
  background-attachment: fixed;
  background-repeat: repeat-x;
  height: inherit; 
 }
 
 
 .list-hover{opacity: 0.1;}
 .list-hover:hover{opacity: 1.0;}
 
 .colStyle{cursor: pointer;}
 
 .list-wrapper{
 	white-space:nowrap;
 	overflow-x: auto;
 	overflow-y: hidden;
 	height:inherit;
 	padding-top: 40px;
 	padding-left: 20px;
 	padding-right: 10px;
 }
 
 .list-wrapper .well {
 	margin-right:10px;
 }
 
 .well{margin-top: 50px;
 	   opacity: 0.8;
 	   max-height: inherit;}
 
 .list-wrap{
 width: 272px;
 margin: 0 4px;
 height: 100%;
 /* box-sizing: border-box; */
 vertical-align: top;
 white-space: nowrap;
 }
 
  
 .list-title{
 display: block;
  width: 270px;
  height: 34px;
  padding: auto;
  font-size: 14px;
  line-height: 1.428571429;
  color: #8e8e93;
  vertical-align: middle;
/*   background-color: #ffffff; */
 /*  border: 1px solid #c7c7cc; */
  border: none;
  border-radius: 4px;  
  -webkit-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
  transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
 }
 
 .assign-to-team-list-item-content, .assign-to-team-create-content {
  cursor: pointer;
  &:hover {
    background: @light-gray-300;
  }
  border-radius: 4px;

  &.disabled {
    color: @quietcolor;
    cursor: default;
  }
}


/* ----------------------------------------------- 민재 -------------------------------------------- */
	.sidenav {
	    height: 100%;
	    width: 0;
	    position: fixed; 
	    z-index: 2; 
	    top: 0;
	    right: 0;
	    background-color: #111;
	    overflow-x: hidden;
	    transition: 0.5s;
	    padding-top: 100px;
	}
	
	.sidenav span {
	    padding: 8px 8px 8px 32px;
	    text-decoration: none;
	    font-size: 25px;
	    color: #818181;
	    display: block;
	    transition: 0.3s;
	    /* cursor: pointer; */
	}
	
	.sidenav span:hover {
	    color: #f1f1f1;
	}
	
	.sidenav .closebtn {
	    position: absolute;
	    top: 0;
	    right: 25px;
	    font-size: 36px;
	    margin-left: 50px;
	}
	
	
	@media screen and (max-height: 450px) {
	  .sidenav {padding-top: 15px;}
	  .sidenav a {font-size: 15px;} 
	}
	
	.imgtd {
		width: 100px;
		/* border: 1px solid green; */
		
	}
	
	#sel1 {
		width: 150px;	}
	
	.btnActivity{
		width:24%;
		height:30px;
		background-color: #00a0df; 
		color: white;
		font-size: 5pt;
		margin-bottom: 20px;
	}
	


</style>

	   <nav class="navbar navbar-inverse" style="width: 100%; margin-top: 20px; height: 30px; position: fixed; opacity: 0.7;">
		  <div class="container-fluid">
		    <div class="navbar-header" >
		      <a class="navbar-brand" href="#" ><span style="color: yellow;">${projectInfo.project_name}</span></a>
		    </div>
		    <ul class="nav navbar-nav">
	      	    <li id="favorite"><a class="clickA" href="#"></a></li>

		      	<c:if test="${projectInfo.project_visibility == '0'}">
		      		<li><a href="#">team visibility</a></li>
		      	</c:if>
		      	<c:if test="${projectInfo.project_visibility == '1'}">
		      		<li><a href="#">private</a></li>
		      	</c:if>
		      	<c:if test="${projectInfo.project_visibility == '2'}">
		      		<li><a href="#">public</a></li>
		      	</c:if>
		    </ul>
		    <p align="right">
		    <button class="btn btn-default" type="button" id="menu1" style=" background-color: black; margin-top: 5px; margin-bottom: 5px; color: black; border-color: black; "> 
	    		<span style="font-size: 13pt; color: yellow;" onclick='openNav();'>...Show Menu</span>
	   		</button></p>
		  </div>
	</nav> 

	<div class="list-wrapper">
	<c:if test="${listvo == null || listvo.size() == 0}">
		<div id="addList" class="well list-hover" style="width: 300px; display: inline-block; vertical-align: top; border-radius: 1em;">
			<label for="addListstyle">
				<span style="font-size: 14pt; color: gray; font-weight: bold;" id="addListstyle"><i class="fa fa-plus"></i>&nbsp;add another list...</span>
			</label>
			<div class="div-listname">
				<input type='text' class='list-title' id="listname" placeholder="Enter list title..." maxlength="30">
				<button class="btn btn-default" style="margin-top: 10px;" onClick="insertList();">add List</button>
			</div>
		</div>
	</c:if>
	
	<c:if test="${listvo.size() != 0}">
		<c:forEach items="${listvo}" var="vo" varStatus="status">
			<c:if test="${vo.list_delete_status != 0 }"><!--  list_delete_status != 0 인 경우에만 리스트 노출 -->
				<div id="list${status.count}" class="well list-hover" style="width:300px;display:inline-block; vertical-align: top; border-radius: 1em;">
					<input type="text" class="project_listname newval" value="${vo.list_name}" style="background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;"/>
					&nbsp;&nbsp;&nbsp;<!-- <i class="fa fa-trash-o" style="font-size: 25px;"></i> --><i class="fa fa-align-justify" style="font-size:24px"></i>
		 			<input type="hidden" class="project_listname oldval" value="${vo.list_name}" style="background-color:transparent; border:none; font-size: 14pt; color: gray; font-weight: bold;"/>
					<div class="card-wrapper" style="max-height:500px;overflow-y:auto; margin-top: 5%;">
					<c:if test="${vo.cardlist != null}">
						<c:forEach items="${vo.cardlist}" var="cardvo">
							<div class="panel panel-default">
							<%-- <div class="panel-body" onClick="location.href='<%=request.getContextPath()%>/carddetail.action?projectIDX=${vo.fk_project_idx}&listIDX=${cardvo.fk_list_idx}&cardIDX=${cardvo.card_idx}'">${cardvo.card_title}</div> --%>
							<div class="panel-body" onClick="window.open('carddetail.action?projectIDX=${vo.fk_project_idx}&listIDX=${cardvo.fk_list_idx}&cardIDX=${cardvo.card_idx}','window_name','width=800,height=710,location=no,status=no,scrollbars=yes');">${cardvo.card_title}</div>
							</div>
						</c:forEach>
					</c:if>
						<!-- <div class="panel panel-default">
							<div class="panel-body">카드 내용</div>
						</div> -->
					</div> 
					<div style="margin-top: 5%;">
						<div class="div-addcard">
							<textarea rows="2" cols="33" placeholder="Enter card title..."></textarea><br/>
							<button class="btn btn-default btn-addcard" style="margin-top: 10px;" >add Card</button>
						<!-- 	<button type="button" class="close">&times;</button> -->
							<input type="hidden" id="list_idx_input${vo.list_idx}" value="${vo.list_idx}">
						</div>
						<span style="font-size: 12pt; color: gray;" id="addCardstyle${status.count}" class="addCardstyle"><i class="fa fa-plus"></i>&nbsp;add another card...</span>
					</div>
					
			    </div>
	    	</c:if>
		</c:forEach>
		
		
		<div id="addList" class="well list-hover" style="width: 300px; display: inline-block; vertical-align: top; border-radius: 1em;">
			<label for="addListstyle">
				<span style="font-size: 14pt; color: gray; font-weight: bold; padding-bottom: 10%;" id="addListstyle"><i class="fa fa-plus"></i>&nbsp;add another list...</span>
			</label>
			<div class="div-listname">
				<input type='text' class='list-title' id="listname" placeholder="Enter list title..." maxlength="30">
				<button class="btn btn-default" style="margin-top: 10px;" onClick="insertList();">add List</button>
			</div>
		</div>
	</c:if>
	</div>
	
<!-- ----------------------------------------------------------  민재 ------------------------------------------------------------------------------- -->	
	<div id="mySidenav" class="sidenav">
	 	  <span style="font-size: 40pt; font-weight: bold;" onclick="Activity();">&#9776; menu</span>
	 	  <a href="javascript:void(0)"onclick="closeNav();"><span style="padding-left: 80%; ">&times;</span></a>
	 	  <span style="cursor:pointer" onclick="openNav2();">Search in PROJECT</span> 
		  <span style=" cursor: pointer;" onclick="location.href='<%= request.getContextPath()%>/leaveProject.action'" onclick="leaveProject();">Leave PROJECT</span> 
		  
		  
		  <span style="cursor: pointer;" onclick="location.href='<%= request.getContextPath() %>/deleteProject.action'" onclick="deleteProject();" >Delete PROJECT</span>
		 
		  <hr style="border: solid 1px gray; background-color: gray;"> 
		  <!-- <span>Activity</span> -->
		    <div class="form-group" style="padding-left:18pt; padding-top: 10pt; width: 150px; border: 0px solid yellow;">
		      <span style="padding-left: 10px;">Activity</span>
		      <select class="form-control" id="sel" name="sel" onchange="selVal();">     <!-- onclick="Activity();" -->
		        <option selected value="수정">CARD EDIT</option>
		        <option value="삭제">CARD DELETE</option>
		        <option value="추가">CARD ADD</option>
		        <option value="생성">LIST CREATE</option>
		      </select>
		    </div>           
		  
		  	<div class="container" style="background-color: #f2f2f2; border: 0px solid red; width:400px;" id="activitylist">
			  <!-- <h2>Activity</h2>  -->          
			  <table class="table" id="projectRecordListTB"> 			    	
			  </table>
		  	</div>
		  
		  
		 
		    
	  </div>
	  
	   <div id="mySideactivity" class="sidenav" style="border: 0px solid yellow;">
   		       
	  	  <span style="font-size: 40pt; font-weight: bold; cursor: pointer; float: left;" onclick="closeNav2();">Activity</span>
		  	  <ul class="w3-ul">
			    <span style="font-size: 30pt; margin-top: 20px; float: left;"><i class="fa fa-arrow-left" onclick="closeNav3();"></i></span>
		  	  </ul>
	  	  
	  	    
	  	  <div style="border: 0px solid yellow; margin-top: 100px;">
		  
	  	  </div>

		    
		    
		  
		  
		  <div class="container" style="background-color: #f2f2f2; border: 0px solid red; width:400px;" id="activitylistMore">
			  <!-- <h2>Activity</h2>  -->          
			  <table class="table" id="projectRecordListMoreTB">
			    			    	
			  </table>
		  </div>
	  </div>
	  
	  
	  <div id="mySidesearch" class="sidenav" style="border: 0px solid yellow;">     
	  	  <span style="font-size: 40pt; font-weight: bold; cursor: pointer; " onclick="closeNav2();">&#9776; menu</span>
		  <a href="javascript:void(0)" onclick="closeNav();"><span style="padding-left: 80%; font-size: 20pt;">&times;</span></a>
		  <span>&nbsp;&nbsp;&nbsp;Search in PROJECT</span>             
		  <div class="container" style="border: 0px solid yellow;" >
			  <form>
			    <div class="form-group" style="padding-left:18pt; padding-top: 10pt; width: 120px; border: 0px solid yellow;">
			      <select class="form-control" id="sel3" onclick="searchINproject();">    
			        <option selected value="list">LIST</option>
			        <option value="card">CARD</option>
			      </select>
			    </div>             
			  </form>
			  
			  <!--  search form start -->
		      <div class="nav search-row" id="top_menu" style="float: left; width: 300px; border: 0px solid orange;">
		      <form class="navbar-form" style="border: 0px solid yellow;">
		         <input class="form-control" placeholder="Search" type="text" id="listsearchINproject" style="float:left; hight: 500px; width: 300px; border: 0px solid yellow;"> 
		      </form>                        
		        <!--  search form start -->
		        <!-- <ul class="nav top-menu"> 
		          <li>
		            
		          </li>
		        </ul>  -->
		        <!--  search form end -->
		      </div>
		  </div>
	  </div>
	  
	 
	  
                           
	 <!--  <div style="float: left;">                     
		<br/>
		<span style="font-size:30px; cursor:pointer;" onclick="openNav();">&#9776; menu</span>
	  </div> -->
	
			
	
	  <form name="project_idxFrm">
	  	<input type="text" name="fk_project_idx" /><%-- value="${project_membervo.fk_project_idx}" --%>
	  	<input type="text" name="sel1Val" />
	  </form>

	  <div style="float: right;">
	  		<input type="text" id="sel1" name="sel1" value=""/>	
	  </div>
	
	
<form name="updateFavorite">
	<input type="hidden" name="userid" value="${projectInfo.member_id}">
	<input type="hidden" name="favorite_status" value="${projectInfo.project_favorite}" id="favorite_status">
	<input type="hidden" name="project_idx" value="${projectInfo.project_idx}">
</form>