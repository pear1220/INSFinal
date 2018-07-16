<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
   
<jsp:include page="top.jsp" /> 



<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/js/jquery-3.3.1.min.js"></script>



<style type="text/css">
   table#tblGender {width: 100%;
                    margin-top: 10%;
                    border: 1px solid gray;
                    border_collapse: collapse;}
                    
   table#tblGender th, table#tblGender td {border: 1px solid gray;
                                           text-align: center;} 
                                                               
   table#tblGender th {background-color: #ffffe6;}

</style>



<script type="text/javascript">

  $(document).ready(function(){
     
     callAjax();
     callAjax2();
     
    /*  $("#btnOK").click(function(){
       
        var chartType = $("#chartType").val();
        
        callAjax(chartType);
        
     });// end of $("#btnOK").click
     
     $("#btnClear").click(function(){
          
       $("#chart").empty();
       $("#tbl").empty();
        
     });// end of $("#btnClear ").click
      */
     
  });
  
 /*  
  function callAjax(chartType){
     
     switch(chartType){
          case "job" : */
          function callAjax(){        
            $.ajax({
             
               url: "adminChartJSON_job.action",
               type: "GET",
               dataType: "JSON",
               success: function(json){ // 배열타입 jsonArray는 [{},{},{},..,{}] 이런식으로 나올 것이다.
                //  $("#chart").empty();
                //  $("#tbl").empty();
                  
                  console.log("성공");
                  var resultArr = [];
                  
                  for(var i=0; i<json.length; i++){
                     var obj = {name : json[i].job,    // 위의 json배열 결과물의 i번째 값의 job 키값
                              y : Number(json[i].percent) }; // 배열 json i번째 값의 점유율  
                                                      // json에서는 name과 y에 들어가는 값은 전부 String이지만 실질적으로 y의 값은 숫자이기 때문에 
                                                      // 꼭 Number(json[i].percent)로 해줘야 한다.
                                                      // 객체는 키값이랑 같이 들어온다. A : A'
                       resultArr.push(obj)   // 배열 속에 값 넣기     
                                             // resultArr을 밑에 차트 data에 넣어주면 된다.
                  } 
                  
                  ////////////////////////////////
                   Highcharts.chart('chart1', {
                      chart: {
                        plotBackgroundColor: null,
                        plotBorderWidth: null,
                        plotShadow: false,
                        type: 'pie'
                      },
                      title: {
                        text: '직업별 인원수'
                      },
                      tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                      },
                      plotOptions: {
                        pie: {
                          allowPointSelect: true,
                          cursor: 'pointer',
                          dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
                            style: {
                              color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
                            }
                          }
                        }
                      },
                      series: [{
                        name: '구성비율',
                        colorByPoint: true,
                        data: resultArr
                      }]
                    });
                  
                  
                  var html = "<table id='tblGender'>"
                           + "<thead>"
                           + "<tr>"
                           + "<th>직업</th>"
                           + "<th>인원수</th>"
                           + "<th>비율(%)</th>"
                           + "</tr>"
                           + "</thead>"
                          + "<tbody>";
                          
                          
                  $.each(json, function(entryIndex, entry){
                     html += "<tr>";
                     html += "<td>"+entry.job+"</td>";
                     html += "<td>"+entry.cnt+"</td>";
                     html += "<td>"+entry.percent+"</td>";
                     html += "</tr>";
                  });
                  
                    html += "</tbody>";
                    html += "</table>";
                    
                    $("#tbl").html(html);
                  
               },
               error: function(request, status, error){ //ajax 요청에 의해 실행했으나 데이터를 받아오는데 실패한 경우, 디버깅을 위해 error를 실행한다.
                      alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
                  }
            
               
            });
          }   

      /*   break;
              
         case "ageline" :
             */
      function callAjax2(){             
            $.ajax({
                
               url: "adminChartJSON_ageline.action",
               type: "GET",
               dataType: "JSON",
               success: function(json){
                  
                //  $("#chart").empty();
                //  $("#tbl").empty();
                  
                      var resultArr = [];
                  
                  for(var i=0; i<json.length; i++){
                     var subArr = [ json[i].ageline, Number(json[i].cnt)];
                     resultArr.push(subArr);
                  } 
                 
                  
                //////////////////////////////////////////////////////////////////////////////////////////  
                 
                  Highcharts.chart('chart2', {
                      chart: {
                          type: 'column'
                      },
                      title: {
                          text: '연령대별 인원수'
                      },
                      subtitle: {
                          text: 'Source: <a href="http://www.google.com">Google</a>'
                      },
                      xAxis: {
                          type: 'category',
                          labels: {
                              rotation: -45,
                              style: {
                                  fontSize: '13px',
                                  fontFamily: 'Verdana, sans-serif'
                              }
                          }
                      },
                      yAxis: {
                          min: 0,
                          title: {
                              text: '인원수 (명)'
                          }
                      },
                      legend: {
                          enabled: false
                      },
                      tooltip: {
                          pointFormat: '연령대별 인원수 : <b>{point.y:.1f} millions</b>'
                      },
                      series: [{
                          name: 'Population',
                          data: resultArr,
                          dataLabels: {
                              enabled: true,
                              rotation: -90,
                              color: '#FFFFFF',
                              align: 'right',
                              format: '{point.y:.0f}', // one decimal  // 1을 0으로 바꿔 소수부를 없앴따.
                              y: 10, // 10 pixels down from the top
                              style: {
                                  fontSize: '13px',
                                  fontFamily: 'Verdana, sans-serif'
                              }
                          }
                      }]
                  });
                  
                
               },
               error: function(request, status, error){ //ajax 요청에 의해 실행했으나 데이터를 받아오는데 실패한 경우, 디버깅을 위해 error를 실행한다.
                      alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
                 }
              
            });
         }
      //  break;
              
        /*  case "deptno" :  // 부서별 평균연봉을 구하고 테이블에는 평균 인원수까지 구하기!!
            $.ajax({
                
               url: "mybatisTest16JSON_deptname.action",
               type: "GET",
               dataType: "JSON",
               success: function(json){
                  
                  $("#chart").empty();
                  $("#tbl").empty();
                  
                      var resultArr = [];
                  
                  for(var i=0; i<json.length; i++){
                     var subArr = [ json[i].deptname, Number(json[i].avgsalary)];
                     resultArr.push(subArr);
                  } 
         
              /////////////////////////////////////////////
                    
                  Highcharts.chart('chart', {
                      chart: {
                          type: 'column'
                      },
                      title: {
                          text: '부서번호별 평균연봉'
                      },
                      subtitle: {
                          text: 'Source: <a href="http://www.google.com">Google</a>'
                      },
                      xAxis: {
                          type: 'category',
                          labels: {
                              rotation: -45,
                              style: {
                                  fontSize: '13px',
                                  fontFamily: 'Verdana, sans-serif'
                              }
                          }
                      },
                      yAxis: {
                          min: 0,
                          title: {
                              text: '평균연봉 ($)'
                          }
                      },
                      legend: {
                          enabled: false
                      },
                      tooltip: {
                          pointFormat: 'Average Salary in Department: <b>{point.y:.0f} $</b>'
                      },
                      series: [{
                          name: 'Avg Salary',
                          data: resultArr,
                          dataLabels: {
                              enabled: true,
                              rotation: -90,
                              color: '#FFFFFF',
                              align: 'right',
                              format: '{point.y:.0f}', // one decimal  // 1을 0으로 바꿔 소수부를 없앴따.
                              y: 10, // 10 pixels down from the top
                              style: {
                                  fontSize: '13px',
                                  fontFamily: 'Verdana, sans-serif'
                              }
                          }
                      }]
                  });
                  
                 
                   var html = "<table id='tblGender'>"
                           + "<thead>"
                           + "<tr>"
                           + "<th>부서번호</th>"
                           + "<th>부서명</th>"
                           + "<th>평균연봉($)</th>"
                           + "<th>인원수(명)</th>"
                           + "</tr>"
                           + "</thead>"
                          + "<tbody>";
                          
                          
                  $.each(json, function(entryIndex, entry){
                     html += "<tr>";
                     html += "<td>"+entry.deptno+"</td>";
                     html += "<td>"+entry.deptname+"</td>";
                     html += "<td>"+entry.avgsalary+"</td>";
                     html += "<td>"+entry.cnt+"</td>";
                     html += "</tr>";
                  });
                  
                    html += "</tbody>";
                    html += "</table>";
                    
                    $("#tbl").html(html); 

               },
               error: function(request, status, error){ //ajax 요청에 의해 실행했으나 데이터를 받아오는데 실패한 경우, 디버깅을 위해 error를 실행한다.
                      alert(" code: " + request.status + "\n message: " + request.responseText + "\n error: " + error);
                 }
            
            });
            
            //////////////////////////////////////////////
        break; */
   //  }// end of switch(chartType)
     
//  }// end of function callAjax(chartType)

</script>




   <!-- Home -->

   <!-- <div class="home">
      <div class="home_background parallax-window" data-parallax="scroll" data-image-src="images/chart.jpg" data-speed="0.8"></div>
      <div class="container">
         <div class="row">
            <div class="col">
               <div class="home_container">
                  <div class="home_content">
                     <div class="home_title">Chart List</div>
                     <div class="breadcrumbs">
                        <ul>
                           <li><a href="index.do">Home</a></li>
                           <li><a href="gochart.do">Chart List</a></li>
                           <li>Chart List</li>
                        </ul>
                     </div>
                  </div>
                  
               </div>
            </div>
         </div>
      </div>
   </div> -->
   <!-- Member List -->
      
      <div class="cart_container">
      <div class="container">
         
         <%-- <div class="row" style="margin-bottom: 20px;">
               <div class="col">            
                  <div class="cart_title">회원 전체 보기 <c:if test="(${empty memberList})"></c:if></div>
               </div>
         </div> --%>
      <!--    <div id="mychart" style="min-width: 300px; height: 200px; margin: 0 auto"></div>
         <div class="row">
           <div class="col-6">
                 <div class="mychart" id="chart3" style="margin-bottom: 20px; margin-top: 20px;"></div>
           </div>
           
           <div class="col-6">
                 <div class="mychart" id="chart4" style="margin-bottom: 20px; margin-top: 20px;"></div>
           </div>
           
         </div> -->
   <!--       <div align="center" style="margin-bottom: 100px;"> -->
<div class="super_container"> 
   <div class="cart_container" style="padding-top: 20px;">
      <div class="container" >
         <div class="row" >
            <div class="col" >
                    
                <div class="row" >
                 <div class="col">  
					<div style="padding-left: 30px;">   
						<h2>회원 통계 자료</h2>
						    <br/><br/>
						         <div class="row">
						            <div class="col">
						               <div class="mychart" id="chart1" style="margin-bottom: 20px;"></div>
						               <div id="tbl" style="margin:0 auto; width: 20%; border: 0px solid red;"></div>
						            </div>
						         </div>
						         <br/>
						         <br/>
						         <div class="row">
							          <div class="col">
							            <div class="mychart" id="chart2" style="margin-bottom: 20px;"></div>
							          </div>
						         </div>        
                     </div>
                 </div>
            </div>
            
        </div>
      </div>
    </div>
  </div>
</div>
   


