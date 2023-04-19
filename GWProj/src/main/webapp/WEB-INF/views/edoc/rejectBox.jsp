<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>


<script type="text/javascript">




$(function(){
	$('.getAtrz').on('click',function(){
		let edocNo = $('.edocNo',this).val();
		console.log("edocNo : "  + edocNo);
		$('#getAT').empty();

		$.ajax({
			url : '/edoc/getAtrz',
			type:'post',
			data: {'edocNo' : edocNo},
			beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(list){
				code ="";
					$.each(list,function(i,v){
						let res ="";
						if(v.ATRZ_YN == 'Y'){
							res = "결재";
						}
						if(v.ATRZ_YN == 'Y' && v.ATRZ_SEQ == 1){
							res = "기안";
						}
						if(v.ATRZ_YN == 'Z'){
							res = "반려";
						}
						if(v.ATRZ_YN ==null){
							res = "-";
						}
 						code+= "<tr class=><td class='align-middle text-center' style='font-size:1.2em;'>"+v.ATRZ_SEQ+"</td>";
						code+= "<td class='align-middle text-center' style='font-size:1.2em;'>"+v.EMP_NM+"</td>";
						code+= "<td class='align-middle text-center' style='font-size:1.2em;'>"+v.JBPS_NM+"</td>";
						code+= "<td class='align-middle text-center' style='font-size:1.2em;'>"+v.DEPT_NM+"</td>";
						code+= "<td class='align-middle text-center' style='font-size:1.2em;'>"+res+"</td>";
						code+= "<td class='align-middle text-center' style='font-size:1.2em;'>"+(v.ATRZ_DT || '-')+"</td></tr>";
					});

					$('#getAT').html(code);
			},
			error : function(xhr){
				alert(xhr.status);
			}
	});
	});
});

</script>



<!--   결재할 문서  -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/edocAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">



			<div class="my-0 py-0 mx-0">
				<h2 class="" style="font-color: black;">반려문서함</h2>
			</div>
			<p class="text-mb mb-2">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
		  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
		  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"></path>
					</svg>
					자신이 기안한 문서 중 반려당한 문서를 조회 할 수 있습니다.
				</p>

			<div class="card">
				<div class="card-header">
					<form action="" method="get" id="searchForm" style="text-align:right; ">
						<input type="hidden" name="page" id="page" />
						<select name="searchType" style="width:100px; height:31px;">
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
									class="text-center text-dark text-md font-weight-bolder ">부서</th>
								<th style="font-size:1.3em;"
									class="text-center text-md font-weight-bolder ">기안일시</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="dataList" value="${pagingVO.dataMapList}" />
							<c:choose>
								<c:when test="${empty dataList}">
									<tr>
										<td class="align-middle text-center" colspan="6">조회하신 문서가 존재하지 않습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach var="edoc" items="${dataList}" >
										<tr class="getAtrz">
											<td class="align-middle text-center " style="font-size:1.2em;" >${edoc.RNUM}</td>
											<td class="align-middle text-center " style="font-size:1.2em;" >결재</a></td>
											<td class="align-middle text-center " style="font-size:1.2em;">
												<a href="" onclick="window.open('/edoc/edocDetail?edocVO.edocNo=${edoc.EDOC_NO}&edocVO.edocFormClsf=${edoc.EDOC_FORM_CLSF}&approve=4','_blank','toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=800, height=1100')">
												${edoc.EDOC_TTL}</a></td>
											<td class="align-middle text-center" style="font-size:1.2em;">${edoc.EMP_NM}</td>
											<td class="align-middle text-center" style="font-size:1.2em;">${edoc.DEPT_NM}</td>
											<td class="align-middle text-center" style="font-size:1.2em;">${edoc.EDOC_DT}</td>
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
			<br />
			<div class="my-0 py-2 mx-0">
				<h3 class="" style="font-color: black;">결재진행상황</h3>
			</div>


			<div class="card">
				<div class="table-responsive">
					<table class='table align-items-center mb-0' id='myTable'>
						<thead><tr>
						<th class='text-center text-dark text-md font-weight-bolder' style="font-size:1.3em;">순번</th>
						<th class='text-center text-dark text-md font-weight-bolder' style="font-size:1.3em;">성명</th>
						<th class='text-center text-dark text-md font-weight-bolder' style="font-size:1.3em;">직위</th>
						<th class='text-center text-dark text-md font-weight-bolder' style="font-size:1.3em;">부서</th>
						<th class='text-center text-dark text-md font-weight-bolder' style="font-size:1.3em;">결재상태</th>
						<th class='text-center text-dark text-md font-weight-bolder' style="font-size:1.3em;">처리일시</th>
						</tr></thead>
						<tbody id="getAT">
									<tr>
										<td class="align-middle text-center" colspan="6" style="font-size:1.2em;">문서를 선택해주세요</td>
									</tr>

					</tbody>
					</table>
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


