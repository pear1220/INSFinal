<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
    
<jsp:include page="top.jsp" /> 

<style>
a {
    text-decoration: none;
    display: inline-block;
    padding: 8px 16px;
}

a:hover {
    background-color: #ddd;
    color: black;
}

.previous {
    background-color: #f1f1f1;
    color: black;
}

.next {
    background-color: #4CAF50;
    color: white;
}

.round {
    border-radius: 50%;
}
</style>

 
<div class="super_container"> 
   <div class="cart_container" style="padding-top: 20px;">
      <div class="container" >
         <div class="row" >
            <div class="col" > 

					  <div class="tab-content">
						    <div id="profile" class="tab-pane fade in active">
						           <!-- 팀목록 -->
							       <div>
							        <table class="table table-hover">
							          <thead>
							            <tr>
							              <th>Teams</th>
							            </tr>
							          </thead>
							          <tbody>
							              <c:if test="${teamList.size() > 0}">  
                                             <c:forEach var="teamvo" items="${teamList}">
									            <tr>
									              <td><a href="#팀페이지로 이동하기">${teamvo.team_name}</a></td>      
									            </tr>
							 
							                </c:forEach>
							             </c:if> 
							           </tbody>
							         </table> 
							       </div>
						               
						          <!-- activity 기록 목록 -->						        					          
							      <div>
							        <table class="table table-hover">
							          <thead>
							            <tr>
							              <th>Activity</th>
							            </tr>
							          </thead>
							          <c:if test="${myRecordList.size() <1 }">						         					        
							              <td style="text-align: center;">${sessionScope.loginuser.name}님의 개인 활동 기록이 없습니다.</td>
							            </c:if>  
							        <c:if test="${myRecordList.size() > 0}"> 
							           
							          <thead>
							              <tr >
							                 <th style="text-align: center;">프로젝트</th>
							                 <th style="text-align: center;">리스트</th>
							                 <th style="text-align: center;">카드</th>
							                 <th style="text-align: center;">내용</th>
							                 <th style="text-align: center;" >기록시간</th>
							              </tr>
							            </thead>         
							            <tbody id="recordList">
							              <c:forEach var="map" items="${myRecordList}">
							            <tr>
							            	   <td style="text-align: center;"><a href="#team1">${map.PROJECT_NAME}</a></td> 
								              <td style="text-align: center;"><a href="#team1">${map.LIST_NAME}</a></td>
								              <td style="text-align: center;"><a href="#team1">${map.CARD_TITLE}</a></td>
								              <td style="text-align: center;" ><a href="#team1">${map.RECORD_DML_STATUS}</a></td> 
								              <td style="text-align: center;"><a href="#team2">${map.PROJECT_RECORD_TIME}</a></td>						              					           								             						           
							            </tr>
							             </c:forEach> 
							                </c:if>  
							         </tbody>					
							         </table> 
							         
							           <%-- #117. 페이지바 보여주기 --%>
				   <div align="center" style="width: 70%; margin-top: 20px;  margin-left: 100px;  margin-right: auto;">
				       ${pagebar}
				   </div>
							         
							       <!--  <div class="btnclass" style="margin-top: 20px; margin-bottom: 20px; text-align:center;">				       
						           <button type="button"  class="btn btn-primary btn-sm" id="btnMore" value="" >더보기....</button>
							       </div> --> 
							               
					        </div>
					  </div>
                </div>
            </div>
         </div>
      </div>
   </div> 
</div>


<script src="resources/jihye/bootstrap4/popper.js"></script> 
<script src="resources/jihye/bootstrap4/bootstrap.min.js"></script>
<script src="resources/jihye/plugins/easing/easing.js"></script>
<script src="resources/jihye/plugins/parallax-js-master/parallax.min.js"></script>
<script src="resources/jihye/checkout_custom.js"></script>


