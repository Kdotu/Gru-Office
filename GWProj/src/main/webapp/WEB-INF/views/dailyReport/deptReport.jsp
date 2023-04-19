<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>
<script src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>

<style>
 .card-border{
	border : 1px solid gray;
 }
</style>


<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.empVO" var="empVO" />

<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/dailyReportAside.jsp" />
		</div>
		<div class="col-lg-10 mt-lg-0 mb-4">
			<div class="card p-4 mt-0 px-4">
			<h3 class="mb-0 font-weight-bolder">부서 일일업무보고 현황</h3>
			<p class="text mb-0">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
		  		<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
		  		<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
			</svg> 부서원의 일일업무보고 현황 목록을 간략하게 확인할 수 있습니다. </p>
				<p class="font-weight-bold "></p>
				<div class="row">
					<div class="col-4">
						<div class="h-100 my-auto">
							<div class="card card-border h-100">
								<div class="card-body p-3 text-center">
									<table class="w-100">
										<tr>
											<td><h6 class="mb-0"
													style="width: 150px; text-align: left;"><fmt:formatDate pattern="yyyy" value="${today}" /></h6></td>
											<td><span class=""
												style="width: 150px; text-align: right;">3월 1주차</span></td>
										</tr>
									</table>
									<p class=" mb-0"><fmt:formatDate pattern="MM/dd (E)" value="${today}" /></p>
									<h4 class="mb-0 pb-2">일일보고 현황</h4>
									<br />
									<table class="w-80 mx-auto">
										<tr style="height:35px;">
											<td><span class="text-lg" style="color: gray;">부서</span></td>
											<td><span class="text">${empVO.deptNm}</span></td>
										</tr>
										<tr>
											<td colspan="2"><hr class="horizontal dark my-3"></td>
										</tr>
										<tr>
											<td><span class="text-lg" style="color: gray;">보고현황</span></td>
											<td><span class="text-md text-right">보고자 ${reportMemCount}명 </span><br>
												<span class="text-md text-right" style="color:red;">미보고자 ${totalMemCount-reportMemCount}명</span></td>
											<td></td>
										</tr>
									</table>
									<hr class="horizontal dark my-3">
									<table class="w-80">
										<tr>
											<td><span class="text">미확인 일일보고</span></td>
											<td>
											<c:choose>
												<c:when test="${nonChkReportCount gt 0}">
													<span class="badge bg-gradient-warning">${nonChkReportCount}건</span>
												</c:when>
												<c:otherwise>
													<span class="badge bg-gradient-light">0건</span>
												</c:otherwise>
											</c:choose>
											</td>
										</tr>
										<tr>
											<td><span class="text">오늘자 확인한 보고</span></td>
											<td>
											<c:choose>
												<c:when test="${todayChkReportCount gt 0}">
													<span class="badge bg-gradient-success">${todayChkReportCount}건</span>
												</c:when>
												<c:otherwise>
													<span class="badge bg-gradient-light">0건</span>
												</c:otherwise>
											</c:choose>
											</td>
										</tr>

									</table>
									<hr class="horizontal dark my-3">
									<a type="button" href="/dailyReport/deptlist" class="btn btn-lg btn-outline-info">목록</a>
								</div>
							</div>
						</div>
					</div>
					<div class="col-4 h-100">
						<div class="col-lg">
							<div class="card card-border card-border card-body mt-0 mb-3">
								<div class="h-100 my-auto">이번주 보고현황 목록</div>
								<div class="table-responsive">
									<table class="table align-items-center mb-0">
										<thead>
											<tr>
												<th class="text-center text-uppercase text-secondary  font-weight-bolder">보고회차</th>
												<th class="text-center text-uppercase text-secondary  font-weight-bolder ps-2">보고현황</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="weekVO" items="${weekReportList}" varStatus="stat">
											<tr>
												<td>
													<div class="d-flex flex-column justify-content-center">
														<h6 class="text-center mb-0 "><fmt:formatDate pattern="yyyy-MM-dd (E)" value="${weekVO.dates}" /></h6>
													</div>
												</td>
												<td>
													<div class=" text-secondary mb-0">
														<p class="text-center  my-0 py-0">보고 ${weekVO.rptpNo}명 / <span class="text-center  my-0 py-0" style="color: red;">미보고 ${totalMemCount - weekVO.rptpNo}명</span></p>

													</div>
												</td>
											</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						</div>
					<div class="col-4">
						<div class="col-lg">
							<div class="card card-border card-body mt-0 mb-3">
							<div class="h-100 my-auto">이전보고 현황 차트</div>
							<p class=" mb-0">
							<div class="row mx-0 px-0 pt-3">
								<div class="col h-100" style="height: 300px; width: 100%;">
									<div class="col-xl mt-lg-0 mt-4 w-100">
										<div class="h-100">
											<ul class="nav nav-pills nav-fill p-1 mb-3" role="tablist">
												<li class="nav-item" role="presentation">
													<a class="nav-link mb-0 px-0 py-1 active" id="dailyChart" data-bs-toggle="tab" href="" role="tab" aria-controls="profile" aria-selected="true"> 일별 </a>
												</li>
												<li class="nav-item" role="presentation">
													<a class="nav-link mb-0 px-0 py-1" id="weeklyChart" data-bs-toggle="tab" href="" role="tab" aria-controls="dashboard" aria-selected="false" tabindex="-1">주별</a>
												</li>
												<li class="nav-item" role="presentation">
													<a class="nav-link mb-0 px-0 py-1" id="monthlyChart" data-bs-toggle="tab" href="" role="tab" aria-controls="dashboard" aria-selected="false" tabindex="-1">월별</a>
												</li>
											</ul>
										</div>
										<div style="clear: both;"></div>
										<div class="mb-3" id="chart1">
											<div class="p-3">
												<div class="chart">
													 <canvas id="pie-chart-0" class="chart-canvas" height="250px;"></canvas>
												</div>
											</div>
										</div>
										<div class="mb-3" style="" id="chart2">
											<div class="p-3">
												<div class="chart">
													 <canvas id="pie-chart-1" class="chart-canvas" height="250px;"></canvas>
												</div>
											</div>
										</div>
										<div class="mb-3" style="" id="chart3">
											<div class="p-3">
												<div class="chart">
													 <canvas id="pie-chart-2" class="chart-canvas" height="250px;"></canvas>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							</div>
						</div>
					</div>
					</div><!-- end row -->

					<div class="row">
						<div class="col">
							<h3 class="mb-0 mt-5 font-weight-bolder">이전보고 현황</h3>
							<p class="text mb-0">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							  		<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
							  		<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								부서원의 일일업무보고 이전 보고현황을 최근 순으로 확인할 수 있습니다.
							</p>
						</div>
						<div class="col">
							<div class="mt-5" style="float:right;">
								<a type="button" class="btn btn-info btn-sm mb-0 mt-4 h5" href="/dailyReport/deptlist" style="float: right; margin-top: 10px;"><i class="ni ni-bold-right m-1"></i> 전체 보고 현황 목록으로</a>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg col-8">
								<div class="card card-border card-body col mt-3 mb-3">
									<div class="table-responsive">
										<table class="table table-flush dataTable-table" id="products-list">
												<thead class="thead-light">
													<tr>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">순번</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고회차</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고자</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">부서</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">직책</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder ps-2 tblHeight" style="font-size : 1.3em;">작성일시</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고여부</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고확인 담당자</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">확인여부</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고조회</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="dailyReportVO" items="${data.content}" varStatus="stat">
														<tr>
															<td class="text-uppercase text-secondary  text-center font-weight-bolder tblHeight" style="font-size : 1.2em;">
																${stat.count}
															</td>
															<td class="text-uppercase text-secondary  text-center font-weight-bolder ps-2 tblHeight" style="font-size : 1.2em;">
																<fmt:formatDate pattern="yyyy-MM-dd" value="${dailyReportVO.dates}" />
															</td>
															<td class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.2em;">${dailyReportVO.empNm}</td>
															<td class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.2em;">${dailyReportVO.deptNm}</td>
															<td class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.2em;">${dailyReportVO.jbpsNm}</td>
															<td class="text-uppercase text-secondary text-center  font-weight-bolder ps-2 tblHeight">
																<fmt:formatDate pattern="HH:mm:ss" value="${dailyReportVO.rptpWrtYmd}"/>
															</td>
															<td class="text-center text-uppercase text-secondary text-center  font-weight-bolder tblHeight" style="font-size : 1.2em;">
															<c:if test="${not empty dailyReportVO.rptpNo}">
																<c:choose>
																	<c:when test="${not empty dailyReportVO.rptpNo}">보고</c:when>
																	<c:otherwise>미보고</c:otherwise>
																</c:choose>
															</c:if>
															</td>
															<td class="text-center text-uppercase text-secondary  font-weight-bolder" style="font-size : 1.2em;">
															<c:choose>
																<c:when test="${not empty dailyReportVO.rptpCmptnPic}">${dailyReportVO.rptpCmptnPicNm} ${dailyReportVO.rptpCmptnPicJbpsNm} </c:when>
																<c:otherwise>-</c:otherwise>
															</c:choose>
															</td>
															<td class="text-center text-uppercase text-secondary  font-weight-bolder" style="font-size : 1.2em;">
															<c:if test="${not empty dailyReportVO.rptpNo}">
																<c:choose>
																	<c:when test="${dailyReportVO.rptpCmptnYn eq 'Y'}">보고완료 </c:when>
																	<c:otherwise>미확인</c:otherwise>
																</c:choose>
															</c:if>
															</td>
															<td class="text-uppercase text-secondary  text-center font-weight-bolder" style="font-size : 1.2em;">
																<c:choose>
																	<c:when test="${not empty dailyReportVO.rptpNo}">
																	<a href="/dailyReport/detail?rptpNo=${dailyReportVO.rptpNo}" class="btn btn-outline-dark mb-0 py-auto pt-1 p-3" style="height:25px;">조회</a>
																	</c:when>
																	<c:otherwise>
																		-
																	</c:otherwise>
																</c:choose>
															</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
									</div>
								</div>
							</div>
					</div> <!-- end row -->
					<h3 class="mb-0 mt-5">보고현황</h3>
					<p class="text mb-0">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
				  		<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
				  		<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
					</svg> 부서원의 일일업무보고 이전 보고현황을  차트로 확인할 수 있습니다. </p>
					<div class="row mx-0 px-0 pt-3">
						<div class="col h-100" style="height: 300px; width: 100%;">
							<div class="card card-border card-body mt-0 mb-3">
								<div class="col-xl mt-lg-0 mt-4 w-100">
									<div class="h-100"></div>
										<div class="h-100 mb-5">
											<ul class="nav nav-pills nav-fill p-1 mb-3" role="tablist">
												<li class="nav-item" role="presentation">
													<a class="nav-link mb-0 px-0 py-1 active" data-bs-toggle="tab" href="" role="tab" aria-controls="profile" aria-selected="true" id="dailyDeptChart"> 일별 </a>
												</li>
												<li class="nav-item" role="presentation">
													<a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="" role="tab" aria-controls="dashboard" aria-selected="false" tabindex="-1" id="weeklyDeptChart">주별</a>
												</li>
												<li class="nav-item" role="presentation">
													<a class="nav-link mb-0 px-0 py-1" data-bs-toggle="tab" href="" role="tab" aria-controls="dashboard" aria-selected="false" tabindex="-1" id="monthlyDeptChart">월별</a>
												</li>
											</ul>
										</div>
									<div class="card mb-3" id="chart4">
										<div class="p-3">
											<div class="chart">
					             			   <canvas id="line-chart-0" class="chart-canvas" height="300px;"></canvas>
											</div>
										</div>
									</div>
									<div class="card mb-3" id="chart5">
										<div class="p-3">
											<div class="chart">
					             			   <canvas id="line-chart-1" class="chart-canvas" height="300px;"></canvas>
											</div>
										</div>
									</div>
									<div class="card mb-3" id="chart6">
										<div class="p-3">
											<div class="chart">
					             			   <canvas id="line-chart-2" class="chart-canvas" height="300px;"></canvas>
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
	</div>
</sec:authorize>
<script>
// 부서별 (도넛그래프)
$("#chart1").css("display","");
$("#chart2").css("display","none");
$("#chart3").css("display","none");

// 부서별 (라인그래프)
$("#chart4").css("display","");
$("#chart5").css("display","none");
$("#chart6").css("display","none");

$("#dailyChart").on("click",function(){
	$("#chart1").css("display","");
	$("#chart2").css("display","none");
	$("#chart3").css("display","none");
	$("#pie-chart-0").css("height", "250px");
});

$("#weeklyChart").on("click",function(){
	$("#chart1").css("display","none");
	$("#chart2").css("display","")
	$("#chart3").css("display","none");
	$("#pie-chart-1").css("height", "250px");
});

$("#monthlyChart").on("click",function(){
	$("#chart1").css("display","none");
	$("#chart2").css("display","none");
	$("#chart3").css("display","")
	$("#pie-chart-2").css("height", "250px");
});


$("#dailyDeptChart").on("click",function(){
	$("#chart4").css("display","");
	$("#chart5").css("display","none");
	$("#chart6").css("display","none");
	$("#line-chart-0").css("height", "250px");
});

$("#weeklyDeptChart").on("click",function(){
	$("#chart4").css("display","none");
	$("#chart5").css("display","")
	$("#chart6").css("display","none");
	$("#line-chart-1").css("height", "250px");
});

$("#monthlyDeptChart").on("click",function(){
	$("#chart4").css("display","none");
	$("#chart5").css("display","none");
	$("#chart6").css("display","");
	$("#line-chart-2").css("height", "250px");
});


// 일일보고 현황 차트
  // Pie chart
    var ctx1 = document.getElementById("pie-chart-0").getContext("2d");
    new Chart(ctx1, {
      type: "pie",
      data: {
        labels: ['미확인','보고', '미보고'],
        datasets: [{
          label: "DailyReport",
          weight: 9,
          cutout: 0,
          tension: 0.9,
          pointRadius: 2,
          borderWidth: 2,
          backgroundColor: ['#FEF5D3', '#CDF59B', '#FC9797'], // 	노 초 분
          data: ['${deptReportchartVO.dailyNonchkCnt}','${deptReportchartVO.dailyCnt-deptReportchartVO.dailyNonchkCnt}','${deptReportchartVO.deptCnt-deptReportchartVO.dailyCnt}'],
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

// 주별
    var ctx2 = document.getElementById("pie-chart-1").getContext("2d");
    new Chart(ctx2, {
      type: "pie",
      data: {
        labels: ['미확인','보고', '미보고'],
        datasets: [{
          label: "DailyReport",
          weight: 9,
          cutout: 0,
          tension: 0.9,
          pointRadius: 2,
          borderWidth: 2,
          backgroundColor: ['#FEF5D3', '#CDF59B', '#FC9797'], // 	노 초 분
          data: ['${deptReportchartVO.weeklyNonchkCnt}','${deptReportchartVO.weeklyCnt-deptReportchartVO.weeklyNonchkCnt}','${deptReportchartVO.deptCnt*7-deptReportchartVO.weeklyCnt}'],
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
    var ctx3 = document.getElementById("pie-chart-2").getContext("2d");
    new Chart(ctx3, {
      type: "pie",
      data: {
        labels: ['미확인','보고', '미보고'],
        datasets: [{
          label: "DailyReport",
          weight: 9,
          cutout: 0,
          tension: 0.9,
          pointRadius: 2,
          borderWidth: 2,
          backgroundColor: ['#FEF5D3', '#CDF59B', '#FC9797'], // 	노 초 분
          data: ['${deptReportchartVO.monthlyNonchkCnt}','${deptReportchartVO.monthlyCnt-deptReportchartVO.monthlyNonchkCnt}','${deptReportchartVO.deptCnt*30-deptReportchartVO.monthlyCnt}'],
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


 // Line chart (일별)
  var ctx4 = document.getElementById("line-chart-0").getContext("2d");

    new Chart(ctx4, {
      type: "line",
      data: {
        labels: ["월요일","화요일","수요일","목요일","금요일","토요일","일요일"],
        datasets: [
        	{
	            label: '${deptReportDay[0].DEPT_NM}',
	            tension: 0.4,
	            borderWidth: 0,
	            pointRadius: 2,
	            pointBackgroundColor: "#cb0c9f",
	            borderColor: "#cb0c9f",
	            borderWidth: 3,
	            data: [
            		"${deptReportDay[0].CNT}", "${deptReportDay[1].CNT}", "${deptReportDay[2].CNT}",
            		"${deptReportDay[3].CNT}", "${deptReportDay[4].CNT}", "${deptReportDay[5].CNT}",
            		"${deptReportDay[6].CNT}"
	            	],
	            maxBarThickness: 6
          },
          {
	            label: '${deptReportDay[7].DEPT_NM}',
	            tension: 0.4,
	            borderWidth: 0,
	            pointRadius: 2,
	            pointBackgroundColor: "#3A416F",
	            borderColor: "#3A416F",
	            borderWidth: 3,
	            data: [
            		"${deptReportDay[7].CNT}", "${deptReportDay[8].CNT}", "${deptReportDay[9].CNT}",
            		"${deptReportDay[10].CNT}", "${deptReportDay[11].CNT}", "${deptReportDay[12].CNT}",
            		"${deptReportDay[13].CNT}"
	            	],
	            maxBarThickness: 6
          },
          {
	            label: '${deptReportDay[14].DEPT_NM}',
	            tension: 0.4,
	            borderWidth: 0,
	            pointRadius: 2,
	            pointBackgroundColor: "#17c1e8",
	            borderColor: "#17c1e8",
	            borderWidth: 3,
	            data: [
            		"${deptReportDay[14].CNT}", "${deptReportDay[15].CNT}", "${deptReportDay[16].CNT}",
            		"${deptReportDay[17].CNT}", "${deptReportDay[18].CNT}", "${deptReportDay[19].CNT}",
            		"${deptReportDay[20].CNT}"
	            	],
	            maxBarThickness: 6
          },

        ],
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
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              padding: 10,
              color: '#b2b9bf',
              font: {
                size: 11,
                family: "Open Sans",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: true,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              color: '#b2b9bf',
              padding: 10,
              font: {
                size: 11,
                family: "Open Sans",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
        },
      },
    });

  // Line chart (주별)
   var ctx5 = document.getElementById("line-chart-1").getContext("2d");

    new Chart(ctx5, {
      type: "line",
      data: {
        labels: ["1주차","2주차","3주차","4주차","5주차"],
        datasets: [{
            label: "${deptReportWeek[0].DEPT_NM}",
            tension: 0.4,
            borderWidth: 0,
            pointRadius: 2,
            pointBackgroundColor: "#cb0c9f",
            borderColor: "#cb0c9f",
            borderWidth: 3,
            data: [
            	"${deptReportWeek[0].CNT}","${deptReportWeek[1].CNT}","${deptReportWeek[2].CNT}",
            	"${deptReportWeek[3].CNT}","${deptReportWeek[4].CNT}"
            	],
            maxBarThickness: 6
          },
          {
            label: "${deptReportWeek[5].DEPT_NM}",
            tension: 0.4,
            borderWidth: 0,
            pointRadius: 2,
            pointBackgroundColor: "#3A416F",
            borderColor: "#3A416F",
            borderWidth: 3,
            data: [
            	"${deptReportWeek[5].CNT}","${deptReportWeek[6].CNT}","${deptReportWeek[7].CNT}",
            	"${deptReportWeek[8].CNT}","${deptReportWeek[9].CNT}"
            ],
            maxBarThickness: 6
          },
          {
            label: "${deptReportWeek[10].DEPT_NM}",
            tension: 0.4,
            borderWidth: 0,
            pointRadius: 2,
            pointBackgroundColor: "#17c1e8",
            borderColor: "#17c1e8",
            borderWidth: 3,
            data: [
            	"${deptReportWeek[10].CNT}","${deptReportWeek[11].CNT}","${deptReportWeek[12].CNT}",
            	"${deptReportWeek[13].CNT}","${deptReportWeek[14].CNT}"

            	],
            maxBarThickness: 6
          },
        ],
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
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              padding: 10,
              color: '#b2b9bf',
              font: {
                size: 11,
                family: "Open Sans",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: true,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              color: '#b2b9bf',
              padding: 10,
              font: {
                size: 11,
                family: "Open Sans",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
        },
      },
    });

 // Line chart (월별)
    var ctx6 = document.getElementById("line-chart-2").getContext("2d");

    new Chart(ctx6, {
      type: "line",
      data: {
        labels: ["1월","2월","3월","4월","5월","6월",
        	     "7월","8월","9월","10월","11월","12월"],
        datasets: [{
            label: "${deptReportMonth[0].DEPT_NM}",
            tension: 0.4,
            borderWidth: 0,
            pointRadius: 2,
            pointBackgroundColor: "#cb0c9f",
            borderColor: "#cb0c9f",
            borderWidth: 3,
            data: [
				"${deptReportMonth[0].CNT}","${deptReportMonth[1].CNT}","${deptReportMonth[2].CNT}",
				"${deptReportMonth[3].CNT}","${deptReportMonth[4].CNT}","${deptReportMonth[5].CNT}",
				"${deptReportMonth[6].CNT}","${deptReportMonth[7].CNT}","${deptReportMonth[8].CNT}",
				"${deptReportMonth[9].CNT}","${deptReportMonth[10].CNT}","${deptReportMonth[11].CNT}"
            	],
            maxBarThickness: 6
          },
          {
            label: "${deptReportMonth[12].DEPT_NM}",
            tension: 0.4,
            borderWidth: 0,
            pointRadius: 2,
            pointBackgroundColor: "#3A416F",
            borderColor: "#3A416F",
            borderWidth: 3,
            data: [
            	"${deptReportMonth[12].CNT}","${deptReportMonth[13].CNT}","${deptReportMonth[14].CNT}",
				"${deptReportMonth[15].CNT}","${deptReportMonth[16].CNT}","${deptReportMonth[17].CNT}",
				"${deptReportMonth[18].CNT}","${deptReportMonth[19].CNT}","${deptReportMonth[20].CNT}",
				"${deptReportMonth[21].CNT}","${deptReportMonth[22].CNT}","${deptReportMonth[23].CNT}"
            	],
            maxBarThickness: 6
          },
          {
            label: "${deptReportMonth[24].DEPT_NM}",
            tension: 0.4,
            borderWidth: 0,
            pointRadius: 2,
            pointBackgroundColor: "#17c1e8",
            borderColor: "#17c1e8",
            borderWidth: 3,
            data: [
            	"${deptReportMonth[24].CNT}","${deptReportMonth[25].CNT}","${deptReportMonth[26].CNT}",
				"${deptReportMonth[27].CNT}","${deptReportMonth[28].CNT}","${deptReportMonth[29].CNT}",
				"${deptReportMonth[30].CNT}","${deptReportMonth[31].CNT}","${deptReportMonth[32].CNT}",
				"${deptReportMonth[33].CNT}","${deptReportMonth[34].CNT}","${deptReportMonth[35].CNT}"
            ],
            maxBarThickness: 6
          },
        ],
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
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              padding: 10,
              color: '#b2b9bf',
              font: {
                size: 11,
                family: "Open Sans",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: true,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              color: '#b2b9bf',
              padding: 10,
              font: {
                size: 11,
                family: "Open Sans",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
        },
      },
    });

</script>


