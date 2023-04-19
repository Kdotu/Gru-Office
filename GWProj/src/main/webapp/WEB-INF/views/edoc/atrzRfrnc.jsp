<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/edocAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">

<div class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-header pb-0">
				<div class="">

				<div class="row mx-0">
					<div class="col-4">
					<h2 class="" style="font-color: black;">참조문서함</h2>

								<p class="text-mb mb-2">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
		  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
		  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"></path>
					</svg>
					자신이 참조된 문서를 조회 할 수 있습니다.
				</p>
					</div>
					<div class="col-8" style="text-align:right;">
											<form action="" method="get" id="searchForm" ">
						<input type="hidden" name="page" id="page" /> <select
							name="searchType" style="width:100px; height:31px;">
							<option value="edocTtl"
								<c:if test="${searchType == 'edocTtl' }">
				<c:out value="selected"/></c:if>>
								문서제목</option>
							<option value="empNm"
								<c:if test="${searchType == 'empNm' }">
				<c:out value="selected"/></c:if>>
								기안자</option>
						</select> <input type="text" name="searchWord" value="${searchWord}">
						<input type="submit" class="btn btn-outline-dark btn-xxs m-0 align-middle text-center" style="height:37px;"
							value="검색">
					</form>
					</div>
</div>

				</div>
			</div>


			<div class="table-responsive">
					<table class="table align-items-center mb-0">
						<thead>
							<tr>
								<th style="font-size:1.3em;"
									class="text-center text-dark text-md font-weight-bolder">순번</th>
								<th style="font-size:1.3em;"
									class="text-center text-dark text-md font-weight-bolder">유형</th>
								<th style="font-size:1.3em;"
									class="text-center text-dark text-md font-weight-bolder ">문서제목</th>
								<th style="font-size:1.3em;"
									class="text-center text-dark text-md font-weight-bolder ">기안자</th>
								<th style="font-size:1.3em;"
									class="text-center text-dark text-md font-weight-bolder ">기안부서</th>
								<th style="font-size:1.3em;"
									class="text-center text-md font-weight-bolder ">수신일시</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="dataList" value="${pagingVO.dataMapList}" />
							<c:choose>
								<c:when test="${empty dataList}">
									<tr>
										<td class="align-middle text-center" colspan="6" style="font-size:1.2em;">조회하신 문서가 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="edoc" items="${dataList}" >
										<tr class="getAtrz">
											<td class="align-middle text-center " style="font-size:1.2em;">${edoc.RNUM}</td>
											<td class="align-middle text-center " style="font-size:1.2em;">참조</a></td>
											<td class="align-middle text-center " style="font-size:1.2em;">
												<a href="" onclick="window.open('/edoc/edocDetail?edocVO.edocNo=${edoc.EDOC_NO}&edocVO.edocFormClsf=${edoc.EDOC_FORM_CLSF}&approve=2','_blank','toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=800, height=1100')">
												${edoc.EDOC_TTL}</a></td>
											<td class="align-middle text-center" style="font-size:1.2em;">${edoc.EMP_NM}</td>
											<td class="align-middle text-center" style="font-size:1.2em;">${edoc.DEPT_NM}</td>
											<td class="align-middle text-center" style="font-size:1.2em;">${edoc.ATRZ_RFRNC_RCPTN_DT}</td>
											<input type="hidden" class="edocNo" value="${edoc.EDOC_NO}"/>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>

					<br />
						<div id="pagingArea">
							${pagingVO.pagingHTML}
						</div>
				</div>
		</div>
	</div>
</div>


</div>
</div>

<script type="text/javascript">
$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");

	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});

</script>
