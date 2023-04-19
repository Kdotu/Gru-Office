<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>
<!-- 조직도 스크립트 -->
<!-- 조직도 스크립트 css만 주석처리하면 우리 부트스트랩 css랑 충돌안남 -->
<!--  <link rel="stylesheet" href="/resources/css/jquery.treeview.css" />  -->
<!--  	<link rel="stylesheet" href="/resources/css/screen.css" />  -->


<style>
.folder{
font-size: 1.3em;
}
</style>

<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery.cookie.js"></script>
<script src="/resources/js/jquery.treeview.js"></script>

	<script type="text/javascript" src="/resources/js/demo.js"></script>

	<script type="text/javascript">
	$(document).ready(function(){
		$("#browser").treeview({
			toggle: function() {
				console.log("%s was toggled.", $(this).find(">span").text());
			}
		});

		$("#add").click(function() {
			var branches = $("<li><span class='folder'>New Sublist</span><ul>" +
				"<li><span class='file'>Item1</span></li>" +
				"<li><span class='file'>Item2</span></li></ul></li>").appendTo("#browser");
			$("#browser").treeview({
				add: branches
			});
		});
	});
</script>
<!-- 조직도 스크립트 끝-->

<style>
ul{
   list-style:none;
   }

.chart-canvaswhole{
  height: 300px;
  width: 600.2px;
}
</style>

<script type="text/javascript">
$(function(){
	//현재 날짜 기준 달 구하기
	 todayy = new Date();

	 year = todayy.getFullYear(); // 년도


	month = $('#hiddenMonth').val();


	//처음 페이지 요청 시 오늘 날짜기준의 달을 가져옴
	if(month == ""){
		month = todayy.getMonth() + 1;
	}

	month = parseInt(month);

	if(month<10){
		month = '0'+month;
	}


	if(month>12){
		month=1;
		year+=1;
	}

// 	alert(year+month);

	let datee = year+month;

	data = {"month" : datee};

// 	deptNo = $('#hiddenDeptNo').val();

// 	console.log("처음페이지요청시 : " + JSON.stringify(data))

	//부서를 고른 후 요청된 페이지라면
// 	if(deptNo != null){
// 	  data = {"month" : datee,
// 			  "deptNo" : deptNo};

// 	  $.ajax({
// 			url:"/admin/getDeptInfo",
// 			type:"post",
// 			async:false,
// 			data: JSON.stringify(data),
// 			contentType:"application/json;charset=utf-8",
// 			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
// 	               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 			},
// 			success:function(result){
// 				console.log("리저트 : " + result);

// 				if(result == null || result == ''){
// 					//이거 왜 안먹을까??
// 					result.DEPT_NM = "-";
// 					result.EMP_NM = "-";
// 					result.JBPS_NM = "-";
// 				}


// 				$('#setDeptNm').text(result.DEPT_NM);

// 				$('#setEmpZZang').text('부서장    | '+result.EMP_NM+'  '+result.JBPS_NM);
// 			}
// 		});

// 	console.log("처음페이지요청시 : " + JSON.stringify(data))
// 	}





	//달력 다음 버튼 누를경우 다음 달로
	$('#nextMonth').on('click', function(){

		month = $('#hiddenMonth').val();

		if(month == ""){
			month = todayy.getMonth() + 1;
		}

		month = parseInt(month)+1;

		if(month<10){
			month = '0'+month;
		}

		if(month>12){
			month=1;
			year+=1;
		}


		console.log('현재 선택한 달 : '+ month);


		console.log('data로 보낼 날짜 : '+ year+month);


		let datee = year+month;

// 		alert(datee);

	location.href = "/admin/deptStatisAdmin?month="+datee+"&deptNo="+deptNo;
	})

	//달력 이전 버튼 누를경우 이전 달로
	$('#lastMonth').on('click', function(){


		month = $('#hiddenMonth').val();

		if(month == ""){
			month = todayy.getMonth() + 1;
		}

		month = parseInt(month)-1;

		if(month<10){
			month = '0'+month;
		}

		if(month<1){
			month=12;
			year-=1;
		}

		let datee = year+month;

		location.href = "/admin/deptStatisAdmin?month="+datee+"&deptNo="+deptNo;
	})

	//부서 선택 시 부서번호같이 넘겨서 페이지 재요청
	$(document).on('click','.team',function(){
		deptNo = $(this).data('deptno'); //hidden에 담을 것
		deptNm = $(this).text();

		$('#deptNo').val(deptNo);
		$('#deptNm').text(deptNm);

		month = year+month;
// 		alert(month);

	location.href="/admin/workDeptChart?deptNo="+deptNo+"&month="+month+"&deptNm="+deptNm;

	});

	//본부 선택 시 본부번호같이 넘겨서 페이지 재요청
	$(document).on('click','.bonbu',function(){
		deptNo = $(this).data('deptno');
		deptNm = $(this).text();

		$('#deptNo').val(deptNo);
		$('#deptNm').text(deptNm);

		month = year+month;
// 		alert(month);

	location.href="/admin/workDeptChart?deptNo="+deptNo+"&month="+month;

	});


	$(document).on('click','.gruIT',function(){

	location.href="/admin/workDeptChart";

	});




var deptCount; // 전역변수 선언

deptNo = $('#hiddenDeptNo').val();

// 총 인원수 구할 때 보낼 파라미터
// data = {"deptNo" : deptNo};

	//해당 부서의 총 인원수
	$.ajax({
		url:"/admin/getDeptPerson",
		type:"post",
		async:false,
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log("리저트 : " + result.RESULT);

			deptCount = result.RESULT;
		}
	});

	//정상근무
	normal = $('#Normal').val();
	normal = parseInt(normal);

	//지각
	late = $('#Late').val();
	late = parseInt(late);

	//조퇴
	early = $('#Early').val();
	early = parseInt(early);

	//결근
	empty = $('#Empty').val();
	empty = parseInt(empty);

	//휴가
	holi = $('#Holi').val();
	holi = parseInt(holi);


	//dept
// 	chart2 = $('#deptNor1').val();

	deptNor = [];
	deptLat = [];
	deptEar = [];
	deptEmp = [];
	deptHol = [];
	depName = [];


	for(i=1 ; i < 4 ; i++){
		deptNor[i] = $('#deptNor'+i).val();
		deptLat[i] = $('#deptLat'+i).val();
		deptEar[i] = $('#deptEar'+i).val();
		deptEmp[i] = $('#deptEmp'+i).val();
		deptHol[i] = $('#deptHol'+i).val();
		depName[i] = $('#depName'+i).val();
	}


	if($('#deptNor1').val() != null){
		$('#test').css("display","block");
	}

	// 달의 마지막 날짜 구하기
    lastDay = $('#hiddenlastDay').val();

    $('#firstT').text(depName[1]);
    $('#secondT').text(depName[2]);
    $('#thirdT').text(depName[3]);




//     alert(Math.floor((100/lastDay*normal)/deptCount));
//     alert("lastDay : " + lastDay);
//     alert("deptCount : " + deptCount);

	//text
	$('#ct1').text(Math.floor((100/lastDay*normal)/deptCount)+"%");
	$('#ct2').text(Math.floor((100/lastDay*late)/deptCount)+"%");
	$('#ct3').text(Math.floor((100/lastDay*early)/deptCount)+"%");
	$('#ct4').text(Math.floor((100/lastDay*empty)/deptCount)+"%");
	$('#ct5').text(Math.floor((100/lastDay*holi)/deptCount)+"%");


	// Chart Doughnut Consumption by room
    var ctx1 = document.getElementById("chart1").getContext("2d");

    var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

    gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.2)');
    gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
    gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)'); //purple colors

    new Chart(ctx1, {
      type: "doughnut",
      data: {
        labels: ['정상근무', '지각', '조퇴','결근','휴가'],
        datasets: [{
          label: "Task",
          weight: 1,
          cutout: 10,
          tension: 0.9,
          pointRadius: 2,
          borderWidth: 4,
          backgroundColor: ['#abe9f7', '#cdf59b', '#fc9797' ,'#f883dd' ,'#8097bf'],
          data: [normal,late,early,empty,holi],
          fill: false
        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        interaction: {
          intersect: false,
          mode: 'index',
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
            },
            ticks: {
              display: false
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
            },
            ticks: {
              display: false,
            }
          },
        },
      },
    });



 // Chart Doughnut Consumption by room
    var ctx1 = document.getElementById("chart2").getContext("2d");

    var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

    gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.2)');
    gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
    gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)'); //purple colors

    new Chart(ctx1, {
      type: "doughnut",
      data: {
        labels: ['정상근무', '지각', '조퇴','결근','휴가'],
        datasets: [{
          label: "Task",
          weight: 1,
          cutout: 10,
          tension: 0.9,
          pointRadius: 2,
          borderWidth: 4,
          backgroundColor: ['#abe9f7', '#cdf59b', '#fc9797' ,'#f883dd' ,'#8097bf'],
          data: [deptNor[1],deptLat[1],deptEar[1],deptEmp[1],deptHol[1]],
          fill: false
        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        interaction: {
          intersect: false,
          mode: 'index',
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
            },
            ticks: {
              display: false
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
            },
            ticks: {
              display: false,
            }
          },
        },
      },
    });

 // Chart Doughnut Consumption by room
    var ctx1 = document.getElementById("chart3").getContext("2d");

    var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

    gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.2)');
    gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
    gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)'); //purple colors

    new Chart(ctx1, {
      type: "doughnut",
      data: {
        labels: ['정상근무', '지각', '조퇴','결근','휴가'],
        datasets: [{
          label: "Task",
          weight: 1,
          cutout: 10,
          tension: 0.9,
          pointRadius: 2,
          borderWidth: 4,
          backgroundColor: ['#abe9f7', '#cdf59b', '#fc9797' ,'#f883dd' ,'#8097bf'],
          data: [deptNor[2],deptLat[2],deptEar[2],deptEmp[2],deptHol[2]],
          fill: false
        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        interaction: {
          intersect: false,
          mode: 'index',
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
            },
            ticks: {
              display: false
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
            },
            ticks: {
              display: false,
            }
          },
        },
      },
    });

 // Chart Doughnut Consumption by room
    var ctx1 = document.getElementById("chart4").getContext("2d");

    var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

    gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.2)');
    gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
    gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)'); //purple colors

    new Chart(ctx1, {
      type: "doughnut",
      data: {
        labels: ['정상근무', '지각', '조퇴','결근','휴가'],
        datasets: [{
          label: "Task",
          weight: 1,
          cutout: 10,
          tension: 0.9,
          pointRadius: 2,
          borderWidth: 4,
          backgroundColor: ['#abe9f7', '#cdf59b', '#fc9797' ,'#f883dd' ,'#8097bf'],
          data: [deptNor[3],deptLat[3],deptEar[3],deptEmp[3],deptHol[3]],
          fill: false
        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        interaction: {
          intersect: false,
          mode: 'index',
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
            },
            ticks: {
              display: false
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
            },
            ticks: {
              display: false,
            }
          },
        },
      },
    });


})

</script>

<div class="row">
	<div class="col-4">
		<div class="card">
		<div class="card-header p-3 pb-0">
			<h4 class="mb-0">부서선택</h4>
		</div>
		<div class="card-body">
		<div style="margin-left: 20px;">
			<div class="ms-auto my-auto">
<!-- 				<button type="button" class="btn btn-secondary btn-sm mb-0" -->
<!-- 					data-bs-toggle="modal" data-bs-target="#import" style="font-size: 1.5em;">전체조회 -->
<!-- 				</button> -->
<!-- 				<button -->
<!-- 					class="btn btn-secondary btn-sm export mb-0 mt-sm-0 mt-1" -->
<!-- 					data-type="csv" type="button" name="button" style="font-size: 1.5em;">팀별조회</button> -->
			</div>
		</div>
		<div id="main">

			<div id="orgList">
	<ul id="browser" class="filetree treeview-famfamfam" >
		<li class="dropdownLi" style="margin-left:-20px;"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder gruIT" data-deptno="gruIt">그루IT</span>
			<ul id="folder21" class="adminEmp">
			</ul>
			<ul>
				<li class="closed dropdownLi"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder bonbu" data-deptno="DEPT002">경영지원본부</span>
<!-- 					<ul> -->
<!-- 						<li class="closed empList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT003">재무팀</span> -->
<!-- 							<ul id="folder21"> -->
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 						<li class="closed empList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT004">인사팀</span> -->
<!-- 							<ul id="folder21"> -->
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 						<li class="closed empList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT005">총무팀</span> -->
<!-- 							<ul id="folder21"> -->
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 					</ul> -->
				</li>
				<li class="closed dropdownLi"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder bonbu" data-deptno="DEPT010">영업본부</span>
<!-- 					<ul> -->
<!-- 						<li class="closed empList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT011">영업팀</span> -->
<!-- 							<ul id="folder21"></ul> -->
<!-- 						</li> -->
<!-- 						<li class="closed empList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT012">마케팅팀</span> -->
<!-- 							<ul id="folder21"> -->
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 						<li class="closed empList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT013">CS팀</span> -->
<!-- 							<ul id="folder21"> -->
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 					</ul> -->
				</li>
				<li class="closed"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder bonbu" data-deptno="DEPT006">개발본부</span>
<!-- 					<ul> -->
<!-- 						<li class="closed empList"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT007">서비스개발팀</span> -->
<!-- 							<ul id="folder21"> -->
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 						<li class="closed empList"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT008">플랫폼운영팀</span> -->
<!-- 							<ul id="folder21"> -->
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 						<li class="closed empList"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT009">디자인팀</span> -->
<!-- 							<ul id="folder21"> -->
<!-- 							</ul> -->
<!-- 						</li> -->
<!-- 					</ul> -->
				</li>
			</ul>
		</li>
	</ul>
	</div>

				<!-- 	<button id="add">추가</button> -->

		</div>
		</div>
		</div>




	</div>
	<div class="col-8">
		<div class="card">
		<div class="d-flex mt-4 pt-2" style="text-align: center; margin-left: 430px;">
<!-- 			<button class="btn btn-outline-black rounded-circle p-2 mb-0" type="button"  id="lastMonth" style="background: white; margin-top: -10px; "> -->
<!-- 			<i class="fas fa-backward p-2" aria-hidden="true"></i> -->
<!-- 			</button> -->
			&nbsp;&nbsp;&nbsp;<h4 id="month">${date}월 근태현황</h4><input id="hiddenMonth" type="hidden" value="${month }">&nbsp;&nbsp;&nbsp;
<!-- 			<button class="btn btn-outline-black rounded-circle p-2 mb-0" type="button" id="nextMonth" style="background: white; margin-top: -10px;"> -->
<!-- 			<i class="fas fa-forward p-2" aria-hidden="true"></i> -->
<!-- 			</button> -->

			<input type="hidden" id="hiddenDeptNo" value="${hiddenDeptNo }">
			<input type="hidden" id="hiddenlastDay" value="${hiddenlastDay }">

			<input type="hidden" id="Normal" value="${result.NORMAL}">
			<input type="hidden" id="Late" value="${result.LATE}">
			<input type="hidden" id="Early" value="${result.EARLY}">
			<input type="hidden" id="Empty" value="${result.EMPTY}">
			<input type="hidden" id="Holi" value="${result.HOLI}">


			<c:forEach var="map" items="${result2 }" varStatus="stat">
				<input type="hidden" id="deptNor${stat.count }" value="${map.NORMAL}">
				<input type="hidden" id="deptLat${stat.count }" value="${map.LATE}">
				<input type="hidden" id="deptEar${stat.count }" value="${map.EARLY}">
				<input type="hidden" id="deptEmp${stat.count }" value="${map.EMPTY}">
				<input type="hidden" id="deptHol${stat.count }" value="${map.HOLI}">

				<input type="hidden" id="depName${stat.count }" value="${map.DEPT_NM}">
			</c:forEach>

		</div>
			<div style="left-margin:15px;">
<%-- 				<h5>${hiddenDeptNm }</h5> --%>
			</div>

<!-- 			<div class="card-header d-flex pb-0 p-3 mt-3"> -->
<!-- 				<div class="nav-wrapper position-relative ms-auto w-100"> -->
<!-- 					<ul class="nav nav-pills nav-fill p-1" role="tablist" style="font-size: 1.5em;"> -->
<!-- 						<li class="nav-item" role="presentation"><a -->
<!-- 							class="nav-link mb-0 px-0 py-1 active" data-bs-toggle="tab" -->
<!-- 							href="#cam1" role="tab" aria-controls="cam1" aria-selected="true"> -->
<!-- 								월별 </a></li> -->
<!-- 						<li class="nav-item" role="presentation"><a -->
<!-- 							class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="#cam2" -->
<!-- 							role="tab" aria-controls="cam2" aria-selected="false" -->
<!-- 							tabindex="-1"> 주별 </a></li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->
			<div class="card-body p-3 mt-3">
			<div class="row" style="margin-bottom:50px;">
			<div class="col-5 text-center" style="margin-top: 20px;">
                <div class="chart">
                  <canvas id="chart1" class="chart-canvaswhole" height="180" ></canvas>
                </div>

			</div>
			<div class="col-7">
                  <div class="table-responsive">
                    <table class="table align-items-center mb-0">
                      <tbody>
                        <tr>
                          <td>
                            <div class="d-flex px-2 py-0">
                              <span class="badge badge-info me-3" style="font-size:1.3em;"> </span>
                              <div class="d-flex flex-column justify-content-center">
                                <h6 class="mb-0" style="font-size:1.3em;">정상근무</h6>
                              </div>
                            </div>
                          </td>
                          <td class="align-middle text-center">
                            <span class="font-weight-bold" style="font-size:1.3em;"> <fmt:formatNumber type="number" id="ct1" maxFractionDigits="0"  value="" />% </span>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <div class="d-flex px-2 py-0" >
                              <span class="badge badge-success me-3" style="font-size:1.3em;"> </span>
                              <div class="d-flex flex-column justify-content-center">
                                <h6 class="mb-0" style="font-size:1.3em;">지각</h6>
                              </div>
                            </div>
                          </td>
                          <td class="align-middle text-center">
                            <span class="font-weight-bold" style="font-size:1.3em;"> <fmt:formatNumber type="number" id="ct2" maxFractionDigits="0"  value="" />% </span>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <div class="d-flex px-2 py-0">
                              <span class="badge badge-danger me-3" style="font-size:1.3em;"> </span>
                              <div class="d-flex flex-column justify-content-center">
                                <h6 class="mb-0" style="font-size:1.3em;">조퇴</h6>
                              </div>
                            </div>
                          </td>
                          <td class="align-middle text-center">
                            <span class="font-weight-bold" style="font-size:1.3em;"> <fmt:formatNumber type="number" id="ct3" maxFractionDigits="0"  value="" />% </span>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <div class="d-flex px-2 py-0">
                              <span class="badge badge-primary me-3" style="font-size:1.3em;"> </span>
                              <div class="d-flex flex-column justify-content-center">
                                <h6 class="mb-0" style="font-size:1.3em;">결근</h6>
                              </div>
                            </div>
                          </td>
                          <td class="align-middle text-center" style="font-size:1.3em;">
                            <span class="font-weight-bold" style="font-size:1.1em;"> <fmt:formatNumber type="number" id="ct4" maxFractionDigits="0"  value="" />% </span>
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <div class="d-flex px-2 py-0">
                              <span class="badge badge-dark me-3" style="font-size:1.3em;"> </span>
                              <div class="d-flex flex-column justify-content-center">
                                <h6 class="mb-0" style="font-size:1.3em;">휴가</h6>
                              </div>
                            </div>
                          </td>
                          <td class="align-middle text-center" style="font-size:1.3em;">
                            <span class="font-weight-bold" style="font-size:1.1em;"> <fmt:formatNumber type="number" id="ct5" maxFractionDigits="0"  value="" />% </span>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                </div>
			</div>
			<div id="test" style="display:none;">
			<div class="row chartDept" style="margin-top:20px;">
			<span style="width:30%; margin-left:80px; font-size:1.5em;" id="firstT" >인사팀</span>
			<span style="width:30%; font-size:1.5em;" id="secondT" >서비스개발팀</span>
			<span style="width:30%; font-size:1.5em;" id="thirdT" >디자인팀</span>

			</div>
			<div class="row chartDept" style="margin-top:10px;">
			<div class="col-4">
				<canvas id="chart2" class="chart-canvas" height="180" width="325" style="display: block; box-sizing: border-box; height: 180px; width: 325.8px;"></canvas>
			</div>
			<div class="col-4">
				<canvas id="chart3" class="chart-canvas" height="180" width="325" style="display: block; box-sizing: border-box; height: 180px; width: 325.8px;"></canvas>
			</div>
			<div class="col-4">
				<canvas id="chart4" class="chart-canvas" height="180" width="325" style="display: block; box-sizing: border-box; height: 180px; width: 325.8px;"></canvas>
			</div>
			</div>
			</div>
		</div>
	</div>
	</div>
