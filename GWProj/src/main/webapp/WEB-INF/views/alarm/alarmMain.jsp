<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
.aList:hover {
	background: #E9ECEF;
}
</style>

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/myPageAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->

          <div class="card" id="notifications">
            <div class="card-header">
              <p class="text-lg mb-0">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
		  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
		  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
					</svg>
					알림을 최신순으로 확인할 수 있습니다.
				</p>
				<button id="deleteAllAlarm" type="button" class="btn btn-secondary btn-sm" style="float: right; margin-top: -22px; font-size: 1.1em;">전체 삭제</button>
            </div>
            <div class="card-body pt-0">
              <ul class="list-group" >
				<c:forEach var="alarmListVO" items="${alarmListVOList}" varStatus="stat">
					<c:if test="${alarmListVO.alarmChkYn eq 'Y'}">
		            <li class="list-group-item border-0 justify-content-between ps-0 pb-0 border-radius-lg aList" style="filter: brightness(98%);">
		            </c:if>
		            <c:if test="${alarmListVO.alarmChkYn eq 'N'}">
		            <li class="list-group-item border-0 justify-content-between ps-0 pb-0 border-radius-lg aList" >
		            </c:if>
		            	<c:if test="${alarmListVO.alarmClsf eq '메일'}">
			              <a href="/mail/detail?emlNo=${alarmListVO.alarmLink}" >
		            	</c:if>
		            	<c:if test="${alarmListVO.alarmClsf eq '설문조사'}">
			              <a href="/survey/detail?srvyNo=${alarmListVO.alarmLink}" >
		            	</c:if>
		            	<c:if test="${alarmListVO.alarmClsf eq '전자결재 대기'}">
			              <a href="/edoc/approve" >
		            	</c:if>
		            	<c:if test="${alarmListVO.alarmClsf eq '전자결재 반려'}">
			              <a href="/edoc/rejectBox" >
		            	</c:if>
		            	<c:if test="${alarmListVO.alarmClsf eq '전자결재 승인'}">
			              <a href="/edoc/completeBox" >
		            	</c:if>
		            	<c:if test="${alarmListVO.alarmClsf eq '전자결재 참조'}">
			              <a href="/edoc/atrzRfrnc" >
		            	</c:if>
		            	<c:if test="${alarmListVO.alarmClsf eq '쪽지'}">
			              <a href="/note/rcvNtDetail?msgNo=${alarmListVO.alarmLink}" >
		            	</c:if>
	                  <div class="d-flex" style="margin-left: 20px;">
	                    <div class="d-flex align-items-center">
	                    	<c:if test="${empty alarmListVO.fileStrgNm}">
	                    	<img id="empNoImag" src="/resources/upload/emp/profile/default.png" class="avatar rounded-circle me-2" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${alarmListVO.empTitle}" >&nbsp;
	                        </c:if>
	                        <c:if test="${not empty alarmListVO.fileStrgNm}">
	                    	<img id="empNoImag" src="/resources/upload${alarmListVO.fileStrgNm}" class="avatar rounded-circle me-2" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${alarmListVO.empTitle}" >&nbsp;
	                        </c:if>
	                      <div class="d-flex flex-column" >
	                      	<c:if test="${alarmListVO.alarmChkYn eq 'Y'}">
					            <h6 class="mb-1 text-secondary text-lg" >[${alarmListVO.alarmClsf}] ${alarmListVO.alarmCn}</h6>
		                        <span class="text-secondary text-md">${alarmListVO.alarmDt}</span>
				            </c:if>
				            <c:if test="${alarmListVO.alarmChkYn eq 'N'}">
					            <h6 class="mb-1 text-dark text-lg" >[${alarmListVO.alarmClsf}] ${alarmListVO.alarmCn}</h6>
		                        <span class="text-dark text-md">${alarmListVO.alarmDt}</span>
				            </c:if>

	                      </div>
	                    </div>
	                    <div class="d-flex align-items-center ms-auto">
	                    	<button type="button" value="${alarmListVO.alarmNo}" class="btn-close text-dark deleteAlarmBtn">
	                      		<span aria-hidden="true" style="font-size:1.3em;" class="deleteAlarm">×</span>
	                      	</button>
	                    </div>
	                  </div>
	                  </a>
	                  <hr class="horizontal dark mt-3 mb-2" />
	                </li>
                </c:forEach>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

<script>
//알림 삭제
$('.deleteAlarmBtn').on('click', function () {
	var p = $(this).parent().parent().parent().parent();
	var alarmNo = $(this).val();
	var data = {
			    'alarmNo':alarmNo
	           }
	$.ajax({
		url: '/alarm/deleteAlarm',
		data: JSON.stringify(data),
		dataType: 'json',
		type: 'post',
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			p.remove();
		}
	});
});

//알림 전체 삭제
$('#deleteAllAlarm').on('click', function () {
	var p = $('.aList');

	let alarmNoArray = [];
	$(".deleteAlarmBtn").each(function(index,data){
		let alarmNo = $(this).val();
		alarmNoArray.push(alarmNo);
	});

	//json object
	let data = {"alarmNoArray":alarmNoArray}

	$.ajax({
		url: '/alarm/deleteAllAlarm',
		data: JSON.stringify(data),
		dataType: 'json',
		type: 'post',
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			p.remove();
		}
	});
});

//알림 확인 처리
$('.aList').on('click', function () {
	var alarmNo = $(this).find('.deleteAlarmBtn').val();
	var data = {'alarmNo':alarmNo};

	$.ajax({
		url: '/alarm/checkAlarm',
		data: JSON.stringify(data),
		dataType: 'json',
		type: 'post',
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			console.log('알림 확인');

		}
	});
});
</script>
