<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<style>
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
 .card-border{
	border : 1px solid gray;
 }

pre{
	font-family: 'Dovemayo_gothic';
	font-size : 1.3em;
}

</style>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.empVO" var="empVO" />
	<div class="container-fluid my-3 py-3 mx-0 px-0">
		<div class="row mb-5">
			<div class="col-lg-2">
				<jsp:include page="/WEB-INF/views/aside/dailyReportAside.jsp" />
			</div>
			<div class="col-lg-10 mt-lg-0 mt-4 mb-4">
				<div class="card p-4 pt-4">
				<h3 class="mb-1 font-weight-bolder">일일업무보고</h3>
					<p class="text mb-0">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
			  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
			  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
						</svg>
						일일 업무보고에 관한 정보를 간략히 확인할 수 있습니다.
					</p>
				<p class="font-weight-bold "></p>
				<div class="row">
					<div class="col-5">
						<div class="h-100 my-auto">
							<div class="card card-border h-100">
								<div class="card-body pt-0 p-3 text-center">
									<table class="mb-1 mt-1 w-100">
										<tr>
											<td><h4 class="mb-0" style="width: 150px; text-align: left;"><fmt:formatDate pattern="yyyy" value="${today}" /></h4></td>
											<td></td>
											<td><span class="h4" style="width: 150px; text-align: right;"><fmt:formatDate pattern="MM" value="${today}" />월 ${thisWeek}주차</span></td>
										</tr> <br />
									</table>
									<p class="mb-0 ">오늘은</p>
									<h3 class="mb-0"><fmt:formatDate pattern="MM/dd (E)" value="${today}" /></h3>
									<br />
										<table class="w-100">
											<tr>
												<td><span class="text-lg">일일보고상태</span></td>
												<td><span class="badge
												<c:choose>
													<c:when test='${not empty todayVO}'> bg-gradient-success">보고</c:when>
													<c:otherwise>bg-gradient-warning">미보고</c:otherwise>
												</c:choose>
												</span></td>
											</tr>
											<tr>
												<td><span class="text-lg">전일보고상태</span></td>
												<td><span class="badge
													<c:choose>
														<c:when test='${not empty yesterDayVO.rptpTaskGoal}'> bg-gradient-success">보고</c:when>
														<c:otherwise>bg-gradient-warning">미보고</c:otherwise>
													</c:choose>
													</span>
												</td>
											</tr>
										</table>
									<hr class="horizontal dark my-3">
									<c:choose>
										<c:when test='${not empty todayVO}'><a href="/dailyReport/detail?rptpNo=${todayVO.rptpNo}" class="btn btn-lg btn-outline-info">보고 조회</a></c:when>
										<c:otherwise><a href="/dailyReport/create" class="btn btn-lg btn-outline-info">보고하기</a></c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
					<div class="col h-100">
						<div class="card card-border  card-body mt-0 mb-3">
							<div class="col-xl mt-lg-0 mt-4 w-100">
								<div class="h-100"></div>
								<h5 class="mb-0">전일 업무 목표</h5>
								<pre class="mt-1 mb-3 mx-3">${yesterDayVO.rptpTaskGoal}</pre>
							</div>
						</div>
						<div class="card card-border card-body mt-0 mb-3"
							style='border: 1px gray sold;'>
							<div class="col-xl mt-lg-0 mt-4 w-100">
								<div class="h-100"></div>
								<h5 class="mb-0">금일 업무 목표</h5>
								<pre class="mt-1 mb-3 mx-3">${todayVO.rptpTaskGoal}</pre>
							</div>
						</div>
						<div class="card card-border card-body mt-0 mb-0"
							style='border: 1px gray sold;'>
							<div class="col-xl mt-lg-0 mt-4 w-100">
								<div class="h-100"></div>
								<h5 class="mb-0">익일 예정 업무</h5>
								<pre class="mt-1 mb-3 mx-3">${todayVO.rptpPrnmntTask}</pre>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<h3 class="mb-0 mt-5 font-weight-bolder">이전보고 현황</h3>
						<p class="text mb-2 pb-1">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
	 							<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
	 							<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
							</svg>
								이전 일일업무보고 현황을 일주일 단위로 확인할 수 있습니다.
						</p>
					</div>
					<div class="col">
						<div class="mt-5" style="float:right;">
						<a type="button" class="btn btn-info btn-sm mb-0 mt-4 h5" href="/dailyReport/list" style="float: right; margin-top: 10px;"><i class="ni ni-bold-right m-1"></i> 전체 보고 현황 목록으로</a>
						</div>
					</div>
				</div>
				<div class="card card-border card-body mt-1 mb-4" style="clear:both;">
					<div class="table-responsive">
						<table class="table table-flush dataTable-table" id="products-list">
							<thead class="thead-light">
								<tr>
									<th class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.3em;">순번</th>
									<th class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.3em;">보고회차</th>
										<c:choose>
											<c:when test="${param.type eq 'dept'}">
									<th class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.3em;">보고자</th>
									<th class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.3em;">직책</th>
											</c:when>
										</c:choose>
									<th class="text-uppercase text-center text-secondary  font-weight-bolder ps-2 tblHeight"  style="font-size : 1.3em;">작성일시</th>
									<th class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.3em;">보고여부</th>
									<th class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.3em;">확인여부</th>
									<th class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.3em;">보고확인 담당자</th>
									<th class="text-uppercase text-center text-secondary  font-weight-bolder tblHeight" style="font-size : 1.3em;">보고조회</th>
								</tr>
							</thead>
							<tbody>
							<tbody>
								<c:forEach var="dailyReportVO" items="${dailyReportVOAllList}" varStatus="stat">
									<tr>
										<th class="text-uppercase text-secondary  text-center font-weight-bolder tblHeight" style="font-size : 1.2em;">
											${stat.count}
										</th>
										<th class="text-uppercase text-secondary  text-center font-weight-bolder ps-2 tblHeight" style="font-size : 1.2em;">
											<fmt:formatDate pattern="yyyy-MM-dd" value="${dailyReportVO.dates}" />
										</th>
										<th class="text-uppercase text-secondary text-center  font-weight-bolder ps-2 tblHeight" style="font-size : 1.2em;">
											<fmt:formatDate pattern="HH:mm:ss" value="${dailyReportVO.rptpWrtYmd}"/>
										</th>
										<th class="text-center text-uppercase text-secondary text-center  font-weight-bolder tblHeight" style="font-size : 1.2em;">
											<c:choose>
												<c:when test="${not empty dailyReportVO.rptpNo}">보고</c:when>
												<c:otherwise>미보고</c:otherwise>
											</c:choose>
										</th>
										<th class="text-center text-uppercase text-secondary  font-weight-bolder" style="font-size : 1.2em;">
											<c:choose>
												<c:when test="${dailyReportVO.rptpCmptnYn eq 'Y'}">보고완료 </c:when>
												<c:otherwise>미확인</c:otherwise>
											</c:choose>
										</th>
										<th class="text-uppercase text-secondary  text-center font-weight-bolder tblHeight" style="font-size : 1.2em;">
											${dailyReportVO.rptpCmptnPicNm}
										</th>
										<th class="text-uppercase text-secondary  text-center font-weight-bolder" style="font-size : 1.2em;">
											<c:choose>
												<c:when test="${not empty dailyReportVO.rptpNo}">
												<a href="/dailyReport/detail?rptpNo=${dailyReportVO.rptpNo}" class="btn btn-outline-dark mb-0 py-auto pt-1 p-3" style="height:25px;">조회</a>
												</c:when>
												<c:otherwise>
													-
												</c:otherwise>
											</c:choose>
										</th>
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
</sec:authorize>
		<script
			src="/resources/maincss/assets/js/plugins/chartjs.min.js"></script>