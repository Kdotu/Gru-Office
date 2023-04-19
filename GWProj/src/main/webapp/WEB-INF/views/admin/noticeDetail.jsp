<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 전체게시판 목록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-3">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">

			<div class="col-12">
								<a href="javascript:;" class="card-title h5 d-block text-darker">
									게시글 상세보기</a>

								<!-- 전체메일/안읽은메일 불러오기..? -->

						<!-- 모달창으로 해야함 (태그) ?-->
						<div style="margin: 10px">
							<button type="button" class="btn btn-danger btn-sm">삭제</button>
							<button type="button" class="btn btn-danger btn-sm">목록</button>
						</div>

						<div class="col-12">
								<div class="card h-100">
									<div class="card-header pb-0 p-3">
										<div class="row">
											<div class="col-md-11 d-flex align-items-center">
												<h5 class="mb-0">게시글 제목</h5>
											</div>
											<div class="col-md-1 d-flex align-items-center">
												<p>조회수<span>0</span></p>
											</div>
										</div>
									</div>
									<div class="card-body p-3 row" style="margin-left: 15px;">
										<div class="col-3">
											<p class="text-sm" style="font-weight: bold;">게시글 작성자</p>
										</div>
										<div class="col-9" >
											<p class="text-sm" style="font-weight: bold;">게시글 등록일시</p>
										</div>
										<div style="width: 95%; margin-bottom: 10px; margin-top: 10px;">
											게시글 내용
										</div>
										<div style="width: 95%; margin-bottom: 30px; margin-top: 20px;">
											멘션 자리
										</div>

										<div class="col-sm-6">
											<div class="d-flex">
												<div class="d-flex align-items-center">
												<i class="ni ni-chat-round me-1 cursor-pointer"></i>
												<span class="text-sm me-3">36</span>
												</div>
												<div class="d-flex align-items-center">
												<i class="ni ni-like-2 me-1 cursor-pointer"></i>
												<span class="text-sm me-3 ">150</span>
												</div>
											</div>
										</div>
										<hr style="border: 2px double gray; width: 95%;">
										<div class="mb-1">
											<div class="d-flex">
												<div class="flex-shrink-0">
													<img alt="Image placeholder" class="avatar rounded-circle" src="../../../assets/img/bruce-mars.jpg">
												</div>
												<div class="flex-grow-1 ms-3">
													<p class="h6 mt-0">Michael Lewis&nbsp;&nbsp;&nbsp;&nbsp;<span>댓글일시</span></p>
													<p class="text-sm">I always felt like I could do anything. That’s the main thing people are controlled by! Thoughts- their perception of themselves!</p>
												</div>
											</div>
											<div class="d-flex mt-2">
												<div class="flex-shrink-0">
													<img alt="Image placeholder" class="avatar rounded-circle me-3" src="../../../assets/img/team-4.jpg">
												</div>
												<div class="flex-grow-1 my-auto">
													<form>
														<div class="row">
															<div class="col-9">
																<textarea class="form-control" placeholder="Write your comment" rows="1"></textarea>
															</div>
															<div class="col-3">
																<img alt="" src="/resources/image/folder.gif" style="width: 30px; margin-bottom: 10px;">&nbsp;&nbsp;&nbsp;
																<button type="button" class="btn btn-warning btn-sm" style="margin-top: 7px;">댓글등록</button>
															</div>
														</div>
													</form>
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
