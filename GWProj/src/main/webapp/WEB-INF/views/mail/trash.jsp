<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script src="/resources/js/sweetalert.min.js"></script>
<script src="/resources/js/sweetalert2.min.js"></script>

<!-- jQuery -->
<!-- <script src="/resources/js/jquery-3.6.0.js"></script> -->
<!-- <script src="/resources/js/jquery-3.6.3.min.js"></script> -->

<script type="text/javascript">
$(function(){
	$("#delete").on("click",function(){
		let emlNoArray = [];

		$("input:checkbox[name='emlNo']:checked").each(function(index,data){
			let emlNo = $(this).data("emlNo");
			console.log("emlNo : " + emlNo);

			emlNoArray.push(emlNo);
		});

		let data = {"emlNoArray":emlNoArray};

		$.ajax({
			url:"/mail/delPost",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(result){
            	console.log("result : " + result);
            	if(result>0){
            		alert("메일이 삭제되었습니다.");
            		location.href="/mail/trash";
            	}

            }
        });
	});

	$("#reset").on("click",function(){
		let emlNoArray = [];

		$("input:checkbox[name='emlNo']:checked").each(function(index,data){
			let emlNo = $(this).data("emlNo");
			console.log("emlNo : " + emlNo);

			emlNoArray.push(emlNo);
		});

		let data = {"emlNoArray":emlNoArray};
			console.log("data : " + JSON.stringify(data));
		

		$.ajax({
			url:"/mail/resetPost",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(result){
            	if(result>0){
            		location.href="/mail/recieveList";
            	}
            }
		});
	});
});
</script>



<!-- 휴지통 -->
<!-- body_left -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/mailAside.jsp" />
		</div>
		<div class="col-lg-9">


			<!-- body_center -->
			<div class="row">
				<div class="col-2">
					<h4>휴지통</h4>
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
											<button type="button" class="btn btn-outline-success" id="reset" style="font-size:0.9em;">복원</button>
											<button type="button" class="btn btn-outline-danger" id="delete" style="font-size:0.9em;" >삭제</button>
<!-- 												<h5 class="mb-0">Datatable Search</h5> -->
<!-- 												<p class="text-sm mb-0">A lightweight, extendable, -->
<!-- 													dependency-free javascript HTML table plugin.</p> -->
											</div>
											<div class="table-responsive">
												<table class="table table-flush" id="datatable-search">
													<thead class="thead-light">
														<tr>
															<th></th>
															<th style="font-size:1.2em;">중요</th>
															<th style="font-size:1.2em;">라벨</th>
															<th style="font-size:1.2em;">읽음여부</th>
															<th style="font-size:1.2em;">첨부파일</th>
															<th style="font-size:1.2em;">제목</th>
															<th style="font-size:1.2em;">발신자</th>
															<th style="font-size:1.2em;">발신일자</th>


														</tr>
													</thead>
													<tbody>

													<!-- recieveList내용임 -->

													<tbody>
											<c:forEach var="mailVO" items="${data}" varStatus="stat">
												<fmt:formatDate value="${mailVO.emlTrsmDt}"
													pattern="yyyy-MM-dd" var="day1" />
												<c:if test="${mailVO.rslt == 1 }">
													<tr>
														<td class="font-weight-normal table-secondary" style="font-size:1.2em;" colspan="8">${day1}</td>
													</tr>
												</c:if>
												<tr>
													<td>
														<div class="form-check">
															<input class="form-check-input addrNo" type="checkbox"
																data-eml-no="${mailVO.emlNo}" name="emlNo"
																value="${mailVO.emlNo}">
														</div>
													</td>
													<td>
														<c:if test="${mailVO.emlImporYn eq '중요'}">
															<img src="/resources/image/star.png"
																style="width: 20px;">
														</c:if>
														<c:if test="${mailVO.emlImporYn eq '기본'}">
															<img src="/resources/image/starbl.png"
																style="width: 25px;">
														</c:if>
													</td>
													<td class="font-weight-normal" style="font-size:1.4em;"><c:if
															test="${mailVO.emlTagcol eq '빨강'}">
															<i class="ni ni-tag" style="color: red"></i>
														</c:if> <c:if test="${mailVO.emlTagcol eq '초록'}">
															<i class="ni ni-tag" style="color: green"></i>
														</c:if> <c:if test="${mailVO.emlTagcol eq '보라'}">
															<i class="ni ni-tag" style="color: purple"></i>
														</c:if></td>

													<td class="font-weight-normal" style="font-size:1.2em;"><a
														href="/mail/detail?emlNo=${mailVO.emlNo}">${fn:substring(mailVO.emlTtl,0,15)}
                                                            <c:if test="${fn:length(mailVO.emlTtl) > 15}">...</c:if></a></td>
													<td class="font-weight-normal" style="font-size:1.2em;"><c:if
															test="${mailVO.fileGroupNo!=null}">
															<img alt="" src="/resources/image/clip.png"
																style="width: 25px;">
														</c:if></td>
													<td class="font-weight-normal" style="font-size:1.2em;"><c:if
															test="${mailVO.rcvrYn eq '미확인'}">
															<img alt="" src="/resources/image/mail_or.png"
																style="width: 25px;">
														</c:if> <c:if test="${mailVO.rcvrYn eq '확인'}">
															<img alt="" src="/resources/image/mail_rd.png"
																style="width: 25px;">
														</c:if></td>
													<td class="font-weight-normal" style="font-size:1.2em;">${mailVO.empNm}</td>
													<td class="font-weight-normal" style="font-size:1.2em;"><fmt:formatDate
															value="${mailVO.emlTrsmDt}"
															pattern="yyyy-MM-dd HH:mm" /></td>
												</tr>
											</c:forEach>
										</tbody>

<%-- 														<c:forEach var="mailVO" items="${data}" varStatus="stat"> --%>
<%-- 															<fmt:formatDate value="${mailVO.emlTrsmDt}" --%>
<%-- 																pattern="yyyy-MM-dd" var="day1" /> --%>
<%-- 															<c:if test="${mailVO.rslt == 1 }"> --%>
<!-- 																<tr> -->
<%-- 																	<td class="font-weight-normal" style="font-size:1.1em;">${day1}</td> --%>
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																	<td></td> -->
<!-- 																</tr> -->
<%-- 															</c:if> --%>
<!-- 															<tr> -->
<!-- 																<td> -->
<!-- 																	<div class="form-check"> -->
<!-- 																		<input class="form-check-input emlNo" type="checkbox" -->
<%-- 																			data-eml-no="${mailVO.emlNo}" name="emlNo" --%>
<%-- 																			value="${mailVO.emlNo}" style="font-size:1.1em;"> --%>
<!-- 																	</div> -->
<!-- 																</td> -->
<%-- 																<td class="text-sm font-weight-normal"><c:if --%>
<%-- 																		test="${mailVO.emlTagcol eq '노랑'}"> --%>
<!-- 																		<img src="/resources/image/bookmark_yl.png" -->
<!-- 																			style="width: 25px;"> -->
<%-- 																	</c:if> <c:if test="${mailVO.emlTagcol eq '초록'}"> --%>
<!-- 																		<img src="/resources/image/bookmark_gr.png" -->
<!-- 																			style="width: 25px;"> -->
<%-- 																	</c:if> <c:if test="${mailVO.emlTagcol eq '보라'}"> --%>
<!-- 																		<img src="/resources/image/bookmark_pp.png" -->
<!-- 																			style="width: 25px;"> -->
<%-- 																	</c:if></td> --%>

<%-- 																<td class="text-sm font-weight-normal"><c:if --%>
<%-- 																		test="${mailVO.rcvrYn eq 'N'}"> --%>
<!-- 																		<img alt="" src="/resources/image/mail_or.png" -->
<!-- 																			style="width: 25px;"> -->
<%-- 																	</c:if> <c:if test="${mailVO.rcvrYn eq 'Y'}"> --%>
<!-- 																		<img alt="" src="/resources/image/mail_rd.png" -->
<!-- 																			style="width: 25px;"> -->
<%-- 																	</c:if></td> --%>
<%-- 																<td class="text-sm font-weight-normal"><c:if --%>
<%-- 																		test="${mailVO.fileGroupNo!=null}"> --%>
<!-- 																		<img alt="" src="/resources/image/clip.png" -->
<!-- 																			style="width: 25px;"> -->
<%-- 																	</c:if></td> --%>
<%-- 																<td class="font-weight-normal" style="font-size:1.1em;">${mailVO.empNm}</td> --%>
<!-- 																<td class="font-weight-normal" style="font-size:1.1em;"><a -->
<%-- 																	href="/mail/detail?emlNo=${mailVO.emlNo}">${fn:substring(mailVO.emlTtl,0,15)} --%>
<%--                                                             <c:if test="${fn:length(mailVO.emlTtl) > 15}">...</c:if></a></td> --%>
<%-- 																<td class="font-weight-normal" style="font-size:1.1em;"><fmt:formatDate --%>
<%-- 																		value="${mailVO.emlTrsmDt}" --%>
<%-- 																		pattern="yyyy-MM-dd HH:mm:ss" /></td> --%>
<!-- 															</tr> -->
<%-- 														</c:forEach> --%>
<!-- 													</tbody> -->
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









