<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- 전체 div 시작 -->
	<div class="card col-11 mb-0">
		<div class="card-body pt-2 pb-0">
			<br>
			<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2 Heads">Reserve List</span>
			<h3 class="card-title d-block text-darker Heads" >전체 예약 목록</h3>
				<div>
					<p class="explains Heads">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
							  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
							  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
							  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
						</svg>
						예약목록 관리와 관련 정보 수정 및 삭제가 가능합니다.
					</p>
				</div>
				<a class="btn bg-gradient-info text-lg" href="/admin/reserveMain">예약 자원관리</a>
		</div>
	</div>

<div class="row">
	<div class="col-11">
	<a class="position-relative btn bg-gradient-info text-lg" href="/admin/room" style="left:1090px; top:65px;">회의실 예약 페이지</a>
		<h4 class="mb-0 font-weight-bolder">회의실 전체  예약목록</h4>
		<p class="explains Heads">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
				fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
				  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
				  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
				  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
				  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
			</svg>
			회의실 예약목록을 확인하고 삭제할 수 있습니다.
		</p>
		<div align="right">
		<div class="card card-body mt-4 mb-4">
			<div class="table-responsive">
				<table class="table align-items-center mb-0">
					<thead>
						<tr>
							<th
								class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">순번</th>
							<th
								class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">회의실</th>
							<th
								class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">신청자</th>
							<th
								class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약신청일시</th>
							<th
								class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약시작일시</th>
							<th
								class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약종료일시</th>
							<th
								class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${roomRsvtVOList}" var="roomRsvtVO" varStatus="stat">
							<tr>
								<td class="align-middle text-center"><span
									class="text-secondary text-lg">${stat.count}</span>
								</td>
								<td class="align-middle text-center">
									<h6 class="mb-0 text-lg">${roomRsvtVO.mtgrmNo}</h6>
								</td>
								<td class="align-middle text-center">
									<h6 class="mb-0 text-lg">${roomRsvtVO.empNo}</h6>
								</td>
								<td class="align-middle text-center">
									<span class="text-secondary text-lg"><c:out value="${fn:substring(roomRsvtVO.rsvtDt,0,10)}"/></span>
								</td>
								<td class="align-middle text-center">
									<span class="text-secondary text-lg text-center"><c:out value="${fn:substring(roomRsvtVO.rsvtBgngDt,5,16)}"/></span>
								</td>
								<td class="align-middle text-center">
									<h6 class="mb-0 text-lg"><c:out value="${fn:substring(roomRsvtVO.rsvtEndDt,5,16)}"/></h6>
								</td>
								<td class="align-middle text-center">
									<button type="button" class="btn-close text-dark deleteReserve"
									value="${roomRsvtVO.rsvtNo}">
						            	<span aria-hidden="true">×</span>
						            </button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
		</div>
		</div>
	</div>
	<div class="col-11">
	<a class="position-relative btn bg-gradient-info text-lg" href="/admin/car" style="left:1100px; top:65px;">차량 예약 페이지</a>
		<h4 class="mb-0 font-weight-bolder">차량 전체 예약목록</h4>
		<p class="explains Heads">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
				fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
				  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
				  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
				  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
				  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
			</svg>
			예약상태 클릭 시 예약 상태 변경이 가능합니다.
		</p>
	<div align="right">
		<div class="card card-body mt-4 mb-4">
			<div class="table-responsive">
				<table class="table align-items-center mb-0">
					<thead>
						<tr>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">순번</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">신청자</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">차량번호</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약신청일시</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약시작일시</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약종료일시</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약상태</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${vhrRsvtVOList}" var="vhrRsvtVO" varStatus="stat">
							<tr>
								<td class="align-middle text-center"><span
									class="text-secondary text-lg">${stat.count}</span>
								</td>
								<td class="align-middle text-center">
									<h6 class="mb-0 text-lg">${vhrRsvtVO.empNo}</h6>
								</td>
								<td class="align-middle text-center">
									<h6 class="mb-0 text-lg">${vhrRsvtVO.vhrNo}</h6>
								</td>
								<td class="align-middle text-center">
									<span class="text-secondary text-lg"><fmt:formatDate pattern="yyyy-MM-dd" value="${vhrRsvtVO.vhrRsvtDt}" /></span>
								</td>
								<td class="align-middle text-center">
									<span class="text-secondary text-lg">
										<c:set var="dayStart" value="${vhrRsvtVO.vhrRsvtBgngDt}"/>
										<c:set var="splitDayStart" value="${fn:split(dayStart, ' ')}"/>
										${splitDayStart[0]}
									</span>
								</td>
								<td class="align-middle text-center">
									<span class="text-secondary text-lg text-center">
										<c:set var="dayEnd" value="${vhrRsvtVO.vhrRsvtEndDt}"/>
										<c:set var="splitDayEnd" value="${fn:split(dayEnd, ' ')}"/>
										${splitDayEnd[0]}
									</span>
								</td>
								<td class="align-middle text-center status">
								  <select class='form-select' onchange="updateCarReserve()">
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '예약대기'}">
								        <option selected>예약대기</option>
								      </c:when>
								      <c:otherwise>
								        <option>예약대기</option>
								      </c:otherwise>
								    </c:choose>
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '예약완료'}">
								        <option selected>예약완료</option>
								      </c:when>
								      <c:otherwise>
								        <option>예약완료</option>
								      </c:otherwise>
								    </c:choose>
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '사용중'}">
								        <option selected>사용중</option>
								      </c:when>
								      <c:otherwise>
								        <option>사용중</option>
								      </c:otherwise>
								    </c:choose>
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '반납'}">
								        <option selected>반납</option>
								      </c:when>
								      <c:otherwise>
								        <option>반납</option>
								      </c:otherwise>
								    </c:choose>
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '미반납'}">
								        <option selected>미반납</option>
								      </c:when>
								      <c:otherwise>
								        <option>미반납</option>
								      </c:otherwise>
								    </c:choose>
								  </select>
								  <h6 class="mb-0 text-lg">${vhrRsvtVO.vhrRsvtSsts}</h6>
								</td>
								<td class="align-middle text-center">
									<button type="button" class="btn-close text-dark deleteReserveCar"
									value="${vhrRsvtVO.vhrRsvtNo}">
						            	<span aria-hidden="true">×</span>
						            </button>
								</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
		</div>
		</div>


		<!--여기부터는 미반납 차량 목록 -->

		<h4 class="mb-0 mt-5 font-weight-bolder">미반납 차량 목록</h4>
		<p class="explains Heads">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
				fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
				  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
				  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
				  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
				  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
			</svg>
			예약 종료일이 지났음에도 반납되지 않은 차량 목록입니다.
		</p>
			<div align="right">
		<div class="card card-body mt-4 mb-4">
			<div class="table-responsive">
				<table class="table align-items-center mb-0">
					<thead>
						<tr>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">순번</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">신청자</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">차량번호</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약신청일시</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약시작일시</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약종료일시</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약상태</th>
							<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${vhrNotReturnRsvtVOList}" var="vhrRsvtVO" varStatus="stat">
							<tr>
								<td class="align-middle text-center"><span
									class="text-secondary text-lg">${stat.count}</span>
								</td>
								<td class="align-middle text-center">
									<h6 class="mb-0 text-lg">${vhrRsvtVO.empNo}</h6>
								</td>
								<td class="align-middle text-center">
									<h6 class="mb-0 text-lg">${vhrRsvtVO.vhrNo}</h6>
								</td>
								<td class="align-middle text-center">
									<span class="text-secondary text-lg"><fmt:formatDate pattern="yyyy-MM-dd" value="${vhrRsvtVO.vhrRsvtDt}" /></span>
								</td>
								<td class="align-middle text-center">
									<span class="text-secondary text-lg">
										<c:set var="dayStart" value="${vhrRsvtVO.vhrRsvtBgngDt}"/>
										<c:set var="splitDayStart" value="${fn:split(dayStart, ' ')}"/>
										${splitDayStart[0]}
									</span>
								</td>
								<td class="align-middle text-center">
									<span class="text-secondary text-lg text-center">
										<c:set var="dayEnd" value="${vhrRsvtVO.vhrRsvtEndDt}"/>
										<c:set var="splitDayEnd" value="${fn:split(dayEnd, ' ')}"/>
										${splitDayEnd[0]}
									</span>
								</td>
								<td class="align-middle text-center status">
								  <select class='form-select' onchange="updateCarReserve()">
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '예약대기'}">
								        <option selected>예약대기</option>
								      </c:when>
								      <c:otherwise>
								        <option>예약대기</option>
								      </c:otherwise>
								    </c:choose>
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '예약완료'}">
								        <option selected>예약완료</option>
								      </c:when>
								      <c:otherwise>
								        <option>예약완료</option>
								      </c:otherwise>
								    </c:choose>
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '사용중'}">
								        <option selected>사용중</option>
								      </c:when>
								      <c:otherwise>
								        <option>사용중</option>
								      </c:otherwise>
								    </c:choose>
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '반납'}">
								        <option selected>반납</option>
								      </c:when>
								      <c:otherwise>
								        <option>반납</option>
								      </c:otherwise>
								    </c:choose>
								    <c:choose>
								      <c:when test="${vhrRsvtVO.vhrRsvtSsts eq '미반납'}">
								        <option selected>미반납</option>
								      </c:when>
								      <c:otherwise>
								        <option>미반납</option>
								      </c:otherwise>
								    </c:choose>
								  </select>
								  <h6 class="mb-0 text-lg">${vhrRsvtVO.vhrRsvtSsts}</h6>
								</td>
								<td class="align-middle text-center">
									<button type="button" class="btn-close text-dark deleteReserveCar"
									value="${vhrRsvtVO.vhrRsvtNo}">
						            	<span aria-hidden="true">×</span>
						            </button>
								</td>

							</tr>
						</c:forEach>
					</tbody>
				</table>

			</div>
		</div>
		</div>

	</div>

</div>

<!-- 전체 div 끝 -->
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<!-- <script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script> -->
<script src="/resources/js/sweetalert.min.js"></script>


<script>
//차량 예약상태 클릭하면 select 요소가 보이도록 함
const statusList = document.querySelectorAll('.status');
  for (let i = 0; i < statusList.length; i++) {
    const selectElement = statusList[i].querySelector('.form-select');
    const h6Element = statusList[i].querySelector('h6');
    selectElement.style.display = 'none'; // hide the select element initially
    statusList[i].addEventListener('click', function() {
      if (selectElement.style.display === 'none') {
        selectElement.style.display = 'block';
        h6Element.style.display = 'none';
      } else {
      }
    });
  }
</script>

 <script>
 function updateCarReserve() {
	  const selectElement = event.target; // 선택한 select 요소를 가져옴.
	  const selectedOption = selectElement.options[selectElement.selectedIndex].text; //위 요소의 옵션 중 select된것의 text를 가져옴
	  console.log(selectedOption);

	  const parentTdElement = selectElement.parentNode; //부모 값 가져옴
	  const siblingTdElement = parentTdElement.nextElementSibling; //부모의 다음 자식 가져옴
	  const vhrRsvtNo = siblingTdElement.querySelector('button.deleteReserveCar').value;
	  //그놈에게서 쿼리셀렉터로 deleteReserveCar클래스 버튼을 찾아 값을 가져옴

	  console.log(vhrRsvtNo);

	  var data = {
	    vhrRsvtNo:vhrRsvtNo,
	    vhrRsvtSsts:selectedOption
	  };
	  console.log(data);

	$.ajax({
	    url: "/reserve/updateCarRes",
	    contentType:"application/json;charset:utf-8",
	    data:JSON.stringify(data),
	    type:"post",
  			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	    success: function(response) {
	    	swal({
			      title: "예약상태가 변경되었습니다!",
			      icon: "success", //success, warning, error
			      button: "확인"
			   }).then(function () {
				   location.reload();
		    });

	    }
	});
}

 $(".deleteReserve").click(function(){
		console.log(this.value);
		var data ={
			rsvtNo:this.value
		};
		RoomResrtveDelete(data);
  });

 $(".deleteReserveCar").click(function(){
		console.log(this.value);
		var data ={
			vhrRsvtNo:this.value
		};
		carResrtveDelete(data);

  });


 //차량 예약 삭제
 function carResrtveDelete(data){
		swal({
			  title: "예약을 삭제하시겠습니까?",
			  text: "확인을 누르면 예약이 삭제됩니다.",
			  icon: "warning",
			  buttons: {
				  cancel : "취소",
				  modifyOK : {
					text : "삭제",
					value : "createOk"
				  }
				},
			})
			.then((value) => {
			  switch (value) {
			    case "createOk":
			    	console.log(data);
		 			$.ajax({
		 			    url: "/reserve/deleteCarRes",
		 			    contentType:"application/json;charset:utf-8",
		 			    data:JSON.stringify(data),
		 			    type:"post",
		 	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		 					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		 				},
		 			    success: function(response) {
			 			   	swal({
							      title: "예약이 삭제되었습니다!",
							      icon: "success", //success, warning, error
							      button: "확인"
							   }).then(function () {
								   location.reload();
						    });
		 			    }
	 				});
			    	break;
			    default:
			      swal({
		 		    	title: "삭제를 취소했습니다",
		 		    	icon :"error"
		 		    });
			 	 }
			});
		}

 //회의실 예약 삭제
 function RoomResrtveDelete(data){
		swal({
			  title: "예약을 삭제하시겠습니까?",
			  text: "확인을 누르면 예약이 삭제됩니다.",
			  icon: "warning",
			  buttons: {
				  cancel : "취소",
				  modifyOK : {
					text : "삭제",
					value : "createOk"
				  }
				},
			})
			.then((value) => {
			  switch (value) {
			    case "createOk":
			    	console.log(data);
					$.ajax({
					    url: "/reserve/deleteRoomRes",
					    contentType:"application/json;charset:utf-8",
					    data:JSON.stringify(data),
					    type:"post",
			   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
							xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
					    success: function(response) {
					    	swal({
							      title: "예약이 삭제되었습니다!",
							      icon: "success", //success, warning, error
							      button: "확인"
							   }).then(function () {
								   location.reload();
						    });
					    }
					});
			    	break;
			    default:
			      swal({
		 		    	title: "삭제를 취소했습니다",
		 		    	icon :"error"
		 		    });
			 	 }
			});
		}

 </script>