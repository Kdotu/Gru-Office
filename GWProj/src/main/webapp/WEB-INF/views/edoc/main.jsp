<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/edocAside.jsp" />
		</div>
		<div class="col-lg-10 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->


<div class="my-0 py-2 mx-0">
	<h3 class="" style="font-color: black;">전자결재함</h3>
</div>



<div class="container">
	<div class="row">
			<div class="col" style="height:20%;">
			<div class="card">
				<div class="card-body m-1 pt-4">
					<a href="/edoc/draftingBox">
					<h3 class="card-title h3 d-block text-darker text-center">
						<img src="/resources/image/edoc.png" width="30px;" />&nbsp기안문서</h3>
					<h3 class="card-description mb-1 text-center">${drafting}건</h3></a>
				</div>
			</div>
		</div>

			<div class="col" style="height:20%;">
			<div class="card">
				<div class="card-body m-1 pt-4">
					<a href="/edoc/approve">
					<h3 class="card-title h3 d-block text-darker text-center">
						<img src="/resources/image/edoc.png" width="30px;" />&nbsp&nbsp결재대기</h3>
					<h3 class="card-description mb-1 text-center">${approve}건</h3></a>
				</div>
			</div>
		</div>

			<div class="col" style="height:20%;">
			<div class="card">
				<div class="card-body m-1 pt-4">
					<a href="/edoc/approved">
					<h3 class="card-title h3 d-block text-darker text-center">
						<img src="/resources/image/edoc.png" width="30px;" />&nbsp결재진행</h3>
					<h3 class="card-description mb-1 text-center">${approved}건</h3></a>
				</div>
			</div>
		</div>

			<div class="col" style="height:20%;">
			<div class="card">
				<div class="card-body m-1 pt-4">
					<a href="/edoc/rejectBox">
					<h3 class="card-title h3 d-block text-darker text-center">
						<img src="/resources/image/edoc.png" width="30px;" />&nbsp결재반려</h3>
					<h3 class="card-description mb-1 text-center">${reject}건</h3></a>
				</div>
			</div>
		</div>

			<div class="col" style="height:20%;">
			<div class="card">
				<div class="card-body m-1 pt-4">
					<a href="/edoc/atrzRfrnc">
					<h3 class="card-title h3 d-block text-darker text-center">
						<img src="/resources/image/edoc.png" width="30px;" />&nbsp참조문서</h3>
					<h3 class="card-description mb-1 text-center">${atrzRfrnc}건</h3></a>
				</div>
			</div>
		</div>
			</div>
</div>

<br />
<div class="my-0 py-2 mx-0">
<div class="row mx-0">
					<div class="col-9">
					<h3 class="" style="font-color: black;">결재할문서</h3>
					</div>
					<div class="col-3" style="text-align:right;">
						<span class="badge bg-gradient-warning"><a href="/edoc/approve">더보기</a></span></p>
					</div>
</div>
</div>


<div class="container">
	<div class="row">
		<c:set var="dataMapList" value="${pagingVO2.dataMapList}" />
		<c:choose>
			<c:when test="${empty dataMapList}">
				<div class="col-12">
				<div class="card" >
				<div class="card-body p-3" style="width:1000px;">
<!-- 					<span -->
					<div class="card-title h4 d-block text-darker col-12" style="text-align:center; ">
						결재할 문서가 없습니다.</div>
				</div>
			</div>
		</div>
			</c:when>
			<c:otherwise>
			<c:forEach var="edoc" items="${dataMapList}">
			<div class="col" style="width:25%; ">
			<div class="card p-2 align-middle text-center" style="height:300px;">
				<div class="card-body pt-2">
					<span
						class="text-gradient text-primary text-uppercase text-md font-weight-bold my-2" style="text-align:center;">진행중</span>
					<p style="height:60px; font-size:23px;" class="titleSize"><a class="titleModal" href="" onclick="window.open('/edoc/edocDetail?edocVO.edocNo=${edoc.EDOC_NO}&edocVO.edocFormClsf=${edoc.EDOC_FORM_CLSF}&approve=1','_blank','toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=1000, height=1500')">
												${edoc.EDOC_TTL}</a></p>
					<p class="card-description mb-4" class="zz">기안자 : ${edoc.EMP_INIT_NO} <br/>
					수신일시 : ${edoc.ATRZ_RECEIPT_DT}
					</p>
					<div class="align-middle text-center">
					<a href=""  class="btn btn-outline-dark btn-lg align-middle text-center"
					onclick="window.open('/edoc/edocDetail?edocVO.edocNo=${edoc.EDOC_NO}&edocVO.edocFormClsf=${edoc.EDOC_FORM_CLSF}&approve=1','_blank','toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=1000, height=1500')">
												결재하기</a>
					</div>
				</div>
			</div>
		</div>

			</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
</div>


<br />
<br />

<div class="my-0 py-2 mx-0">
<div class="row mx-0">
					<div class="col-9">
					<h3 class="" style="font-color: black;">결재진행문서</h3>
					</div>
					<div class="col-3" style="text-align:right;">
						<span class="badge bg-gradient-warning"><a href="/edoc/approved">더보기</a></span>
					</div>
</div>

 <div class="container">
 <div class="card ">
				<div class="table-responsive">
					<table class="table align-items-center mb-0">
						<thead>
							<tr>
								<th
									class="text-center text-dark text-md font-weight-bolder">순번</th>
								<th
									class="text-center text-dark text-md font-weight-bolder">유형</th>
								<th
									class="text-center text-dark text-md font-weight-bolder ">문서제목</th>
								<th
									class="text-center text-dark text-md font-weight-bolder ">기안자</th>
								<th
									class="text-center text-dark text-md font-weight-bolder ">기안부서</th>
								<th
									class="text-center text-dark text-md font-weight-bolder ">결재상태</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="dataList3" value="${pagingVO3.dataMapList}" />
							<c:choose>
								<c:when test="${empty dataList3}">
									<tr>
										<td class="align-middle text-center" colspan="6">조회하신 문서가 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="edoc3" items="${dataList3}" >
										<tr class="getAtrz">
											<td class="align-middle text-center ">${edoc3.RNUM}</td>
											<td class="align-middle text-center ">결재</a></td>
											<td class="align-middle text-center ">
												<a href="" onclick="window.open('/edoc/edocDetail?edocVO.edocNo=${edoc3.EDOC_NO}&edocVO.edocFormClsf=${edoc3.EDOC_FORM_CLSF}&approve=3','_blank','toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=1000, height=1500')">
												${edoc3.EDOC_TTL}</a></td>
											<td class="align-middle text-center">${edoc3.EMP_NM}</td>
											<td class="align-middle text-center">${edoc3.DEPT_NM}</td>
											<td class="align-middle text-center"><span class="badge bg-info">진행중</span></td>
											<input type="hidden" class="edocNo" value="${edoc3.EDOC_NO}"/>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>

					<br />
				</div>
			</div>
		</div>


	</div>
				</div>
			</div>




<script type="text/javascript">
$(document).ready(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");


	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});


	let title = $('.titleModal').text();

	if(title.length<12){
			$('.titleSize').css('font-size','40px;');

	}
});

</script>
