<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
    
<jsp:include page="top.jsp" /> 

<!-- 차트그리기 --> 
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="https://code.highcharts.com/modules/drilldown.js"></script>





<script type="text/javascript">

	$(document).ready(function() {
		loopshowNowTime();
		showRank();
	}); // end of ready(); ---------------------------------

	function showNowTime() {
		
		var now = new Date();
	
		var strNow = now.getFullYear() + "-" + (now.getMonth() + 1) + "-" + now.getDate();
		
		var hour = "";
		if(now.getHours() > 12) {
			hour = " 오후 " + (now.getHours() - 12);
		} else if(now.getHours() < 12) {
			hour = " 오전 " + now.getHours();
		} else {
			hour = " 정오 " + now.getHours();
		}
		
		var minute = "";
		if(now.getMinutes() < 10) {
			minute = "0"+now.getMinutes();
		} else {
			minute = ""+now.getMinutes();
		}
		
		var second = "";
		if(now.getSeconds() < 10) {
			second = "0"+now.getSeconds();
		} else {
			second = ""+now.getSeconds();
		}
		
		strNow += hour + ":" + minute + ":" + second;
		
		$("#clock").html("<span style='color:green; font-weight:bold;'>"+strNow+"</span>");
	
	}// end of function showNowTime() -----------------------------


	function loopshowNowTime() {
		
		showNowTime();
		
		var timejugi = 1000;   // 시간을 1초 마다 자동 갱신하려고.
		
		setTimeout(function() {
						loopshowNowTime();	
					}, timejugi);
		
	}// end of loopshowNowTime() --------------------------
	
	
	// 제품명별 등수
	function getTableRank(){
		
		$.ajax({
			url: "rankShowJSON.action",
		    type: "GET",
		    dataType: "JSON",
		    success: function(json){
		    	
		    	$("#displayTable").empty();
		    	
		    	var html  = "<table class=table table-hover' align='center' width='250px' height='180px' >";  //table 태그에서 class에 적은 것은 부트스트랩을 참조한 것이다.
		    	    html += "<tr>";
		    	    html += "<th class='myaligncenter'>등수</th>";
		    	    html += "<th class='myaligncenter'>제품명</th>";
		    	    html += "<th class='myaligncenter'>주문량총계</th>";   // layout-tiles.jsp에 보면 css에 .myaligncenter 를 align='center'로 설정해둠.
		    	    html += "</tr>";
		    	    
		    	$.each(json, function(entryIndex, entry){
		    		html += "<tr>";
		    	    html += "<td class='myaligncenter myrank'>"+entry.RANK+"</td>";
		    	    html += "<td class='myaligncenter'>"+entry.JEPUMNAME+"</td>";
		    	    html += "<td class='myaligncenter'>"+entry.TOTALQTY+"</td>";
		    	    html += "</tr>";
		    	});   
		    	
		    	html += "</table>";
	    	    

		    	$("#displayTable").append(html);
		    },
			error: function(request, status, error){ //ajax 요청에 의해 실행했으나 데이터를 받아오는데 실패한 경우, 디버깅을 위해 error를 실행한다.
	             alert(" code: " + request.status + "\n"+"message: " + request.responseText + "\n"+"error: " + error);
	        }
		});
		
		
	}// end of getTableRank()
	
	
	function getChartRank(){
		
		$.ajax({
			url: "rankShowJSON.action",
		    type: "GET",
		    dataType: "JSON",
		    success: function(json){
		    	
		    	var jepumObjArr = [];
		    	
		    	// 배열 속에 값넣기
		    	$.each(json,function(entryIndex, entry){
		    		
		    		// 실제 데이터 값 jepumObjArr에 넣기
		    		jepumObjArr.push({
		  		           "name": entry.JEPUMNAME,
		  		           "y": parseFloat(entry.PERCENT),
		  		           "drilldown": entry.JEPUMNAME
					});

		    	});// end of $.each(json,function(entryIndex, entry)
		    				
		    			
		    	// *** 객체 속의 배열
		    	var jepumObjDetailArr = [];	
		    	
		    	// 배열 속의 객체 속의 배열에 값넣기
		    	$.each(json,function(entryIndex, entry){
		    		
		    		var form_data = {jepumname : entry.JEPUMNAME}; // form_data로 값을 보낸다.
		    		
		    		// 새로운 쿼리문으로 값을 구해야 하기 때문에 ajax를 또 한다. 
		    		$.ajax({
		    		    url: "jepumdetailnameRankShowJSON.action",
		    		    data: form_data,
		    		    type: "get",
		    		    dataType: "JSON",
		    		    success: function(json2){
		                     
		    		    	var subArr = [];
		    		    	
		    		    	$.each(json2,function(entryIndex2, entry2){
		    		    		subArr.push([
		    		    		   	          entry2.JEPUMDETAILNAME,
		    		    		   	          parseFloat(entry2.PERCENT)
		    		    		             ]);
		    		    	});// end of $.each(json2,function()
		    		    	
		    		    			
		    		    	jepumObjDetailArr.push({
		    		    		"name": entry.JEPUMNAME,
				  		        "id": entry.JEPUMNAME,
				  		        "data": subArr          
		    		    	});  //{}는 객체		
		    		    			
		    		    },
		    			error: function(request, status, error){ //ajax 요청에 의해 실행했으나 데이터를 받아오는데 실패한 경우, 디버깅을 위해 error를 실행한다.
		   	             alert(" code: " + request.status + "\n"+"message: " + request.responseText + "\n"+"error: " + error);
		   	           }
		    		    
		    		
		    		});
		    	});	
		    			

		    			
		    			
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// Create the chart
		    	Highcharts.chart('chart-container', {
		  		  chart: {
		  		    type: 'column'
		  		  },
		  		  title: {
		  		    text: 'Browser market shares. January, 2018'
		  		  },
		  		  subtitle: {
		  		    text: 'Click the columns to view versions. Source: <a href="http://statcounter.com" target="_blank">statcounter.com</a>'
		  		  },
		  		  xAxis: {
		  		    type: 'category'
		  		  },
		  		  yAxis: {
		  		    title: {
		  		      text: 'Total percent market share'
		  		    }

		  		  },
		  		  legend: {
		  		    enabled: false
		  		  },
		  		  plotOptions: {
		  		    series: {
		  		      borderWidth: 0,
		  		      dataLabels: {
		  		        enabled: true,
		  		        format: '{point.y:.1f}%'
		  		      }
		  		    }
		  		  },

		  		  tooltip: {
		  		    headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
		  		    pointFormat: '<span style="color:{point.color}">{point.name}</span>: <b>{point.y:.2f}%</b> of total<br/>'
		  		  },

		  		  "series": [ //배열
		  		    {
		  		      "name": "판매제품",
		  		      "colorByPoint": true,
		  		      "data": jepumObjArr // *** 위에서 구한 값을 대입시킴 ***//
		  		     /* "data": [
		  		        {
		  		          "name": "Chrome",
		  		          "y": 62.74,
		  		          "drilldown": "Chrome"
		  		        },
		  		        {
		  		          "name": "Firefox",
		  		          "y": 10.57,
		  		          "drilldown": "Firefox"
		  		        },
		  		        {
		  		          "name": "Internet Explorer",
		  		          "y": 7.23,
		  		          "drilldown": "Internet Explorer"
		  		        },
		  		        {
		  		          "name": "Safari",
		  		          "y": 5.58,
		  		          "drilldown": "Safari"
		  		        },
		  		        {
		  		          "name": "Edge",
		  		          "y": 4.02,
		  		          "drilldown": "Edge"
		  		        },
		  		        {
		  		          "name": "Opera",
		  		          "y": 1.92,
		  		          "drilldown": "Opera"
		  		        },
		  		        {
		  		          "name": "Other",
		  		          "y": 7.62,
		  		          "drilldown": null
		  		        }
		  		      ] */
		  		    }
		  		  ] ,
		  		  "drilldown": {
		  			"series": jepumObjDetailArr // *** 위에서 구한 값을 대입시킴 ***//
		  		   /* "series": [
		  		      {
		  		        "name": "Chrome",
		  		        "id": "Chrome",
		  		        "data": [
		  		          [
		  		            "v65.0",
		  		            0.1
		  		          ],
		  		          [
		  		            "v64.0",
		  		            1.3
		  		          ],
		  		          [
		  		            "v63.0",
		  		            53.02
		  		          ],
		  		          [
		  		            "v62.0",
		  		            1.4
		  		          ],
		  		          [
		  		            "v61.0",
		  		            0.88
		  		          ],
		  		          [
		  		            "v60.0",
		  		            0.56
		  		          ],
		  		          [
		  		            "v59.0",
		  		            0.45
		  		          ],
		  		          [
		  		            "v58.0",
		  		            0.49
		  		          ],
		  		          [
		  		            "v57.0",
		  		            0.32
		  		          ],
		  		          [
		  		            "v56.0",
		  		            0.29
		  		          ],
		  		          [
		  		            "v55.0",
		  		            0.79
		  		          ],
		  		          [
		  		            "v54.0",
		  		            0.18
		  		          ],
		  		          [
		  		            "v51.0",
		  		            0.13
		  		          ],
		  		          [
		  		            "v49.0",
		  		            2.16
		  		          ],
		  		          [
		  		            "v48.0",
		  		            0.13
		  		          ],
		  		          [
		  		            "v47.0",
		  		            0.11
		  		          ],
		  		          [
		  		            "v43.0",
		  		            0.17
		  		          ],
		  		          [
		  		            "v29.0",
		  		            0.26
		  		          ]
		  		        ] 
		  		      },
		  		      {
		  		        "name": "Firefox",
		  		        "id": "Firefox",
		  		        "data": [
		  		          [
		  		            "v58.0",
		  		            1.02
		  		          ],
		  		          [
		  		            "v57.0",
		  		            7.36
		  		          ],
		  		          [
		  		            "v56.0",
		  		            0.35
		  		          ],
		  		          [
		  		            "v55.0",
		  		            0.11
		  		          ],
		  		          [
		  		            "v54.0",
		  		            0.1
		  		          ],
		  		          [
		  		            "v52.0",
		  		            0.95
		  		          ],
		  		          [
		  		            "v51.0",
		  		            0.15
		  		          ],
		  		          [
		  		            "v50.0",
		  		            0.1
		  		          ],
		  		          [
		  		            "v48.0",
		  		            0.31
		  		          ],
		  		          [
		  		            "v47.0",
		  		            0.12
		  		          ]
		  		        ]
		  		      },
		  		      {
		  		        "name": "Internet Explorer",
		  		        "id": "Internet Explorer",
		  		        "data": [
		  		          [
		  		            "v11.0",
		  		            6.2
		  		          ],
		  		          [
		  		            "v10.0",
		  		            0.29
		  		          ],
		  		          [
		  		            "v9.0",
		  		            0.27
		  		          ],
		  		          [
		  		            "v8.0",
		  		            0.47
		  		          ]
		  		        ]
		  		      },
		  		      {
		  		        "name": "Safari",
		  		        "id": "Safari",
		  		        "data": [
		  		          [
		  		            "v11.0",
		  		            3.39
		  		          ],
		  		          [
		  		            "v10.1",
		  		            0.96
		  		          ],
		  		          [
		  		            "v10.0",
		  		            0.36
		  		          ],
		  		          [
		  		            "v9.1",
		  		            0.54
		  		          ],
		  		          [
		  		            "v9.0",
		  		            0.13
		  		          ],
		  		          [
		  		            "v5.1",
		  		            0.2
		  		          ]
		  		        ]
		  		      },
		  		      {
		  		        "name": "Edge",
		  		        "id": "Edge",
		  		        "data": [
		  		          [
		  		            "v16",
		  		            2.6
		  		          ],
		  		          [
		  		            "v15",
		  		            0.92
		  		          ],
		  		          [
		  		            "v14",
		  		            0.4
		  		          ],
		  		          [
		  		            "v13",
		  		            0.1
		  		          ]
		  		        ]
		  		      },
		  		      {
		  		        "name": "Opera",
		  		        "id": "Opera",
		  		        "data": [
		  		          [
		  		            "v50.0",
		  		            0.96
		  		          ],
		  		          [
		  		            "v49.0",
		  		            0.82
		  		          ],
		  		          [
		  		            "v12.1",
		  		            0.14
		  		          ]
		  		        ]
		  		      }
		  		    ] */
		  		  }
		  		});
                
               //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		    },
			error: function(request, status, error){ //ajax 요청에 의해 실행했으나 데이터를 받아오는데 실패한 경우, 디버깅을 위해 error를 실행한다.
	             alert(" code: " + request.status + "\n"+"message: " + request.responseText + "\n"+"error: " + error);
	        }    
		});

		
		
		
		
	} // end of getCharRank()
	
	function showRank(){

		getTableRank();
		getChartRank();
		
        var timejugi = 10000;   // 시간을 1초 마다 자동 갱신하려고.
		
		setTimeout(function() {
			           showRank();	
					}, timejugi);
	} // end of showRank()
	
	
</script>


<div style="margin: 0 auto;" align="center">
	현재시각 :&nbsp; 
	<div id="clock" style="display:inline;"></div>
</div>
	
<div id="displayTable" style="min-width: 90%; margin-top: 50px; margin-bottom: 50px; padding-left: 20px; padding-right: 20px;"></div>	
	
	
<div id="chart-container" style="min-width: 90%; height: 400px; margin: 0 auto"></div>	
