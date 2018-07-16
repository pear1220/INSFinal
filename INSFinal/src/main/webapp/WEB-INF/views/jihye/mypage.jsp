<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
    
<jsp:include page="top.jsp" /> 
   
<%--     
   <div class="navtab" align="center">    
	    <ul class="nav nav-tabs abc">
	    <!-- 부트스트랩 3.3.7버전에서 data-toggle에 tab이라 적으면 안된다 그래서 tab1이라 바꿨다. -->
	    <li class="active"><a data-toggle="tab1" href="<%= request.getContextPath() %>/mypage.action"><span style="color: black;">Profile</span></a></li>
	    <li><a data-toggle="tab1" href="<%= request.getContextPath() %>/qna.action">Q&A</a></li>
	    <li ><a data-toggle="tab1" href="<%= request.getContextPath() %>/setting.action">Setting</a></li>
	    <li ><a data-toggle="tab1" href="<%= request.getContextPath() %>/edit.action">Edit</a></li> 
	   </ul>   
   </div>     

 --%>
 
 
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
							          <thead>
							              <tr >
							                 <th style="text-align: center;">프로젝트</th>
							                 <th style="text-align: center;">리스트</th>
							                 <th style="text-align: center;">카드</th>
							                 <th style="text-align: center;">내용</th>
							                 <th style="text-align: center;" >기록시간</th>
							              </tr>
							            </thead>
							          <c:if test="${myRecordList != null}">
							          <c:forEach var="map" items="${myRecordList}">
							            
							            <tbody>
							            <tr>
							              <td style="text-align: center;"><a href="#team1">${map.PROJECT_NAME}</a></td> 
							              <td style="text-align: center;"><a href="#team1">${map.LIST_NAME}</a></td>
							              <td style="text-align: center;"><a href="#team1">${map.CARD_TITLE}</a></td>
							              <td style="text-align: center;" ><a href="#team1">${map.RECORD_DML_STATUS}</a></td> 
							              <td style="text-align: center;"><a href="#team2">${map.PROJECT_RECORD_TIME}</a></td>  							           
							            </tr>
							         </tbody>
							          </c:forEach>
							          </c:if>

							           <%--  
							            <tr>
							              <td>John</td>      
							            </tr>
							              --%> 
							           </tbody>
							         </table> 
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


