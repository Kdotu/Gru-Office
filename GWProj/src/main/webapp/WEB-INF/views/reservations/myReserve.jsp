<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/reserveAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">

<div class="card card-body mt-0 mb-4" align="left">
				<div class="card-body pt-2 pb-2">
					<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2">My Reserve List</span>
					<h3 class="mb-0 font-weight-bolder">내 예약현황</h3>
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
								내 예약목록을 확인하고 관리할 수 있습니다.
							</p>
						</div>
				</div>
			

</div>

<!-- 2번째 사이드바 -->
			<div align="right">
			<div class="card card-body mt-4 mb-4" align="left">
			<h4 class="mb-0 mt-3 font-weight-bolder" style="margin-left: 20px;">회의실 예약목록</h4>
						<div>
							<p class="explains  mb-5" style="margin-left: 20px;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-info-circle"
									viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
								  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
								   1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
								    0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								내 회의실 예약목록을 확인하고 관리할 수 있습니다.
							</p>
						</div>
				<div class="table-responsive">
					<table class="table align-items-center mb-0">
						<thead>
							<tr>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">순번</th>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">회의실</th>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">신청자</th>
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
										<span class="text-secondary text-lg">${roomRsvtVO.empNo}</span>
									</td>
									<td class="align-middle text-center">
										<span class="text-secondary text-lg"><c:out value="${fn:substring(roomRsvtVO.rsvtDt,0,10)}"/></span>
									</td>
									<td class="align-middle text-center">
										<h6 class="mb-0 text-lg"><c:out value="${fn:substring(roomRsvtVO.rsvtBgngDt,5,16)}"/></h6>
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
				<a class="btn bg-gradient-info text-lg" href="/reserve/room">회의실 예약</a>
			</div>

		<div align="right">
			<div class="card card-body mt-4 mb-4" align="left">
			<h4 class="mb-0 mt-4 font-weight-bolder" style="margin-left: 20px;">차량 예약목록</h4>
						<div>
							<p class="explains  mb-5" style="margin-left: 20px;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-info-circle"
									viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
								  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
								   1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
								    0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								나의 차량 예약상황을 확인할 수 있습니다.
							</p>
						</div>
				<div class="table-responsive">
					<table class="table align-items-center mb-0">
						<thead>
							<tr>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">순번</th>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">차량번호</th>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약신청일시</th>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약시작일시</th>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약종료일시</th>
								<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">예약상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${vhrRsvtVOList}" var="vhrRsvtVO" varStatus="stat">
								<tr>
									<td class="align-middle text-center"><span
										class="text-secondary text-lg">${stat.count}</span>
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
									<td class="align-middle text-center">
										<h6 class="mb-0 text-lg">${vhrRsvtVO.vhrRsvtSsts}</h6>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
				<a class="btn bg-gradient-info text-lg" href="/reserve/car">차량 예약</a>
			</div>
		</div>
	</div>
</div>


 <script>
     $(".deleteReserve").click(function(){
 		console.log(this.value);
 		var data ={
 			rsvtNo:this.value
 		}

			$.ajax({
			    url: "/reserve/deleteRoomRes",
			    contentType:"application/json;charset:utf-8",
			    data:JSON.stringify(data),
			    type:"post",
	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
			    success: function(response) {
			    	location.reload();
			    }
			});

     });

 </script>
