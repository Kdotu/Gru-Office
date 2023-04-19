<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 전체게시판 목록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->
			<div class="row">
					<div class="card-body">
						<div>
							<div class="row pt-0" style="padding: 10px;">
								<div class="col">
									<div class="card"
										style="font-weight: bold; border-style: solid; border-color: #FAE58C;">

										<div class="card-body pt-2">
											<h4 class="p-3 pb-0" >공지게시판</h4>
											<a type="button" class="btn btn-info btn-sm" href="/board/noticeBList" style="float: right; margin-top: 10px; font-size: 1.1em;">+ 더보기</a>
											<p class="text-mb mb-0 mx-3">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
									  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
									  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
												</svg>
												 공지게시판의 글을 최신순으로 5개씩만 조회할 수 있습니다.
											</p>
										</div>


										<div class="table-responsive" style="bopadding: 15px;">
											<table class="table align-items-center mb-0">
												<thead>
													<tr style="text-align: center;">
														<th
															class="font-weight-bolder" style="width: 10%; font-size:1.1em; text-align: center;">No</th>
														<th
															class="font-weight-bolder"  style="width: 30%; font-size:1.1em; text-align: center;">글제목</th>
														<th
															class="font-weight-bolder "  style="width: 10%; font-size:1.1em; text-align: center;">작성자</th>
														<th
															class="font-weight-bolder "  style="width: 20%; font-size:1.1em; text-align: center;">등록일자</th>
														<th
															class=" font-weight-bolder "  style="width: 10%; font-size:1.1em; text-align: center;">조회수</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="mainNotice" items="${mainNotice}" varStatus="stat">
													<tr style="text-align: center;">
														<td style="font-size:1.1em; width: 10%;"  >
															<span>${mainNotice.wholBbsNo}</span>
														</td>
														<td style="font-size:1.1em; text-align: center; width: 30%;">
															<a class="mb-0"  href="/board/noticeBDetail?wholBbsNo=${mainNotice.wholBbsNo}">${mainNotice.wholBbsTtl}</a>
														</td>
														<td style="font-size:1.1em; text-align: center; width: 10%;"><span class="badge badge-dot me-4"> <i
																class="bg-info"></i> <span class="text-dark" style="font-size:1.2em; text-align: center;">${mainNotice.empNm}</span>
														</span></td>
														<td style="font-size:1.1em; text-align: center; width: 10%;"><span class="badge badge-dot me-4" >  <span class="text-dark "style="font-size:1.2em; text-align: center;"><fmt:formatDate value="${mainNotice.wholBbsRegYmd}" pattern="yyyy-MM-dd HH:mm" /></span>
														</span></td>
														<td style="font-size:1.1em; text-align: center; width: 10%;"><span class="badge badge-dot me-4">  <span class="text-dark " style="font-size:1.2em; text-align: center;">${mainNotice.wholBbsInqCnt}</span>
														</span></td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
										<div class="author align-items-center"></div>
									</div>

								</div>
							</div>
						</div>

						<div>
							<div class="author align-items-center"></div>
							<div class="row" style="padding: 10px;">
								<div class="col">
									<div class="card"
										style="font-weight: bold; border-style: solid; border-color: #FAE58C">

										<div class="card-body pt-2">
											<h4 class="p-3 pb-0" >전사게시판</h4>
											<a type="button" class="btn btn-info btn-sm" href="/board/wholBList" style="float: right; margin-top: 10px; font-size: 1.1em;">+ 더보기</a>
											<p class="text-mb mb-0  mx-3">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
									  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
									  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
												</svg>
												 전사게시판 글을 최신순으로 5개씩만 조회할 수 있습니다.
											</p>
										</div>


										<div class="table-responsive" style="bopadding: 15px;">
											<table class="table align-items-center mb-0">
												<thead>
													<tr style="text-align: center;">
														<th class=" font-weight-bolder " style="width: 10%; font-size:1.1em;">No</th>
														<th class=" font-weight-bolder "  style="width: 30%; font-size:1.1em;">글제목</th>
														<th class=" font-weight-bolder "  style="width: 10%; font-size:1.1em;">작성자</th>
														<th class="  font-weight-bolder "  style="width: 20%; font-size:1.1em;">등록일자</th>
														<th class="  font-weight-bolder "  style="width: 10%; font-size:1.1em;">조회수</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="mainWhole" items="${mainWhole}" varStatus="stat">
													<tr style="text-align: center;">
														<td style="font-size:1.1em;">
															<span>${mainWhole.wholBbsNo}</span>
														</td>
														<td style="font-size:1.1em;">
															<a class=" mb-0" href="/board/wholBDetail?wholBbsNo=${mainWhole.wholBbsNo}">${mainWhole.wholBbsTtl}</a>
														</td>
														<td style="font-size:1.1em;"><span class="badge badge-dot me-4"> <i class="bg-info"></i> <span class="text-dark" style="font-size:1.3em; text-align: center;">${mainWhole.empNm}</span></span></td>
														<td><span class="badge badge-dot me-4">  <span class="text-dark " style="font-size:1.1em; text-align: center;"><fmt:formatDate value="${mainWhole.wholBbsRegYmd}" pattern="yyyy-MM-dd HH:mm" /></span></span></td>
														<td><span class="badge badge-dot me-4">  <span class="text-dark " style="font-size:1.1em; text-align: center;">${mainWhole.wholBbsInqCnt}</span></span></td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>

										<div class="author align-items-center"></div>
									</div>

								</div>
							</div>
						</div>

						<div>
							<div class="author align-items-center"></div>
							<div class="row" style="padding: 10px;">
								<div class="col">
									<div class="card"
										style="font-weight: bold; bopadding: 8px; border-style: solid; border-color: #FAE58C">

										<div class="card-body pt-2">
											<h4 class="p-3 pb-0">${deptNm} 부서게시판</h4>
											<a type="button" class="btn btn-info btn-sm" href="/board/depBList" style="float: right; margin-top: 10px; font-size: 1.1em;">+ 더보기</a>
											<p class="text-mb mb-0 mx-3">
												<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
									  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
									  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
												</svg>
												 직원이 속한 부서의 부서게시판의 글을 최신순으로 5개씩만 조회할 수 있습니다.
											</p>
										</div>


										<div class="table-responsive" style="bopadding: 15px;">
											<table class="table align-items-center mb-0">
												<thead>
													<tr style="text-align: center;">
														<th style="font-size:1.1em;"
															class="   " style="width: 10%;">No</th>
														<th style="font-size:1.1em;"
															class="   "  style="width: 40%;">글제목</th>
														<th style="font-size:1.1em;"
															class=""  style="width: 10%;">작성자</th>
														<th style="font-size:1.1em;"
															class=" "  style="width: 20%;">등록일자</th>
														<th style="font-size:1.1em;"
															class=" "  style="width: 10%;">조회수</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="mainDept" items="${mainDept}" varStatus="stat">
													<tr style="text-align: center;">
														<td style="font-size:1.1em;">
															<span>${mainDept.wholBbsNo}</span>
														</td>
														<td style="font-size:1.1em;">
															<a class="mb-0" href="/board/wholBDetail?wholBbsNo=${mainDept.wholBbsNo}">${mainDept.wholBbsTtl}</a>
														</td>
														<td style="font-size:1.1em;"><span class="badge badge-dot me-4"> <i
																class="bg-info"></i> <span class="text-dark" style="font-size:1.1em;">${mainDept.empNm}</span>
														</span></td>
														<td><span class="badge badge-dot me-4">  <span class="text-dark" style="font-size:1.1em;"><fmt:formatDate value="${mainDept.wholBbsRegYmd}" pattern="yyyy-MM-dd HH:mm" /></span>
														</span></td>
														<td><span class="badge badge-dot me-4">  <span class="text-dark" style="font-size:1.1em;">${mainDept.wholBbsInqCnt}</span>
														</span></td>
													</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>

										<div class="author align-items-center"></div>
									</div>

								</div>
							</div>
						</div>

					</div>
			</div>
		</div>
	</div>
</div>
