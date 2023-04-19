<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<script src="/resources/ckeditor/ckeditor.js"></script>
<script src="/resources/maincss/assets/js/plugins/flatpickr.min.js"></script>
<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>

<script src="/resources/js/jquery.cookie.js"></script>
<script src="/resources/js/jquery.treeview.js"></script>

<script type="text/javascript" src="/resources/js/demo.js"></script>

<style>
.qustBox:hover{
	background-color : #EDFAFA;
}
.btn-outline-dark{
	background-color:white;
}
</style>
<style>
a {
  color: #369;
}
.note {
  width: 500px;
  margin: 50px auto;
  font-size: 1.1em;
  color: #333;
  text-align: justify;
}
#drop-area {
  border: 2px dashed #ccc;
  border-radius: 20px;
  width: 480px;
/*   margin: 50px auto; */
/*   padding: 20px; */
}
#drop-area.highlight {
  border-color: purple;
}
p {
  margin-top: 0;
}
.my-form {
  margin-bottom: 10px;
}
#gallery {
  margin-top: 10px;
}
#gallery img {
  width: 200px;
  margin-bottom: 10px;
  margin-right: 10px;
  vertical-align: middle;
}
.button {
  display: inline-block;
  padding: 10px;
  background: #ccc;
  cursor: pointer;
  border-radius: 5px;
  border: 1px solid #ccc;
}
.button:hover {
  background: #ddd;
}
#fileElemlem {
  display: none;
}
</style>
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/surveyAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->
			<form:form modelAttribute="SrvyVO" action="/survey/createPost" method="post" id="surveyFrm"  enctype="multipart/form-data">
			<div class="card card-body">
				<span class="text-gradient text-dark text-uppercase h6 font-weight-bold my-2">Create Survey</span>
				<h3 class="mb-0">설문조사 등록</h3>
				<p class="explains text-sm mb-0 position-relative mt-2" style="bottom:10px;">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
					<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
					<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
				</svg>
				새로운 설문을 등록합니다.
				</p>

				<hr class="horizontal dark my-3">
				<!-- start row 1 -->
				<div class="row mx-2">
					<div class="col-6">
						<!-- 설문 제목 -->
						<label for="surveyName" class="form-label h4 mt-3 mb-0">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
							  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
							</svg>
							설문 제목
						</label>
						<p class="form-text text-muted h6 ms-1">등록할 설문조사의 제목을 입력해주세요.</p>
						<input type="text" class="form-control" id="srvyTtl" name="srvyTtl" onfocus="focused(this)" onfocusout="defocused(this)" />
					<c:choose>
						<c:when test="${authority eq 'admin'}">
							<input type="hidden" name="empNo" value="202300"/>
						</c:when>
						<c:otherwise>
							<sec:authorize access="isAuthenticated()">
								<sec:authentication property="principal.empVO" var="empVO" />
								<input type="hidden" name="empNo" value="${empVO.empNo}"/>
		<%-- 						<input type="hidden" name="srvyTrprVOList[0].empNo" value="${empVO.empNo}" /> --%>
							</sec:authorize>
						</c:otherwise>
					</c:choose>
					</div>
				<!-- 설문 기간 -->
					<div class="col-6">
							<p class="form-label h4 mt-3 mb-0">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
									  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
								</svg>
							설문기간</p>
							<p class="form-text text-muted h6 ms-1">설문조사를 진행할 일자를 선택해주세요.</p>
							<div class="row">
								<input class="form-control datepicker" placeholder="설문조사를 진행할 일자를 선택..." id="surveyDates" type="text" onfocus="focused(this)" onfocusout="defocused(this)" />
								<input type="hidden" name="srvyBgngYmd" id="srvyBgngYmd" /> <!-- 설문조사 시작일자 -->
								<input type="hidden" name="srvyEndYmd" id="srvyEndYmd" /> <!-- 설문조사 종료일자 -->
							</div>
					  </div>
				</div>
				<!-- end row 1 -->
				<!-- start row 2 -->
				<div class="row mt-5 pt-2 mb-3 pb-2 mx-2">
					<!-- 설문 대상자 -->
					<div class="col-7 col-sm">
							<div class="row w-100" style="margin-right:0px; padding-right:0px;">
								<div class="col-7">
									<div class="form-label h4 mt-3 mb-0">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
										  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
										</svg>
									설문 대상자
										<p class="form-text text-muted h6 ms-1 mt-0">설문조사 대상자를 추가해주세요.</p>
									</div>
								</div>
								<div class="col-4 mt-3 px-0">
									<a class="btn btn-lg btn-outline-secondary mt-1 mx-auto my-auto px-2 w-100"
										id="" style="width: 100px;" data-bs-toggle="modal" data-bs-target="#modal-default">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus-square" viewBox="0 0 16 16">
										  <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2z"/>
										  <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
										</svg>
									추가
									</a>
								</div>
							</div>
							<div class="col">
								<div style="border:2px solid #f5f7ff; width:auto; height:100px;" id="surveyTargetList"></div>
						</div>
					</div>
					<div class="row col-5">
							<div class="row mx-auto px-0">
							<div class="row">
								<p class="form-label h4 mt-3 mb-0">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
									  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
									</svg>
									알림여부
								</p>
								<p class="form-text text-muted h6 ms-1 mt-0">설문대상자에게 알림메일 발송여부 체크</p>
								<table class="mx-5">
									<tbody><tr>
										<td>
											<label>메일 알림</label>
											<div class="form-text text-muted h6 ms-1 mb-0"></div>
										</td>
										<td>
											<div class="form-check form-switch ms-1">
											<input class="form-check-input" type="checkbox" id="alarmMail" onclick="notify(this)" data-type="info" data-content="설문대상으로 설정된 대상자에게 메일 알림을 보냅니다." data-title="메일 알림 발송 체크" data-icon="ni ni-bell-55">
												<label class="form-check-label" for="alarmMail"></label>
										</div></td>
									</tr>
									<tr>
										<td>
											<label>실시간 알림</label>
											<div class="form-text text-muted h6 ms-1 mb-0"></div>
										</td>
										<td>
											<div class="form-check form-switch ms-1">
											<input class="form-check-input" type="checkbox" id="alarm" onclick="notify(this)" data-type="info" data-content="설문대상으로 설정된 대상자에게 실시간 알림을 보냅니다." data-title="실시간 알림 발송 체크" data-icon="ni ni-bell-55">
												<label class="form-check-label" for="alarm"></label>
											</div>
										</td>
									</tr>
								</tbody></table>
							</div>
						</div>
					</div>
				</div><!-- end row 2 -->
			</div>
			<div class="card card-body my-3"><!--카드 시작-->
				<!-- 설문내용 -->
				<label class="h4 mb-0">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
					  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
					</svg>
				설문 내용
				</label>
				<p class="form-text text-muted h6 ms-1 mt-0 mb-0">등록할 설문에 대한 설명을 입력해주세요.</p>
				<div class="form-group">
					<label class=""></label>
					<!-- 세로 : cols, 가로 : rows -->
					<textarea class="form-control w-100" cols="70" rows="2" id="srvyExpln" name="srvyExpln"></textarea>
				</div>
				<!-- 파일첨부 -->
					<label class="mt-4 h4 form-label mb-0">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
							  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
						</svg>
						파일첨부
					</label>
					<p class="form-text text-muted h6 ms-1">설문조사 내용을 설명할 첨부파일을 등록해주세요.</p>
					<div class="col-6">
						<div class="mb-3">
							<input type="file" id="fileElemlem" name="uploadFile" multiple accept="image/*" onchange="handleFiles(this.files)"><label style="width:100px;height:35px; right:10px;" class="button position-relative btn btn-sm btn-icon-only bg-gradient-light bottom-1 mb-n2 me-n2 pt-1 h6" for="fileElemlem">파일선택</label>
							<input type="hidden" name="empVO" value="${empVO.empNo}"/>
						</div>
						<progress id="progress-bar" max=100 value=0></progress>
			 	  </div>
			 	  <div id="drop-area" class="w-100">
					<div id="gallery">
						<br><br>
					</div>
				</div>

			<!--태그 시작 -->
				<div class="row"><!-- start row 3 -->
		            <label class="mt-4 h4 form-label">
			            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
						  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
						</svg>
		            설문조사  태그
		            </label>


		            <select class="form-control" name="hashTag" id="hashTag" multiple>

		            </select>
				</div><!-- end row 3 -->
			<!--태그 끝-->

			</div>	<!--카드 끝-->
			<!-- 카드시작 -->
			<div class="card card-body my-3">
				<!-- 질문내용 -->
				<label for="QustName" class="form-label h4 m-2 mt-0">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
					  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
					</svg>
					질문
				</label>
				<p class="form-text text-muted h6 ms-1">등록할 설문조사의 질문내용을 입력해주세요.</p>

				<div id="addQust">
				<div class="row mx-1 px-2 mb-2 qustBox" style="border:2px solid #f5f7ff; position:relative;"  >

					<div class="row qustList mb-3">
						<div class="col-8">
							<label class="mt-4 qnum">1.</label>
							<input type="text" class="qInput form-control" name="srvyQstnVOList[0].srvyQstnCn" placeholder="질문 내용 입력..." onfocus="focused(this)" onfocusout="defocused(this)"
									style="height:40px;"/>
							<a class="btn btn-outline-secondary m-1 p-1 px-2" style="position:absolute; top:5px; right:5px; background-color:white;">
								<span aria-hidden="true" class="">×</span>
							</a>
						</div>
						<div class="col-4">
							<div class="col-sm-6 mt-sm-0 mt-4">
								<label class="mt-4">질문유형</label>
								<select class="qInputType form-control choices-category" name="srvyQstnVOList[0].srvyQstnType" style="height:40px;">
									<option value="QSTN0001" selected="">선택형</option>
									<option value="QSTN0002">답변형</option>
								</select>
							</div>
						</div>
					</div>
					<!-- 질문보기 내용시작 -->
					<div class="row replyList exnum-0">
						<div class="col-8" style="margin-left:30px;">
							<input type="text" class="form-control" name="srvyQstnVOList[0].srvyQstnArtVOList[0].srvyQstnArtclCn" placeholder="보기 내용 입력..." onfocus="focused(this)" onfocusout="defocused(this)" />
							<input type="hidden"  name="srvyQstnVOList[0].srvyQstnArtVOList[0].srvyQstnArtclOrder" value="1" />
						</div>
						<div class="col-3 selectType">
							<input type="button" class="btn btn-outline-dark" onclick="fn_addExample(this,0)" value="추가" />
							<input type="button" class="btn btn-outline-dark" onclick="fn_removeExample(0)" value="삭제" />
						</div>
					</div>
					<!-- 질문보기 내용끝-->
					<!-- 질문내용 -->
				</div>
				</div>
<!-- 				<div id="addQust"></div> -->
				<button type="button" class="btn btn-secondary mt-2 mb-2 pt-2 pb-2" onclick="fn_addQust()"><span>질문 추가</span></button>

					<div class="d-flex justify-content-end mt-4 mb-3 pt-2 mb-2">
						<button type="button" class="btn btn-lg btn-secondary m-0">취소</button>
						<button type="button" onclick="fn_createSurvey()" class="btn btn-lg bg-gradient-dark m-0 ms-2">등록</button>
					</div>
				</div>
				<!--카드 끝-->
				<sec:csrfInput/>
			</form:form>
			</div>
		</div>
	</div>

<!-- 대상자 추가 모달창 -->
<div class="row">
	<div class="col-md-2">
		<div class="modal fade" id="modal-default" tabindex="-1" role="dialog"
			aria-labelledby="modal-default" aria-hidden="true">
			<div class="modal-dialog modal- modal-dialog-centered modal-lg"
				role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="modal-title-default">설문조사 대상자 추가</h4>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span class="h5" aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body" style="height: 600px;">
						<div class="nav-wrapper position-relative end-0 mb-3">
							<div class="row">
								<div class="col-lg-6 col-6">
									<div class="border-dashed border-1 border-secondary border-radius-md py-3 px-3 m-1">
										<h5 class="text-dark text-gradient mb-0">조직도</h5>
										<div id="orgList" style="overflow: scroll; height: 500px;">
											<ul id="browser" class="filetree treeview-famfamfam">
												<li class="dropdownLi" style="margin-left: -20px;">
													<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
														<span class="folder">그루IT</span>
													<ul id="folder21" class="adminEmpSrvy">
													</ul>
													<ul>
														<li class="closed dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
															<span class="folder" data-deptno="DEPT002">경영지원본부</span>
															<ul>
																<li class="closed suvyEmpList dropdownLi">
																<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																<span class="folder" data-deptno="DEPT003">재무팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																<span class="folder" data-deptno="DEPT004">인사팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																<span class="folder" data-deptno="DEPT005">총무팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21">
																	</ul></li>
															</ul></li>
														<li class="closed dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
															<span class="folder" data-deptno="DEPT010">영업본부</span>
															<ul>
																<li class="closed suvyEmpList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																	<span class="folder" data-deptno="DEPT011">영업팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21"></ul></li>
																<li class="closed suvyEmpList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																	<span class="folder" data-deptno="DEPT012">마케팅팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList dropdownLi"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																	<span class="folder" data-deptno="DEPT013">CS팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21">
																	</ul></li>
															</ul></li>
														<li class="closed"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
															<span class="folder" data-deptno="DEPT006">개발본부</span>
															<ul>
																<li class="closed suvyEmpList"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																	<span class="folder" data-deptno="DEPT007">서비스개발팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																	<span class="folder" data-deptno="DEPT008">플랫폼운영팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList"><i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;
																	<span class="folder" data-deptno="DEPT009">디자인팀<span class="srvyFile selectDept badge badge-secondary mx-2 p-1 py-1">+</span></span>
																	<ul id="folder21">
																	</ul></li>
															</ul></li>
													</ul></li>
											</ul>
										</div>
									</div>
								</div>
								<!-- 추가된 대상자 확인하는 공간 시작 -->
								<div class="col-lg-6 col-6">
									<div class="border-1 border-secondary border-radius-md">
										<div class="card-body">
											<div class="row">
												<div class="col-12">
													<div class="table-responsive">
														<div class="border-dashed border-1 border-secondary border-radius-md py-3 px-3 m-1" style="height: 560px;">
															<div>
																<h5>설문조사 대상자</h5>
																<hr class="horizontal dark mt-0">
																<div id="srvyTarget">
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- 추가된 대상자 확인하는 공간 끝 -->
							</div>
						</div>
					</div>
					<div class="modal-footer">
<!-- 						<button type="button" class="btn btn-outline-dark" onclick="fn_addAll()">전체 사원 추가</button> -->
						<button type="button" class="btn btn-outline-dark" id="reset">초기화</button>
						<button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal" onclick="fn_addTarget()">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
// 전체 사원 추가
// function fn_addAll(){

// 	console.log("전사원 추가");
// 	code ="";
//     code += "<span class='m-1 srvyTarget badge badge-secondary' data-deptNo='all' style='padding-right:10px;'>";
//     code += "<input type='hidden' name='srvyTrprVOList[0].deptNo' value='all' />"+ 전 사원 대상;
//     code += "<span style='margin-left:10px;' class='deleteTarget'><i class='fa-lg ni ni-fat-remove'></i></span></span></i>";
//     $("#srvyTarget").append(code);


// 	let targetList = document.querySelector("#surveyTargetList");
// 	let inputList = document.querySelector("#srvyTarget").innerHTML;
// 	targetList.innerHTML=inputList;
// }

// 설문조사 질문 추가
// datePicker에서 선택한 날짜 정보 기입
$("#surveyFrm").on("change",function(){
	let dateInfo = $("#surveyDates").val();
	dateArr = dateInfo.split("to");
	$("#srvyBgngYmd").val(dateArr[0]);
	$("#srvyEndYmd").val(dateArr[1]);
});

// 선택형, 답변형 선택할 때 적용되는 함수
$(document).on("change",".choices-category",function(){
	let obj = $(this);
	let objVal = $(this).val();
	console.log(obj);
	let qustBox = $(this).parents("div .qustBox");
	console.log("qustBox : " + qustBox);

	let replyList = $(this).parents("div .qustBox").find(".replyList");
	console.log("replyList : " + replyList);

	if(objVal == "QSTN0001"){
		replyList.css("display","");
	}
	if(objVal == "QSTN0002"){
		replyList.css("display","none");
	}
})

function fn_addQust(){
	//.qustBox의 개수
	let qIndex = $("#addQust .qustBox").length;
	let aIndex = $(".qustBox .exnum-"+qIndex+" ").length;

	console.log("질문 추가 버튼");
	console.log("qIndex : " + qIndex);
	console.log("aIndex : " + aIndex);
	code = "";
	code += '	<div class="row mx-1 px-2 mb-2 qustBox" style="border:2px solid #f5f7ff;  position:relative;">';
	code += '		<div class="row qustList mb-3">';
	code += '			<div class="col-8">';
	code += '				<label class="mt-4 qnum">'+(qIndex+1) +'.</label>';
	code += '				<input type="text" class="qInput form-control" name="srvyQstnVOList['+ qIndex+'].srvyQstnCn" placeholder="질문 내용 입력..." onfocus="focused(this)" onfocusout="defocused(this)" style="height;40px;" />';
	code += '					<a class="btn btn-outline-secondary delBtn m-1 p-1 px-2" style="position:absolute; top:5px; right:5px; background-color:white;">';
	code += '					<span aria-hidden="true" class="delBtn">×</span>';
	code += '					</a>';
	code += '			</div>';
	code += '			<div class="col-4">';
	code += '				<div class="col-sm-6 mt-sm-0 mt-4">';
	code += '					<label class="mt-4">질문유형</label>';
	code += '					<select class="qInputType form-control choices-category" name="srvyQstnVOList['+ qIndex+'].srvyQstnType" style="height;40px;">';
	code += '						<option value="QSTN0001" selected="">선택형</option>';
	code += '						<option value="QSTN0002">답변형</option>';
	code += '					</select>';
	code += '				</div>';
	code += '			</div>';
	code += '		</div>';
	code += '		<!-- 질문보기 내용시작 -->';
	code += '		<div class="row replyList exnum-'+qIndex+'">';
	code += '			<div class="col-8" style="margin-left:30px;">';
	code += '				<input type="text" class="form-control" name="srvyQstnVOList['+ qIndex+'].srvyQstnArtVOList['+ aIndex+'].srvyQstnArtclCn" placeholder="보기 내용 입력..." onfocus="focused(this)" onfocusout="defocused(this)" />';
	code += '				<input type="hidden"  name="srvyQstnArtVOList['+ qIndex+'].srvyQstnArtVOList['+ aIndex +'].srvyQstnArtclOrder" value="' + (aIndex+1) + '" />';
	code += '			</div>';
	code += '			<div class="col-3 selectType">';
	code += '				<input type="button" class="btn btn-outline-dark" onclick="fn_addExample(this,'+qIndex+')" value="추가" />';
	code += '				<input type="button" class="btn btn-outline-dark" onclick="fn_removeExample('+qIndex+')" value="삭제" />';
	code += '			</div>';
	code += '		</div>';
	code += '	</div>';

	$("#addQust").append(code);
}

//2. 보기 추가-------------------------------
function fn_addExample(obj,qIndex) {
	let aIndex = $(".exnum-"+ qIndex).length;
	console.log(".exnum-"+qIndex);

	console.log("보기 추가 버튼");
	console.log("qIndex : " + qIndex);
	console.log("aIndex : " + aIndex);

	  // 버튼을 누른 위치에 대한 요소를 찾아 replyList 변수에 저장
	  var replyList = $(event.target).closest('.replyList');

	  let  code ="";

	  code += '		<div class="row replyList exnum-'+ qIndex +'">';
	  code += '			<div class="col-8" style="margin-left:30px;">';
	  code += '				<input type="text" 		class="anumCn-'+qIndex+' form-control" name="srvyQstnVOList['+ qIndex+'].srvyQstnArtVOList['+ aIndex+'].srvyQstnArtclCn" placeholder="보기 내용 입력..." onfocus="focused(this)" onfocusout="defocused(this)" />';
	  code += '				<input type="hidden"  	class="anumOrder-'+qIndex+'"+ name="srvyQstnVOList['+ qIndex+'].srvyQstnArtVOList['+ aIndex+'].srvyQstnArtclOrder" value="' + (aIndex+1) + '" />';
	  code += '			</div>';
	  code += '			<div class="col-3 selectType">';
	  code += '				<input type="button" class="btn btn-outline-dark" onclick="fn_addExample(this,'+qIndex+')" value="추가" />';
	  code += '				<input type="button" class="btn btn-outline-dark" onclick="fn_removeExample('+qIndex+')" value="삭제" />';
	  code += '			</div>';

	  // 새로운 replyList 요소를 해당 버튼 요소의 부모 요소에 추가
	  replyList.after(code);
	}

// 보기 항목 하나 삭제
function fn_removeExample(qIndex) {
	  // 삭제 버튼을 누른 위치에 대한 요소를 찾아 replyList 변수에 저장
	  var replyList = $(event.target).closest('.replyList');
	  // replyList 요소를 삭제
	  replyList.remove();

	  // 보기삭제 시 나머지 name정렬
	  // qIndex ==> 보기가 속한 질문 인덱스
	  console.log("qIndex : " +qIndex);

		  console.log("보기삭제시 일어나는 이벤트")
	  $(".exnum-"+qIndex).each(function(index){
		  console.log("---------------")
		  console.log("index : " + index);
// 		  $(".anum").
	  })
}

//x 클릭 시 질문 박스가 사라짐
$(document).on("click",".delBtn",function(){
	console.log("삭제버튼")
	console.log(this);
	let qustBox = this.parentNode.parentNode.parentNode.parentNode;
	console.log("qustBox : " , qustBox);
	qustBox.remove();

	// 삭제 시 name 정렬
	console.log("qnum.length : " + $(".qnum").length);

    $(".qnum").each(function(index){
	  console.log("index : " + index);
	 $(this).text((index+1) + ".");
    });

    // 질문내용 name
    $(".qInput").each(function(index){
		 $(this).attr("name","srvyQstnVOList["+index+"].srvyQstnCn");
    });
    // 질문유형 name
    $(".qInputType").each(function(index){
		 $(this).attr("name","srvyQstnVOList["+index+"].srvyQstnType");
    });
})
</script>

<!-- 설문조사 대상자 추가 조직도 시작 -->
<script>
// 최상위에 있는 직원 붙이기
$.ajax({
	url:"/org/orgAdminEmp",
	type:"post",
	beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	},
	success:function(result){
		let str = "";
		$.each(result,function(i,v){
			str+= "<li><i class='fas fa-user text-secondary text-sm' ></i>&nbsp;<a class='srvyFile' data-empno='"+v.empNo+"'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
		});
		$(".adminEmpSrvy").append(str);
	}
});

//.suvyEmpList를 선택하면 (this) 아작스 호출해서 해당 태그 자식에 요소 append
// (조직도 폴더 클릭 시 사원 붙이기)
$('.suvyEmpList').on('click',function(){

	//부서 번호 변수에 담기
	let deptNo = $(this).children('span').data('deptno');
	let $_target = $(this);
	let data = {"deptNo" : deptNo};

	$.ajax({
		url:"/org/orgEmp",
		type:"post",
		data: JSON.stringify(data),
		contentType:"application/json;charset=utf-8",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			let str = "";
			console.log(result);
			$.each(result,function(i,v){
				str+= "<li><a class='srvyFile' data-empno='"+v.empNo+"'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
			});
			$($_target).find('ul').html(str);
		}
	});
})

$(document).on('click', '.srvyFile', function() {
	console.log(this);
	let obj = $(this);
	console.log("text ==> ",obj.text());
	code = "";

	 //사원 번호 대상자 목록 공간에 담기 (모달 안)
	 let empNo = obj.data('empno');
	 let deptNo = obj.parent().data('deptno');
	 let deptNm = obj.parent().text().replaceAll("+","");

	 console.log("check ==> ",empNo," ", deptNo, " ", deptNm);
	 let data = {"empNo": empNo};

	// 이미 추가된 사원인지 확인
	var ele = document.getElementById('srvyTarget');
	var spanIndex = ele.childElementCount+1;
	console.log("spanIndex 1 : " , spanIndex);

      // 설문대상 부서 추가
	if(deptNo != null){
	      code += "<span class='m-1 srvyTarget badge badge-secondary' data-deptNo='" + deptNo + "' style='padding-right:10px;'>";
	      code += "<input type='hidden' name='srvyTrprVOList[" + (spanIndex-1) + "].deptNo' value='" + deptNo + "' />"+ deptNm;
	      code += "<span style='margin-left:10px;' class='deleteTarget'><i class='fa-lg ni ni-fat-remove'></i></span></span></i>";
	}else{
		// 사원대상 추가
	  $.ajax({
	    url: "/org/empModal",
	    type: "post",
	    data: JSON.stringify(data),
	    contentType: "application/json;charset=utf-8",
	    beforeSend: function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
	      xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    },
	    success: function(result) {

    	  // 설문대상 사원 추가
	      if(result.empNo != null){
		      code += "<span class='m-1 srvyTarget badge badge-secondary' data-empNo='" + result.empNo + "' style='padding-right:10px;'>";
		      code += "<input type='hidden' name='srvyTrprVOList[" + (spanIndex-1) + "].empNo' value='" + result.empNo + "' />" + result.deptNm + " " + result.empNm + " " + result.jbpsNm;
		      code += "<span style='margin-left:10px;' class='deleteTarget'><i class='fa-lg ni ni-fat-remove'></i></span></span></i>";
	      }
	      code += "";

	      // 대상자 목록에서 중복된 정보가 있는지 검사
	      if (isTargetDuplicated(empNo, deptNo)) {
	        alert("이미 추가된 대상자입니다.");
	        return;
	      }

	      $("#srvyTarget").append(code);

	      //삭제버튼을 누르면
	      $('.deleteTarget').off('click').on('click', function() {
	        // Get the current row and index
	        var currentRow = $(this).parent().closest('span');
	        var currentIndex = currentRow.index();

	        //내가누른 요소를 업애줌
	        currentRow.remove();
	        console.log("currentRow : ",currentRow);
	      });
	    }
	  }); // empModal ajax 끝
	}
	  $("#srvyTarget").append(code);
	});

//대상자 중복 체크 함수
  function isTargetDuplicated(empNo, deptNo) {
    var targetList = document.getElementById("surveyTargetList");
    for (var i = 0; i < targetList.children.length; i++) {
      var target = targetList.children[i];
      if (
        target.getAttribute("data-empno") === empNo ||
        target.getAttribute("data-deptno") === deptNo
      ) {
        return true;
      }
    }
    return false;
  }

// function isTargetDuplicated(empNo, deptNo) {
// 	console.log("중복체크하러는 오는지?");
// 	let res = 0;
//  var targetList = document.getElementById("surveyTargetList");
//  for (var i = 0; i < targetList.children.length; i++) {
//    var target = targetList.children[i];
//    if (
//      target.getAttribute("data-empno") === empNo ||
//      target.getAttribute("data-deptno") === deptNo
//    ) {
//      res += 1;
//    }
//  } // end for targetList

//  var targetModal = document.getElementById("surveyTarget");

// //  for (var i = 0; i < targetModal.children.length; i++) {
// //    var target = targetModal.children[i];
// //    if (
// //      target.getAttribute("data-empno") === empNo ||
// //      target.getAttribute("data-deptno") === deptNo
// //    ) {
// //      res += 1;
// //    }
//  } // end for target Modal
// 	if(res > 0){
// 		return true;
// 	}
//  return false;
// }



//담아둔 대상 목록 초기화
$("#reset").on("click",function(){
	$("#srvyTarget").empty();
})

//사원 번호 대상자 목록 공간에 담기 (모달 바깥)
function fn_addTarget(){
	let targetList = document.querySelector("#surveyTargetList");
	let inputList = document.querySelector("#srvyTarget").innerHTML;
	targetList.innerHTML=inputList;
}

$(document).on('click','#surveyTargetList .deleteTarget', function() {
	let target = $(this).parents(".srvyTarget");
	// 모달창 밖에 있는 요소 삭제 시
	$(this).parents(".srvyTarget").remove();
	// 모달창에 안에 있는 요소도 삭제
	$("#srvyTarget").find("span[data-empno="+target.data("empno")+"]").remove();
	$("#srvyTarget").find("span[data-deptno="+target.data("deptno")+"]").remove();
});

</script>
<!-- 설문조사 대상자 추가  조직도 끝 -->
<!-- choice (태그) 시작 -->
 <script>
 	var hashTagListVOList = ${hashTagListVOList};
	console.log("hashTagListVOList : " + hashTagListVOList);

    if (document.getElementById('hashTag')) {
      var element = document.getElementById('hashTag');
      const example = new Choices(element, {
        removeItemButton: true
      });

      // json형식으로 태그 목록을 가져오기
      // ajax로 실행해야겠다
      example.setChoices(
  		hashTagListVOList,
        'value',
        'label',
        false
      );
      example.setChoiceByValue(hashTagListVOList[0].value);
    }
</script>
<!-- choice 끝 -->
<!-- date Picker 시작 -->
<script>
if (document.querySelector('.datepicker')) {
  flatpickr('.datepicker', {
    mode: "range",
   	minDate: new Date().fp_incr(0)
  });
}
</script>
<!-- date Picker 끝 -->
<!-- ckeditor 시작 -->
		<script type="text/javascript">
	CKEDITOR.replace('srvyExpln');
	CKEDITOR.resize("300px", "500px");
</script>
<!-- ckeditor 끝 -->

<!-- 파일첨부 시작 -->
<script>
//************************ Drag and drop ***************** //
let dropArea = document.getElementById("drop-area")

// Prevent default drag behaviors
;['dragenter', 'dragover', 'dragleave', 'drop'].forEach(eventName => {
  dropArea.addEventListener(eventName, preventDefaults, false)
  document.body.addEventListener(eventName, preventDefaults, false)
})

// Highlight drop area when item is dragged over it
;['dragenter', 'dragover'].forEach(eventName => {
  dropArea.addEventListener(eventName, highlight, false)
})

;['dragleave', 'drop'].forEach(eventName => {
  dropArea.addEventListener(eventName, unhighlight, false)
})

// Handle dropped files
dropArea.addEventListener('drop', handleDrop, false)

function preventDefaults (e) {
  e.preventDefault()
  e.stopPropagation()
}

function highlight(e) {
  dropArea.classList.add('highlight')
}

function unhighlight(e) {
  dropArea.classList.remove('active')
}

function handleDrop(e) {
  var dt = e.dataTransfer
  var files = dt.files

  handleFiles(files)
}

let uploadProgress = []
let progressBar = document.getElementById('progress-bar')

function initializeProgress(numFiles) {
  progressBar.value = 0
  uploadProgress = []

  for(let i = numFiles; i > 0; i--) {
    uploadProgress.push(0)
  }
}

function updateProgress(fileNumber, percent) {
  uploadProgress[fileNumber] = percent
  let total = uploadProgress.reduce((tot, curr) => tot + curr, 0) / uploadProgress.length
  progressBar.value = total
}

function handleFiles(files) {
  files = [...files]
  initializeProgress(files.length)
  files.forEach(uploadFile)
  files.forEach(previewFile)
}

function previewFile(file) {
  let reader = new FileReader()
  reader.readAsDataURL(file)
  reader.onloadend = function() {
    let img = document.createElement('img')
    img.src = reader.result
    $("#gallery").append(img);

//     document.getElementById('gallery').empty();
//     document.getElementById('gallery').append(img);
  }
}

function uploadFile(file, i) {
  var url = 'https://api.cloudinary.com/v1_1/joezimim007/image/upload'
  var xhr = new XMLHttpRequest()
  var formData = new FormData()
  xhr.open('POST', url, true)
  xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest')

  // Update progress (can be used to show progress indicator)
  xhr.upload.addEventListener("progress", function(e) {
    updateProgress(i, (e.loaded * 100.0 / e.total) || 100)
  })

  xhr.addEventListener('readystatechange', function(e) {
    if (xhr.readyState == 4 && xhr.status == 200) {
      updateProgress(i, 100) // <- Add this
    }
    else if (xhr.readyState == 4 && xhr.status != 200) {
      // Error. Inform the user
    }
  })

  formData.append('upload_preset', 'ujpu6gyk')
  formData.append('file', file)
  xhr.send(formData)
}

</script>
<!-- 파일첨부 끝 -->
<script>
//설문 제출 전 확인
function fn_createSurvey(){
	// 공란이 있는지 확인
	let srvyTtl =$("#srvyTtl").val();
// 	let srvyExpln = $("#srvyExpln").val();
	let srvyTrpr = $("#srvyTarget span").length/2;
	let surveyDate = $("#srvyBgngYmd").val();

	console.log("srvyTrpr : " + srvyTrpr);
// 	console.log("srvyExpln : " + srvyExpln);
	console.log("surveyDate : " + surveyDate);
	console.log("srvyTtl : " + srvyTtl);

	if(srvyTtl == null || srvyTtl == ''){
	      swal({
	    	title: "설문등록 오류",
	    	text : "설문조사 제목을 입력해주세요!",
	    	icon :"error"
	    });
    	$("#srvyTtl").focus();
		return false;
	}
	if(surveyDate == null || surveyDate == ''){
// 	if(surveyDate.length == 0 ){
	      swal({
	    	title: "설문등록 오류",
	    	text : "설문조사 날짜 정보를 입력해주세요!",
	    	icon :"error"
	    });
    	$("#srvyTtl").focus();
		return false;
	}

	if(srvyTrpr == 0){
	      swal({
	    	title: "설문등록 오류",
	    	text : "대상자 추가 없이 설문조사를 등록할 수 없습니다!",
	    	icon :"error"
	    });
        $("#srvyTtl").focus();
		return false;
	}

	swal({
		  title: "'" + srvyTtl + "' 설문조사를 등록하시겠습니까?",
		  text: "확인을 누르면 설문조사가 등록됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "등록",
				value : "createOk"
			  }
			},
		})
		.then((value) => {
		  switch (value) {
		    case "createOk":
				$("#surveyFrm").submit();
		    	break;
		    default:
		      swal({
	 		    	title: "설문 답변등록 취소!",
	 		    	icon :"error"
	 		    });
		 	 }
		});
}
</script>
