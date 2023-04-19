<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 전체게시판 목록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/myPageAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
		<!-- 2번째 사이드바 -->
<!-- 상단에 들어가는 마이페이지 회원정보 시작 -->
	<jsp:include page="/WEB-INF/views/aside/myPageSection.jsp" />
<!-- 상단에 들어가는 마이페이지 회원정보 끝 -->

		<div class="container-fluid py-4">
			<form id="frm" name="frm" action="/note/replyPost" method="post">
				<div class="row">
				<input type="hidden" name="empNoRcvr" value="${param.empNoSndpty}">

					<div class="dataTable-top mb-0">
							<a href="javascript:;" class="card-title h5 d-block text-darker">
								쪽지작성</a>
						<p class="text-sm mb-0">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
				  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
				  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
							</svg>
							수신자를 정하여 쪽지를 작성할 수 있습니다.
						</p>
					</div>

						<div class="card card-body mt-4 px-5">
							<div class="row mt-4" style="margin-bottom: 15px;">
								<div class="col-12 col-md-6">
									<div class="form-check">
									  <input class="form-check-input" type="checkbox" value="긴급" id="msgCateTag"  name="msgCateTag" >
									  <label class="custom-control-label" for="customCheck1" style="font-size: 1.1em;"><span class="badge badge-danger">긴급</span></label>
									  <!-- value="MSGT0002" -->
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-2">
									<label class="form-label" style="font-size: 1.1em;">수신자</label>
								</div>
								<div class="col-8">
									<!-- 이거!! -->
	<!-- 								<div style="border:2px solid #f5f7ff; width:750px; height:50px;" id="surveyTargetList"></div> -->
										<input class="form-control datetimepicker flatpickr-input" type="text" style="width: 800px;" name="rcvr" value="${param.sender}" readonly>

	<!-- 								<input -->
	<!-- 									class="form-control datetimepicker flatpickr-input" type="text" -->
	<!-- 									id="empNoRcvrShow" name="empNoRcvrShow" 									 -->
	<!-- 									placeholder="" data-input="" -->
	<!-- 									onfocus="focused(this)" onfocusout="defocused(this)"> -->

	<!-- 								<input -->
	<!-- 									class="form-control datetimepicker flatpickr-input" type="hidden" -->
	<!-- 									id="noteList[0].empNoRcvr" name="noteList[0].empNoRcvr" /> -->
								</div>
								<div class="col-2">
								</div>
							</div>
							<div class="row" style="margin-top: 15px;">
								<div class="col-2">
									<label class="form-label" style="font-size: 1.1em;">내용</label>
								</div>
								<div class="col-9">
									<textarea class="form-control" cols="100" rows="2" id="msgCn" name="msgCn"></textarea>
								</div>
							</div>
							<div class="d-flex justify-content-center mt-4">
								<a href="/note/recieveList" class="btn btn-lg btn-secondary" style="font-size: 1.1em;">취소</a>
								<button type="submit"
									class="btn btn-lg btn-outline-dark ms-2" style="font-size: 1.1em;">전송</button>
							</div>
						</div>

					</div>
					<sec:csrfInput/>
				</form>
			</div>
		</div><!-- end for row의 2번째 부분 -->
	</div>
</div>









