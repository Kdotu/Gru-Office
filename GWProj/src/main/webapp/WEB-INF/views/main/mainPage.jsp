<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
img{
	object-fit : contain;
	width : 100%;
}
.type_btn_list_block {
	list-style-type: none;
}
.swal-text {
  font-size: 1.6rem !important;
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

// 	month = $('#hiddenMonth').val();
	month = todayy.getMonth() + 1;

	$('#title').text(month+"월 근태통계")

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

	//출근하기 버튼을 누르면 근태관리 테이블에 insert
	$('#gotoworkBtn').on('click',function(){
		let $target = $(this);
		console.log($target);

		$.ajax({
				url:"/work/insertgw",
				type:"post",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					console.log(result);
					//sweetalert 처리하기

					var str = "";

					  if(result.workMngDtlCn=="지각"){
				    	 str += result.workMngDtlCn+"이네요! 다음번에는 늦지 마세요!!"
			    	  }else{
			    		 str += result.workMngDtlCn+"으로 등록되었어요~! 시간맞춰 잘 오셨어요!"
			    	  }

					swal({
					      title: "출근이 처리되었습니다!",
					      icon: "success", //success, warning, error
					      text: str,
					      button: "확인",
					   }).then(function () {
						   location.reload();
					    });

				}
			});
	})


	//퇴근하기 버튼을 누르면 근태관리 테이블 update
	$('#gotohomeBtn').on('click',function(){
		let $target = $(this);
		console.log($target);

		$.ajax({
				url:"/work/insertgh",
				type:"post",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					console.log(result);
					//sweetalert 처리하기
					swal({
					      title: "퇴근이 처리되었습니다!",
					      icon: "success", //success, warning, error
					      button: "확인",
					   }).then(function () {
						   location.reload();
					    });
				}
			});
	})

	//출근여부에 따른 출근버튼 비활성화
	$.ajax({
		url:"/work/countWork",
		type:"post",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){

			if(result.workMngNo==1){
				//이미 출근한 상태라면 출근버튼 비활성화
					$('#gotoworkBtn').prop("disabled", true);
				if(result.workMngEndDt != null){
			    //출근한 상태이면서 퇴근도 했을 경우 퇴근 버튼도 비활성화
					$('#gotohomeBtn').prop("disabled", true);
			    //퇴근했으면 근무상태가 자동으로 '업무종료'가 됨(트리거 사용)
			    //select 기능 막는 방법을 모르겠음
			    $('#choices-work').disabled = true;

				}
			}if(result.workMngNo==0){
				//출근도 전이라면 퇴근버튼 비활성화
				$('#gotohomeBtn').prop("disabled", true);
			}

		}//success 끝
	});


})
</script>

<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />


	<body class="g-sidenav-show  bg-gray-100">
		<main
			class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
			<!-- start row 1 -->
			<div class="container-fluid py-4 px-0">
				<div class="row">
					<!-- 회원정보,근태관리,Todo 목록 -->
					<div class="col">
						<!-- 회원정보 카드 시작 -->
						<div class="card">
							<div class="card-body p-3 position-relative">
								<div class="mb-xl-0 mb-4">
									<div class="card card-blog card-plain">
										<div class="position-relative">
											<a class="d-block border-radius-xl">
								<c:choose>
									<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
					                 	<img src="/resources/upload${empVO.fileGrVO.filesList[0].fileStrgNm}" alt="${empVO.fileGrVO.filesList[0].fileOrgnlNm}" class="img-fluid border-radius-xl">
									</c:when>
									<c:otherwise>
					                	<img src="/resources/upload/emp/profile/default.png" alt="default.png" class="img-fluid border-radius-xl">
									</c:otherwise>
				        	    </c:choose>
											</a>
										</div>
										<div class="card-body px-1 pb-0">
											<p class="text-gradient text-dark mb-2 text-sm"
												style="text-align: center;">${empVO.deptNm}</p>
											<a href="javascript:;">
												<h5 style="text-align: center;">${empVO.empNm}</h5>
											</a>
											<div class="d-flex align-items-center px-5 w-100">
												<table class="w-100">
													<tr>
														<td><p>
																<b>오늘 온 메일</b>
															</p></td>
														<td style="text-align: right;"><p>${todayMailCnt}</p></td>
													</tr>
													<tr>
														<td><p>
																<b>오늘의 일정</b>
															</p></td>
														<td style="text-align: right;"><p>${totalTodayCount}</p></td>
													</tr>
												</table>
											</div>
										</div>
										<div class="mx-auto">
											<table>
												<tr>
													<td>
														<a href="/mail/write" class="btn btn-outline-dark btn-lg p-4 m-2" data-bypass="true" style="border: 2px solid;">
															<span class="ic_dashboard2 ic_create_survey" title="메일쓰기">
																<img class="img" alt="" src="/resources/maincss/assets/img/mail.png" style="width: 25px;"></span>
																<span class="txt keepAll">메일쓰기</span>
														</a>
													</td>
													<td>
														<a href="/cal/calFrame" class="btn btn-outline-dark btn-lg p-4 m-2" data-bypass="true" style="border: 2px solid;">
														<span class="type">
															<span class="ic_dashboard2 ic_create_survey" title="일정">
															<img class="img" alt="" src="/resources/maincss/assets/img/cal.png" style="width: 25px;">
															</span>
														</span>
														<span class="txt keepAll">&nbsp;&nbsp;&nbsp;&nbsp;일 정&nbsp;&nbsp;&nbsp;&nbsp;</span>
														</a>
													</td>
												</tr>
												<tr>
													<td>
														<a href="/survey/create" class="btn btn-outline-dark btn-lg p-4 m-2" data-bypass="true" style="border: 2px solid;">
															<span class="type">
																<span class="ic_dashboard2 ic_create_survey" title="설문작성">
																	<img class="img" alt="" src="/resources/maincss/assets/img/board.png" style="width: 25px;">
																</span>
															</span>
															<span class="txt keepAll">설문작성</span>
														</a>
													</td>
													<td>
														<a href="/edoc/main" class="btn btn-outline-dark btn-lg p-4 m-2" data-bypass="true" style="border: 2px solid;">
															<span class="type">
																<span class="ic_dashboard2 ic_create_survey" title="전자결재">
																	<img class="img" alt="" src="/resources/maincss/assets/img/sign.png" style="width: 25px;">
																</span>
															</span>
															<span class="txt keepAll">전자결재</span>
														</a>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 회원정보 카드 끝 -->
					<!-- 근태관리 카드 시작 -->
					<div class="col-6">
						<div class="card">
							<div class="card-body">
								<div class="row">
									<h4><img class="img mx-2 mb-1" alt="" src="/resources/maincss/assets/img/bag.png" style="width: 25px; magin-right:5px;">근태관리</h4>
								</div>

								<!-- 근태 통계 시작 -->
								<div class="row mt-4">
						<div class="col-lg-6 col-md-6 col-12">
							<div class="card" style="background-image: url('/resources/maincss/assets/img/curved-images/white-curved.jpeg')">
								<span class="mask bg-gradient-dark opacity-9 border-radius-xl"></span>
								<div class="card-body p-3 position-relative"
									style="height: 158px;">
									<div class="row">
										<div class="col-12 text-center">
											<h4 class="text-white font-weight-bolder mb-0 mt-3">이번달 누적</h4>
											<span class="text-white" id="getMonthWT" style="font-size: 2.3em; font-weight: lighter;"></span>
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
					<!-- 근태 통계 끝 -->
					<hr/>

									<button id="gotoworkBtn" type="button" class="btn btn-lg btn-outline-info"
										style="width: 300px; border-radius: 20px; font-size: 1.1em;">출근하기</button>
									<button id="gotohomeBtn" type="button" class="btn btn-lg btn-outline-info"
										style="width: 300px; margin-left:25px; border-radius: 20px; font-size: 1.1em;">퇴근하기</button>
								<!-- 근태 그래프 시작 -->
								<div class="col-lg-12 col-12 mt-4 mt-lg-0">
					<div class="card h-100">
						<div class="card-header pb-0 p-3">
							<h6 class="mb-0" id="title"></h6>
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
											<span class="me-2 text-md font-weight-bold text-capitalize">정상근무</span>
											<span class="ms-auto text-sm font-weight-bold" id="ct1"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c1">
												<!-- 												<div class="progress-bar bg-gradient-info w-80" 그래프는 w-80의 숫자를 변경해서 코딩></div> -->
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item border-0 d-flex align-items-center px-0 mb-2">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 text-md font-weight-bold text-capitalize">지각
											</span> <span class="ms-auto text-sm font-weight-bold" id="ct2"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c2">
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item border-0 d-flex align-items-center px-0 mb-2">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 text-md font-weight-bold text-capitalize">조퇴
											</span> <span class="ms-auto text-sm font-weight-bold" id="ct3"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c3">
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item border-0 d-flex align-items-center px-0 mb-2">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 text-md font-weight-bold text-capitalize">결근
											</span> <span class="ms-auto text-sm font-weight-bold" id="ct4"></span>
										</div>
										<div>
											<div class="progress progress-md" id="c4">
											</div>
										</div>
									</div>
								</li>
								<li class="list-group-item border-0 d-flex align-items-center px-0 mb-2">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 text-md font-weight-bold text-capitalize">휴가
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
				<!-- 근태 그래프 끝 -->
				<hr/>
								<a href="/work/workList" class="text-info icon-move-right">근태 페이지 바로가기 <i class="fas fa-arrow-right text-xs ms-1"
									aria-hidden="true"></i>
								</a>
							</div>
						</div>
					</div>
					<!-- 근태관리 카드 끝 -->
					<!-- 일일업무보고 카드 시작 -->
					<div class="col">
						<div class="card">
							<div class="card-body">
								<div class="row">
									<h4><img class="img mx-2 mb-1" alt="" src="/resources/maincss/assets/img/business-report.png" style="width: 25px; magin-right:5px;">일일업무보고</h4>
								</div>
								<div class="pt-0 p-3 text-center">
									<button type="button" style="margin-top:-30px; right-margin: -50px; left:135px; bottom:25px;" class="btn btn-icon-only btn-rounded btn-outline-secondary btn-sm position-relative" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="금일 작성한 일일업무 보고 현황을 확인할 수 있습니다." data-bs-original-title="금일 작성한 일일업무 보고 현황을 확인할 수 있습니다.">
										<i class="fas fa-info" aria-hidden="true"></i>
									</button>
									<p class="mb-0 text-sm mt-3"><fmt:formatDate pattern="yyyy" value="${today}" />년 <fmt:formatDate pattern="MM" value="${today}" />월 ${thisWeek}주차</p>
									<h3 class="mb-0"><fmt:formatDate pattern="MM/dd (E)" value="${today}" /></h3>
									<br />
									<table class="w-100">
										<tr>
											<td><span class="text-md">일일보고상태</span></td>
											<td><span class="badge
											<c:choose>
												<c:when test='${not empty todayVO}'> bg-gradient-success">보고</c:when>
												<c:otherwise>bg-gradient-warning">미보고</c:otherwise>
											</c:choose>
											</span></td>
										</tr>
									</table>
								<hr class="horizontal dark my-3">
								<c:choose>
									<c:when test='${not empty todayVO}'><a href="/dailyReport/detail?rptpNo=${todayVO.rptpNo}" class="btn btn-lg btn-default">보고 조회</a></c:when>
									<c:otherwise><a href="/dailyReport/create" class="btn btn-lg btn-outline-info">보고하기</a></c:otherwise>
								</c:choose>
							</div>
						<sec:authorize access="hasAuthority('AUTH_MID')">
							<!-- 부서별 일일업무현황 시작 -->
							<div class="card-body p-3 text-center"style="border-top: 1px dotted gray;">
								<button type="button" style="margin-top:-30px; right-margin: -50px; left:135px;top:15px; " class="btn btn-icon-only btn-rounded btn-outline-secondary btn-sm position-relative" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="부서별 금일 일일업무 보고 현황을 확인할 수 있습니다." data-bs-original-title="부서별 금일 일일업무 보고 현황을 확인할 수 있습니다.">
									<i class="fas fa-info" aria-hidden="true"></i>
								</button>
								<p class="text-md mb-0 pt-2"> ${empVO.deptNm} </p>
								<h5 class="mb-0 pb-2">일일보고 현황</h5>
								<br />

								<table class="w-80 mx-auto">
									<tr>
										<td><span class="text-md text-right">보고자 ${reportMemCount-0}명 </span></td>
										<td><span class="text-md text-right" style="color:red;">미보고자 ${totalMemCount-reportMemCount}명</span></td>
									</tr>
								</table>


								<hr class="horizontal dark my-3">
								<table class="w-100">
									<tr>
										<td><span class="text-md">미확인 일일보고</span></td>
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
										<td><span class="text-md">오늘자 확인한 보고</span></td>
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
						</sec:authorize>
							<!-- 부서별 일일업무현황 끝 -->



						</div>
					</div>
				</div>
				<!-- todo 카드 끝 -->
			</div>
			<!-- end for row 1 -->
			<!-- start row 2 -->
			<div class="container-fluid py-4 px-0">
				<div class="row">
					<!-- 캘린더, 전자결재, 예약현황 -->
					<!-- 프로젝트 카드 시작 -->
					<div class="col">
						<div class="card">
							<div class="card widget-calendar h-100">
								<div class="card-header p-3 pb-0">
								<div class="row mt-2">
									<h4><img class="img mx-2 mb-1" alt="" src="/resources/maincss/assets/img/works.png" style="width: 25px; magin-right:5px;">참여중인 프로젝트</h4>
								</div>
									<button type="button" style="float: right; margin-top: -40px;"
										class="btn btn-icon-only btn-rounded btn-outline-secondary btn-sm position-relative"
										data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label=""
										data-bs-original-title="프로젝트 마감일이 가까운 순으로 보여집니다.">
										<i class="fas fa-info" aria-hidden="true"></i>
									</button>

								</div>

								<div class="card-body pt-0" style="margin-top: 20px;">
									<c:forEach var="projVO" items="${mainProjList}" varStatus="stat">
										<div class="row">
											<div class="h-100 col-10">
												<p class="text-md mb-1">${projVO.projTtl}</p>
											</div>
											<div class="h-100 col-2">
												<a href="/projects/projDetail?projNo=${projVO.projNo}" class="text-info text-sm icon-move-right my-auto">
												<i class="fas fa-arrow-right text-xs ms-1" aria-hidden="true"></i>
												</a>
											</div>
										</div>
										<hr class="horizontal dark">
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
					<!-- 프로젝트 카드 끝 -->
					<!-- 전자결재 카드 시작 -->
					<div class="col-6">
						<div class="card">
							<div class="card-header p-3 pb-0">
								<div class="row mx-0 mt-2">
									<div class="col-4">
										<div class="row">
											<h4><img class="img mx-2 mb-1" alt="" src="/resources/maincss/assets/img/sign.png" style="width: 25px; magin-right:5px;">결재대기문서</h4>
										</div>
									<h3 class="" style="font-color: black;"></h3>
									</div>
									<div class="col-1" style="">
										<span class="badge bg-gradient-warning"><a href="/edoc/approve">더보기</a></span>
									</div>
								</div>

								<button type="button" style="float: right; margin-top: -55px;"
									class="btn btn-icon-only btn-rounded btn-outline-secondary btn-sm position-relative"
									data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label=""
									data-bs-original-title="결재대기중인 문서를 5개씩 조회할 수 있습니다.">
									<i class="fas fa-info" aria-hidden="true"></i>
								</button>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table align-items-center mb-0">
										<thead>
											<tr>
												<th class="text-center text-dark text-md font-weight-bolder">순번</th>
												<th class="text-center text-dark text-md font-weight-bolder ">문서제목</th>
												<th class="text-center text-dark text-md font-weight-bolder ">기안자</th>
												<th class="text-center text-dark text-md font-weight-bolder ">기안부서</th>
												<th class="text-center text-md font-weight-bolder ">수신일시</th>
											</tr>
										</thead>
										<tbody>
											<c:set var="dataList" value="${pagingVO.dataMapList}" />
											<c:choose>
												<c:when test="${empty dataList}">
													<tr>
														<td class="align-middle text-center" colspan="6">조회하신 문서가 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="edoc" items="${dataList}" >
														<tr class="getAtrz">
															<td class="align-middle text-center ">${edoc.RNUM}</td>
															<td class="align-middle text-center " >
																<a href="" onclick="window.open('/edoc/edocDetail?edocVO.edocNo=${edoc.EDOC_NO}&edocVO.edocFormClsf=${edoc.EDOC_FORM_CLSF}&approve=1','_blank','toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=1000, height=1500')">
																${edoc.EDOC_TTL}</a></td>
															<td class="align-middle text-center">${edoc.EMP_INIT_NO}</td>
															<td class="align-middle text-center">${edoc.EMP_INIT_NM}</td>
															<td class="align-middle text-center">${edoc.ATRZ_RECEIPT_DT}</td>
															<input type="hidden" class="edocNo" value="${edoc.EDOC_NO}" />
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</div>
							</div>

						</div>
					</div>
					<!-- 전자결재 카드 끝 -->
					<!-- 예약 카드 시작 -->
					<div class="col">
						<div class="card">
							<div class="card-header p-3 pb-0">
								<div class="row mt-2">
									<h4><img class="img mx-2 mb-1" alt="" src="/resources/maincss/assets/img/res.png" style="width: 25px; magin-right:5px;">예약 현황</h4>
								</div>
								<button type="button" style="float: right; margin-top: -45px;"
									class="btn btn-icon-only btn-rounded btn-outline-secondary btn-sm position-relative"
									data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label=""
									data-bs-original-title="금일 회의실 예약 현황과 일주일 이내 예약 차량 정보를 확인할 수 있습니다.">
									<i class="fas fa-info" aria-hidden="true"></i>
								</button>
							</div>
							<div class="card-body text-center">
								<!-- 오늘 예약 현황 시작-->

								<table class="w-100 mx-auto">
									<tr>
										<td class="text-start"><h5 class="text-md">오늘 예약된 회의실</h5></td>
										<td>
										<c:choose>
											<c:when test="${resRoonTodayCount gt 0}">
												<span class="badge bg-gradient-warning">${resRoonTodayCount}건</span>
											</c:when>
											<c:otherwise>
												<span class="badge bg-gradient-light">0건</span>
											</c:otherwise>
										</c:choose>
										</td>
									</tr>

								</table>
								<hr class="horizontal dark my-3">
								<h5 class="mb-0 pb-2 text-start">최근 예약 차량</h5>
								<table class="w-100 mx-auto">
								<tr>
									<th>
										<span class="text-md text-center">차량 번호</span>
									</th>
									<th>
										<span class="text-md text-center">예약 시작일</span>
									</th>
									<th>
										<span class="text-md text-center">예약 마감일</span>
									</th>
								</tr>
								<tr>
									<c:if test="${resCarTodayList.size() eq 0}">
										<td colspan="3">
											<span class="text-md text-center">최근 예약 완료된 차량이 없습니다.</span>
										</td>
									</c:if>
									<c:if test="${resCarTodayList ne null}">
											<c:forEach items="${resCarTodayList}" var="vhrRsvtVO"  varStatus="status">
											<tr>
												<td>
													<span class="text-md text-center">${vhrRsvtVO.vhrNo}</span>
												</td>
												<td>
												<c:set var="dayStart" value="${vhrRsvtVO.vhrRsvtBgngDt}"/>
												<c:set var="splitDayStart" value="${fn:split(dayStart, ' ')}"/>
													<span class="text-md text-center">${splitDayStart[0]}</span>
												</td>
												<td>
												<c:set var="dayEnd" value="${vhrRsvtVO.vhrRsvtEndDt}"/>
												<c:set var="splitDayEnd" value="${fn:split(dayEnd, ' ')}"/>
													<span class="text-md text-center">${splitDayEnd[0]}</span>
												</td>
												</tr>
											</c:forEach>
									</c:if>
								</tr>
								</table>
								<hr class="horizontal dark my-3">
								<a type="button" href="/reserve/myres" class="btn btn-lg btn-outline-info" >내 예약목록</a>
								<!-- 오늘 예약 현황 끝-->
							</div>
						</div>
					</div>
				</div>
				<!-- 예약 카드 끝 -->
			</div>
			<!-- end for row 2 -->
		</main>
</sec:authorize>
<!--   Core JS Files   -->
<script src="../../assets/js/core/popper.min.js"></script>
<script src="../../assets/js/core/bootstrap.min.js"></script>
<script src="../../assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="../../assets/js/plugins/smooth-scrollbar.min.js"></script>
<!-- Kanban scripts -->
<script src="../../assets/js/plugins/dragula/dragula.min.js"></script>
<script src="../../assets/js/plugins/jkanban/jkanban.js"></script>
<script src="../../assets/js/plugins/chartjs.min.js"></script>
<script>
	var ctx1 = document.getElementById("chart-line").getContext("2d");
	var ctx2 = document.getElementById("chart-pie").getContext("2d");
	var ctx3 = document.getElementById("chart-bar").getContext("2d");

	var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

	gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.2)');
	gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
	gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)'); //purple colors

	var gradientStroke2 = ctx1.createLinearGradient(0, 230, 0, 50);

	gradientStroke2.addColorStop(1, 'rgba(20,23,39,0.2)');
	gradientStroke2.addColorStop(0.2, 'rgba(72,72,176,0.0)');
	gradientStroke2.addColorStop(0, 'rgba(20,23,39,0)'); //purple colors

	// Line chart
	new Chart(ctx1, {
		type : "line",
		data : {
			labels : [ "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov",
					"Dec" ],
			datasets : [ {
				label : "Facebook Ads",
				tension : 0.4,
				borderWidth : 0,
				pointRadius : 2,
				pointBackgroundColor : "#cb0c9f",
				borderColor : "#cb0c9f",
				borderWidth : 3,
				backgroundColor : gradientStroke1,
				fill : true,
				data : [ 50, 100, 200, 190, 400, 350, 500, 450, 700 ],
				maxBarThickness : 6
			}, {
				label : "Google Ads",
				tension : 0.4,
				borderWidth : 0,
				pointRadius : 2,
				pointBackgroundColor : "#3A416F",
				borderColor : "#3A416F",
				borderWidth : 3,
				backgroundColor : gradientStroke2,
				fill : true,
				data : [ 10, 30, 40, 120, 150, 220, 280, 250, 280 ],
				maxBarThickness : 6
			} ],
		},
		options : {
			responsive : true,
			maintainAspectRatio : false,
			plugins : {
				legend : {
					display : false,
				}
			},
			interaction : {
				intersect : false,
				mode : 'index',
			},
			scales : {
				y : {
					grid : {
						drawBorder : false,
						display : true,
						drawOnChartArea : true,
						drawTicks : false,
						borderDash : [ 5, 5 ]
					},
					ticks : {
						display : true,
						padding : 10,
						color : '#9ca2b7'
					}
				},
				x : {
					grid : {
						drawBorder : false,
						display : true,
						drawOnChartArea : true,
						drawTicks : true,
						borderDash : [ 5, 5 ]
					},
					ticks : {
						display : true,
						color : '#9ca2b7',
						padding : 10
					}
				},
			},
		},
	});

	// Pie chart
	new Chart(ctx2,
			{
				type : "pie",
				data : {
					labels : [ 'Facebook', 'Direct', 'Organic', 'Referral' ],
					datasets : [ {
						label : "Projects",
						weight : 9,
						cutout : 0,
						tension : 0.9,
						pointRadius : 2,
						borderWidth : 2,
						backgroundColor : [ '#17c1e8', '#cb0c9f', '#3A416F',
								'#a8b8d8' ],
						data : [ 15, 20, 12, 60 ],
						fill : false
					} ],
				},
				options : {
					responsive : true,
					maintainAspectRatio : false,
					plugins : {
						legend : {
							display : false,
						}
					},
					interaction : {
						intersect : false,
						mode : 'index',
					},
					scales : {
						y : {
							grid : {
								drawBorder : false,
								display : false,
								drawOnChartArea : false,
								drawTicks : false,
							},
							ticks : {
								display : false
							}
						},
						x : {
							grid : {
								drawBorder : false,
								display : false,
								drawOnChartArea : false,
								drawTicks : false,
							},
							ticks : {
								display : false,
							}
						},
					},
				},
			});

	// Bar chart
	new Chart(ctx3, {
		type : "bar",
		data : {
			labels : [ '16-20', '21-25', '26-30', '31-36', '36-42', '42+' ],
			datasets : [ {
				label : "Sales by age",
				weight : 5,
				borderWidth : 0,
				borderRadius : 4,
				backgroundColor : '#3A416F',
				data : [ 15, 20, 12, 60, 20, 15 ],
				fill : false
			} ],
		},
		options : {
			indexAxis : 'y',
			responsive : true,
			maintainAspectRatio : false,
			plugins : {
				legend : {
					display : false,
				}
			},
			scales : {
				y : {
					grid : {
						drawBorder : false,
						display : true,
						drawOnChartArea : true,
						drawTicks : false,
						borderDash : [ 5, 5 ]
					},
					ticks : {
						display : true,
						padding : 10,
						color : '#9ca2b7'
					}
				},
				x : {
					grid : {
						drawBorder : false,
						display : false,
						drawOnChartArea : true,
						drawTicks : true,
					},
					ticks : {
						display : true,
						color : '#9ca2b7',
						padding : 10
					}
				},
			},
		},
	});
</script>
<script>
	var win = navigator.platform.indexOf('Win') > -1;
	if (win && document.querySelector('#sidenav-scrollbar')) {
		var options = {
			damping : '0.5'
		}
		Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
	}
</script>
<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
<script src="../../assets/js/soft-ui-dashboard.min.js?v=1.1.1"></script>
</body>
