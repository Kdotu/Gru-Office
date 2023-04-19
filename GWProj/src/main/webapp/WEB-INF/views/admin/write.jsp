<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery-3.6.3.min.js"></script>

<script src="/resources/ckeditor/ckeditor.js"></script>
<script
	src="/resources/maincss/assets/js/plugins/dropzone.min.js"></script>



<!-- 전체게시판 목록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-3">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->
			<!-- body_center -->

						<div class="" >
							<p>공지게시판</p>
							<div class="row">
								<div class="col-9" >
									<button type="button" class="btn btn-info btn-sm">글쓰기</button>
									<button type="button" class="btn btn-success btn-sm">메일발송</button>
									<button type="button" class="btn btn-success btn-sm">수정</button>
									<button type="button" class="btn btn-danger btn-sm">삭제</button>
									<button type="button" class="btn btn-success btn-sm">목록</button>
								</div>

								<div class="col-3">
									<div class="dataTable-search">
										<input class="dataTable-input" placeholder="Search..."
											type="text">
									</div>
								</div>
							</div>
						</div>
			<div class="card">





						<div class="dataTable-top">
							<form>
								<div class="form-group row">
									<div class="col-sm-1">
										<label for="inputtitle3" class="col-form-label lb">제목</label>
									</div>
									<div class="col-sm-11" style="margin-left: -35px;">
										<div class="form-check" style="width: 100%;">
											<div style="float: left; margin-top: 5px;"></div>
											<div style="float: left; margin-top: 5px;"></div>
											<div style="float: left; margin-left: 10px; width: 80%;">
												<input type="Title" class="form-control" id="inputtitle3"
													placeholder="Title" style="width: 100%;" />
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>

						<div class="form-check form-switch" style="margin-left: 15px;">
							<span>공지팝업</span> <input class="form-check-input" type="checkbox"
								id="flexSwitchCheckDefault" onclick="notify(this)"
								data-type="warning"
								data-content="Once a project is made private, you cannot revert it to a public project."
								data-title="Warning" data-icon="ni ni-bell-55"> <label
								class="form-check-label" for="flexSwitchCheckDefault"></label>
						</div>

						<div class="dataTable-top row">
							<div class="col-sm-1">
								<label for="inputfile3" class="col-form-label lb">파일첨부</label>
							</div>
							<div class="col-sm-11">
								<!-- 							    <input type="button" name="file" id="file" value="파일선택" > -->
								<!-- 							     <input type="file" class="form-control" id="inputfile3" placeholder="여기에 첨부파일을 끌어오세요. 또는 파일선택"> -->
								<form action="/file-upload" class="form-control dropzone"
									id="dropzone" />
								<div class="fallback">
									<input name="file" type="file" id="file" multiple />
								</div>
							</div>
						</div>





					<!-- ckeditor -->
					<div class="form-group row" style="margin-left: 20px;">
						<label class="col-sm-2"></label>
						<div style="width: 90%;">
							<!-- 세로 : cols, 가로 : rows -->
							<textarea class="form-control" cols="70" rows="2" id="description"
								name="description"></textarea>
						</div>
					</div>
					<div style="text-align: center;">
						<button type="button" class="btn btn-info btn-sm">등록</button>
					</div>
					</div>
			</div>
		</div>
</div>
<script type="text/javascript">
	CKEDITOR.replace('description');

	CKEDITOR.resize("300px", "500px");
</script>
