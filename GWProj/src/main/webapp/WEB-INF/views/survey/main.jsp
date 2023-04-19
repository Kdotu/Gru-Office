<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<style>
 .card-border{
	border : 1px solid gray;
 }
</style>


<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->


<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/surveyAside.jsp" />
		</div>
		<div class="col-lg-10 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->
			<div class="row">
				<div class="col card">
					<div class="card-body pt-2">
						<span class="text-gradient text-dark text-uppercase text-xs font-weight-bold my-2">Survey</span>
						<a href="javascript:;" class="card-title h5 d-block text-darker">
							<h3>설문조사</h3>
						</a>
						<p class="card-description mb-4">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
							  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
							</svg>
							등록한 설문조사에 대한 정보를 간략히 확인할 수 있습니다.
						</p>
						<div class="container">
							<div class="row">
								<div class="row col-3 p-3">

									<div class="card card-border mb-2">
										<div class="card-body p-1 mx-3" style="padding-left:10px;">
											<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2">Enroll</span>
											<a href="javascript:;" class="card-title h4 d-block text-darker"> 등록한 설문조사 </a>
											<p class="card-description h4 mt-3 opacity-7" style="text-align:right;">${statusSrvyCnt.enrollCnt}건</p>
											<div class="author align-items-center"></div>
										</div>
									</div>

									<div class="card card-border mt-2">

										<div class="card-body p-1 mx-3" style="padding-left:10px;">
											<span class="text-gradient text-warning text-uppercase text-xs font-weight-bold my-2">Hold　　　</span>
											<a href="javascript:;" class="card-title h4 d-block text-darker"> 보류처리된 설문조사 </a>
											<p class="card-description h4 mt-3 opacity-7" style="text-align:right;">${statusSrvyCnt.holdCnt}건</p>
											<div class="author align-items-center"></div>
										</div>
									</div>

								</div>

								<div class="row col-3 p-3">
										<div class="card card-border mb-2">
											<div class="card-body p-1 mx-3" style="padding-left:10px;">
											<span class="text-gradient text-success text-uppercase text-xs font-weight-bold my-2">Progress</span>
												<a href="javascript:;" class="card-title h4 d-block text-darker"> 진행중인 설문조사 </a>
												<p class="card-description h4 mt-3 opacity-7" style="text-align:right;">${statusSrvyCnt.progressCnt}건</p>
												<div class="author align-items-center"></div>
											</div>
										</div>

										<div class="card card-border mt-2" >
											<div class="card-body p-1 mx-3" style="padding-left:10px;">
												<span class="text-gradient text-dark text-uppercase text-xs font-weight-bold my-2">Complete</span>
												<a href="javascript:;" class="card-title h4 d-block text-darker"> 마감된 설문조사 </a>
												<p class="card-description h4 mt-3 opacity-7" style="text-align:right;">${statusSrvyCnt.endCnt}건</p>
												<div class="author align-items-center"></div>
											</div>
										</div>
								</div>
								<div class="col p-3">
									<div class="card card-border">
										<div class="card-header pb-0 p-3">
											<div class="">
												<span class="text-gradient text-warning text-uppercase text-xs font-weight-bold my-2">Comment</span>
												<h5 class="card-title h5 d-block text-darker">진행중인 설문에 달린 댓글</h5>
											</div>
										</div>
										<div class="table-responsive mx-auto">
											<table class="table align-items-center">
												<colgroup>
													<col width="1">
													<col width="20">
													<col width="20">
													<col width="130">
													<col width="20">
												</colgroup>
												<tbody>
													<c:forEach var="cmntVO" items="${recentCmntList}" varStatus="stat">
													<tr onclick="location.href='/survey/detail?srvyNo=${cmntVO.srvyNo}'">
														<td><i class="ni ni-chat-round"></i></td>
														<td>
															<div>
																<p class="text-xs font-weight-bold mb-0">${cmntVO.cmntClsf}</p>
																<h6 class="text-sm mb-0">${cmntVO.srvyTtl}</h6>
															</div>
														</td>
														<td>
															<div class="text-center">
														<sec:authorize access="isAuthenticated()">
															<sec:authentication property="principal.empVO" var="empVO" />
															<a href="javascript:;" class="" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="${cmntVO.empDeptNm} ${cmntVO.empTitle}" data-bs-original-title="${cmntVO.empDeptNm} ${cmntVO.empTitle}">
																 <img src="/resources/upload${cmntVO.cmntProfile}" class="avatar avatar-sm rounded-circle img" alt="${cmntVO.cmntProfile}">
															</a>
																</sec:authorize>
															</div>
														</td>
														<td>
															<div class="text-center">
																<p class="text-xs font-weight-bold mb-0">댓글내용</p>
																<h6 class="text-sm mb-0">
																${fn:substring(cmntVO.cmntCn,0,15)}
																				<c:if test="${fn:length(cmntVO.cmntCn) > 15}">...</c:if></h6>
															</div>
														</td>
														<td class="align-middle text-sm">
															<div class="col text-center">
																<p class="text-xs font-weight-bold mb-0">댓글등록일자</p>
																<h6 class="text-sm mb-0">${cmntVO.cmntRegYmd}</h6>
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
						</div>
						<div class="mt-5">
							<h3 class="" style="font-color: black;">진행중인 설문조사</h3>
							<p class="" style="font-color: black;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
								  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								진행중인 설문조사 중 설문대상인 설문을 보여줍니다.
							</p>
						</div>
						<div class="container">
							<div class="row">
							<c:choose>
								<c:when test="${empty SrvyTrprList}">
									<div class="col">
										<div class="card p-2">
											<div class="mx-auto m-2">대상자로 등록된 설문조사가 없습니다.</div>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach var="srvyTrprVO" items="${SrvyTrprList}" varStatus="stat">
										<div class="col-4">
											<div class="card card-border">
												<div class="card-body pt-2">
													<c:choose>
														<c:when test="${srvyTrprVO.srvySsts eq 'SRVY0001'}"><span class="text-gradient text-success text-uppercase text-xs font-weight-bold my-2" style="text-align: center;">진행중</span></c:when>
														<c:when test="${srvyTrprVO.srvySsts eq 'SRVY0002'}"><span class="text-gradient text-warning text-uppercase text-xs font-weight-bold my-2" style="text-align: center;">보류</span></c:when>
														<c:otherwise><span class="text-gradient text-dark text-uppercase text-xs font-weight-bold my-2" style="text-align: center;">마감</span></c:otherwise>
													</c:choose>

													<a href="javascript:;" class="card-title h4 d-block text-darker text-center">
														${fn:substring(srvyTrprVO.srvyTtl,0,15)}
															<c:if test="${fn:length(srvyTrprVO.srvyTtl) > 15}">...</c:if>
													</a>
													<span class="mx-auto row text-sm my-1"><span class="badge badge-secondary col col-3">등록자</span><span class="col col-5">${srvyTrprVO.empTitle}</span></span>
													<span class="mx-auto row text-sm my-1"><span class="badge badge-secondary col col-3">등록일시</span><span class="col"><fmt:formatDate pattern="yyyy-MM-dd" value="${srvyTrprVO.srvyRegYmd}" /></span></span>
													<span class="mx-auto row text-sm my-1"><span class="badge badge-secondary col col-3 my-auto">조사기간</span><span class="col"><fmt:formatDate pattern="yyyy-MM-dd" value="${srvyTrprVO.srvyBgngYmd}" /> ~ <fmt:formatDate pattern="yyyy-MM-dd" value="${srvyTrprVO.srvyEndYmd}" /></span></span>
													<span class="mx-auto row text-sm my-1"><span class="badge badge-secondary col col-3">답변여부</span><span class="col col-5">
														<c:choose><c:when test="${srvyTrprVO.srvyRspnsCnt gt 0}">응답</c:when><c:otherwise>미응답</c:otherwise></c:choose></span>
													</span>
													<div class="mt-3 text-center">
														<a href="/survey/detail?srvyNo=${srvyTrprVO.srvyNo}" class="btn btn-outline-dark btn-lg">설문참여</a>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							</div>
						</div>
						<div class="mt-5">
							<h3 class="" style="font-color: black;">등록한 설문조사 현황</h3>
							<p class="" style="font-color: black;">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
								  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								최근에 등록한 설문조사의 현황을 확인할 수 있습니다.
							</p>
						</div>
						<div class="container">
							<div class="row">
							<c:choose>
								<c:when test="${empty SrvyEnrollList}">
									<div class="col">
										<div class="card card-border p-2">
											<div class="mx-auto m-2">등록한 설문조사가 없습니다.</div>
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach var="srvyEnrollVO" items="${SrvyEnrollList}" varStatus="stat">
										<div class="col-4">
											<div class="card card-border">
												<div class="card-body pt-2">
													<c:choose>
														<c:when test="${srvyEnrollVO.srvySsts eq 'SRVY0001'}"><span class="text-gradient text-success text-uppercase text-xs font-weight-bold my-2" style="text-align: center;">진행중</span></c:when>
														<c:when test="${srvyEnrollVO.srvySsts eq 'SRVY0002'}"><span class="text-gradient text-warning text-uppercase text-xs font-weight-bold my-2" style="text-align: center;">보류</span></c:when>
														<c:otherwise><span class="text-gradient text-dark text-uppercase text-xs font-weight-bold my-2" style="text-align: center;">마감</span></c:otherwise>
													</c:choose>

													<a href="javascript:;" class="card-title h4 d-block text-darker text-center">
														${fn:substring(srvyEnrollVO.srvyTtl,0,15)}
															<c:if test="${fn:length(srvyEnrollVO.srvyTtl) > 15}">...</c:if>
													</a>
													<span class="mx-auto row text-sm my-1"><span class="badge badge-secondary col col-3">등록자</span><span class="col col-5">${srvyEnrollVO.empTitle}</span></span>
													<span class="mx-auto row text-sm my-1"><span class="badge badge-secondary col col-3">등록일시</span><span class="col"><fmt:formatDate pattern="yyyy-MM-dd" value="${srvyEnrollVO.srvyRegYmd}" /></span></span>
													<span class="mx-auto row text-sm my-1"><span class="badge badge-secondary col col-3 my-auto">조사기간</span><span class="col"><fmt:formatDate pattern="yyyy-MM-dd" value="${srvyEnrollVO.srvyBgngYmd}" /> ~ <fmt:formatDate pattern="yyyy-MM-dd" value="${srvyEnrollVO.srvyEndYmd}" /></span></span>
													<div class="mt-3 text-center">
														<a href="/survey/detail?srvyNo=${srvyEnrollVO.srvyNo}" class="btn btn-outline-dark btn-lg">설문상세</a>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:otherwise>
							</c:choose>
							</div>
						</div>
						<br /> <br />
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
console.log("${resMsg}");
if("${resMsg}" == "Success"){
	let Toast = Swal.mixin({
		toast:true,
		position:'middle-middle',
		showConfirmButton:false,
		timer:3000
	});
	Toast.fire({
		icon:'success',
		title:'설문등록 완료!'
	});
}
</script>

