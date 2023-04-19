<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jQuery -->
<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>




<!-- 전사게시판 목록 -->
<!-- body_left -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->
			<!-- body_center -->


<!-- 			<div class=""> -->
<!-- 				<p>전사게시판</p> -->

<!-- 			</div> -->

			<div class="card">
				<div class="col-12">

					<div class="row" style="margin: 10px;">
						<div class="col-9">
<!-- 							<a href="/board/wholBWrite" class="btn btn-outline-dark btn-sm">글쓰기</a> -->
<!-- 							<button type="button" class="btn btn-outline-dark btn-sm">글쓰기</button> -->
<!-- 							<button type="button" class="btn btn-outline-dark btn-sm">메일발송</button> -->
<!-- 							<button type="button" class="btn btn-outline-danger btn-sm" id="del">삭제</button> -->
						</div>

<!-- 						<div class="col-3"> -->
<!-- 							<div class="dataTable-search"> -->
<!-- 								<input class="dataTable-input" placeholder="Search..." -->
<!-- 									type="text"> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>
					<div class="card-header">
              <h4 class="mb-0">전사게시판</h4>
				<p class="text-mb mb-0 mx-3">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
		  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
		  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
					</svg>
					 전사게시판의 조회 및 글등록이 가능합니다.
				</p>
            </div>

					 <table class="table table-flush" id="datatable-search">

					<div class="table-responsive">
						<table class="table align-items-center mb-0">
							<thead>
								<tr>
									<th style="font-size:1.1em; text-align:center;"
										class="text-uppercase  font-weight-bolder">No</th>
									<th style="font-size:1.1em; text-align:center;"
										class="text-uppercase  font-weight-bolder">글제목</th>
									<th style="font-size:1.1em; text-align:center;"
										class="text-uppercase  font-weight-bolder ps-2">작성자</th>
									<th style="font-size:1.1em; text-align:center;"
										class="text-uppercase  font-weight-bolder ps-2">등록일자</th>
									<th style="font-size:1.1em; text-align:center;"
										class="text-uppercase  font-weight-bolder ps-2">조회수</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="wholBVO" items="${data}" varStatus="stat">
									<tr>
										<td style="font-size:1.1em; text-align:center;">
											<div class="px-2 py-1">

												<div class=" flex-column justify-content-center" style="font-size:1.1em; text-align:center;">
													<h6 class="mb-0">
														<div class="" style="font-size:1.2em; text-align:center;">
															<input class="form-check-input" type="checkbox"
																id="customCheck1">${wholBVO.rnum}
													</h6>
												</div>
											</div>
											</div>
										</td>
										<td style="font-size:1.1em; text-align:center;">
											<a href="/board/wholBDetail?wholBbsNo=${wholBVO.wholBbsNo}">${wholBVO.wholBbsTtl}</a>
										</td>
										<td style="font-size:1.1em; text-align:center;">${wholBVO.empNm}</td>
										<td style="font-size:1.1em; text-align:center;"><fmt:formatDate value="${wholBVO.wholBbsRegYmd}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
										<td style="font-size:1.1em; text-align:center;">${wholBVO.wholBbsInqCnt}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>


					</table>


<br />

<!-- 					<div class="pagination-container justify-content-center" -->
<!-- 						style="padding-left: 500px;"> -->
<!-- 						<ul class="pagination pagination-info"> -->
<!-- 							<li class="page-item"><a class="page-link" href="#link" -->
<!-- 								aria-label="Previous"> <span aria-hidden="true"><i -->
<!-- 										class="ni ni-bold-left" aria-hidden="true"></i></span> -->
<!-- 							</a></li> -->
<!-- 							<li class="page-item"><a class="page-link" href="#link">1</a> -->
<!-- 							</li> -->
<!-- 							<li class="page-item active"><a class="page-link" -->
<!-- 								href="#link">2</a></li> -->
<!-- 							<li class="page-item"><a class="page-link" href="#link">3</a> -->
<!-- 							</li> -->
<!-- 							<li class="page-item"><a class="page-link" href="#link">4</a> -->
<!-- 							</li> -->
<!-- 							<li class="page-item"><a class="page-link" href="#link">5</a> -->
<!-- 							</li> -->
<!-- 							<li class="page-item"><a class="page-link" href="#link" -->
<!-- 								aria-label="Next"> <span aria-hidden="true"><i -->
<!-- 										class="ni ni-bold-right" aria-hidden="true"></i></span> -->
<!-- 							</a></li> -->
<!-- 						</ul> -->
<!-- 					</div> -->

				</div>
			</div>
		</div>
	</div>
</div>
