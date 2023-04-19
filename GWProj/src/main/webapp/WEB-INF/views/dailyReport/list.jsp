<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>
<script src="/resources/maincss/assets/js/plugins/flatpickr.min.js"></script>

<style>
.tblHeight{
	height : 50px;
}
</style>

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/dailyReportAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->

			<div class="container-fluid py-4 pt-0">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-header pb-0">
								<div class="d-lg-flex">
									<div>
										<h3 class="mb-0 font-weight-bolder"> <c:if test="${list_type eq '부서별'}">부서별</c:if>일일업무보고 목록   ${deptNm}</h3>
										<p class=" mb-0">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
											  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
											  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
											</svg>
											이전에 작성한 일일업무보고 현황 목록을 확인할 수 있습니다.
										</p>
									</div>
								</div>
							</div>
							<div class="card-body px-0 pb-0">
								<div class="table-responsive mx-2">
									<div
										class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
										<div class="dataTable-top pt-0">
<!-- 											<div class="dataTable-dropdown"> -->
<!-- 												<label><select class="dataTable-selector"> -->
<!-- 														<option value="10" selected>10</option> -->
<!-- 														<option value="15">15</option> -->
<!-- 														<option value="20">20</option> -->
<!-- 														<option value="25">25</option></select> entries per page</label> -->
<!-- 											</div> -->
											<div class="dataTable-search w-40">
											<c:choose>
												<c:when test="${list_type eq '부서별'}">
												<div class="deptList row mb-3">
													<c:forEach var="deptVO" items="${deptList}" varStatus="stat">
													<div class="deptOne col-sm">
														<input type="button" value="${deptVO.DEPT_NM}"  onclick="fn_deptList()"/>
														<input type="hidden" value="${deptVO.DEPT_NO}" class="deptNoInput" />
													</div>
													</c:forEach>
												</div>
												</c:when>
											</c:choose>
											<form id="searchFrm" action="/dailyReport/<c:if test="${list_type eq '부서별'}">dept</c:if>list" method="get">
												<input type="hidden" name="deptNo" id="deptNo" />
												<input type="submit" class="btn btn-outline-dark py-1 px-3" name="search" id="search" value="검색" style="float:right; margin-left:10px; height:40px;">
												<label for="search" style=" font-size:1.3em;">검색기간</label>
												<div id="search" style="float:right;">
													<input class="form-control datepicker" placeholder="검색할 보고 기간을 선택..." value="<c:choose><c:when test="${not empty dateArr1}">${dateInfo}</c:when></c:choose>" id="dateInfo" type="text" onfocus="focused(this)" onfocusout="defocused(this)">
													<input type="hidden" name="dateArr1" id="dateArr1" />
													<input type="hidden" name="dateArr2" id="dateArr2" />
												</div>
												<sec:csrfInput />
											</form>
											</div>
										</div>
										<div class="dataTable-container">
											<table class="table table-flush dataTable-table" id="products-list">
												<thead class="thead-light">
													<tr>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">순번</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고회차</th>
															<c:choose>
																<c:when test="${list_type eq '부서별'}">
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고자</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">부서</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">직책</th>
																</c:when>
															</c:choose>
														<th class="text-uppercase text-center text-secondary font-weight-bolder ps-2 tblHeight" style="font-size : 1.3em;">작성일시</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고여부</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">확인여부</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고확인 담당자</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고확인 일시</th>
														<th class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.3em;">보고조회</th>
													</tr>
												</thead>
												<tbody>
													<c:choose>
													<c:when test="${empty data.content}">
														<tr><td class="text-center" colspan='11'>검색된 결과가 없습니다.</td></tr>
													</c:when>
													<c:otherwise>
													<c:forEach var="dailyReportVO" items="${data.content}" varStatus="stat">
														<tr>
															<td class="text-uppercase text-secondary text-center font-weight-bolder tblHeight" style="font-size : 1.2em;">
																${stat.count}
															</td>
															<td class="text-uppercase text-secondary text-center font-weight-bolder ps-2 tblHeight" style="font-size : 1.2em;">
																<fmt:formatDate pattern="yyyy-MM-dd" value="${dailyReportVO.dates}" />
															</td>
															<c:choose>
																<c:when test="${list_type eq '부서별'}">
															<td class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.2em;">${dailyReportVO.empNm}</td>
															<td class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.2em;">${dailyReportVO.deptNm}</td>
															<td class="text-uppercase text-center text-secondary font-weight-bolder tblHeight" style="font-size : 1.2em;">${dailyReportVO.jbpsNm}</td>
																</c:when>
															</c:choose>

															<td class="text-uppercase text-secondary text-center  font-weight-bolder ps-2 tblHeight" style="font-size : 1.2em;">
																<fmt:formatDate pattern="HH:mm:ss" value="${dailyReportVO.rptpWrtYmd}"/>
															</td>
															<td class="text-center text-uppercase text-secondary text-center  font-weight-bolder tblHeight" style="font-size : 1.2em;">
																<c:choose>
																	<c:when test="${not empty dailyReportVO.rptpWrtYmd}">보고</c:when>
																	<c:otherwise>미보고</c:otherwise>
																</c:choose>
															</td>
															<td class="text-center text-uppercase text-secondary  font-weight-bolder" style="font-size : 1.2em;">
															<c:if test="${not empty dailyReportVO.rptpWrtYmd}">
																<c:choose>
																	<c:when test="${not empty dailyReportVO.rptpCmptnPicNm}"><span class="badge badge-info">확인</span></c:when>
																	<c:otherwise><span class="badge badge-warning">미확인</span></c:otherwise>
																</c:choose>
															</c:if>
															</td>
															<td class="text-center text-uppercase text-secondary  font-weight-bolder">
																${dailyReportVO.rptpCmptnPicNm}
															</td>
															<td class="text-center text-uppercase text-secondary  font-weight-bolder">
																<fmt:formatDate pattern="HH:mm:ss" value="${dailyReportVO.rptpCmptnDt}"/>
															</td>
															<td class="text-uppercase text-secondary  text-center font-weight-bolder">
																<c:choose>
																	<c:when test="${not empty dailyReportVO.rptpNo}">
																	<a href="/dailyReport/detail?rptpNo=${dailyReportVO.rptpNo}" class="btn btn-outline-dark mb-0 py-auto pt-1 p-3" style="height:25px;">조회</a>
																	</c:when>
																	<c:otherwise>
																		-
																	</c:otherwise>
																</c:choose>
															</td>
														</tr>
													</c:forEach>
													</c:otherwise>
													</c:choose>
												</tbody>
											</table>
										</div>
									<!-- 페이징 시작 -->
										<div class="dataTable-bottom  col-sm-12 col-md-7">
										<div class="dataTable-info"> </div>
											<div class="dataTable-pagination">
												<nav class="dataTable-pagination">
												<ul class="dataTable-pagination-list">
													<li class="paginate_button page-item previous
														<c:if test='${data.startPage lt 6}'> disabled</c:if>
														" id="dataTable_previous">
														 <a href="/dailyReport/<c:if test="${list_type eq '부서별'}">dept</c:if>list?currentPage=${data.startPage-5}&keyword=${param.keyword}&searchType=${param.searchType}"
														aria-controls="dataTable" data-dt-idx="0" tabindex="0"
														class="page-link">‹</a></li>

													<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
													<li class="paginate_button page-item
															<c:if test='${param.currentPage==pNo}'>active</c:if>
															">
													<a href="/dailyReport/<c:if test="${list_type eq '부서별'}">dept</c:if>list?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}"
														aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${pNo}</a></li>
													</c:forEach>

													<li class="paginate_button page-item next
														<c:if test='${data.endPage ge data.totalPages}'>disabled</c:if>
													" id="dataTable_next">
													<a href="/dailyReport/<c:if test="${list_type eq '부서별'}">dept</c:if>list?currentPage=${data.startPage+5}&keyword=${param.keyword}&searchType=${param.searchType}"
														aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">›</a></li>
												</ul>
												</nav>
											</div>
										</div>
									<!-- 페이징 끝 -->
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
function fn_deptList(){
	var deptNoInput = event.target.parentNode.querySelector('.deptNoInput');
    var deptNo = deptNoInput.value;
	console.log("deptNo : " + deptNo);
	let inputDept = document.querySelector("#deptNo");
	inputDept.value = deptNo;

	document.querySelector("#searchFrm").submit();
}



$("#searchFrm").on("change",function(){
	let dateInfo = $("#dateInfo").val();
	dateArr = dateInfo.split("to");
	console.log(dateArr);

	let dateArrOne = dateArr[0].replace(/ /g,"").replaceAll("-","");
	let dateArrTwo = dateArr[1].replace(/ /g,"").replaceAll("-","");
	console.log("dateArrOne : " + dateArrOne);
	console.log("dateArrTwo : " + dateArrTwo);

	$("#dateArr1").val(dateArrOne);
	$("#dateArr2").val(dateArrTwo);

});
</script>

<script>
    const dataTableSearch = new simpleDatatables.DataTable("#datatable-search", {
      searchable: true,
      fixedHeight: false,
      perPageSelect: false
    });

    document.querySelectorAll(".export").forEach(function(el) {
      el.addEventListener("click", function(e) {
        var type = el.dataset.type;

        var data = {
          type: type,
          filename: "soft-ui-" + type,
        };

        if (type === "csv") {
          data.columnDelimiter = "|";
        }

        dataTableSearch.export(data);
      });
    });
  </script>
<script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
<!-- date Picker 시작 -->
<script>
if (document.querySelector('.datepicker')) {
  flatpickr('.datepicker', {
    mode: "range"
  });
}
</script>
<!-- date Picker 끝 -->


