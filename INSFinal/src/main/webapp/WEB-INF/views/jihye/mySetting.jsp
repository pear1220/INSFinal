<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
    
<jsp:include page="top.jsp" /> 
   
<script>


</script>
 
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
							              <th>Invite Team Member</th>
							            </tr>
							          </thead>
							          <tbody>
							               <c:if test="${teamName.size() > 0}">   
                                             <c:forEach var="teamName" items="${teamName}">
									            <tr>
									              <td style="width: 60%;"><span style="color: orange;">${teamName.TEAM_NAME}</span> 에서 초대하셨습니다.</td> 
									              <td style="width: 10%;">
									              <button type="button" class="btn btn-primary btn-sm "  name="approveDeny" value="승인" onclick="location.href='<%= request.getContextPath() %>/approveTeam.action?approveDeny=승인'" >승인</button>
									              </td>
									              <td style="width: 10%;">
									              <button type="button" class="btn btn-warning btn-sm "   name="approveDeny" value="거절" onclick="location.href='<%= request.getContextPath() %>/approveTeam.action?approveDeny=거절'">거절</button>
									              </td>
									                
									            </tr>							 
							                </c:forEach>
							         </c:if>
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


