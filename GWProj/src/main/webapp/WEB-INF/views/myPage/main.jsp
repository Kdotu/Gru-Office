<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/myPageAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->
<!-- 상단에 들어가는 마이페이지 회원정보 시작 -->
	<jsp:include page="/WEB-INF/views/aside/myPageSection.jsp" />
<!-- 상단에 들어가는 마이페이지 회원정보 끝 -->

	<div class="container-fluid py-4">
      <div class="row mt-3">
      <!-- 회원정보  카드 시작 -->
		<div class="col-12 col-md-6 col-xl-4 mt-md-0 mt-4">
          <div class="card h-100 p-1">
            <div class="card-header pb-0 p-3">
              <div class="row">
                <div class="col-md-8 d-flex align-items-center">
                  <h4 class="mb-0">기본 정보</h4>
                </div>
                <div class="col-md-4 text-end">
                  <a href="/myPage/modifyInfo">
                    <i class="fas fa-user-edit fa-lg text-secondary text" data-bs-toggle="tooltip" data-bs-placement="top" title="기본정보 수정"></i>
                  </a>&nbsp;
                  <a href="/myPage/modifyPswd">
                    <i class="fa fa-unlock-alt fa-lg text-secondary text" data-bs-toggle="tooltip" data-bs-placement="top" title="비밀번호 변경"></i>
                  </a>
                </div>
              </div>
            </div>
            <sec:authorize access="isAuthenticated()">
				<sec:authentication property="principal.empVO" var="empVO" />
            <div class="card-body p-3">
              <p class="text-lg">
				소속회사 : ${empVO.empOgdpCoNm}
              </p>
              <hr class="horizontal gray-light my-3">
              <ul class="list-group mx-2">
                <li class="list-group-item border-0 ps-0 pt-0 text-lg"><div class="text-dark" style="width:50px;">이름 :</div> &nbsp; <span class="mx-2">${empVO.empNm}</span></li>
                <li class="list-group-item border-0 ps-0 text-lg"><div class="text-dark">연락처(휴대전화):</div> &nbsp; <span class="mx-2">${empVO.empCoTelno}</span></li>
                <li class="list-group-item border-0 ps-0 text-lg"><div class="text-dark">연락처(사내전화):</div> &nbsp; <span class="mx-2">${empVO.empCoTelno}</span></li>
                <li class="list-group-item border-0 ps-0 text-lg"><div class="text-dark">이메일주소:</div> &nbsp; <span class="mx-2">${empVO.empEmlAddr}</span></li>
                <li class="list-group-item border-0 ps-0 text-lg"><div class="text-dark">주소:</div> &nbsp; <span class="mx-2">${empVO.empAddr}<br/>&nbsp;&nbsp;&nbsp;&nbsp;${empVO.empDaddr}<br/>&nbsp;&nbsp;&nbsp;&nbsp;(${empVO.empZip})</span></li>
              </ul>
            </div>
            </sec:authorize>
          </div>
        </div>
        <!-- 회원정보  카드 끝 -->
        <!-- 쪽지 카드 시작 -->
        <div class="row col-8">
        <div class="row mt-md-0 mt-4 mb-3">
          <div class="card h-100 p-1">
            <div class="card-header pb-0 p-3">
              <div class="row">
                <div class="col-md-8 d-flex align-items-center">
                  <h4 class="mb-0">쪽지</h4>
                </div>
                <div class="col-md-4 text-end">
                <button type="button" style="left:0px; top:10px;" class="btn btn-icon-only btn-rounded btn-outline-secondary btn-sm position-relative" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="최근 받은 쪽지 목록을 확인할 수 있습니다." data-bs-original-title="최근 받은 쪽지 목록을 확인할 수 있습니다.">
					<i class="fas fa-info" aria-hidden="true"></i>
				</button>
                </div>
              </div>
            </div>
            <div class="card-body p-3">
              	<table class="table align-items-center mb-0">
					<thead>
						<tr>
							<th class="text-uppercase text-center text-secondary text-md font-weight-bolder">분류</th>
							<th class="text-uppercase text-center text-secondary text-md font-weight-bolder  ps-2">쪽지내용</th>
							<th class="text-uppercase text-center text-secondary text-md font-weight-bolder  ps-2">발신자</th>
							<th class="text-uppercase text-center text-secondary text-md font-weight-bolder  ps-2">보낸시각</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach var="noteVO" items="${data}" varStatus="stat">
						<tr>
							<td class="text-center">
								<p class="text-md text-secondary mb-0"><c:choose><c:when test="${noteVO.msgCateTag eq '긴급'}"><span class="badge badge-danger" style="font-size: 1.0em;">긴급</span></c:when>
									<c:otherwise><span class="badge badge-secondary" style="font-size: 1.0em;">일반</span></c:otherwise></c:choose>
								</p>
							</td>
							<td class="msgCn text-center">
								<span  class="text-dark text-md">
									<a style="color:#344767!important;" href="/note/rcvNtDetail?msgNo=${noteVO.msgNo}">${fn:substring(noteVO.msgCn,0,15)}
                                                            <c:if test="${fn:length(noteVO.msgCn) > 15}">...</c:if></a>
								</span>
							</td>
							<td class="text-center">
								<span class="badge badge-dot me-4">
									<i class="bg-info"></i><span class="text-dark text-lg">${noteVO.sender}</span>
								</span>
							</td>
							<td class="text-center">
								<span class="text-dark text-md">
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${noteVO.msgDsptchDt}"/>
								</span>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
          </div>
        </div>
        </div>
        <!-- 쪽지 카드 끝 -->
        <!-- 알림목록 카드 시작 -->
        <div class="row mt-md-0 mt-4">
          <div class="card h-100 p-1">
            <div class="card-header pb-0 p-3">
              <div class="row">
                <div class="col-md-8 d-flex align-items-center">
                  <h4 class="mb-0">알림목록</h4>
                </div>
                <div class="col-md-4 text-end">
                <button type="button" style="left:0px; top:10px;" class="btn btn-icon-only btn-rounded btn-outline-secondary btn-sm position-relative" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="최근 받은 알림 목록을 확인할 수 있습니다." data-bs-original-title="최근 받은 알림 목록을 확인할 수 있습니다.">
					<i class="fas fa-info" aria-hidden="true"></i>
				</button>
                </div>
              </div>
            </div>
            <div class="card-body p-3">
            <ul class="list-group">
				<c:forEach begin="1" end ="4" var="alarmListVO" items="${alarmListVOList}" varStatus="stat">
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
		            	<c:if test="${alarmListVO.alarmClsf eq '전자결재'}">
			              <a href="/edoc/main" >
		            	</c:if>
	                  <div class="d-flex" style="margin-left: 20px;">
	                    <div class="d-flex align-items-center">
	                    	<c:if test="${empty alarmListVO.fileStrgNm}">
	                    	<img id="empNoImag" src="/resources/upload/emp/profile/default.png" class="avatar rounded-circle me-2" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${alarmListVO.empTitle}" style="">&nbsp;
	                        </c:if>
	                        <c:if test="${not empty alarmListVO.fileStrgNm}">
	                    	<img id="empNoImag" src="/resources/upload${alarmListVO.fileStrgNm}" class="avatar rounded-circle me-2" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${alarmListVO.empTitle}" >&nbsp;
	                        </c:if>
	                      <div class="d-flex flex-column" >
	                      	<c:if test="${alarmListVO.alarmChkYn eq 'Y'}">
					            <h6 class="mb-1 text-secondary text-md" >[${alarmListVO.alarmClsf}] ${alarmListVO.alarmCn}</h6>
		                        <span class="text-secondary text">${alarmListVO.alarmDt}</span>
				            </c:if>
				            <c:if test="${alarmListVO.alarmChkYn eq 'N'}">
					            <h6 class="mb-1 text-dark text-md" >[${alarmListVO.alarmClsf}] ${alarmListVO.alarmCn}</h6>
		                        <span class="text-dark text">${alarmListVO.alarmDt}</span>
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
        <!-- 알림목록 카드 끝 -->
         </div>
       </div>
     </div>
   </div><!-- end for row의 2번째 부분 -->
 </div>
