<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<!-- 모달용 스크립트 -->

<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script src="/resources/js/sweetalert.min.js"></script>
<!-- sweetalert 관련 2줄 (css1개, 알고리즘1개) -->

<style>
	.backslash {
		background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg"><line x1="20%" y1="20%" x2="80%" y2="80%" stroke="lightgray" /></svg>');
	}
	.datepickDiv{
		width:100%;
		display: flex;
	}
	#datepicker {
		margin-bottom : 16px;
		margin-left: 5px;
		margin-right: 5px;
		width: 100%;
		text-align: center;
	}
	.selectBox {
	    -webkit-appearance:none; /* 크롬 화살표 없애기 */
	    -moz-appearance:none; /* 파이어폭스 화살표 없애기 */
	    appearance:none; /* 화살표 없애기 */
	    text-align-last: center;
	    text-align: center;
	    border-radius: 5px;
	}
	option{
	 text-align-last: center;
	}
	.titleRestRoom{
	 margin-left: 20px;
	}
	.text-secondary {
     color: #000000!important;
	}
	.timeClick{
	 color: #ffffff!important;
	}

</style>
	<!-- Modal -->
		<div class="modal fade" id="roomResModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" id="exampleModalLabel">회의실 예약</h4>
		        <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      		<p>${empNm} 님께서는 현재 <span id="RoomNmText"></span>실을 <span id="myHour"></span>시부터 <select class="selectBox" id="selectTime" style='width:auto;'>
		      		</select>시까지</p>
		      		<p>예약하려 하십니다.</p>
		      		<p>회의실 예약을 진행하시겠습니까?</p>

		      		<!-- 위는 저장에는 필요없는 정보 아래는 필요한 정보, 방 예약번호랑 예약일은 query에서 처리함 -->

		      		<input type="hidden" value="" id="RoomNoVal" />
		      		<input type="hidden" value="${empNo}" id="empNoVal"/>
		      		<input type="hidden" value="" id="RoomReserveDateStartVal" />
		      		<input type="hidden" value="" id="RoomReserveDateEndVal" />

		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">취소</button>
		        <button type="button" class="btn bg-gradient-info" id="reserveStart">확인</button>
		      </div>
		    </div>
		  </div>
		</div>

	<!-- 모달 끝. 모달은 따로 빼둬야 합니다 -->

<!-- 1번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/reserveAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->

			<div class="row">
		<!-- 테이블 집어넣고 정렬할 div 시작 -->
				<div align="left">
					<div class="card card-body mb-4">
				<div class="card-body pt-2">
					<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2">Meeting room</span>
					<h3 class="mb-0 font-weight-bolder">회의실 예약</h3>
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
								회의실 별 구비물품과 일정을 확인하고 빈 회의실을 예약할 수 있습니다.
							</p>
						</div>
				</div>
					<!-- datepicker 들어갈 자리 -->
						<div class="datepickDiv" align="center">
							<button id="prev-day" type="button" class="btn btn-outline-secondary">&lt;</button>
							<input type="text" class="pickers form-control text-lg" id="datepicker" readonly="readonly">
							<button id="next-day" type="button" class="btn btn-outline-secondary">&gt;</button>
    					</div>
					<!-- datepicker 들어갈 자리 END -->

						<div class="table-responsive mb-4 mt-3">
							<table class="table table-hover align-items-center mb-0 mx-auto" style="overflow: auto;" id="scheduleTable">
								<thead>
									<tr>
										<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder ">
											구분
										</th>
									<c:forEach items="${mtgrmVOList}" var="mtgrmVO" varStatus="stat">
										<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder ">
										<input type="hidden" value="${mtgrmVO.mtgrmNo}" class="roomNos">
										<input type="hidden" value="${mtgrmVO.mtgrmAvalYn}" class="roomNos">
										${mtgrmVO.mtgrmInfo}
										</th>
									</c:forEach>
									</tr>
									<tr>
										<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder ">
											구비물품
										</th>
									<c:forEach items="${mtgrmVOList}" var="mtgrmVO" varStatus="stat">
										<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder  "
										data-bs-toggle="tooltip" data-bs-placement="top"
											title="프로젝터: ${mtgrmVO.mtgrmProj}개,
													화이트보드: ${mtgrmVO.mtgrmBo}개,
													컴퓨터: ${mtgrmVO.mtgrmPc}개,
													냉난방기: ${mtgrmVO.mtgrmAir}개 "
										data-container="body" data-animation="true"
										>
										<img class="icon" src="/resources/image/icon_projector.png" alt="프로젝터">
										<img class="icon" src="/resources/image/icon_whiteboard.png" alt="화이트보드">
										<img class="icon" src="/resources/image/icon_com.png" alt="컴퓨터">
										<img class="icon" src="/resources/image/icon_aircon.png" alt="냉난방기">
										</th>
									</c:forEach>
									</tr>
									<tr>
										<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder ">
											수용인원
										</th>
									<c:forEach items="${mtgrmVOList}" var="mtgrmVO" varStatus="stat">
										<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder ">
										${mtgrmVO.mtgrmAvarPeo}명
										</th>
									</c:forEach>
									</tr>
									<tr class="reserveTime">
										<th class="backslash text-uppercase text-center text-secondary text-lg font-weight-bolder ">
											<div class="mb-2">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp이용여부</div>
											<div class="mt-2">예약시간&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</div>
										</th>
										<c:forEach items="${mtgrmVOList}" var="mtgrmVO" varStatus="stat">
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder ">
												${mtgrmVO.mtgrmAvalYn}
											</th>
										</c:forEach>
									</tr>
								</thead>

								<!-- thead는 일단 이걸로 끝 -->
								<tbody id="scheduleBody">

								<c:forEach var="i" begin="09" end="21" step="1">
   									<tr class="reserveTime">
										<td class="text-uppercase text-center text-secondary text-lg font-weight-bolder ">${i}:00</td>
										<c:forEach items="${mtgrmVOList}" var="mtgrmVO" varStatus="stat">
											<td class="text-uppercase text-center text-secondary text-lg font-weight-bolder  timeClick"
											data-bs-toggle="modal" data-bs-target="#roomResModal"
											data-myRoomNo="${mtgrmVO.mtgrmNo}" data-myRoomNm="${mtgrmVO.mtgrmInfo}" data-myRoomYn="${mtgrmVO.mtgrmAvalYn}">
											<c:forEach items="${roomRsvtVOList}" var="roomRsvtVO" varStatus="stat">
												<c:if test="${roomRsvtVO.mtgrmNo == mtgrmVO.mtgrmInfo && fn:substring(roomRsvtVO.rsvtBgngDt,0,10) == today
															&& fn:substring(roomRsvtVO.rsvtBgngDt,11,13) == i}" var="check">${roomRsvtVO.empNo}
												</c:if>
											</c:forEach>
											</td>
										</c:forEach>
									</tr>
								</c:forEach>
								</tbody>
								<!-- tbody 끝 -->
							</table>
							<!-- table END -->
						</div>
						<!-- table-responsive END -->
					</div>
					<!-- card card-body mt-2 mb-4" END -->
				</div>
				<!-- <div align="right"> END -->
			</div>
			<!-- <div class="row"> END -->
		</div>
		<!-- 2번째 사이드바 END-->
	</div>
	<!-- <div class="row mb-5"> END -->
</div>
<!-- 1번째 사이드바 END-->

<script src="/resources/js/jquery-3.6.0.js"></script>

<script src="//code.jquery.com/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>

<!-- datepicker용 스크립트 -->

<script type="text/javascript">
$(function() {
	  //============ 여기부터 datepicker ===============

	  // 페이지 로드 시 오늘 날짜로 초기화
	  var today = new Date();
	  var todayMonth = (today.getMonth() + 1);
	  todayMonth = todayMonth < 10 ? ("0" + todayMonth) : todayMonth;
	  var todayDate = today.getDate();
	  todayDate = todayDate < 10 ? ("0" + todayDate) : todayDate;

	  let myDate = "${today}";
	  
	  if(myDate!=""){
		  $("#datepicker").val(myDate);
		  console.log("sds");
		  console.log(myDate);
	  }else{
	  	$("#datepicker").val(today.getFullYear() + "-" + todayMonth + "-" + todayDate);
	  }
	  
	  // DatePicker 초기화
	  $("#datepicker").datepicker({
		  	hideIfNoPrevNext: true,
			minDate: "0D",
			maxDate: "7D",
	    	dateFormat: "yy-mm-dd",
	    	prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		    dayNames: ['일','월','화','수','목','금','토'],
		    dayNamesShort: ['일','월','화','수','목','금','토'],
		    dayNamesMin: ['일','월','화','수','목','금','토'],
		    showMonthAfterYear: true,
		    changeMonth: true,
		    changeYear: true,
		    yearSuffix: '년',
	    	onSelect: function(dateText, inst) {
		     	 // 날짜가 선택되면 입력 상자의 값을 업데이트
		      	$(this).val(dateText);
		      	location.href="/reserve/room?myDate=" + dateText;
    	    }
	  });

	  // "이전 날짜" 버튼 클릭 시, DatePicker의 날짜를 하루 전으로 변경
	  $("#prev-day").click(function() {
		let today = new Date(new Date().setHours(0, 0, 0, 0));
	    var selectedDate = $("#datepicker").datepicker("getDate");
	    selectedDate.setDate(selectedDate.getDate() - 1);
	    $("#datepicker").datepicker("setDate", selectedDate);
	    
	    let result = convertDateToString(selectedDate);
	    let todayString = convertDateToString(today);
	    
	    if(selectedDate < today){
	    	firstDate();
	    	$("#datepicker").datepicker("setDate", today);
	    	return;
	    }else{
	    	location.href="/reserve/room?myDate=" + result;
	    }
	  });
	  
	  // "다음 날짜" 버튼 클릭 시, DatePicker의 날짜를 하루 후로 변경
	  $("#next-day").click(function() {
		let today = new Date(new Date().setHours(0, 0, 0, 0));
	    var selectedDate = $("#datepicker").datepicker("getDate");	    
	    selectedDate.setDate(selectedDate.getDate() + 1);
	    $("#datepicker").datepicker("setDate", selectedDate);
	    
	    let result = convertDateToString(selectedDate);
	    let todayString = convertDateToString(today);
	    let maxDay = new Date(new Date().setHours(0, 0, 0, 0));
	    maxDay.setDate(maxDay.getDate() + 7);
	    
	    console.log("selectedDate2 : " + selectedDate);
	    console.log("maxDay : " + maxDay);
	    console.log("today : " + today);
	    
	    if(maxDay < selectedDate){
	    	lastDate();
	    	$("#datepicker").datepicker("setDate", selectedDate);
	    	return;
	    }else{
	    	location.href="/reserve/room?myDate=" + result;
	    }

	  });
	  
	  //선택한 날짜 변경용 function
	  function convertDateToString(dd){
		  let year = dd.getFullYear();
		  let month = dd.getMonth() + 1;
		  let date = dd.getDate();

		  month = month >= 10 ? month : '0' + month;
		  date = date  >= 10 ? date  : '0' + date;
		    
		  let result = year + "-" + month + "-" + date;
		  
		  return result;
	  }

	  //============ 여기까지 datepicker ===============


	// 아래는 각 시간표 영역 클릭 시 해당 시간과 클래스에 맞는 정보가 모달에 입력되도록 하는 메서드.
	// 이때, 모달은 해당 메서드에 속하지 않고 따로 올라옴.
	var day ="";
	$(".timeClick").click(function(){

			 // 1. tr에 속한 값 및 td에 속한 값 가져오기 (데이트피커 날짜, 선택한 시간)
			 var clickedClass = $(this); // 선택한 th
			 var trElement = clickedClass.parent(); //선택한th가 속한 td 요소
			 var trText = trElement.text().trim(); //선택한 시간대. 이유는 모르겠지만 공백이 엄청 많이 생겨서 trim 씀  (val)
			 day = $("#datepicker").val(); //데이트피커 날짜 (val)

			 console.log("trText",trText); //확인trText

			 //2. 텍스트 값 불러오기 (방 이름, 방 번호, 방YN)
			 var roomNo = clickedClass.data('myroomno');
			 console.log("roomNo : " + roomNo); //방 이름
			 var roomNm = clickedClass.data('myroomnm');
			 console.log("roomNm : " + roomNm); //방 넘버 (val)
			 var roomYn = clickedClass.data('myroomyn');
			 console.log("roomYn : " + roomYn); //방 YN (val)

			 console.log("day + trText : " + day, trText); //확인


			 //현재시간, 현재시간 +1시간, +2시간, +3시간 옵션 만들기.
			 var trHr = trText.split(":"); //시간 자른것

			 var myHour = trHr[0]; // 내 시간
			 var oneHour = parseInt(trHr[0]) +1; // +1시간
			 var twoHour = parseInt(trHr[0]) +2; // +2시간
			 var threeHour = parseInt(trHr[0]) +3; // +3시간

			 console.log("myHour : ",myHour);
			 console.log("oneHour : ",oneHour);
			 console.log("twoHour : ",twoHour);
			 console.log("threeHour : ",threeHour);

			 //3. 시작날짜 및 끝 날짜 작성
			 let dayTrStart = day + " " + myHour + ":00"; //시작날짜
			 let dayTrEnd = day + " " + oneHour + ":00";

			 console.log("dayTrStart : " + dayTrStart); //시작시간 확인
			 console.log("dayTrEnd : " + dayTrEnd); //최소 끝나는 시간 확인

			 //사원 번호 대상자 목록 공간에 담기 (모달 안)
			 //==================이 아래로 구분======================

			$("#RoomNmText").text(roomNm);
			 // 이 위는 보여줄 정보 아래는 필요정보
			$("#myHour").text(myHour);

			if (myHour==20){ //선택한 시간이 20시이면
				$("#selectTime").html(
						"<optgroup label='종료시간'>"
						+"<option value='"+oneHour+"'>"+oneHour+"</option checked>"
						+"<option value="+twoHour+">"+twoHour+"</option>"
						+"</optgroup>"
						);
			}else if (myHour==21){ //선택한 시간이 21시이면
				$("#selectTime").html(
						"<optgroup label='종료시간'>"
						+"<option value='"+oneHour+"'>"+oneHour+"</option checked>"
						+"</optgroup>"
						);
			}else{ //선택한 시간이 20시 미만이면
				$("#selectTime").html(
						"<optgroup label='종료시간'>"
						+"<option value='"+oneHour+"'>"+oneHour+"</option checked>"
						+"<option value="+twoHour+">"+twoHour+"</option>"
						+"<option value="+threeHour+">"+threeHour+"</option>"
						+"</optgroup>"
						);
			}

			//방 번호 값
			$("#RoomNoVal").val(roomNo);
			//회의실 예약 시작 시간
			$("#RoomReserveDateStartVal").val(dayTrStart);
			//회의실 예약 끝 시간
			$("#RoomReserveDateEndVal").val(dayTrEnd);

		});

		//모달 안에서 예약시간 바꿀 때 실행
	  	$("#selectTime").change(function(){
	  		var selectedHr = $("#selectTime option:selected").val();
	  		console.log(selectedHr);
	  		$("#RoomReserveDateEndVal").val(day + " " + selectedHr + ":00");
	  	});

		//예약신청 버튼 클릭
		$("#reserveStart").on("click",function(){
			var mtgrmNo = $("#RoomNoVal").val();
			var empNo = $("#empNoVal").val();
			var startDate = $("#RoomReserveDateStartVal").val();
			var EndtDate = $("#RoomReserveDateEndVal").val();
				console.log(mtgrmNo);
				console.log(empNo);
				console.log(startDate);
				console.log(EndtDate);
				var data = {
					mtgrmNo:mtgrmNo,
					empNo:empNo,
					rsvtBgngDt:startDate,
					rsvtEndDt:EndtDate
				};
				roomRes(data);
		});
		fn_removeLink();

	});

	function firstDate(){
		swal({
			  title: "어제 날짜로는 예약할 수 없습니다.",
			  text: "날짜를 확인해주세요.",
			  icon: "warning",
			  buttons: {
				  modifyOK : {
					text : "알겠습니다",
					value : "createOk"
				  }
				}
			})
	}
	function lastDate(){
		swal({
			  title: "예약가능 기간은 오늘 기준 일주일 뒤 까지입니다.",
			  text: "날짜를 확인해주세요.",
			  icon: "warning",
			  buttons: {
				  modifyOK : {
					text : "알겠습니다",
					value : "createOk"
				  }
				}
			})
	}

	 //회의실 예약 실행
	function roomRes(data){
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
	    			    url: "/reserve/createRoomReserve",
	    			    contentType:"application/json;charset:utf-8",
	    			    data:JSON.stringify(data),
	    			    type:"post",
	    	   			beforeSend:function(xhr) {  // 데이터 전송 전  헤더에 csrf값 설정
	    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    				},
	    			    success: function(response) {
							location.reload();
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

	 function fn_removeLink(){

		 $("#scheduleTable thead tr.reserveTime th").each(function(thIndex, thObj){

		     var thValue = $(this).text().trim();
		     if(thValue == "N"){

		         $("#scheduleBody").find("tr.reserveTime").each(function(trIndex, trObj){
		             $(this).find("td").each(function(tdIndex, tdObj){
		                     if(thIndex == tdIndex){
		                         $(tdObj).removeAttr("data-bs-toggle");
		                         $(tdObj).css("background-color", "#D8D8D8");
		                     }
		             })
		          });
		     }
		 });

		 $("#scheduleBody").find("tr.reserveTime").each(function(trIndex, trObj){
		     $(this).find("td").each(function(tdIndex, tdObj){
		         var tdValue = $(tdObj).text().trim();
		         if(tdIndex > 0 && (tdValue != undefined && tdValue != "")){
		             $(tdObj).removeAttr("data-bs-toggle");
		             $(tdObj).css("background-color", "#3a69f2");
		             $(tdObj).css("color", "#ffffff");
		             
		         }
		     })
		  });
	 }

</script>

