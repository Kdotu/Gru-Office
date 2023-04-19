<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="/resources/maincss/assets/js/plugins/flatpickr.min.js"></script>
<script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<style>
.tblHeight{
	height : 50px;
}
</style>

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid mx-0 px-0">
	<div class="mb-5">
		<div class="card col-11 mb-0">
			<div class="card-body pt-2 pb-0">
				<br>
				<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2 Heads">Reserve List</span>
				<h3 class="card-title d-block text-darker Heads" >설문조사 관리</h3>
						<p class="explains Heads">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
								  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
								  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
								  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
							</svg>
							등록된 설문조사와 설문조사 등록 시 사용할 해시태그를 관리할 수 있습니다.
						</p>
				<a class="btn bg-gradient-info text-lg" href="/admin/srvyManage">해시태그 관리</a>
				<a class="btn bg-gradient-info text-lg" href="/admin/srvyList">설문조사 관리</a>
					<div>
					</div>
			</div>
		</div>
		<div class="col-11 mt-4">
		<div class="m-3 pt-3">
			<h4 class="mb-0">전체 설문관리</h4>
			<p class="text-lg mb-0">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
				  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
				  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
				</svg>
				관리자페이지에서는 전체 설문조사의 목록을 조회할 수 있습니다.
			</p>
		</div>
			<div class="card pt-2 pb-5 my-3">
				<div class="" style="clear:both;">
					<div class="table-responsive mx-2">
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top row">
								<div class="row text-center mb-3 col-6">
									<div class="col-3 px-0">
										<input type="button" class="btn btn-outline-secondary w-80 text-lg" onclick="location.href=<c:choose><c:when test='${not empty authority}'>'/admin/srvyList?</c:when><c:otherwise>'/survey/list?</c:otherwise></c:choose>'" value="전체" />
									</div>
									<div class="col-3 px-0">
										<input type="button" class="btn btn-info w-80 text-lg" onclick="location.href=<c:choose><c:when test='${not empty authority}'>'/admin/srvyList?</c:when><c:otherwise>'/survey/list?</c:otherwise></c:choose>status=progress'" value="진행" />
									</div>
									<div class="col-3 px-0">
										<input type="button" class="btn btn-warning w-80 text-lg" onclick="location.href=<c:choose><c:when test='${not empty authority}'>'/admin/srvyList?</c:when><c:otherwise>'/survey/list?</c:otherwise></c:choose>status=hold'" value="보류" />
									</div>
									<div class="col-3 px-0">
										<input type="button" class="btn btn-secondary w-80 text-lg" onclick="location.href=<c:choose><c:when test='${not empty authority}'>'/admin/srvyList?</c:when><c:otherwise>'/survey/list?</c:otherwise></c:choose>status=end'" value="마감" />
									</div>
								</div>
								<div class="col-2">
								</div>
								<div class="dataTable-search w-35 col-4">
									<form id="searchFrm" action="/survey/list" method="get">
										<input type="submit" class="btn btn-outline-dark py-1 px-3" name="search" id="search" value="검색" style="float:right; margin-left:10px; height:40px;">
										<label for="search" class="h6">검색기간</label>
										<div id="search" style="float:right;">
											<input class="form-control datepicker" placeholder="설문의 시작일자 기간선택..." value="<c:choose><c:when test="${not empty dateArr1}">${dateInfo}</c:when></c:choose>" id="dateInfo" type="text" onfocus="focused(this)" onfocusout="defocused(this)">
											<input type="hidden" name="dateArr1" id="dateArr1" />
											<input type="hidden" name="dateArr2" id="dateArr2" />
										</div>
										<sec:csrfInput />
									</form>
								</div>
							</div>

							<div class="dataTable-container " id="updateSpace">
								<table class="table table-flush dataTable-table" id="products-list">
									<thead class="thead-light">
										<tr>
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder tblHeight">
												<a href="#" class="dataTable-sorter">진행상태</a>
											</th>
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder tblHeight">
												<a href="#" class="dataTable-sorter">설문번호</a>
											</th>
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder tblHeight">
												<a href="#" class="dataTable-sorter">제목</a>
											</th>
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder tblHeight">
												<a href="#" class="dataTable-sorter">설문기간</a>
											</th>
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder tblHeight">
												<a href="#" class="dataTable-sorter">설문작성자</a>
											</th>
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder tblHeight">
												<a href="#" class="dataTable-sorter">설문진행도</a>
											</th>
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder tblHeight">
												<a href="#" class="dataTable-sorter">참여자수</a>
											</th>
											<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder tblHeight">
												<a href="#" class="dataTable-sorter">Action</a>
											</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${empty data.content}">
												<tr><td class="text-center" colspan='11'>검색된 결과가 없습니다.</td></tr>
											</c:when>
											<c:otherwise>
												<c:forEach var="srvyVO" items="${data.content}" varStatus="stat">
													<tr onclick="location.href=<c:choose><c:when test='${not empty authority}'>'/admin/srvyDetail?</c:when><c:otherwise>'/survey/detail?</c:otherwise></c:choose>srvyNo=${srvyVO.srvyNo}'" class="findRow">
														<td class="text-center text-uppercase text-secondary text-lg font-weight-bolder">
															<c:if test="${srvyVO.srvySsts eq 'SRVY0001'}"><span class="srvySsts badge badge-success">진행중</span></c:if>
															<c:if test="${srvyVO.srvySsts eq 'SRVY0002'}"><span class="srvySsts badge badge-warning">보류</span></c:if>
															<c:if test="${srvyVO.srvySsts eq 'SRVY0003'}"><span class="srvySsts badge badge-secondary">마감</span></c:if>
														</td>
														<td class="text-center text-uppercase text-secondary text-xs font-weight-bolder srvyNo">${srvyVO.srvyNo}</td>
														<td class="text-center text-uppercase text-secondary text-lg font-weight-bolder">${fn:substring(srvyVO.srvyTtl,0,15)}<c:if test="${fn:length(srvyVO.srvyTtl) > 15}">...</c:if></td>
														<td class="text-center text-uppercase text-secondary text-lg font-weight-bolder srvyPeriod">
															<p class="text-xs my-0 srvyBgngYmd"><fmt:formatDate pattern="yyyy-MM-dd" value="${srvyVO.srvyBgngYmd}" /></p>
															<p class="text-xs my-0 srvyEndYmd"><fmt:formatDate pattern="yyyy-MM-dd" value="${srvyVO.srvyEndYmd}" /></p>
														</td>
														<td class="text-center text-uppercase text-secondary text-lg font-weight-bolder">
														<label class="form-label mb-0">${srvyVO.deptNm}</label>
														<div id="srvyEnroller">${srvyVO.empNm} ${srvyVO.jbpsNm}</div>

														</td>
														<td>
															<c:choose><c:when test="${srvyVO.rspnYn == 1}"><span class="badge badge-info">응답완료</span></c:when><c:otherwise><span class="badge badge-secondary">미응답</span></c:otherwise></c:choose>
														</td>
														<td class="text-uppercase text-secondary text-xs text-center font-weight-bolder"> ${srvyVO.srvyRspnsCnt}명 / ${srvyVO.srvyTrprCnt}명
														</td>
														<td class="text-lg"  onclick="event.cancelBubble=true">

														<!-- 설문 상태 메뉴 시작 -->
														<a href="/survey/detail?srvyNo=${srvyVO.srvyNo}" data-bs-toggle="tooltip" data-bs-original-title="설문조사 상세확인">
															<i class="fas fa-eye text-secondary" aria-hidden="true"></i>
														</a>
														<!-- 설문 진행중일때만 수정 보류 삭제 가능 -->
														<c:choose>
															<c:when test="${srvyVO.srvySsts eq 'SRVY0002' && srvyVO.empNo eq loginEmpVO.empNo}"> <%-- 관리자일때 & 진행중인 경우만 수정/삭제 가능 --%>
																<a onclick="fn_unholdSrvy(this)" data-bs-toggle="tooltip" data-bs-original-title="설문조사 보류해제" class="mx-1">
																	<i class="ni ni-key-25" style="width:18px;" aria-hidden="true"></i>
																</a>
																<a onclick="fn_srvyDelete('${srvyVO.srvyNo}',this)" data-rspnsCnt="${srvyVO.srvyRspnsCnt}" data-bs-toggle="tooltip" data-bs-original-title="설문조사 삭제">
																	<i class="fas fa-trash text-secondary" aria-hidden="true"></i>
																</a>
															</c:when>
															<c:when test="${srvyVO.srvySsts eq 'SRVY0001' && authority=='admin'}"> <%-- 관리자일때 & 진행중인 경우만 수정/삭제 가능 --%>
																<a onclick="fn_holdSrvy(this)" data-bs-toggle="tooltip" data-bs-original-title="설문조사 보류" class="mx-1">
																	<i class="ni ni-lock-circle-open" style="width:18px;" aria-hidden="true"></i>
																</a>
															</c:when>
															<c:when test="${srvyVO.srvySsts eq 'SRVY0002' && authority=='admin'}"> <%-- 관리자일때 & 보류중인 경우만 삭제 가능 --%>
																<a onclick="fn_unholdSrvy(this)" data-bs-toggle="tooltip" data-bs-original-title="설문조사 보류해제" class="mx-1">
																	<i class="ni ni-key-25" style="width:18px;" aria-hidden="true"></i>
																</a>
																<a onclick="fn_srvyDelete('${srvyVO.srvyNo}',this)" data-rspnsCnt="${srvyVO.srvyRspnsCnt}" data-bs-toggle="tooltip" data-bs-original-title="설문조사 삭제">
																	<i class="fas fa-trash text-secondary" aria-hidden="true"></i>
																</a>
															</c:when>
															<c:otherwise>
																<%-- 작성자일때 &  진행중인 경우만 수정 가능 --%>
																<c:if test="${srvyVO.srvySsts eq 'SRVY0001' && srvyVO.empNo eq loginEmpVO.empNo}">
																	<a onclick="fn_holdSrvy(this)" data-bs-toggle="tooltip" data-bs-original-title="설문조사 보류" class="mx-1">
																		<i class="ni ni-lock-circle-open" style="width:18px;" aria-hidden="true"></i>
																	</a>
																	<a onclick="fn_modifySrvy(this)" data-srvyno="${srvyVO.srvyNo}" data-bs-toggle="tooltip" data-bs-original-title="설문조사 수정">
																		<i class="fas fa-user-edit text-secondary" aria-hidden="true"></i>
																	</a>
																</c:if>
															</c:otherwise>
															<%-- 작성자도 관리자도 아닐때 --%>
														</c:choose>
														<%-- 설문 상태 메뉴 메뉴 끝 --%>
														</td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						<!-- 페이징 시작  -->
							<div class="dataTable-bottom">
								<div class="dataTable-pagination">
									<nav class="dataTable-pagination">
									<ul class="dataTable-pagination-list">
										<li class="paginate_button page-item previous
											<c:if test='${data.startPage lt 6}'> disabled</c:if>
											" id="dataTable_previous">
											 <a href="<c:choose><c:when test='${not empty authority}'>/admin/srvyList?</c:when><c:otherwise>/survey/list?</c:otherwise></c:choose>status=${status}&currentPage=${data.startPage-5}"
											aria-controls="dataTable" data-dt-idx="0" tabindex="0"
											class="page-link">‹</a></li>
									<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}">
										<li class="paginate_button page-item
												<c:if test='${param.currentPage==pNo}'>active</c:if>
												">
										<a href="<c:choose><c:when test='${not empty authority}'>/admin/srvyList?</c:when><c:otherwise>/survey/list?</c:otherwise></c:choose>status=${status}&currentPage=${pNo}"
											aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${pNo}</a></li>
									</c:forEach>

										<li class="paginate_button page-item next
											<c:if test='${data.endPage ge data.totalPages}'>disabled</c:if>
										" id="dataTable_next">
										<a href="<c:choose><c:when test='${not empty authority}'>/admin/srvyList?</c:when><c:otherwise>/survey/list?</c:otherwise></c:choose>status=${status}&currentPage=$=${data.startPage+5}"
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
	<!-- 모달창 시작 -->
 <div class="modal fade modal" id="ModifySrvyModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">설문조사 수정</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="/survey/modifyPost" method="post" id="modifySrvyFrm">
            	<input type="hidden" name="srvyNo" value="" id="modifySrvyNo" />
              <div class="form-group">
                <label for="hashTagNm" class="text-lg col-form-label">설문조사 제목</label>
                <input type="text" class="form-control" name="srvyTtl" id="srvyTtl" >
              </div>
              <div class="form-group">
                <label for="hashTagNm" class="text-lg col-form-label">설문조사 내용</label>
                <textarea id="srvyExpln" class="form-control"></textarea>
              </div>
              <div class="form-group">
                <label for="srvyPeriod" class="text-lg col-form-label">기존 설문일자</label>
					<input type="text" class="form-control" name="srvyPeriod" id="srvyPeriod" readonly />
                <label for="surveyDates" class="text-lg col-form-label">수정할 설문조사 일자</label>
					<input class="form-control datepicker" placeholder="설문조사를 진행할 일자를 선택..." id="surveyDates" type="text" onfocus="focused(this)" onfocusout="defocused(this)" />
					<input type="hidden" name="srvyBgngYmd" id="srvyBgngYmd" /> <!-- 설문조사 시작일자 -->
					<input type="hidden" name="srvyEndYmd" id="srvyEndYmd" /> <!-- 설문조사 종료일자 -->
              </div>
              <sec:csrfInput/>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn bg-gradient-info" id="submitBtn">수정</button>
          </div>
        </div>
      </div>
    </div>
<!-- 모달창 끝 -->

<script>
$(document).on("click","#submitBtn",function(){
	// 수정 확인
	swal({
		  title: "해당 설문조사를 수정하시겠습니까?",
		  text: "확인을 누르면 해당 설문조사의 내용이 수정됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "확인",
				value : "confirmOk"
			  }
			},
		})
		.then((value) => {
			  switch (value) {
			    case "confirmOk":
						$("#modifySrvyFrm").submit();
			    	break;
			    default:
			      swal({
		 		    	title: "설문조사 보류 취소",
		 		    	icon :"error"
		 		    });
			 	 }
			});
	});

// 설문수정 메서드
function fn_modifySrvy(obj){
	let srvyNo =$(obj).data("srvyno");
	let srvyPeriod1 = $(obj).parents(".findRow").find(".srvyBgngYmd").text();
	let srvyPeriod2 = $(obj).parents(".findRow").find(".srvyEndYmd").text();
	console.log("srvyPeriod1 : " + srvyPeriod1);
	console.log("srvyPeriod2 : " + srvyPeriod2);
	$("#modifySrvyNo").val(srvyNo);
	$("#srvyPeriod").val(srvyPeriod1 + "~" + srvyPeriod2);

	let data = {"srvyNo" : srvyNo};

	$.ajax({
		url : "/survey/modifySrvy",
		data : JSON.stringify(data),
		type : "POST",
		dataType: 'json',
		contentType:"application/json;charset:utf-8",
		beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res){
			console.log(res);
			console.log(res.srvyBgngYmd);
			console.log("srvyTtl : " + res.srvyTtl);
			console.log("expln : " + res.srvyExpln );
			$("#srvyTtl").val(res.srvyTtl);
			let srvyExpln = res.srvyExpln.replace("<p>","").replace("</p>","");
			$("#srvyExpln").text( srvyExpln );
		}
	})
	$("#ModifySrvyModal").modal("show");
}

// 설문조사 보류 해제 메서드
function fn_unholdSrvy(obj){
	console.log($(this));
	$(this).css("border","1px solid red");
	let srvyNo = $(obj).parents(".findRow").find(".srvyNo").text();
	let srvySsts = $(obj).parents(".findRow").find(".srvySsts").text();

	console.log("srvyNo : " + srvyNo);
	console.log("srvySsts : " + srvySsts);

	if(srvySsts == "보류"){
		swal({
			  title: "해당 설문조사를 보류해제 하시겠습니까?",
			  text: "확인을 누르면 해당 설문조사의 상태가 진행중으로 전환됩니다.",
			  icon: "warning",
			  buttons: {
				  cancel : "취소",
				  modifyOK : {
					text : "확인",
					value : "confirmOk"
				  }
				},
			})
			.then((value) => {
				  switch (value) {
				    case "confirmOk":
				    	$.ajax({
				    		url:"/survey/modifySstsSrvy",
				    		type : "POST",
				    		data : {"srvyNo" : srvyNo,
				    				"srvySsts": "SRVY0001"},
		    				beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    				},
				    		success : function(res){
				    			$("#updateSpace").load("${contextPath}/admin/srvyList #products-list");
				    			swal({
					 		    	title: "설문조사 보류해제완료",
					 		    	icon :"success"
					 		    });
				    		}
				    	})

				    	break;
				    default:
				      swal({
			 		    	title: "설문조사 보류해제 취소",
			 		    	icon :"error"
			 		    });
				 	 }
				});
			}
	}

//설문조사 보류 메서드
function fn_holdSrvy(obj){
	console.log($(this));
	$(this).css("border","1px solid red");
	let srvyNo = $(obj).parents(".findRow").find(".srvyNo").text();
	let srvySsts = $(obj).parents(".findRow").find(".srvySsts").text();

	console.log("srvyNo : " + srvyNo);
	console.log("srvySsts : " + srvySsts);

	if(srvySsts == "진행중"){
		swal({
			  title: "해당 설문조사를 보류처리하시겠습니까?",
			  text: "확인을 누르면 해당 설문조사가 보류 처리됩니다.",
			  icon: "warning",
			  buttons: {
				  cancel : "취소",
				  modifyOK : {
					text : "확인",
					value : "confirmOk"
				  }
				},
			})
			.then((value) => {
				  switch (value) {
				    case "confirmOk":
				    	$.ajax({
				    		url:"/survey/modifySstsSrvy",
				    		type : "POST",
				    		data : {"srvyNo" : srvyNo,
				    				"srvySsts": "SRVY0002"},
		    				beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    				},
				    		success : function(res){
								  <c:choose>
								  	<c:when test="${authority eq 'admin'}"> $("#updateSpace").load("${contextPath}/admin/srvyList #products-list");</c:when>
								  	<c:otherwise> $("#updateSpace").load("${contextPath}/survey/list #products-list");</c:otherwise>
							  	   </c:choose>

// 								$("#updateSpace").load("${contextPath}/admin/srvyList #products-list");
				    			swal({
					 		    	title: "설문조사 보류 완료",
					 		    	icon :"success"
					 		    });
				    		}
				    	})
				    	break;
				    default:
				      swal({
			 		    	title: "설문조사 보류 취소",
			 		    	icon :"error"
			 		    });
				 	 }
				});
			}
	}

// 설문조사 삭제 메서드
function fn_srvyDelete(srvyNo, obj){
	console.log("설문삭제" + srvyNo);
	console.log( $(obj).data("rspnscnt") );
	let srvySsts = $(obj).parents(".findRow").find(".srvySsts").text();
	let rspnsCnt = $(obj).data("rspnscnt");

	console.log("rspnsCnt : " + rspnsCnt);
// 	<c:if test="${srvyVO.srvySsts eq 'SRVY0002'}"><span class="badge badge-warning">보류</span></c:if>
// 	if("${srvyVO.srvySsts ne 'SRVY0002'}"){
// 		// 진행중이거나 마감된 설문은 삭제 불가하다는 알림창 띄우기
// 	      swal({
//  		    	title: "설문조사 삭제 불가",
//  		    	text : "진행중이거나 마감된 설문은 삭제 불가능합니다!",
//  		    	icon :"error"
//  		    });
// 		return false;
// 	}




	if(rspnsCnt > 0){
		// 답변이 있는 설문은 삭제 불가
	      swal({
 		    	title: "설문조사 삭제 불가",
 		    	text : "답변이 등록된 설문조사는 삭제 불가능합니다. 관리자에게 문의해주세요.",
 		    	icon :"error"
 		    });
		return false;
	}


	swal({
		  title: "해당 설문조사를 삭제하시겠습니까?",
		  text: "확인을 누르면 해당 설문조사가 삭제 처리되고 복구할 수 없습니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  confirmOk : {
				text : "확인",
				value : "confirmOk"
			  }
			},
		})
		.then((value) => {
			  switch (value) {
			    case "confirmOk":
			    	$.ajax({
			    		url:"/survey/deleteSrvy",
			    		type : "POST",
			    		data : {"srvyNo" : srvyNo},
			    		beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    				},
			    		success : function(res){
							console.log(res);
							  swal({
					 		    	title: "삭제 완료",
					 		    	text : "설문조사가 성공적으로 삭제되었습니다.",
					 		    	icon : "success"
					 		    });

							  <c:choose>
							  	<c:when test="${authority eq 'admin'}"> $("#updateSpace").load("${contextPath}/admin/srvyList #products-list");</c:when>
							  	<c:otherwise> $("#updateSpace").load("${contextPath}/survey/list #products-list");</c:otherwise>
						  	   </c:choose>


			    		}
			    	})
			    	break;
			    default:
			      swal({
		 		    	title: "설문조사 삭제 취소",
		 		    	icon :"error"
		 		    });
			 	 }
			});
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
<!-- date Picker 시작 -->
<script>
if (document.querySelector('.datepicker')) {
  flatpickr('.datepicker', {
    mode: "range"
  });
}
</script>
<!-- date Picker 끝 -->