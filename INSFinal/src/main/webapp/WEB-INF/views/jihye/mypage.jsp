<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="top.jsp" /> 
   
    
   <div class="navtab" align="center">    
	    <ul class="nav nav-tabs abc">
	    <!-- 부트스트랩 3.3.7버전에서 data-toggle에 tab이라 적으면 안된다 그래서 tab1이라 바꿨다. -->
	    <li class="active"><a data-toggle="tab1" href="<%= request.getContextPath() %>/mypage.action"><span style="color: black;">Profile</span></a></li>
	    <li><a data-toggle="tab1" href="<%= request.getContextPath() %>/qna.action">Q&A</a></li>
	    <li ><a data-toggle="tab1" href="<%= request.getContextPath() %>/setting.action">Setting</a></li>
	    <li ><a data-toggle="tab1" href="<%= request.getContextPath() %>/edit.action">Edit</a></li> 
	   </ul>   
   </div>     



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
		            <tr>
		              <td><a href="#team1">John</a></td>      
		            </tr>
		            <tr>
		              <td><a href="#team2">Mary</a></td>      
		            </tr>
		           <%--  <c:forEach items="">
		            <tr>
		              <td>John</td>      
		            </tr>
		          </c:forEach>    --%> 
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
		          <tbody class="activity">
		            <tr>
		              <td><a href="#team1">내용</a></td>      
		            </tr>
		            <tr>
		              <td><a href="#team2">내용</a></td>      
		            </tr>
		           <%--  <c:forEach items="">
		            <tr>
		              <td>John</td>      
		            </tr>
		          </c:forEach>    --%> 
		           </tbody>
		         </table> 
		       </div>
        </div>
  </div>





