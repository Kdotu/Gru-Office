<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
	<!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<!-- fullcalendar CDN -->
	<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
	<!-- fullcalendar 언어 CDN -->
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
	<script src="/resources/maincss/assets/js/plugins/flatpickr.min.js"></script>	
	<!-- sweetalert 관련 2줄 (css1개, 알고리즘1개) -->
	<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
	<script src="/resources/js/sweetalert.min.js"></script> 
	
	<style>
	  /* body 스타일 */
	  html, body {
	    overflow: hidden;
	    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	  }
	  /* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
	  .fc-header-toolbar {
	    padding-top: 1em;
	    padding-left: 1em;
	    padding-right: 1em;
	  }
	  .fc-daygrid-day-number{
	  	pointer-events: none;
	  }
	  .fc-toolbar{
		font-size: 10px;
	  }
	  #calendar-wrapper {
		width: 80%;
	  }
	  .titles{
	  	text-align: left;
	  	margin-left: 10px;
	  }
	  h5, h4{
	  	text-align: left;
	  }
	  .ma{
	  	text-align: left;
	  }
	  .flatpickr-disabled {
		  background-color: #e72121; /* 변경하고자 하는 배경 색상 */
		  color: #e72121; /* 변경하고자 하는 텍스트 색상 */
	  }	
	</style>
	<!-- authorize 부분 시작. 중요! -->	
	
	<sec:authorize access="isAuthenticated()"> 
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
	
    <input  id="userno" name="userno" type="hidden" value="${empVO.empNo}">
    <input  id="username"  name="username" type="hidden" value="${empVO.empNm}">
    
    
	</sec:authorize>
	<!-- CSS only => tiles index.jsp로 넣어둠-->
	<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
	<div class="container-fluid my-3 py-3 mx-0 px-0" id="carReserveFormat">
		<div class="row mb-5">
			<div class="col-lg-2">
				<jsp:include page="/WEB-INF/views/aside/reserveAside.jsp" />
			</div>
			<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
	<!-- 2번째 사이드바 -->
	<div class="card card-body mt-0 mb-4" align="left">
				<div class="card-body pt-2 pb-2">
					<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2">Car Detail</span>
					<h3 class="mb-0 font-weight-bolder">차량 상세</h3>
						<div>
							<p class="explains mb-0">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-info-circle"
									viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
								  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
								   1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
								    0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								차량정보와 예약일정을 확인하고 예약신청할 수 있습니다.
							</p>
						</div>
				</div>
			

</div>
			<div class="card container" align="middle">
				<div class="container-fluid my-3 py-3">
					<h3 class="titles mt-5">차량 정보</h3>
					<div class="col-lg-12 mt-lg-0 mt-4 mb-4">
						<div class="card w-95">
							<div class="row mt-4">
								<div class="col-12">
									<div class="card bg-gradient-secondary">
										<img src="/resources/maincss/assets/img/shapes/waves-white.svg"
											alt="pattern-lines" class="position-absolute opacity-4 start-0 top-0 w-100">
										<div class="card-body px-5 z-index-1 bg-cover">
											<div class="row">
												<div class="col-lg-3 col-12 my-auto" align="left">
													<h6 class="text-white">${vhrVO.vhrCmp}</h6>
													<h4 class="text-white">${vhrVO.vhrNm}</h4>
													<hr class="horizontal light mt-1 mb-3">
													<div class="d-flex">
														<div>
															<h4 class="mb-0 text-white">등록일</h4>
															<h6 class="text-white opacity-9">
																<fmt:formatDate pattern="yyyy-MM-dd" value="${vhrVO.vhrRegDt}" />
															</h6>
														</div>
													</div>
												</div>
												<div class="col-lg-6 col-12">
													<c:if test="${vhrVO.fileGrVO.filesList eq null}">
										                <img src="/resources/image/car-sonata.png"
															 class="img-fluid border-radius-lg mx-auto"/>
									                </c:if>
									                <c:if test="${vhrVO.fileGrVO.filesList ne null}">
										                <img src="/resources/upload${vhrVO.fileGrVO.filesList[0].fileStrgNm}"
															 class="img-fluid border-radius-lg mx-auto"/>
								                	</c:if>
													<div class="my-auto">
														<div class="ms-lg-6 ms-4">
														<h4 class="text-white ms-md-auto">차량번호  : 
														<span class="text-white opacity-7 ms-0 ms-md-auto">${vhrVO.vhrRegNo}</span>
														</h4>
															<h4 class="text-white ms-md-auto">부가정보 : 
															<span class="text-white opacity-7 ms-0 ms-md-auto">${vhrVO.vhrInfo}</span>
															</h4>
														</div>
													</div>
												</div>
												<div class="col-lg-3 col-12 my-auto">
													<h4 class="text-white opacity-9">제원</h4>
													<hr class="horizontal light mt-1 mb-3">
														<div>
															<h6 class="mb-0 text-white">구분: ${vhrVO.vhrSort}</h6>
															<h6 class="mb-0 text-white">크기: ${vhrVO.vhrSz}</h6>
															<h6 class="mb-0 text-white">연료: ${vhrVO.vhrFuel}</h6>
														</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<br> 
					<br> 
					
		<!-- 캘린더 시작 -->
					
  		<!-- calendar 태그 -->
		<h3 class="titles">예약 기간 </h3>
		  <div id='calendar-wrapper lg-9'>
		    <div id='calendar'></div>
		<br> 
		<hr>
		  
		<div class="row" style="margin: auto;" >
			<div style="">
					<h4 class="mb-3">예약기간을 선택해주세요.</h4>
					<p class="explains Heads ma">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
						fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
						  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
						  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 
						  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 
						  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
					</svg>
					예약시작일은 당일 이후부터, 반납예정일은 당일로부터 6개월  이내로만 설정 가능합니다.
				</p>
					
					<div class="row" id="surveyFrm">
						<input class="form-control datepicker" placeholder="" id="surveyDates" type="text" onfocus="focused(this)" onfocusout="defocused(this)">
						<input type="hidden" name="srvyBgngYmd" id="srvyBgngYmd" /> <!-- 설문조사 시작일자 -->
						<input type="hidden" name="srvyEndYmd" id="srvyEndYmd" /> <!-- 설문조사 종료일자 -->
						<input type="hidden" id="vhrNo" value="${vhrVO.vhrNo}" /> <!-- 설문조사 종료일자 -->
					</div>
			  </div>
             <div class="col-6" align="right">
             	<br>
             	<br>
            <button type="button" class="btn bg-info btn-lg text-lg" id="reserveStart" style="color:white;">예약 신청</button>
             </div>
             <div class="col-6" align="left">
             	<br>
             	<br>
            <a class="btn bg-secondary btn-lg text-lg" style="color:white;" href="/reserve/car">차량 목록</a>
             </div>
           </div>
		  </div>
					  
     
		<!-- 예약 기간 -->
					  
		<script type="text/javascript" defer="defer">
		    $(function(){
		   		var reserveData = ${vhrRsvtVOListString};
		      // calendar element 취득
		      var calendarEl = $('#calendar')[0];
		      // full-calendar 생성하기
		      var calendar = new FullCalendar.Calendar(calendarEl, {
		        height: '500px', // calendar 높이 설정
		        expandRows: true, // 화면에 맞게 높이 재설정
		        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
		        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
		        // 해더에 표시할 툴바
		        headerToolbar: {
		          left: 'title',
		          center: '',
		          right: 'prev,today,next'
		        },
		        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
		//         initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
		        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
		        editable: false, // 수정 가능?
		        selectable: false, // 달력 일자 드래그 설정가능
		        nowIndicator: true, // 현재 시간 마크
		        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
		        locale: 'ko', // 한국어 설정
		        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
		          console.log(obj.event.title);
		        },
		        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
		          console.log(obj);
		        },
		        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
		          console.log('삭제됨 '+obj);
		        },
		        // 이벤트 
		        events: reserveData,
		        eventRender: function(event, element) {
		            element.find('.fc-event-time').hide(); // fc-event-time 클래스 숨기기
		            element.find('.fc-event-main').text(event.vhrRsvtSsts); // 이벤트 설명 추가
		        }
		      });
		
		      // 캘린더 랜더링
		      calendar.render();
		    });
		    
		</script>
									
		<!-- 캘린더 끝 -->
					
	  <script>
	    if (document.getElementById('editor')) {
	      var quill = new Quill('#editor', {
	        theme: 'snow' // Specify theme in configuration
	      });
	    }
	
	    if (document.getElementById('choices-multiple-remove-button')) {
	      var element = document.getElementById('choices-multiple-remove-button');
	      const example = new Choices(element, {
	        removeItemButton: true
	      });
	
	      example.setChoices(
	        [{
	            value: 'One',
	            label: 'Label One',
	            disabled: true
	          },
	          {
	            value: 'Two',
	            label: 'Label Two',
	            selected: true
	          },
	          {
	            value: 'Three',
	            label: 'Label Three'
	          },
	        ],
	        'value',
	        'label',
	        false
	        );
	    }
	
	    if (document.querySelector('.datetimepicker')) {
	      flatpickr('.datetimepicker', {
	        allowInput: true
	      }); // flatpickr
	    }
	
	    Dropzone.autoDiscover = false;
	    var drop = document.getElementById('dropzone')
	    var myDropzone = new Dropzone(drop, {
	      url: "/file/post",
	      addRemoveLinks: true
	
	    });
    </script>
    
    <!-- 아래는 새 스크립트입니다 -->
    
 	<!-- flatpickr 시작 -->
		<script>
		  	$(function() {
		  		
				let reserveDate = ${vhrRsvtVOListString};
				
				// 리스트 생성 (바로 json으로 사용가능)
				var dateData = new Array() ;
				
			  	$.each(reserveDate, function(i, v){
					// 객체 생성
					var data = new Object() ;
					data.from = v.start.substr(0, 10);
					data.to = v.end.substr(0, 10);
					
					// 리스트에 생성된 객체 삽입
					dateData.push(data);
			  	});
				
			  	//값 확인
				console.log("dateData",dateData);
				
				//datePicker에서 선택한 날짜 정보 기입
				$("#surveyFrm").on("change",function(){ //form태그
					let dateInfo = $("#surveyDates").val();
					dateArr = dateInfo.split("to");
					
					$("#srvyBgngYmd").val(dateArr[0]);
					$("#srvyEndYmd").val(dateArr[1]);
				});
				
				// 날짜 제한 관련 설정 (예약기간 제한, 중복예약 방지)
				if (document.querySelector('.datepicker')) {
				  flatpickr('.datepicker', {
				    mode: "range",
				    minDate: new Date().fp_incr(0),
				    maxDate: new Date().fp_incr(180),
				    disable: dateData
				  });
				}
				//예약신청 버튼 클릭
				$("#reserveStart").on("click",function(){
					var startDate = $("#srvyBgngYmd").val();
					var EndtDate = $("#srvyEndYmd").val().trim();
					if(EndtDate === ''){
						console.log(startDate);
						console.log(EndtDate);
						carResWrong();
					}else{
						console.log(startDate);
						console.log(EndtDate);
						var userno = $("#userno").val();
						var vhrNo = $("#vhrNo").val();
						var data = {
							vhrNo:vhrNo,
							title:userno,
							start:startDate,
							end:EndtDate,
							vhrRsvtSsts:"예약대기"
						};
						carRes(data);
					}
				});
				
			});
		  	
		  	 //차량 예약 실행
		  	 function carRes(data){
		  			swal({
		  				  title: "예약을 하시겠습니까?",
		  				  text: "확인을 누르면 예약이 등록됩니다.",
		  				  icon: "warning",
		  				  buttons: {
		  					  cancel : "취소",
		  					  modifyOK : {
		  						text : "예약",
		  						value : "createOk"
		  					  }
		  					},
		  				})
		  				.then((value) => {
		  				  switch (value) {
		  				    case "createOk":
		  				    	console.log(data);
				    			$.ajax({
				    			    url: "/reserve/createCarReserve",
				    			    contentType:"application/json;charset:utf-8",
				    			    data:JSON.stringify(data),
				    			    type:"post",
				    	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				    				},
				    			    success: function(response) {
										success();
										setTimeout(function() {
// 		 		    			    	$("#carReserveFormat").load("/reserve/carDet #carReserveFormat");
										location.reload();
										}, 1000);
				    			    }
				    			});
		  				    	break;
		  				    default:
		  				      swal({
		  			 		    	title: "예약을 취소했습니다",
		  			 		    	icon :"error"
		  			 		    });
		  				 	 }
		  				});
		  	}
		  	 
		  	 //날짜입력이 잘못되었을 때
		  	 function carResWrong(){
		  			swal({
		  				  title: "날짜 입력을 확인해주세요",
		  				  text: "시작 날짜와 끝 날짜가 모두 선택되어야 합니다",
		  				  icon: "warning",
		  				  buttons: {
		  					  modifyOK : {
		  						text : "알겠습니다"
		  					  }
		  					},
		  				})
		  	}
		  	 //예약 완료 시
		  	 function success(){
		  			swal({
		  				  title: "차량 예약이 완료되었습니다",
		  				  text: "관리자 승인 후 사용 가능합니다\r\n이 문구는 1초후 사라집니다.",
		  				  icon: "success",
		  				  buttons: {
		  					  modifyOK : {
		  						text : "확인"
		  					  }
		  					},
		  				})
		  	}
		  	 
		</script>
	<!-- flatpickr 끝 -->
					
				</div>
			</div>
		</div>
	</div>
</div>
