<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery-3.6.3.min.js"></script>

<!-- 내 글 목록 -->
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




			<div class="col-12">
				<div class="card">

									<div class="card-header">
              <h2 class="mb-0">내 게시글</h2>
              <p class=" mb-0">
											<p class="text-mb mb-0 mx-3">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
									  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
									  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
												</svg>
												 내가 쓴 게시글의 조회 및 글 등록이 가능합니다.
											</p>
              </p>
            </div>

					<div class="row" style="margin: 10px;">
						<div class="col-9">
<!-- 							<button type="button" class="btn btn-outline-dark btn-sm">수정</button> -->
<!-- 							<button type="button" class="btn btn-outline-dark btn-sm">메일발송</button> -->
<!-- 							<button type="button" class="btn btn-outline-danger btn-sm">삭제</button> -->
						</div>

						<div class="col-3">
<!-- 							<div class="dataTable-search"> -->
<!-- 								<input class="dataTable-input" placeholder="Search..." -->
<!-- 									type="text"> -->
<!-- 							</div> -->
						</div>
					</div>

<!-- 					<div class="table-responsive"> -->
<!-- 						<table class="table align-items-center mb-0"> -->
<!-- 							<thead> -->
<!-- 								<tr> -->
<!-- 									<th -->
<!-- 										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th> -->
<!-- 									<th -->
<!-- 										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">글제목</th> -->
<!-- 									<th -->
<!-- 										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">작성자</th> -->
<!-- 									<th -->
<!-- 										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">등록일자</th> -->
<!-- 									<th -->
<!-- 										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">조회수</th> -->
<!-- 								</tr> -->
<!-- 							</thead> -->
<!-- 							<tbody> -->
<!-- 								<tr> -->
<!-- 									<td> -->
<!-- 										<div class="d-flex px-2 py-1"> -->

<!-- 											<div class="d-flex flex-column justify-content-center"> -->
<!-- 												<h6 class="mb-0 text-sm"> -->
<!-- 													<div class=""> -->
<!-- 														<input class="form-check-input" type="checkbox" -->
<!-- 															id="customCheck1"> John Michael -->
<!-- 												</h6> -->
<!-- 											</div> -->
<!-- 										</div> -->
<!-- 										</div> -->
<!-- 									</td> -->
<!-- 									<td> -->
<!-- 										<p class="text-sm text-secondary mb-0">Manager</p> -->
<!-- 									</td> -->
<!-- 									<td><span class="badge badge-dot me-4"> <i -->
<!-- 											class="bg-info"></i> <span class="text-dark text-xs">positive</span> -->
<!-- 									</span></td> -->
<!-- 									<td><span class="badge badge-dot me-4"> <i -->
<!-- 											class="bg-info"></i> <span class="text-dark text-xs">positive</span> -->
<!-- 									</span></td> -->
<!-- 									<td><span class="badge badge-dot me-4"> <i -->
<!-- 											class="bg-info"></i> <span class="text-dark text-xs">positive</span> -->
<!-- 									</span></td> -->

<!-- 								</tr> -->
<!-- 							</tbody> -->
<!-- 						</table> -->
<!-- 					</div> -->
						<div class="table-responsive">
						<table class="table align-items-center mb-0">
							<thead>
								<tr>
									<th
										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th>
									<th
										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">글제목</th>
									<th
										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">작성자</th>
									<th
										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">등록일자</th>
									<th
										class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">조회수</th>
								</tr>
							</thead>
							<tbody>
<!--
wholBVOList : [
WholBVO(wholBbsNo=42, empNo=202304, rnum=0, empNm=null, bbsClsfNo=BBS_CLSF02, fileGroupNo=FILE_GR007, wholBbsTtl=하하
		, wholBbsCn=<p>ㅁㄴㅇㄹ</p>
		, wholBbsRegYmd=Mon Mar 27 14:53:24 KST 2023, wholBbsInqCnt=23, cntGood=0, uploadFile=null, fileGrVO=null),
WholBVO(wholBbsNo=49, empNo=202304, rnum=0, empNm=null, bbsClsfNo=BBS_CLSF02, fileGroupNo=FILE_GR007, wholBbsTtl=게시글등록, wholBbsCn=<p>asedf</p>
		, wholBbsRegYmd=Mon Mar 27 21:27:43 KST 2023, wholBbsInqCnt=26, cntGood=0, uploadFile=null, fileGrVO=null)]
-->
								<c:forEach var="wholBVO" items="${data}" varStatus="stat">
									<tr>
										<td>
											<div class="d-flex px-2 py-1">

												<div class="d-flex flex-column justify-content-center">
													<h6 class="mb-0 text-sm">
														<div class="">
															<input class="form-check-input" type="checkbox"
																id="customCheck1">${wholBVO.rnum}
													</h6>
												</div>
											</div>
											</div>
										</td>
										<td>
											<p class="text-sm text-secondary mb-0"><a href="/board/wholBDetail?wholBbsNo=${wholBVO.wholBbsNo}">${wholBVO.wholBbsTtl}</a></p>
										</td>
										<td><span class="badge badge-dot me-4"> <i
												class="bg-info"></i> <span class="text-dark text-xs">${wholBVO.empNm}</span>
										</span></td>
										<td><span class="badge badge-dot me-4"> <i
												class="bg-info"></i> <span class="text-dark text-xs">
												<fmt:formatDate value="${wholBVO.wholBbsRegYmd}" pattern="yyyy-MM-dd HH:mm:ss"/>
												</span>
										</span></td>
										<td><span class="badge badge-dot me-4"> <i
												class="bg-info"></i> <span class="text-dark text-xs">${wholBVO.wholBbsInqCnt}</span>
										</span></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>


					<!-- 페이징 -->
<!-- 					<div class="pagination-container justify-content-center" -->
<!-- 						style="padding-left: 500px;"> -->
<!-- 						<ul class="pagination pagination-info"> -->
<!-- 							<li class="page-item"><a class="page-link" -->
<!-- 								href="javascript:;" aria-label="Previous"> <span -->
<!-- 									aria-hidden="true"><i class="fa fa-angle-double-left" -->
<!-- 										aria-hidden="true"></i></span> -->
<!-- 							</a></li> -->
<!-- 							<li class="page-item"><a class="page-link" -->
<!-- 								href="javascript:;">1</a></li> -->
<!-- 							<li class="page-item"><a class="page-link" -->
<!-- 								href="javascript:;">2</a></li> -->
<!-- 							<li class="page-item active"><a class="page-link" -->
<!-- 								href="javascript:;">3</a></li> -->
<!-- 							<li class="page-item"><a class="page-link" -->
<!-- 								href="javascript:;">4</a></li> -->
<!-- 							<li class="page-item"><a class="page-link" -->
<!-- 								href="javascript:;">5</a></li> -->
<!-- 							<li class="page-item"><a class="page-link" -->
<!-- 								href="javascript:;" aria-label="Next"> <span -->
<!-- 									aria-hidden="true"><i class="fa fa-angle-double-right" -->
<!-- 										aria-hidden="true"></i></span> -->
<!-- 							</a></li> -->
<!-- 						</ul> -->
<!-- 					</div> -->


				</div>
			</div>

		</div>
		<div class="row">
			<div class="col-8"></div>
		</div>
	</div>
</div>