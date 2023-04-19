<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<!-- <script src="/resources/js/jquery-3.6.3.min.js"></script> -->

<script type="text/javascript">

	$(function(){
		$.ajax({
			url:"/mail/totalCnt",
			type:"get",
			success:function(result){
				console.log("totalCnt result :" , result);
				$("#totalCnt").text(result);
			}
		});


	});
</script>

<script type="text/javascript">
$(function(){

	$.ajax({
		url:"/mail/unReadCnt",
		type:"get",
		success:function(result){
			console.log("unReadCnt result:" , result);
			$("#unCnt").text(result);
		}
	});
})
</script>

<!-- body_left -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/mailAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">


			<!-- body_center -->
			<div class="row">
				<div class="col-2">
					<h4>중요 메일함</h4>
				</div>
				<div class="col-10">
					<p>
<!-- 						전체메일 <span id="totalCnt"></span> / 안읽은메일<span id="unCnt"></span> -->
					</p>
				</div>
			</div>
			<div class="table-responsive">
				<!-- <div
						class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						<div class=""> -->

				<!-- 	</div> -->

				<!-- dataTables -->
				<div class="container-fluid py-4">
					<div class="row mt-4">
						<div class="col-12">
							<div class="card">

								<!-- Card header -->
								<!--  <div class="card-header">


            </div> -->


								<div class="row mt-4">
									<div class="col-12">
										<div class="card">
											<!-- Card header -->
											<div class="card-header">
											<button type="button" class="btn btn-outline-dark">태그</button>
<!-- 											<button type="button" class="btn btn-outline-dark">이동</button> -->
											<button type="button" class="btn btn-outline-danger">삭제</button>
<!-- 												<h5 class="mb-0">Datatable Search</h5> -->
<!-- 												<p class="text-sm mb-0">A lightweight, extendable, -->
<!-- 													dependency-free javascript HTML table plugin.</p> -->
											</div>
											<div class="table-responsive">
												<table class="table table-flush" id="datatable-search">
													<thead class="thead-light">
														<tr>
															<th></th>
															<th>중요</th>
															<th>라벨</th>
															<th>읽음여부</th>
															<th>첨부파일</th>
															<th>제목</th>
															<th>발신자</th>
															<th>발신일자</th>

														</tr>
													</thead>
													<tbody>
														<c:forEach var="mailVO" items="${impEmlList}" varStatus="stat">
															<tr>
																<td colspan="8">${mailVO.emlDtStr}</td>
															</tr>
																
															<c:if test="${mailVO.rslt == 1 }">
																<tr>
																	<td class="text-sm font-weight-normal">${day1}</td>
																	<td></td>
																	<td></td>
																	<td></td>
																	<td></td>
																	<td></td>
																	<td></td>
																	<td></td>
																</tr>
															</c:if>
															<tr>
																<td>
																	<div class="form-check">
																		<input class="form-check-input addrNo" type="checkbox"
																			data-addr-no="212" id="customCheck1" name="addrNo"
																			value="212">
																	</div>
																</td>
																<td>
																	중요
																</td>
																<td class="text-sm font-weight-normal"><c:if
																		test="${mailVO.emlTagcol eq '노랑'}">
																		<img src="/resources/image/bookmark_yl.png"
																			style="width: 20px;">
																	</c:if> <c:if test="${mailVO.emlTagcol eq '초록'}">
																		<img src="/resources/image/bookmark_gr.png"
																			style="width: 20px;">
																	</c:if> <c:if test="${mailVO.emlTagcol eq '보라'}">
																		<img src="/resources/image/bookmark_pp.png"
																			style="width: 20px;">
																	</c:if></td>

																<td class="text-sm font-weight-normal"><c:if
																		test="${mailVO.rcvrYn eq '미확인'}">
																		<img alt="" src="/resources/image/mail_or.png"
																			style="width: 20px;">
																	</c:if> <c:if test="${mailVO.rcvrYn eq '확인'}">
																		<img alt="" src="/resources/image/mail_rd.png"
																			style="width: 20px;">
																	</c:if></td>
																<td class="text-sm font-weight-normal"><c:if
																		test="${mailVO.fileGroupNo!=null}">
																		<img alt="" src="/resources/image/clip.png"
																			style="width: 20px;">
																	</c:if></td>
																<td class="text-sm font-weight-normal"><a
																	href="/mail/detail?emlNo=${mailVO.emlNo}">${mailVO.emlTtl}</a></td>
																<td class="text-sm font-weight-normal">${mailVO.empNm}</td>
																<td class="text-sm font-weight-normal">${mailVO.emlDtStr}</td>
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
					</div>
				</div>


				<!-- </div> -->



			</div>
		</div>
	</div>
</div>


<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>

<script type="text/javascript">

const dataTableSearch = new simpleDatatables.DataTable("#datatable-search", {
    searchable: true,
    fixedHeight: true
  });

  document.querySelectorAll(".export").forEach(function(el) {
    el.addEventListener("click", function(e) {
      var type = el.dataset.type;

      var data = {
        type: type,
        filename: "근태현황",
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
				damping : '0.5'
			}
			Scrollbar.init(document.querySelector('#sidenav-scrollbar'),
					options);
		}
	</script>









