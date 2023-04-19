<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 전체게시판 목록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" /> 
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			
			
			<div class="col-12">
								<a href="javascript:;" class="card-title h5 d-block text-darker">
									게시글 상세보기</a>

								<!-- 전체메일/안읽은메일 불러오기..? -->
				
						<!-- 모달창으로 해야함 (태그) ?-->
						<div style="margin: 10px">
							<button type="button" class="btn btn-primary btn-sm">수정</button>
							<button type="button" class="btn btn-primary btn-sm">메일발송</button>
							<button type="button" class="btn btn-danger btn-sm">삭제</button>
							<button type="button" class="btn btn-primary btn-sm">목록</button>
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
										
										
										
										
								</div>
									
								</div>
							</div>
							
							
							
							
							
					</div>
		</div>
	</div>
</div>
