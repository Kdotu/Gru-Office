<%@page import="kr.or.ddit.vo.Work2VO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
th{
font-size : 1.1em;
}
</style>



<script type="text/javascript">


$(function(){
	//현재 날짜 기준 달 구하기 
	 todayy = new Date();   

	 year = todayy.getFullYear(); // 년도
	 dd = todayy.getDate();  // 날짜
	
	 
	// 달의 마지막 날짜 구하기
	var lastDay = new Date(todayy.getFullYear(), todayy.getMonth() + 1, 0).getDate();
	 
	month = $('#hiddenMonth').val(); 
	
	
	
	//처음 페이지 요청 시 오늘 날짜기준의 달을 가져옴
	if(month == "" ){
		month = todayy.getMonth() + 1;
	}
	
	if(month<10){
		month = '0'+month;
	}
	
	if(month>12){
		month=1;
		year+=1;
	}
	
	let datee = year+month;
	let dt = year+month+dd;
	
	
	// 데이터로 보낼 것들 
	let data = {"month" : datee,
				"dt"	: dt  };
	
// 	alert(datee); 
// 	alert(dt); 
	
	//ajax로 누적근무시간 받아오기 	
	$.ajax({
		url:"/work/getMonthWT",
		type:"post",
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log("리저트 : " + result); 
			
			$('#getMonthWT').text(result.result); 
			
		}
	});
	
	//ajax로 월기준 근무상세 count 가져오기 
	$.ajax({
		url:"/work/getMonthCNT",
		type:"post",
		data: JSON.stringify(data),
		dataType: "json",
		contentType:"application/json;charset=utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
	
		cnt1 = parseInt(result.정상근무);
		cnt2 = parseInt(result.지각);
		cnt3 = parseInt(result.조퇴);
		cnt4 = parseInt(result.결근);
		cnt5 = parseInt(result.휴가);
		
		// 지각3번(지각수/3으로 나눈 몫을 조퇴에 +1) => 조퇴 +1
		// 조퇴3번(조퇴수/3으로 나눈 몫을 결근에 +1) => 결근 +1
		cnt3 += Math.floor(cnt2 / 3);
		cnt4 += Math.floor(cnt3 / 3);
			
			$('#cnt1').text(cnt1); 
			$('#cnt2').text(cnt2); 
			$('#cnt3').text(cnt3); 
			$('#cnt4').text(cnt4); 
			$('#cnt5').text(cnt5); 
			
		//근태 현황 그래프(비율 나타내는거 )
		// 	100 / 한달의 마지막날 * 그 개수 등등 

		//text 
		$('#ct1').text(Math.floor(100/lastDay*cnt1)+"%");   	
		$('#ct2').text(Math.floor(100/lastDay*cnt2)+"%");   	
		$('#ct3').text(Math.floor(100/lastDay*cnt3)+"%");   	
		$('#ct4').text(Math.floor(100/lastDay*cnt4)+"%");   	
		$('#ct5').text(Math.floor(100/lastDay*cnt5)+"%");   	
		
		let rate1 = Math.floor(100/lastDay*cnt1);
		if (rate1 >= 10) {
		  rate1 = Math.floor(rate1 / 10) * 10;
		} else if (rate1 === 0) {
		  rate1 = "0";
		}
		
		let rate2 = Math.floor(100/lastDay*cnt2);
		if (rate2 >= 10) {
			rate2 = Math.floor(rate2 / 10) * 10;
		} else if (rate2 === 0) {
			rate2 = "0";
		}
		
		let rate3 = Math.floor(100/lastDay*cnt3);
		if (rate3 >= 10) {
		  rate3 = Math.floor(rate3 / 10) * 10;
		} else if (rate3 === 0) {
		  rate3 = "0";
		}
		
		let rate4 = Math.floor(100/lastDay*cnt4);
		if (rate4 >= 10) {
			rate4 = Math.floor(rate4 / 10) * 10;
		} else if (rate4 === 0) {
			rate4 = "0";
		}
		
		let rate5 = Math.floor(100/lastDay*cnt5);
		if (rate5 >= 10) {
			rate5 = Math.floor(rate5 / 10) * 10;
		} else if (rate5 === 0) {
			rate5 = "0";
		}
		
		
		//근무상세 그래프 
		$('#c1').append("<div class='progress-bar bg-gradient-info w-"+rate1+"' role='progressbar' aria-valuenow='60' aria-valuemin='0' aria-valuemax='100'></div>")
		$('#c2').append("<div class='progress-bar bg-gradient-danger w-"+rate2+"' role='progressbar' aria-valuenow='10' aria-valuemin='0' aria-valuemax='100'></div>")
		$('#c3').append("<div class='progress-bar bg-gradient-danger w-"+rate3+"' role='progressbar' aria-valuenow='10' aria-valuemin='0' aria-valuemax='100'></div>")
		$('#c4').append("<div class='progress-bar bg-gradient-dark w-"+rate4+"' role='progressbar' aria-valuenow='10' aria-valuemin='0' aria-valuemax='100'></div>")
		$('#c5').append("<div class='progress-bar bg-gradient-green w-"+rate5+"' role='progressbar' aria-valuenow='10' aria-valuemin='0' aria-valuemax='100'></div>")
			
		}
	});
	
	
	
	
	
	
	
	
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
		
		
		console.log('현재 선택한 달 : '+ month); //month는 문자열 '01'형태 //이걸 ajax로 불러와야하지 않을까
		
		
		console.log('data로 보낼 날짜 : '+ year+month); //month는 문자열 '01'형태 
		
		
		let datee = year+month;
		let dt = year+month+dd; 

// 		alert(datee); 
		
		
// 		alert("파라미터로 보낼 dt : " + dt); 
		
		location.href = "/work/workList?month="+datee+"&dt="+dt;
			
			
			
	})
	
	
	//달력 이전 버튼 누를경우 이전 달로 
	$('#lastMonth').on('click', function(){
		

		month = $('#hiddenMonth').val();
		
		
		if(month == ""){
		   month = todayy.getMonth()+1;
		}
		
		month = parseInt(month)-1; 
// 		alert(month); 
		
		
		if(month<10){
			month = '0'+month;
		}
		
		if(month<1){
			month=12;
			year-=1;
		}
		
		let datee = year+month;
		
		location.href = "/work/workList?month="+datee;
	})
	
})
</script>
<div class="row">
	<div class="col-2">
		<jsp:include page="/WEB-INF/views/aside/workAside.jsp" />
	</div>
	<div class="col-10">
		<div class="d-flex mt-4 pt-2" style="text-align: center; margin-left: 570px;">
			<button class="btn btn-outline-black rounded-circle p-2 mb-0"  id="lastMonth" type="button" style="background: white; margin-top: -10px; ">
			<i class="fas fa-backward p-2" aria-hidden="true"></i>
			</button>
			&nbsp;&nbsp;&nbsp;<h4 id="month" >${date}</h4><input id="hiddenMonth" type="hidden" value="${month }">&nbsp;&nbsp;&nbsp;
			<button class="btn btn-outline-black rounded-circle p-2 mb-0" id="nextMonth" type="button" style="background: white; margin-top: -10px;">
			<i class="fas fa-forward p-2" aria-hidden="true"></i>
			</button>
		</div>
		<div class="container-fluid py-4">
			<div class="row">
				<div class="col-lg-6 col-12">
					<div class="row">
						<div class="col-lg-6 col-md-6 col-12">
							<div class="card"
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-dark opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-12 text-center">
											<h4 class="text-white font-weight-bolder mb-0 mt-3">이번주 누적</h4>
											<span class="text-white" style="font-size: 2.5em; font-weight: lighter;">${thisWeekSumVO.result }</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-12">
							<div class="card"         
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-dark opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-12 text-center">
											<h4 class="text-white font-weight-bolder mb-0 mt-3">이번주 잔여</h4>
											<span class="text-white" style="font-size: 2.5em; font-weight: lighter;">${thisWeekleft }</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col-lg-6 col-md-6 col-12">
							<div class="card"
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-dark opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-12 text-center">
											<h4 class="text-white font-weight-bolder mb-2 mt-3">이번달 누적</h4>
											<span class="text-white" id="getMonthWT" style="font-size: 2.2em; font-weight: lighter;"></span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-lg-6 col-md-6 col-12">
							<div class="card"
								style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-dark opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-6 text-start" style="color: white; font-weight: bolder;">
											<p style="margin-bottom: -1px;">정상근무</p>
											<p style="margin-bottom: -1px;">지각</p>
											<p style="margin-bottom: -1px;">조퇴</p>
											<p style="margin-bottom: -1px;">결근</p>
											<p style="margin-bottom: -1px;">휴가</p>
										</div>
										<div class="col-6 text-end" style="color: white; font-weight: bold;">
											<p style="margin-bottom: -1px;" id="cnt1"></p>
											<p style="margin-bottom: -1px;" id="cnt2"></p>
											<p style="margin-bottom: -1px;" id="cnt3"></p>
											<p style="margin-bottom: -1px;" id="cnt4"></p>
											<p style="margin-bottom: -1px;" id="cnt5"></p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-12 mt-4 mt-lg-0">
					<div class="card h-100">
						<div class="card-header pb-0 p-3">
							<h4 class="mb-0">내 근태 통계</h4>
						<button type="button" style="margin-top:-30px; right-margin: -50px;" 
											class="btn btn-icon-only btn-rounded btn-outline-secondary mb-2 ms-2 btn-sm d-flex align-items-center justify-content-center ms-auto"
											data-bs-toggle="tooltip" data-bs-placement="bottom"
											aria-label="지각 3번은 조퇴 1번 , 조퇴3번은 결근 1번으로 집계됩니다."
											data-bs-original-title="지각 3번은 조퇴 1번, 조퇴3번은 결근 1번으로 집계됩니다.">
											<i class="fas fa-info" aria-hidden="true"></i>
										</button>
						</div>
						<div class="card-body pb-0 p-3">
							<ul class="list-group">
								<li class="list-group-item border-0 d-flex align-items-center px-0 mb-0">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 font-weight-bold text-capitalize" style="font-size:1.1em;">정상근무</span>
											<span class="ms-auto text-sm font-weight-bold" id="ct1"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c1">
												<!-- 												<div class="progress-bar bg-gradient-info w-80" 그래프는 w-80의 숫자를 변경해서 코딩></div> -->
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item border-0 d-flex align-items-center px-0">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 font-weight-bold text-capitalize" style="font-size:1.1em;">지각
											</span> <span class="ms-auto text-sm font-weight-bold" id="ct2"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c2">
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item border-0 d-flex align-items-center px-0">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 font-weight-bold text-capitalize" style="font-size:1.1em;">조퇴
											</span> <span class="ms-auto text-sm font-weight-bold" id="ct3"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c3">
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item border-0 d-flex align-items-center px-0">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 font-weight-bold text-capitalize" style="font-size:1.1em;">결근
											</span> <span class="ms-auto text-sm font-weight-bold" id="ct4"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c4">
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item border-0 d-flex align-items-center px-0">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 font-weight-bold text-capitalize" style="font-size:1.1em;">휴가
											</span> <span class="ms-auto text-sm font-weight-bold" id="ct5"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c5">
											</div>
										</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<hr/>
			<div class="row"   style="margin-left: 70px;" >
			<c:forEach var="work2VO" items="${workSumList }" varStatus="stat">
			<span class="badge badge-secondary col-2" style="font-size:1.2em;"><p style="font-size:1.5em; color:navy;">${stat.count } 주차</p>${work2VO.result }</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</c:forEach>
			</div>

			<div class="row my-4">
				<div class="col-12">
					<div class="card" >
						<div class="accordion-1">
							<div class="container">
								<div class="row">
									<div class="col-md-10 mx-auto">
										<div class="accordion" id="accordionRental">
										<!-- 현재 날짜가 속한 아코디언의 속성을 변경하여 열리게 하기 -->
										<!-- class="accordion-button border-bottom font-weight-bold collapsed" 콜랍스를 없앰  -->
										<!-- aria-expanded="true" false를 true로 변경 -->
										<!-- class="accordion-collapse collapse " 끝에 show를 붙임 -->
										<c:set value="0" var="week"/>
										<div id="nextMonth">
										<c:forEach items="${data }" var="work2VO" varStatus="stat">
											<c:if test="${stat.count eq fn:length(data)  }">
												<c:set value="${week + 1 }" var="week"/>
												<div class="accordion-item mb-3">
													<h5 class="accordion-header" id="heading2">
														<button
															class="accordion-button border-bottom font-weight-bold"
															type="button" data-bs-toggle="collapse"
															data-bs-target="#collapse2" aria-expanded="true"
															aria-controls="collapse2" >
															${week}주차 <i
																class="collapse-close fa fa-plus text-xs pt-1 position-absolute end-0 me-3"
																aria-hidden="true"></i> </i> <i
																class="collapse-open fa fa-minus text-xs pt-1 position-absolute end-0 me-3"
																aria-hidden="true"></i>
														</button>
													</h5>
													<div id="collapse2" class="accordion-collapse collapse show"
													aria-labelledby="heading2"
													data-bs-parent="#accordionRental" style="">
													<div class="accordion-body text-md">
														<div class="table-responsive">
															<div
																class="dataTable-wrapper dataTable-loading no-footer sortable fixed-height fixed-columns">
																<div class="dataTable-container"
																	style="height: 500.641px;">
																	<table class="table table-flush dataTable-table"
																		id="datatable-basic">
																		<thead class="thead-light">
																			<tr>
																				<th
																					class="text-uppercase text-secondary font-weight-bolder "
																					data-sortable="" style="width: 24.9465%; font-size:1.3em;" ><a
																					href="#" class="dataTable-sorter" >일자</a></th>
																				<th
																					class="text-uppercase text-secondary font-weight-bolder"
																					data-sortable="" style="width: 34.5296%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">업무시작</a></th>
																				<th
																					class="text-uppercase text-secondary font-weight-bolder"
																					data-sortable="" style="width: 20.8395%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">업무종료</a></th>
																				<th
																					class="text-uppercase text-secondary font-weight-bolder"
																					data-sortable="" style="width: 10.1916%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">총 근무시간</a></th>
																				<th
																					class="text-uppercase text-secondary font-weight-bolder"
																					data-sortable="" style="width: 18.5578%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">근무상세</a></th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:set value="${(week - 1) * 7 }" var="beginCount"/>
																			<c:forEach items="${data }" var="work2VO" varStatus="stat2" begin="${beginCount }" end="${(week+1) * 7 }" step="1">
																				<tr>
																					<td class="text-lg font-weight-bolder">${work2VO.dates }</td>
																					<td class="text-lg font-weight-normal">${work2VO.workMngBgngDt}</td>
																					<td class="text-lg font-weight-normal">${work2VO.workMngEndDt}</td>
																					<td class="text-lg font-weight-normal">${work2VO.workMngHr}</td>
																					<td class="text-lg font-weight-normal">${work2VO.workMngDtlCn}</td>
																				</tr>
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
												</div>
												</div>
											</c:if>
											<c:if test="${stat.count % 7 == 0 }">
												<c:set value="${week + 1 }" var="week"/>
												<div class="accordion-item mb-3">
													<h5 class="accordion-header" id="heading2">
														<button
															class="accordion-button border-bottom font-weight-bold"
															type="button" data-bs-toggle="collapse"
															data-bs-target="#collapse2" aria-expanded="true"
															aria-controls="collapse2">
															${week}주차 <i
																class="collapse-close fa fa-plus text-xs pt-1 position-absolute end-0 me-3"
																aria-hidden="true"></i> </i>  <i
																class="collapse-open fa fa-minus text-xs pt-1 position-absolute end-0 me-3"
																aria-hidden="true"></i>
														</button>
													</h5>
													<div id="collapse2" class="accordion-collapse collapse show"
													aria-labelledby="heading2"
													data-bs-parent="#accordionRental" style="">
													<div class="accordion-body text-md">
														<div class="table-responsive">
															<div
																class="dataTable-wrapper dataTable-loading no-footer sortable fixed-height fixed-columns">
																<div class="dataTable-container"
																	style="height: 500.641px;">
																	<table class="table table-flush dataTable-table"
																		id="datatable-basic">
																		<thead class="thead-light">
																			<tr>
																				<th
																					class="text-uppercase text-secondary font-weight-bolder "
																					data-sortable="" style="width: 24.9465%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">일자</a></th>
																				<th
																					class="text-uppercase text-secondary  font-weight-bolder "
																					data-sortable="" style="width: 34.5296%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">업무시작</a></th>
																				<th
																					class="text-uppercase text-secondary  font-weight-bolder "
																					data-sortable="" style="width: 20.8395%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">업무종료</a></th>
																				<th
																					class="text-uppercase text-secondary  font-weight-bolder "
																					data-sortable="" style="width: 10.1916%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">총 근무시간</a></th>
																				<th
																					class="text-uppercase text-secondary  font-weight-bolder "
																					data-sortable="" style="width: 18.5578%; font-size:1.3em;"><a
																					href="#" class="dataTable-sorter">근무상세</a></th>
																			</tr>
																		</thead>
																		<tbody>
																			<c:set value="0" var="beginCount"/>
																			<c:if test="${stat.index > 6 }">
																				<c:set value="${7 * (week-1) }" var="beginCount"/>
																			</c:if>
																			<c:set var="doneLoop" value="true"/>
																			<c:forEach items="${data }" var="work2VO" varStatus="stat2" begin="${beginCount }" end="${(week+1) * 7 }" step="1">
																				<c:if test="${doneLoop }">
																					<tr>
																						<td class="text-lg font-weight-bolder">${work2VO.dates }</td>
																						<td class="text-lg font-weight-normal">${work2VO.workMngBgngDt}</td>
																						<td class="text-lg font-weight-normal">${work2VO.workMngEndDt}</td>
																						<td class="text-lg font-weight-normal">${work2VO.workMngHr}</td>
																						<td class="text-lg font-weight-normal">${work2VO.workMngDtlCn}</td>
																					</tr>
																					<c:if test="${stat2.count % 7 == 0 }">
																						<c:set var="doneLoop" value="false"/>
																					</c:if>
																				</c:if>
																			</c:forEach>
																		</tbody>
																	</table>
																</div>
															</div>
														</div>
													</div>
												</div>
												</div>
											</c:if>
										</c:forEach>
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
</div>
<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>