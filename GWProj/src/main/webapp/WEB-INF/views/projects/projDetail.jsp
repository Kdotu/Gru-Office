<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<style>
.hr1{
	height: 2px;
	background-color: gray;
	margin: 5px;
}

.imgIcon{
	width: 20px;
}

.delBtn, .editBtn, .delCBtn, .editCBtn, #addExp{
			display: none;
		}

.labelCol{
	width: 30px;
	text-align: center;
	border-radius: 3px;
	height: 30px;
	margin: 1px;
}
.labelCol:hover {
	border: 3px double white;
}

.choices__list--single{
	font-size: 1.3em;
}
</style>

<script>


//즐겨찾기 아이콘(별) 클릭시 이벤트
function bMark(e) {
	var src = $(e).attr("src");
	var projNo = $(e).attr("title");
	var data = {
		       'projNo' : projNo
		       };

	if(src == "/resources/image/starli.png"){
		$(e).attr("src","/resources/image/starbl.png");

		//즐겨찾기 삭제
		$.ajax({
			url: '/projects/deleteBookmark',
			data: JSON.stringify(data),
	        dataType: 'json',
			type: 'post',
			beforeSend: function(xhr) {
		           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		    },
			success: function (res) {

			}

		});
	}else{
		$(e).attr("src","/resources/image/starli.png");

		//즐겨찾기 등록
		$.ajax({
			url: '/projects/createBookmark',
			data: JSON.stringify(data),
			dataType: 'json',
			type: 'post',
			beforeSend: function(xhr) {
		           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		    },
			success: function (res) {

			}
		});
	}
}



</script>

<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
<div class="card-header pb-0 p-3">
	<div class="dropdown">
		<button class="btn bg-gradient-dark dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 1.2em;">
	    	Works
		</button>
		<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="font-size: 1.2em;">
			<p style="color: gray; text-align: center; margin-top: 10px;">Works</p>
			<hr class="hr1">&nbsp;&nbsp;
			<button type="button"  data-bs-toggle="modal" data-bs-target="#projCreate" style="background: none; border: none;">
				<img alt="" src="/resources/image/add.png" class="imgIcon">&nbsp;&nbsp;새 프로젝트 만들기
			</button>
			<hr class="hr1">
			<a class="dropdown-item" href="/projects/projList" style="color: black;"><img alt="" src="/resources/image/home1.png" class="imgIcon">&nbsp;&nbsp;Works 홈</a><hr class="hr1">
			&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" src="/resources/image/starbl.png" class="imgIcon">&nbsp;&nbsp;<span style="color: black;">즐겨찾는 프로젝트</span>
			<div id="bookMark"></div>
			<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
			<c:if test="${projVO.bookmark == 1}">
				<div style="margin-left: 27px;">
					<a class="dropdown-item" href="/projects/projDetail?projNo=${projVO.projNo}">${projVO.projTtl}</a>
				</div>
			</c:if>
			</c:forEach>
			<hr class="hr1">
			&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" src="/resources/image/ing.png" class="imgIcon">&nbsp;&nbsp;<span style="color: black;">진행중인 프로젝트</span>
			<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
			<c:if test="${projVO.cdNm eq '진행중'}">
				<div style="margin-left: 27px;">
					<a class="dropdown-item" href="/projects/projDetail?projNo=${projVO.projNo}">${projVO.projTtl}</a>
				</div>
			</c:if>
			</c:forEach>
			<hr class="hr1">
			&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" src="/resources/image/done.png" class="imgIcon">&nbsp;&nbsp;<span style="color: black;">완료된 프로젝트</span>
			<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
			<c:if test="${projVO.cdNm eq '종료'}">
			<div style="margin-left: 27px;">
				<a class="dropdown-item" href="/projects/projDetail?projNo=${projVO.projNo}">${projVO.projTtl}</a>
			</div>
		</c:if>
		</c:forEach>
		</ul>
	</div>
</div>

<div class="row mt-4" >
	<div class="col-lg-7 col-12" style="margin-top: -30px;">
 		<div class="card" >
			<div class="card-header p-3">
				<div class="row">
					<div class="col-md-8">
						<h4 class="mb-0">태스크 목록</h4>
						<c:if test="${projVO.projSsts eq 'PROJ0003'}">
							<p class="text-md mb-0" style="margin: 10px;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
					  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
					  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								이 프로젝트는 삭제된 프로젝트로 태스크 상세보기/편집이 불가합니다.
							</p>
						</c:if>
						<c:if test="${projVO.projSsts eq 'PROJ0002'}">
							<p class="text-sm mb-0" style="margin: 10px;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
					  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
					  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								이 프로젝트는 종료된 프로젝트로 편집이 불가합니다.
							</p>
						</c:if>
					</div>
					<div class="col-md-4 d-flex justify-content-end align-items-center">
						<button type="button" class="btn btn-info btn-sm mb-0" data-bs-toggle="modal" data-bs-target="#exampleModalMessage3" style="font-size: 1.2em;"<c:if test="${projVO.projSsts eq 'PROJ0002' || projVO.projSsts eq 'PROJ0003'}">disabled</c:if>>+ 새 태스크 등록 </button>
					</div>
				</div>
				<hr class="horizontal dark mb-0">
			</div>
			<div class="card-body p-3 pt-0">
				<ul class="list-group list-group-flush" data-toggle="checklist" >
					<c:forEach var="taskVO" items="${tProjVO.projTaskVOList}" varStatus="stat">
					<c:if test="${empty taskVO.taskNo}"><p>등록된 태스크가 없습니다.</p></c:if>
					<c:if test="${not empty taskVO.taskNo}">
					<li class="list-group-item border-0 flex-column align-items-start ps-0 py-0 mb-3" >
						<div class="checklist-item checklist-item-${taskVO.labelNm} ps-2 ms-3" style="height: 45px;">
							<div class="d-flex align-items-center" >
								<button class="tDetail" title="${taskVO.taskNo}" style="background: none; border: none;" data-bs-toggle="modal" data-bs-target="#taskModal"<c:if test="${projVO.projSsts eq 'PROJ0003'}">disabled</c:if>>
									<h5 class="mb-0 text-dark font-weight-bold text-md">${taskVO.taskTtl}</h5>
								</button>
							</div>
							<div class="d-flex align-items-center ms-4 ps-1" style="margin-left: 150px;">
								<div class="ms-auto" style="text-align: center; margin-top: -30px;">
									<p class="text-lg mb-0 text-secondary font-weight-bold">담당자</p>
									<c:choose>
										<c:when test="${not empty taskVO.fileStrgNm}">
						                 	<img alt="" src="/resources/upload${taskVO.fileStrgNm}" class="imgIcon" style="width: 25px;">&nbsp;
										</c:when>
										<c:otherwise>
						                	<img src="/resources/upload/emp/profile/default.png" alt="default.png" style="width: 20px;">
										</c:otherwise>
					        	    </c:choose>
									<span class="text-lg font-weight-bolder">${taskVO.tempno}</span>
								</div>
								<div style="text-align: center; width: 65px; margin-left: 30px; margin-top: -30px;">
									<p class="text-lg mb-0 text-secondary font-weight-bold">상태</p>
									<c:if test="${taskVO.taskSsts eq '대기'}"><span class="badge badge-warning" style="font-size: 1.0em;">${taskVO.taskSsts}</span></c:if>
									<c:if test="${taskVO.taskSsts eq '진행중'}"><span class="badge badge-success" style="font-size: 1.0em;">${taskVO.taskSsts}</span></c:if>
									<c:if test="${taskVO.taskSsts eq '완료'}"><span class="badge badge-danger" style="font-size: 1.0em;">${taskVO.taskSsts}</span></c:if>
								</div>

							</div>
						</div>
						<hr class="horizontal dark mt-4 mb-0">
					</li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
			<div class="card-footer p-3">
				<div align="left">
					<span class="badge badge-dot">
						<i class="bg-danger" style="width: 30px;"></i>
						<span class="text-dark text-lg">보고</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="bg-warning" style="width: 30px;"></i>
						<span class="text-dark text-lg">자료</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="bg-success" style="width: 30px;"></i>
						<span class="text-dark text-lg">현장</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="bg-info" style="width: 30px;"></i>
						<span class="text-dark text-lg">개발</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="bg-dark" style="width: 30px;"></i>
						<span class="text-dark text-lg">세미나</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="bg-primary" style="width: 30px;"></i>
						<span class="text-dark text-lg">기술</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="bg-secondary" style="width: 30px;"></i>
						<span class="text-dark text-lg">홍보</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<i class="bg-light" style="width: 30px;"></i>
						<span class="text-dark text-lg">회계</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</span>
				</div>
				<hr class="horizontal dark mb-0">
			</div>
		</div>
	</div>

	<div class="col-lg-5 col-12" style="margin-top: -30px;">
		<div class="card overflow-hidden">
			<div class="card-header p-3 pb-0">
				<div class="d-flex align-items-center" style="margin-bottom: 15px;">
					<span class="badge bg-gradient-dark" style="font-size: 1.3em; padding: 6px; padding-top: 10px;">${projVO.projTtl}&nbsp;&nbsp;
					<button type="button" style="border: none; background: none; padding: 0px;">
						<img onclick="bMark(this)" alt="Image placeholder" src="/resources/image/<c:if test="${projVO.bookmark == 1}">starli</c:if><c:if test="${projVO.bookmark == 0}">starbl</c:if>.png" title="${projVO.projNo}" style="width: 20px; margin-bottom: 5px;">
					</button>
					</span>
				</div>
				<div class="d-flex align-items-right justify-content-between" >
					<div class="avatar-group mt-2" style="margin-bottom: 15px;">
						<h4>참여자</h4>

						<c:forEach var="prtpntVO" items="${projVO.projPrtpntVOList}" varStatus="stat">
						<c:if test="${empty prtpntVO.pempno}"></c:if>
						<c:if test="${not empty prtpntVO.pempno}">
						<a href="javascript:;" class="avatar avatar-md rounded-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="${prtpntVO.empNm} ${prtpntVO.empJbps}" data-bs-original-title="${prtpntVO.empNm} ${prtpntVO.empJbps}">
							<c:choose>
								<c:when test="${not empty prtpntVO.fileStrgNm}">
				                 	<img alt="Image placeholder" src="/resources/upload${prtpntVO.fileStrgNm}" >
								</c:when>
								<c:otherwise>
				                	<img src="/resources/upload/emp/profile/default.png" alt="default.png" >
								</c:otherwise>
			        	    </c:choose>
						</a>
						</c:if>
						</c:forEach>
						<c:if test="${empVO.empNm eq projVO.empNo && projVO.projSsts eq 'PROJ0001'}">
							<button data-bs-toggle="modal" data-bs-target="#projPrtAddModal" style="background: none; border: none;"><img alt="Image placeholder" src="/resources/image/add2.png" style="width: 40px; margin-top: -35px; "></button>
						</c:if>
					</div>
				</div>
				<div>
					<h4>기한일&nbsp;&nbsp;
					<span id="pEnd" class="badge badge-danger" style="font-weight: bolder; font-size: 1.0em; height: 35px; padding-top: 7px;"><img alt="" src="/resources/image/cal.png" style="width: 20px; margin-right: 10px; padding: 0px; margin-bottom: 5px;">${projVO.projEndYmd}</span>
					</h4>

				</div>
			</div>
		</div>
		<div class="row" style="margin-top: 15px;">
			<div class="row px-0" style="margin-left: 0px;">
				<div class="col-md-8 mb-lg-0 mb-4" style="margin-top: 10px;  ">
					<div class="card h-100">
			            <div class="card-header pb-0 p-3">
			              <div class="d-flex align-items-center">
			                <h4 class="mb-0">태스크 요약</h4>
			                <button type="button" class="btn btn-icon-only btn-rounded btn-outline-secondary mb-0 ms-2 btn-sm d-flex align-items-center justify-content-center ms-auto" data-bs-toggle="tooltip" data-bs-placement="bottom" title="전체 태스크의 진행상황을 확인할 수 있습니다.">
			                  <i class="fas fa-info"></i>
			                </button>
			              </div>
			            </div>
			            <div class="card-body p-3">
			              <div class="row">
			                <div class="col-5 text-center" style="margin-top: -30px;">
			                  <div class="chart">
			                    <canvas id="chart-consumption" class="chart-canvas" height="180" ></canvas>
			                  </div>
			                  &nbsp;<h4 class="font-weight-bold" style="margin-top: -145px;">
			                    <span style="font-size: 1.3em;">${taskCountVO.allTask}</span>
			                    <span class="d-block text-body text-sm">TASK</span>
			                  </h4>
			                </div>
			                <div class="col-7">
			                  <div class="table-responsive">
			                    <table class="table align-items-center mb-0">
			                      <tbody>
			                        <tr>
			                          <td>
			                            <div class="d-flex px-2 py-0">
			                              <span class="badge badge-warning me-3"> </span>
			                              <div class="d-flex flex-column justify-content-center">
			                                <h6 class="mb-0 text-lg">대기</h6>
			                              </div>
			                            </div>
			                          </td>
			                          <td class="align-middle text-center text-sm">
			                            <span class="text-lg font-weight-bold"> <fmt:formatNumber type="number" maxFractionDigits="0"  value="${taskCountVO.holdTask / taskCountVO.allTask * 100}" />% </span>
			                          </td>
			                        </tr>
			                        <tr>
			                          <td>
			                            <div class="d-flex px-2 py-0">
			                              <span class="badge badge-success me-3"> </span>
			                              <div class="d-flex flex-column justify-content-center">
			                                <h6 class="mb-0 text-lg">진행중</h6>
			                              </div>
			                            </div>
			                          </td>
			                          <td class="align-middle text-center text-sm">
			                            <span class="text-lg font-weight-bold"> <fmt:formatNumber type="number" maxFractionDigits="0"  value="${taskCountVO.ingTask / taskCountVO.allTask * 100}" />% </span>
			                          </td>
			                        </tr>
			                        <tr>
			                          <td>
			                            <div class="d-flex px-2 py-0">
			                              <span class="badge badge-danger me-3"> </span>
			                              <div class="d-flex flex-column justify-content-center">
			                                <h6 class="mb-0 text-lg">완료</h6>
			                              </div>
			                            </div>
			                          </td>
			                          <td class="align-middle text-center text-sm">
			                            <span class="text-lg font-weight-bold"> <fmt:formatNumber type="number" maxFractionDigits="0"  value="${taskCountVO.endTask / taskCountVO.allTask * 100}" />% </span>
			                          </td>
			                        </tr>
			                      </tbody>
			                    </table>
			                  </div>
			                </div>
			              </div>
			            </div>
			          </div>
				</div>
				<div class="col-md-4 mb-lg-0 mb-4" style="margin-top: 10px; padding-left: 0px;">
					<div class="card h-100">
						<div class="card-header pb-0 p-3">
			              <div class="d-flex align-items-center">
			                <h4 class="mb-0">프로젝트<br>진행률</h4>
			                <button style="margin-top: -30px;" type="button" class="btn btn-icon-only btn-rounded btn-outline-secondary mb-0 ms-2 btn-sm d-flex align-items-center justify-content-center ms-auto" data-bs-toggle="tooltip" data-bs-placement="bottom" title="현재 프로젝트가 얼마나 진행되었는지 확인할 수 있습니다.">
			                  <i class="fas fa-info"></i>
			                </button>
			              </div>
			            </div>
						<div class="card-body text-center" >
		                  <h1 class="text-dark text-gradient" > <span id="status2" style="font-size: 1.5em;" countto="${taskCountVO.endTask / taskCountVO.allTask * 100}">${taskCountVO.endTask / taskCountVO.allTask * 100}</span> <span class="text-lg ms-n1" >%</span></h1>
		                </div>
					</div>
				</div>
			</div>
			<div class="col-md-12 mb-lg-0 mb-4" style="margin-top: 25px;">
				<div class="card h-100" >
					<div class="card-header pb-0 p-3">
			              <div class="d-flex align-items-center">
			                <h4 class="mb-0">태스크 진행률</h4>
			                <button type="button" class="btn btn-icon-only btn-rounded btn-outline-secondary mb-0 ms-2 btn-sm d-flex align-items-center justify-content-center ms-auto" data-bs-toggle="tooltip" data-bs-placement="bottom" title="태스크별로 진행상황을 확인할 수 있습니다.">
			                  <i class="fas fa-info"></i>
			                </button>
			              </div>
			            </div>
					<div class="card-body pb-0 p-3">
						<ul class="list-group">
							<c:forEach var="taskVO" items="${tProjVO.projTaskVOList}" varStatus="stat">
								<li class="list-group-item border-0 d-flex align-items-center px-0 mb-0">
									<div class="w-100">
										<div class="d-flex mb-2">
											<span class="me-2 text-lg font-weight-bolder text-capitalize">${taskVO.taskTtl}</span>
										</div>
										<div>
											<div class="progress progress-lg" style="height: 26px;">
												<c:set var="progressVal" value="0"/>
												<c:if test="${taskVO.allChk ne 0}">
													<c:if test="${(taskVO.clearChk / taskVO.allChk * 100) % 10 lt 5}">
														<c:set var="progressVal" value="${(taskVO.clearChk / taskVO.allChk * 100) - (taskVO.clearChk / taskVO.allChk * 100)%10}"/>
													</c:if>
													<c:if test="${(taskVO.clearChk / taskVO.allChk * 100) % 10 ge 5}">
														<c:set var="progressVal" value="${(taskVO.clearChk / taskVO.allChk * 100) - (taskVO.clearChk / taskVO.allChk * 100)%10 + 10}"/>
													</c:if>
												</c:if>
												<div class="progress-bar bg-gradient-dark w-<fmt:formatNumber type='number' maxFractionDigits='0'  value='${progressVal}' />" role="progressbar" aria-valuenow="<fmt:formatNumber type='number' maxFractionDigits='0'  value='${progressVal}' />" aria-valuemin="0" aria-valuemax="100" style="height: 27px; font-size: 1.3em;"><fmt:formatNumber type="number" maxFractionDigits="0"  value="${(taskVO.clearChk / taskVO.allChk * 100)}" />%</div>
											</div>
										</div>
									</div>
								</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 새 태스크 등록 모달창 -->
<div class="modal fade" id="exampleModalMessage3"  tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true" >
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="exampleModalLabel">새 태스크 등록하기</h4>
				<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<form action="/projects/taskCreate?${_csrf.parameterName}=${_csrf.token}" id="frm" name="frm" method="post">
				<div class="modal-body" style="font-size: 1.3em;">
					<div class="form-group" style="margin-bottom: 35px;">
						<label for="recipient-name" class="col-form-label">제목</label>
						<input type="text" style="font-size: 1.0em;" class="form-control" name="taskTtl" id="taskTtl" placeholder="태스크 제목을 입력하세요">
						<input type="hidden" name="projNo" value="${projVO.projNo}">
					</div>
					<div class="form-group" style="margin-bottom: 35px;">
						<label for="recipient-name" class="col-form-label">담당자</label>
						<p class="text-md mb-0" >
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
				  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
				  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
							</svg>
							태스크 담당자는 프로젝트 참여자 중에서만 설정할 수 있습니다.
						</p>
						<select class="form-control" name="empNo" id=empNo ></select>
					</div>
					<div class="form-group">
						<label for="recipient-name" class="col-form-label">기한일</label>
						<input type="date" class="form-control endYmd" id="taskEndDt" name="taskEndDt"  placeholder="태스크 기한일을 선택하세요" style="font-size: 0.8em;">
					</div>
				</div>
				<div class="modal-footer">
		            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal" style="font-size: 1.1em;">취소</button>
		            <button type="submit" class="btn bg-gradient-primary" style="background: #5C67F5; font-size: 1.1em;" >등록</button>
				</div>
			</form>
		</div>
	</div>
</div>

<!-- 태스크 상세보기 모달창 -->
<div class="modal fade" id="taskModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="exampleModalLabel">태스크 #<span id="taskNo"></span></h4>
        <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close" onclick="reload()">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" style=" padding: 0px;">
      		<div class="card overflow-hidden" style="padding: 10px; ">
				<div class="card-header p-3 pb-0" style="border-bottom: 2px dotted gray; ">
					<div class="d-flex align-items-center">
						<img alt="Image placeholder" src="/resources/image/task1.png" style="width: 25px; margin-top: -15px;">&nbsp;&nbsp;
						<h4 id="taskTtl1"></h4>&nbsp;&nbsp;<span id="taskSsts1" style="color: #aaaaaa; font-size: 1.3em;"></span>
					</div>
					<div id="exp" class="d-flex align-items-center" style="margin-left: 25px;">
						<img alt="Image placeholder" src="/resources/image/sort.png" style="width: 20px; margin-top: -15px;">&nbsp;&nbsp;
						<h5 id="taskExpln"></h5>
					</div>
					<!-- 태스크 설명이 없을 경우 -->
					<button id="addExpBtn" class="btn btn-icon btn-3 btn-outline-secondary" type="button" style="font-size: 1.0em; height: 35px; text-align: center; padding: 5px; width: 80px;">
						<span class="btn-inner--icon"><i class="ni ni-fat-add"></i></span>
					   설명
					</button>
					<!-- 태스크 설명 추가 버튼 클릭시 보이는 부분 -->
					<div id="addExp" style="display: none; ">
						<textarea class="form-control" placeholder="태스크 설명을 작성해주세요" rows="4" id="expText" style="margin-bottom: 10px; margin-left: 24px; width: 95%;"></textarea>
						<button type="button" id="addExpp" value="" class="btn btn-info btn-sm" style="margin-left: 24px;">등록</button>
						<button type="button" id="addExppX" class="btn btn-secondary btn-sm">취소</button>
					</div>
					<div class="row" style="margin: 10px;">
						<div class="col-2" style="text-align: left;">
							<p class="text-lg mb-0 text-secondary font-weight-bold">담당자</p>
							<img id="empNoImag" src="" class="avatar rounded-circle me-2" data-bs-toggle="tooltip" data-bs-placement="bottom" title="" >&nbsp;
						</div>
						<div class="col-3" style="text-align: left; ">
							<p class="text-lg mb-0 text-secondary font-weight-bold">기한</p>
							<span id="taskEndDt1" class="badge badge-danger" style="font-size: 1.2em; height: 35px; "></span>
						</div>
						<div class="col-3" style="text-align: left; ">
							<p class="text-lg mb-0 text-secondary font-weight-bold">라벨</p>
							<div class="row">
								<div class="labelCol" style="background: #EA0606;" data-bs-toggle="tooltip" data-bs-placement="top" title="보고"><input type="hidden" value="LABEL7"></div>
								<div class="labelCol" style="background: #FBCF33;" data-bs-toggle="tooltip" data-bs-placement="top" title="자료"><input type="hidden" value="LABEL3"></div>
								<div class="labelCol" style="background: #82D616;" data-bs-toggle="tooltip" data-bs-placement="top" title="현장"><input type="hidden" value="LABEL4"></div>
								<div class="labelCol" style="background: #17C1E8;" data-bs-toggle="tooltip" data-bs-placement="top" title="개발"><input type="hidden" value="LABEL6"></div>
							</div>
							<div class="row">
								<div class="labelCol" style="background: #344767;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="세미나"><input type="hidden" value="LABEL2"></div>
								<div class="labelCol" style="background: #CB0C9F;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="기술"><input type="hidden" value="LABEL1"></div>
								<div class="labelCol" style="background: #8392AB;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="홍보"><input type="hidden" value="LABEL5"></div>
								<div class="labelCol" style="background: #E9ECEF;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="회계"><input type="hidden" value="LABEL8"></div>
							</div>
						</div>
						<div class="col-4" style="text-align: left; ">
							<p class="text-lg mb-0 text-secondary font-weight-bold">이동</p>
							<input type="hidden" id="hTaskSsts" value=""/>
							<select class="form-control" name="taskSsts" id="taskSsts" ></select>
						</div>
					</div>
				</div>

				<div class="card-header p-3 pb-0" style="border-bottom: 2px dotted gray; padding: 20px;">
					<div class="d-flex align-items-center">
						<img alt="Image placeholder" src="/resources/image/checklist.png" style="width: 25px; margin-top: -15px;">&nbsp;&nbsp;
						<h4>체크리스트</h4>
					</div>
					<div id="taskChkList">
					<!-- 체크리스트 반복 부분 -->
					</div>
					<!-- 항목 추가 버튼 클릭시 보이는 부분 -->
					<div id="addChkList" style="display: none;">
						<input id="chkText" class="form-control form-control-md" type="text" placeholder="체크리스트 내용을 입력하세요" style="margin-left: 24px; width: 98%; margin-bottom: 5px; font-size: 1.2em;">
						<button type="button" id="addChk" value="" class="btn btn-info btn-sm" style="margin-left: 24px; font-size: 1.2em; height: 35px;">등록</button>
						<button type="button" id="addChkX" class="btn btn-secondary btn-sm" style="font-size: 1.2em; height: 35px;">취소</button>
					</div>
					<!-- 항목 추가 버튼 -->
					<button type="button" id="btnChk" class="btn btn-outline-secondary btn-sm" style="margin-left: 25px; height: 40px; margin-top: 5px; font-size: 1.3em;">+&nbsp;&nbsp;항목 추가</button>

				</div>

				<div class="card-header p-3 pb-0" style="border-bottom: 2px dotted gray;" >
					<div class="d-flex align-items-center">
						<img alt="Image placeholder" src="/resources/image/file.png" style="width: 25px; margin-top: -15px;">&nbsp;&nbsp;
						<h4>파일첨부</h4>
					</div>
					<div class="row">
						<div class="col-10">
						<form id="frmFile" style="margin-bottom: 20px;" enctype="multipart/form-data">
			              <div>
			                <input id="file" name="uploadFile" type="file" multiple style="font-size: 1.2em;"/>
			              </div>
			            </form>
			            </div>
			            <div class="col-2">
			            <button type="button" id="btn-upload-file" class="btn btn-info" style="float: right; font-size: 1.2em; height: 40px; padding: 0px; padding-left: 20px; padding-right: 20px;">업로드</button>
			            </div>
					</div>
					<div id="previewFile">

					</div>
				</div>

				<div class="card-header p-3 pb-0" style="border-bottom: 2px dotted gray;" >
					<div class="d-flex align-items-center">
						<h5>댓글&nbsp;<span id="countCmnt" ></span></h5>
					</div>
					<div class="mb-1" style="margin-top: -15px;">
						<div class="d-flex mt-3">
							<div class="flex-shrink-0">
								<c:choose>
									<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
					                 	<img id="myImg" alt="Image placeholder" style="width:50px; height:50x;" class="avatar rounded-circle me-2" src="/resources/upload${empVO.fileGrVO.filesList[0].fileStrgNm}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${empVO.empNm} ${empVO.jbpsNm}">
									</c:when>
									<c:otherwise>
					                	<img id="myImg" src="/resources/upload/emp/profile/default.png" class="avatar rounded-circle me-2" style="width:50px; height:50px;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${empVO.empNm} ${empVO.jbpsNm}">
									</c:otherwise>
				        	    </c:choose>
							</div>
							<div class="flex-grow-1 my-auto">
								<input type="hidden" value="${empVO.empNo}" id="cEmpNo">
								<input type="hidden" value="" id="cTaskNo">
								<textarea class="form-control" style="font-size: 1.2em;" placeholder="댓글을 작성해주세요" rows="1" id="tCmnt" onclick="cBig()"></textarea>
							</div>
						</div>
							<!-- 댓글 등록 입력칸 클릭시 보이는 부분 -->
							<div id="clickCmnt" style="display: none;  margin-top: 8px;">
								<button type="button" id="addCmnt" class="btn btn-info btn-sm" style="margin-left: 52px;">저장</button>
								<button type="button" id="addCmntX" class="btn btn-secondary btn-sm">취소</button>
							</div>
						<!-- 댓글 -->
						<div id="cmntTask"></div>

					</div>
				</div>
			</div>
      	</div>

    </div>
  </div>
</div>

<!-- 프로젝트 참여자 모달창 -->
<div class="modal fade" id="projPrtAddModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">프로젝트 참여자 추가하기</h5><br/>
				<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<div class="modal-body" style="overflow: auto; height: 550px;">
				<p><img alt="" src="/resources/image/info.png" class="imgIcon" style="margin-bottom: 5px;">&nbsp;&nbsp;이미 참여중인 사원은 선택할 수 없습니다.</p>
				<div class="dataTable-container">
					<table class="table table-flush dataTable-table"
						id="datatable-search">
						<thead>
							<tr>
								<th class="text-secondary opacity-7" style="font-size: 1.2em;"></th>
								<th class="text-secondary opacity-7" style="font-size: 1.2em;">이름</th>
								<th class="text-secondary opacity-7" style="font-size: 1.2em;">직위</th>
								<th class="text-secondary opacity-7" style="font-size: 1.2em;">부서</th>
							</tr>
						</thead>
						<tbody>
							<!-- data : ArticlePage
								data.content : List<AddrVO> addrList
							-->
							<c:forEach var="empVO" items="${empList}" varStatus="stat">
								<tr>
									<td style="font-size: 1.0em;">
										<div class="d-flex align-items-center">
											<div class="form-check">
												<input class="form-check-input empNo" type="checkbox"
													data-emp-no="${empVO.empNo}"
													<c:forEach var="prtpntVO" items="${projVO.projPrtpntVOList}" varStatus="stat">
													<c:if test="${empVO.empNo eq prtpntVO.pempno}">disabled style="background:#8c8c8c;"</c:if>
													</c:forEach>
													id="customCheck1" name="empNo" value="${empVO.empNo}">
											</div>
											<p class="text-xs font-weight-bold ms-2 mb-0"></p>
										</div>
									</td>
									<td class="font-weight-bold">
										<span class="my-2 text-md">${empVO.empNm}</span>
									</td>
									<td class="text-lg font-weight-bold">
										<span class="my-2 text-md">${empVO.jbpsNo}</span>
									</td>
									<td class="text-lg font-weight-bold">
										<span class="my-2 text-md">${empVO.deptNo}</span>
									</td>
								</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="modal-footer">
	            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">취소</button>
	            <button type="button" id="projPrtAdd" class="btn bg-gradient-info">추가</button>
			</div>
		</div>
	</div>
</div>
</sec:authorize>
<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>
<script src="/resources/maincss/assets/js/plugins/dropzone.min.js"></script>

<script>
$(function () {
	const urlParams = new URL(location.href).searchParams;
	const projNo = urlParams.get('projNo');
	var data = {
		       'projNo' : projNo
		       };

	//프로젝트 참여자 목록
	$.ajax({
		url: '/projects/prtList',
		data: JSON.stringify(data),
        dataType: 'json',
		type: 'post',
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			if (document.getElementById('empNo')) {
				var prt = document.getElementById('empNo');
				setTimeout(function() {
					const example = new Choices(prt);
				}, 1);

				var prtNmArray = new Array();
				var empNoArray = new Array();

				$.each(res,function (i, v) {
					prtNmArray[i] = v.empNm + " " + v.empJbps;
					empNoArray[i] = v.empNo;
				})

				for (m = 0; m < prtNmArray.length; m++) {
					var optn = document.createElement("OPTION");
					optn.text = prtNmArray[m];
					optn.value = empNoArray[m];
					prt.options.add(optn);
				}
			}
		}
	});


});

</script>
<script src="/resources/maincss/assets/js/plugins/countup.min.js"></script>
<script>
//countTO
if (document.getElementById('status2')) {
      const countUp = new CountUp('status2', document.getElementById("status2").getAttribute("countTo"));
      if (!countUp.error) {
        countUp.start();
      } else {
      }
    }

// Chart Doughnut Consumption by room
    var ctx1 = document.getElementById("chart-consumption").getContext("2d");

    var gradientStroke1 = ctx1.createLinearGradient(0, 230, 0, 50);

    gradientStroke1.addColorStop(1, 'rgba(203,12,159,0.2)');
    gradientStroke1.addColorStop(0.2, 'rgba(72,72,176,0.0)');
    gradientStroke1.addColorStop(0, 'rgba(203,12,159,0)'); //purple colors

    new Chart(ctx1, {
      type: "doughnut",
      data: {
        labels: ['대기', '진행중', '완료'],
        datasets: [{
          label: "Task",
          weight: 1,
          cutout: 30,
          tension: 0.9,
          pointRadius: 2,
          borderWidth: 4,
          backgroundColor: ['#FEF5D3', '#CDF59B', '#FC9797'],
          data: ['<c:out value="${taskCountVO.holdTask}"/>', '<c:out value="${taskCountVO.ingTask}"/>', '<c:out value="${taskCountVO.endTask}"/>'],
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
</script>
<script>

function refresh(){
	location.reload();
}
//프로젝트 참여자 등록
$("#projPrtAdd").on("click", function(){
	const urlParams = new URL(location.href).searchParams;
	const projNo = urlParams.get('projNo');

	let empNoArray = [];

	$("input:checkbox[name='empNo']:checked").each(function(index,data){
		let empNo = $(this).data("empNo");
		empNoArray.push(empNo);
	});

	//json object
	let data = {"empNoArray":empNoArray,
			     'projNo' : projNo}

	//ajax
	$.ajax({
		url:"/projects/projPrtAdd",
		contentType:"application/json;charset:utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(result){
			swal({
				title: "참여자(들)이 추가되었습니다.",
				icon: "success", //success, warning, error
				button: "확인",
				closeOnClickOutside: false
			}).then(function () {
				refresh();
			});
		}
	});
});

//태스트 클릭시 해당 태스크 정보 가져오기
$(".tDetail").on("click", function(){
	var loginEmpNo = $('#cEmpNo').val();
	var taskNo = $(this).attr("title");
	var data = {
		       'taskNo' : taskNo
		       };
	var tSt = "";
	$.ajax({
		url: '/projects/taskDetail',
		data: JSON.stringify(data),
        dataType: 'json',
		type: 'post',
		async:false,
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			//res : TaskVO taskDetailVO
			tSt = res.taskSsts;

			$('#taskNo').text(res.taskNo);
			$('#taskTtl1').text(res.taskTtl);
			if(res.taskExpln == null){
				$('#exp').css('display', "none");
 				$('#addExpBtn').css('display', "block");
 				$('#taskExpln').text("");
			}else{
				$('#addExpBtn').css('display', "none");
				$('#taskExpln').text(res.taskExpln);
			}
			$('#taskSsts1').text('  in '+ res.taskSsts);
			if(res.fileStrgNm == null){
				$('#empNoImag').attr('src', '/resources/upload/emp/profile/default.png');
			}else{
				$('#empNoImag').attr('src', '/resources/upload'+ res.fileStrgNm);
			}
			$('#empNoImag').attr('data-bs-original-title', res.tempno +' '+res.empJbps);
			$('#taskEndDt1').text(res.taskEndDt);
			$('#countCmnt').text(res.countCmnt);
			$('#cTaskNo').val(res.taskNo);
			$('#addChk').val(res.taskNo);
			$('#hTaskSsts').val(res.taskNo);

			str = "";
			strC = "";
			strF = "";
			//체크리스트
			for(var i=0; i<res.taskChkList.length; i++){
				if(res.taskChkList[i].chkNo == null){
					str = "";
				}
				else{
					str += "<div class='d-flex align-items-center list' style='margin-left: 25px;'>";
					str += "	<div class='d-flex align-items-center'>";
					str += "		<div class='form-check'>";
					if(res.taskChkList[i].chkSsts == 'Y'){
						str += "			<input class='form-check-input chkSt' type='checkbox' value='"+ res.taskChkList[i].chkNo +"' id='flexCheckDefault' checked>";
					}else{
						str += "			<input class='form-check-input chkSt' type='checkbox' value='"+ res.taskChkList[i].chkNo +"' id='flexCheckDefault'>";
					}
					if(res.taskChkList[i].chkSsts == 'Y'){
						str += "		<h5 class='mb-0 text-dark font-weight-bold text-md chk' style='text-decoration:line-through'>"+ res.taskChkList[i].chkCn +"</h5>";
					}else{
						str += "		<h5 class='mb-0 text-dark font-weight-bold text-md chk'>"+ res.taskChkList[i].chkCn +"</h5>";
					}
					str += "		</div>";
					str += "		<button type='button' value='"+ res.taskChkList[i].chkNo +"' style='float:left; margin-top:-20px;' class='btn-close text-dark deleteChk'>";
					str += "  			<span aria-hidden='true' class='delBtn' style='font-size:1.5em;'>×</span>";
					str += "		</button>";
	// 				str += "		<button type='button' value='"+ res.taskChkList[i].chkNo +"' style='float:left; margin-top:-10px;' class='btn-close text-dark editChk'>";
	// 				str += "  			<img src='/resources/image/editC.png' style='width:10px; margin-left:-5px;' class='editBtn'>";
	// 				str += "		</button>";
					str += "	</div>";
					str += "</div>";
				}
			}
 			$('#taskChkList').html(str);

			//댓글
			for(var i=0; i<res.taskCmntList.length; i++){
				if(res.taskCmntList[i].cmntNo == 0){
					strC = "";
				}else{
					strC += "<div class='d-flex mt-3 cmntList'>";
					strC += "	<div class='flex-shrink-0'>";
					if(res.taskCmntList[i].efileStrgNm == null){
						strC += "		<img alt='Image placeholder' style='width:50px; height:50px;' class='avatar rounded-circle me-2' src='/resources/upload/emp/profile/default.png' data-bs-toggle='tooltip' data-bs-placement='bottom' title='"+ res.taskCmntList[i].empTitle +"'>";
					}else{
						strC += "		<img alt='Image placeholder' style='width:50px; height:50px;' class='avatar rounded-circle me-2' src='/resources/upload"+ res.taskCmntList[i].efileStrgNm+"' data-bs-toggle='tooltip' data-bs-placement='bottom' title='"+ res.taskCmntList[i].empTitle +"'>";
					}
					strC += "	</div>";
					strC += "	<div class='flex-grow-1 my-auto' >";
					strC += "		<span class='orgCmnt' style='font-size: 1.2em;'>"+ res.taskCmntList[i].cmntCn +"</span><br/>";
					strC += "		<textarea class='form-control tCmntModi' rows='4' style='display:none; font-size: 1.2em;'>"+res.taskCmntList[i].cmntCn+"</textarea>";
					strC += "		<div class='modiCmnt' style='margin-top: 8px; display:none;'>";
					strC += "			<button type='button' style='font-size: 1.2em;' value='"+ res.taskCmntList[i].cmntNo +"' class='btn btn-info btn-sm btnMCmnt' >저장</button>";
					strC += "			<button type='button' style='font-size: 1.2em;' class='btn btn-secondary btn-sm btnMCmntX'>취소</button>";
					strC += "		</div>";
					strC += "		<span style='font-size: 1.0em; color: gray;'>"+ res.taskCmntList[i].cmntRegYmd +"</span>";
					strC += "	</div>";
					if(loginEmpNo == res.taskCmntList[i].cempNo){
						strC += "	<button type='button' value='"+ res.taskCmntList[i].cmntNo +"' style='float:right; margin-top:-10px; margin-right:10px;' class='btn-close text-dark deleteCmnt'>";
						strC += "  		<span aria-hidden='true' style='font-size: 2.0em;' class='delCBtn'>×</span>";
						strC += "	</button>";
						strC += "	<button type='button' value='"+ res.taskCmntList[i].cmntNo +"' style='float:right;' class='btn-close text-dark editCmnt'>";
						strC += "  		<img src='/resources/image/editC.png' style='width:20px; margin-left:-5px;'' class='editCBtn'>";
						strC += "	</button>";
					}
					strC += "</div>";
				}
			}
			$('#cmntTask').html(strC);

			//파일
			//filesList=[
// 				FilesVO(fileNo=FILE073, fileGroupNo=FILE_GR065, fileOrgnlNm=0118_1.jpg, fileStrgNm=/task/TASK001/f1e84ad8-80d6-43da-970d-d51ce98b840e_0118_1.jpg
// 						, fileStrgAddr=C:\eGovFrameDev-3.10.0-64bit\workspace\GWProj\src\main\webapp\resources\upload\task\TASK001, fileSz=583882
// 						, fileThumb=/task/TASK001/s_f1e84ad8-80d6-43da-970d-d51ce98b840e_0118_1.jpg, fileType=image/jpeg),
// 				FilesVO(fileNo=FILE074, fileGroupNo=FILE_GR065, fileOrgnlNm=0118_3.jpg, fileStrgNm=/task/TASK001/76334ef7-9187-4525-9dbe-088732563a40_0118_3.jpg
// 						, fileStrgAddr=C:\eGovFrameDev-3.10.0-64bit\workspace\GWProj\src\main\webapp\resources\upload\task\TASK001, fileSz=446330
// 						, fileThumb=/task/TASK001/s_76334ef7-9187-4525-9dbe-088732563a40_0118_3.jpg, fileType=image/jpeg),
// 				FilesVO(fileNo=FILE075, fileGroupNo=FILE_GR065, fileOrgnlNm=0120_1.jpg, fileStrgNm=/task/TASK001/1cd72374-4ffa-4154-b0d6-82241bbc3853_0120_1.jpg
// 						, fileStrgAddr=C:\eGovFrameDev-3.10.0-64bit\workspace\GWProj\src\main\webapp\resources\upload\task\TASK001, fileSz=533454
// 						, fileThumb=/task/TASK001/s_1cd72374-4ffa-4154-b0d6-82241bbc3853_0120_1.jpg, fileType=image/jpeg)]))
				for(var i=0; i<res.fileGrVO.filesList.length; i++){
					if(res.fileGrVO.filesList[i].fileNo == null){
						strF += "첨부된 파일이 없습니다.";
					}else{
						strF += "<div style='margin:10px;'>";
						strF += "	<button type='button' value='"+ res.fileGrVO.filesList[i].fileNo +"' style='float:left; margin-top:-5px;' class='btn-close text-dark deleteFile'>";
						strF += "  		<span aria-hidden='true' style='font-size:1.3em;' class='delFBtn'>×</span>";
						strF += "	</button>";
						strF += "	<a style='font-size:1.2em;' href='/resources/upload"+ res.fileGrVO.filesList[i].filePlace +"' download>"+ res.fileGrVO.filesList[i].fileOrgnlNm +"  ("+ Math.round(res.fileGrVO.filesList[i].fileSz / 1024) +"KB)</a>";
						strF += "</div>";
					}
			}
			$('#previewFile').html(strF);

			//태스크 상태
			if (document.getElementById('taskSsts')) {
				var taskSt = document.getElementById('taskSsts');
				setTimeout(function() {
					const example = new Choices(taskSt);
				}, 1);

				var taskStArray = new Array();
				taskStArray[0] = "대기";
				taskStArray[1] = "진행중";
				taskStArray[2] = "완료";

				var taskStCdArray = new Array();
				taskStCdArray[0] = "TASK0001";
				taskStCdArray[1] = "TASK0002";
				taskStCdArray[2] = "TASK0003";

				for (m = 0; m < taskStArray.length; m++) {
					var optn = document.createElement("OPTION");
					optn.text = taskStArray[m];
					optn.value = taskStCdArray[m];
					if (taskStArray[m] == tSt) {
						optn.selected = true;
					}
					taskSt.options.add(optn);
				}
			}
		}
	});
});

//태스크 이동 버튼이 change가 되면 태스크 테이블 update
$('#taskSsts').on('change', function(){
	let taskSsts = $(this).val();
	let ttaskSsts = $(this).text();
	var c = $(this).parent().parent().prev();
	let taskNo = c.val();
	let data = {"taskNo" : taskNo
			,"taskSsts" : taskSsts};

	$.ajax({
			url:"/projects/updateSsts",
			type:"post",
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				$('#taskSsts1').text('  in '+ ttaskSsts);
				swal({
					title: "태스크 상태가 "+ ttaskSsts +"(으)로\n변경되었습니다.",
					icon: "success", //success, warning, error
					button: "확인",
					closeOnClickOutside: false
				});
			}
		});
});

//체크리스트 체크/체크해제
$(document).on('click',".chkSt",function(){
	var chkList = $(this);
	//체크
	if (chkList.prop("checked")){
		var chkNo1 = chkList.val();
		var data = {'chkNo' : chkNo1};
		$.ajax({
			url: '/projects/chkY',
			data: JSON.stringify(data),
			dataType: 'json',
			type: 'post',
			beforeSend: function(xhr) {
		           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		    },
			success: function (res) {
				chkList.next().css("text-decoration", "line-through");
			}
		});

	//체크해제
	} else {
		var chkNo1 = chkList.val();
		var data = {'chkNo' : chkNo1};
		$.ajax({
			url: '/projects/chkN',
			data: JSON.stringify(data),
			dataType: 'json',
			type: 'post',
			beforeSend: function(xhr) {
		           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		    },
			success: function (res) {
				chkList.next().css("text-decoration", "none");
			}
		});
	};
});

//체크리스트 등록
$('#btnChk').on('click',function(){
	$('#addChkList').css('display','block');
	$('#btnChk').css('display','none');
});
$('#addChkX').on('click',function(){
	$('#chkText').val("");
	$('#addChkList').css('display','none');
	$('#btnChk').css('display','block');
});

$('#addChk').on('click',function(){
	var taskNo = $('#addChk').val();
	var chkText = $('#chkText').val();
	var data = {
		       'taskNo' : taskNo,
		       'chkCn' : chkText
		       };

	$.ajax({
		url: '/projects/addChkList',
		data: JSON.stringify(data),
		dataType: 'json',
		type: 'post',
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			str = "<div class='d-flex align-items-center list' style='margin-left: 25px;'>";
			str += "	<div class='d-flex align-items-center'>";
			str += "		<div class='form-check'>";
			str += "			<input class='form-check-input chkSt' type='checkbox' value='"+ res +"' id='flexCheckDefault'>";
			str += "		<h5 class='mb-0 text-dark font-weight-bold text-md chk'>"+ chkText +"</h5>";
			str += "		</div>";
			str += "		<button type='button' value='"+ res +"' style='float:left; margin-top:-10px;' class='btn-close text-dark deleteChk'>";
			str += "  			<span aria-hidden='true' class='delBtn'>×</span>";
			str += "		</button>";
			str += "	</div>";
			str += "</div>";

			$('#taskChkList').append(str);
			$('#chkText').val("");
			$('#addChkList').css('display','none');
			$('#btnChk').css('display','block');
		}
	});

});

//체크리스트 삭제
$(document).on('click',".deleteChk",function(){
	var p = $(this).parent().parent();

	var chkNo = $(this).val();
	var data = {
		       'chkNo' : chkNo,
		       };

	$.ajax({
		url: '/projects/delChkList',
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

//댓글 삭제
$(document).on('click',".deleteCmnt",function(){
	var c = $('#countCmnt').text();
	var c1 = Number(c) - 1;
	var p = $(this).parent();
	var cmntNo = $(this).val();
	var data = {
		       'cmntNo' : cmntNo,
		       };

	$.ajax({
		url: '/projects/delCmntList',
		data: JSON.stringify(data),
		dataType: 'json',
		type: 'post',
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			p.remove();
			$('#countCmnt').text(c1);
		}
	});
});

//댓글 수정
$(document).on('click',".editCmnt",function(){
	var oc = $(this).prev().prev().find('.orgCmnt');
	var tc = $(this).prev().prev().find('.tCmntModi');
	var mc = $(this).prev().prev().find('.modiCmnt');
	oc.css('display', 'none');
	tc.css('display','block');
	mc.css('display','block');
});

$(document).on('click',".btnMCmntX",function(){
	var oc = $(this).parent().prev().prev().prev();
	var tc = $(this).parent().prev();
	var mc = $(this).parent();
	oc.css('display', 'block');
	tc.val('');
	tc.css('display','none');
	mc.css('display','none');
});

$(document).on('click',".btnMCmnt",function(){
	var oc = $(this).parent().prev().prev().prev();
	var tc = $(this).parent().prev();
	var mc = $(this).parent();

	var cmntNo = $(this).val();
	var cmntCn = $(this).parent().prev().val();
	var data = {
			'cmntNo':cmntNo,
			'cmntCn':cmntCn
	}

	$.ajax({
		url: '/projects/updateCmnt',
		data: JSON.stringify(data),
		dataType: 'json',
		type: 'post',
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			oc.css('display', 'block');
	    	tc.css('display','none');
	    	mc.css('display','none');

	    	oc.text(cmntCn);
		}
	});
});

//부모창 새로고침
function reload(){
	location.reload();
}

//댓글 등록
function cBig() {
	$('#tCmnt').attr('rows','5');
	$('#clickCmnt').css('display','block');
}

$('#addCmntX').on('click',function(){
	$('#tCmnt').attr('rows','1');
	$('#clickCmnt').css('display','none');
});

$('#addCmnt').on('click',function(){
	var c = $('#countCmnt').text();
	var c1 = Number(c) + 1;
	var myImg = $('#myImg').attr('src');

	var taskNo = $('#cTaskNo').val();
	var tCmnt = $('#tCmnt').val();
	var empNo = $('#cEmpNo').val();
	var data = {
			'cmntClsf':taskNo,
			'cmntCn':tCmnt
			}

	if(tCmnt == ''){
		swal({
			title: "댓글 내용을 입력해주세요",
			icon: "info", //success, warning, error
			button: "확인",
			closeOnClickOutside: false
		});
	}

	$.ajax({
	    url: "/projects/createCmnt",
	    contentType:"application/json;charset:utf-8",
	    data:JSON.stringify(data),
	    type:"post",
			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	    success: function(res) {
	    	$('#tCmnt').val('');
	    	$('#tCmnt').attr('rows','1');
	    	$('#clickCmnt').css('display','none');

	    	strC = "<div class='d-flex mt-3 cmntList'>";
			strC += "	<div class='flex-shrink-0'>";
			strC += "		<img alt='Image placeholder' class='avatar rounded-circle me-2' src='"+ myImg +"' style='width:50px; height:50px;'>";
			strC += "	</div>";
			strC += "	<div class='flex-grow-1 my-auto'>";
			strC += "		<span style='font-size:1.2em;' class='orgCmnt'>"+ tCmnt +"</span><br/>";
			strC += "		<textarea class='form-control tCmntModi' rows='4' style='display:none; font-size:1.2em;'>"+ tCmnt +"</textarea>";
			strC += "		<div class='modiCmnt' style='margin-top: 8px; display:none;'>";
			strC += "			<button type='button' value='"+ res +"' class='btn btn-info btn-sm btnMCmnt' >저장</button>";
			strC += "			<button type='button' class='btn btn-secondary btn-sm btnMCmntX'>취소</button>";
			strC += "		</div>";
			strC += "		<span style='font-size: 1.2em; color: gray;'>방금</span>";
			strC += "	</div>";
			strC += "	<button type='button' value='"+ res +"' style='float:right; margin-top:-10px; margin-right:10px;' class='btn-close text-dark deleteCmnt'>";
			strC += "  		<span aria-hidden='true' style='font-size: 2.0em;' class='delCBtn'>×</span>";
			strC += "	</button>";
			strC += "	<button type='button' value='"+ res +"' style='float:right;' class='btn-close text-dark editCmnt'>";
			strC += "  		<img src='/resources/image/editC.png' style='width:20px; margin-left:-5px;' class='editCBtn'>";
			strC += "	</button>";
			strC += "</div>";
	    	$('#cmntTask').prepend(strC);
	    	$('#countCmnt').text(c1);
	    }
	});
});

//버튼 위에 마우스 있을때만 삭제, 수정 버튼 보임
$(document).on("mouseover", ".list", function(){
	$(this).find(".delBtn").show();
	$(this).find(".editBtn").show();
});
$(document).on("mouseout", ".list", function(){
	$(this).find(".delBtn").hide();
	$(this).find(".editBtn").hide();
});
$(document).on("mouseover", ".cmntList", function(){
	$(this).find(".delCBtn").show();
	$(this).find(".editCBtn").show();
});
$(document).on("mouseout", ".cmntList", function(){
	$(this).find(".delCBtn").hide();
	$(this).find(".editCBtn").hide();
});

//태스크 설명 등록
$('#addExpBtn').on('click',function(){
	$('#addExpBtn').css('display', "none");
	$('#addExp').css('display', "block");
});
$('#addExppX').on('click',function(){
	$('#addExpBtn').css('display', "block");
	$('#addExp').css('display', "none");
});
$('#addExpp').on('click',function(){
	var taskExpln = $('#expText').val();
	var taskNo = $('#taskNo').text();
	var data = {
			'taskNo':taskNo,
			'taskExpln':taskExpln
	}
	if(taskExpln == ""){
		swal({
			title: "태스크 설명을 입력해주세요",
			icon: "info", //success, warning, error
			button: "확인",
			closeOnClickOutside: false
		});
	}

	$.ajax({
	    url: "/projects/createExp",
	    contentType:"application/json;charset:utf-8",
	    data:JSON.stringify(data),
	    type:"post",
			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	    success: function(res) {
	    	$('#taskExpln').text(taskExpln);
	    	$('#addExp').css('display', "none");
	    }
	});
});

//태스크 라벨 선택
$('.labelCol').on('click', function(){
	var col = $(this).find('input').val();
	var taskNo = $('#taskNo').text();
	var data = {
			'taskNo':taskNo,
			'labelNo':col
	}

	$.ajax({
	    url: "/projects/createLabel",
	    contentType:"application/json;charset:utf-8",
	    data:JSON.stringify(data),
	    type:"post",
		beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
	    success: function(res) {
	    	swal({
				title: "라벨이 추가/변경되었습니다.",
				icon: "success", //success, warning, error
				button: "확인",
				closeOnClickOutside: false
			});
	    }
	});
});

//파일 업로드
$("#btn-upload-file").click(function() {
	var fileCheck = $("#file").val();
    if(!fileCheck){
    	swal({
			title: "파일을 선택해주세요.",
			icon: "warning", //success, warning, error
			button: "확인",
			closeOnClickOutside: false
		});
    }else{
		var taskNo = $('#taskNo').text();
		var formData = new FormData($("#frmFile")[0]);

		formData.append('taskNo', taskNo);

	    $.ajax({
	        url : "/projects/uploadFile",
	      	type : "POST",
	      	processData : false,
	      	contentType : false,
	      	data : formData,
	    	beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
	        success:function(res) {
	      }
	  });
    }
});

//파일 선택 시 목록 띄우기
$(document).on("change", "#file", function(){
	target = document.getElementById('file');
    fileList = "";
    for(i = 0; i < target.files.length; i++){
        fileList += target.files[i].name + "<img src=''>"+"<br>";
    }
    target2 = document.getElementById('previewFile');
    target2.innerHTML = fileList;
});

//파일 삭제하기
$(document).on("click", ".deleteFile", function(){
	var p = $(this).parent();
	var fileNo = $(this).val();
	var data = {'fileNo':fileNo};
	swal({
		title: "파일을 삭제하시겠습니까?",
		text: "삭제된 파일은 복구할 수 없습니다.",
		icon: "warning", //success, warning, error
		buttons: {
			cancel: {
			    text: "취소",
			    value: false,
			    visible: true,
			    className: "btn btn-secondary"
			  },
			  confirm: {
			    text: "삭제",
			    value: true,
			    className: "btn btn-danger"
			  }
		  },
		closeOnClickOutside: false
	}).then(function(result){
		if(result){
			$.ajax({
			    url: "/projects/deleteFile",
			    contentType:"application/json;charset:utf-8",
			    data:JSON.stringify(data),
			    type:"post",
				beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
			    success: function(res) {
			    	p.remove();
			    }
			});
		}
	});
});
</script>
<script>
var now_utc = Date.now() // 지금 날짜를 밀리초로
//getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
//new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
document.getElementById("taskEndDt").setAttribute("min", today);
//태스크 최대기한일 설정
document.getElementById("taskEndDt").setAttribute("max", $('#pEnd').text());
</script>