<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- 다음 우편번호  -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- sweet alert  -->
<script src="/resources/js/sweetalert.min.js"></script>
<div
	class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg"
	style="background-image: url('/resources/image/laptop.jpg');">
	<span class="mask bg-gradient-dark opacity-6"></span>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-5 text-center mx-auto">
				<h1 class="text-white mb-2 mt-5">Welcome!</h1>
				<h5 class="text-white mb-2 mt-5">GruOffice</h5>
				<p class="text-lead text-white">시간과 장소에 얽매이지 않고 언제 어디에서나!</p>
				<p class="text-lead text-white">조직의 업무 환경을 더 효율적이고 편리하게</p>
			</div>
		</div>
	</div>
</div>
<div class="container">
	<div class="row mt-lg-n10 mt-md-n11 mt-n10 justify-content-center">
		<div class="col-xl-7 col-lg-6 col-md-7 mx-auto">
			<div class="card z-index-0 mb-5">
				<div class="card-header text-center pt-4 mx-2 mt-2">
					<table class="mx-auto w-100">
						<tbody>
							<tr>
								<td style="align: center;"><img
									class="px-auto mx-3 mt-2 mb-2"
									style="width: 120px; height: 120px; float: left;"
									src="/resources/image/logo6.png" alt="bear-logo.png"></td>
								<td rowspan="2">
									<h3>회원가입</h3>
								</td>
							</tr>
							<tr>
								<td style="align-content: center;">
									<h5>GruOffice</h5>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="container-fluid py-4">
					<div class="row">
						<div class="col-12">
							<div class="multisteps-form">

								<div class="row">
									<div class="col-12 col-lg-10 mx-auto my-3">
										<div class="multisteps-form__progress">
											<button class="multisteps-form__progress-btn js-active"
												type="button" title="Company BasicInfo">
												<span>회사 기본정보</span>
											</button>
											<button class="multisteps-form__progress-btn" type="button"
												title="Company DetailInfo">회사 추가정보</button>
											<button class="multisteps-form__progress-btn" type="button"
												title="Admin Info">관리자정보</button>
										</div>
									</div>
								</div>

								<div class="row">
									<div class="m-auto">
										<form method="post" action="/joinPost" id="joinFrm"
											class="multisteps-form__form mb-3" style="height: 408px;">
											<div class="multisteps-form__panel p-3 border-radius-xl bg-white js-active"
												data-animation="FadeIn">
												<h5 class="font-weight-bolder mb-0">기업 회원가입</h5>
												<p class="mb-0 text-sm">기업 정보를 입력하여 회원가입을 진행해주세요.</p>
												<div class="multisteps-form__content">
													<div class="row mt-4">
														<div class="col-12 col-sm-6">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															회사명</label>
															<input type="text" class="multisteps-form__input form-control"
																id="empNm" name="empNm" placeholder="회사명 입력..."
																onfocus="focused(this)" onfocusout="defocused(this)"
																 />
														</div>
														<div class="col-12 col-sm-6 mt-3 mt-sm-0">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																	  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															회사 연락처</label>
															<input type="text" class="multisteps-form__input form-control" name="empMblTelno" id="empMblTelno"
																placeholder="연락처 입력 ex) 010-0000-0000" />
														</div>
													</div>
													<div class="row mt-3">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																	  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															사업자등록번호 <span class="mx-3 mb-0 text-sm" style="color:#8392ab;">숫자만 입력해주세요. ex) 4082420619</span></label>
														<div class="col col-sm-8">
															<input  type="text" class="multisteps-form__input form-control" placeholder="사업자등록번호 입력..." id="businessNo" name="empRrno" />
														</div>
														<div class="col">
														<a onclick="fn_autoWrite1()">　</a>
															<input type="button" class="btn btn-info w-60" id="btnRegNo"
																style="float: right; font-size:1.2em;"  value="인증" />
														</div>
													</div>
														<div class="row" style="clear: both;">
															<input type="hidden" name="empJncmpYmd" id="empJncmpYmd" />
															<label class="form-label mt-2 h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																	  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															회사설립일</label>
															<div class="col-5" style="margin-left: 20px;">
																<label class="form-label h6">연도</label>
																 <select class="form-control" name="choices-year" id="choices-year"></select>
															</div>
															<div class="col-3">
																<label class="form-label h6">월</label>
																<select class="form-control" name="choices-month" id="choices-month"></select>
															</div>
															<div class="col-3">
																<label class="form-label h6">일</label>
																<select class="form-control" name="choices-day" id="choices-day"></select>
															</div>
														</div>
														<div class="row mt-3">
														<div class="button-row d-flex mt-3">
															<button type="button"
																class="btn bg-gradient-dark btn-lg ms-auto mb-0" data-bs-toggle="tooltip" data-bs-placement="top"
																title="작성하지 않은 항목이 있습니다." data-container="body" data-animation="true"
																title="Next" id="fPage">Next</button>
														</div>
													</div>
												</div>
											</div>
											<div class="multisteps-form__panel p-3 border-radius-xl bg-white"
												data-animation="FadeIn">
												<h5 class="font-weight-bolder">회사주소 정보</h5>
												<div class="multisteps-form__content">
													<div class="row mt-3">
														<div class="col">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																	  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															기본주소</label>
															<input type="text"
																class="multisteps-form__input form-control"
																name="empAddr" id="empAddr" placeholder="기본주소 입력..." />
														</div>
													</div>
													<div class="row mt-3">
														<div class="col">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																	  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															상세주소</label>
															<input type="text" class="multisteps-form__input form-control"
																name="empDaddr" id="empDaddr" placeholder="상세주소 입력..." />
														</div>
													</div>
													<div class="row mt-3">
														<div class="col row">
															<div class="col-6 mt-3 mt-sm-0">
																<label class="h5">
																	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																		  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																	</svg>
																우편번호</label>
																<input type="text" class="multisteps-form__input form-control"
																	placeholder="우편번호 입력..." maxlength="5"  name="empZip" id="empZip" />
															</div>
															<div class="col-6 mt-3 mt-sm-0">
																<label class="h5" style="font-size:1.2em;">
																	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																		  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																	</svg>
																주소 검색</label>
																<input type="button" class="w-100 btn btn-info" style="font-size : 1.2em;" value="검색" id="btnPostNo" />
															</div>
														</div>
														<div class="button-row d-flex mt-5">
															<button type="button" class="btn bg-gradient-light mb-0 js-btn-prev" title="Prev">Prev</button>
															<button type="button" class="btn bg-gradient-dark btn-lg ms-auto mb-0" data-bs-toggle="tooltip" data-bs-placement="top"
																title="작성하지 않은 항목이 있습니다." data-container="body" data-animation="true" id="sPage">Next</button>
														</div>
														</div>
													</div>
												</div>
											<div class="multisteps-form__panel p-3 border-radius-xl bg-white"
												data-animation="FadeIn">
												<h5 class="font-weight-bolder">관리자정보</h5>
												<div class="multisteps-form__content">
													<div class="row mt-3">
														<div class="col-9 mt-3 mt-sm-0">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															아이디</label>
															<p class="mb-0 text-sm">숫자 6자리 조합으로 입력해주세요</p>
															 <input type="text" class="multisteps-form__input form-control" id="empNo"
																name="empNo" placeholder="ex) 201023" maxlength="6" />
														</div>
														<div class="col mt-5">
															<input type="button" id="idCheck" class="btn btn-info btn-tooltip mx-0 px-1 mt-1" data-bs-toggle="tooltip" data-bs-placement="top"
																title="등록된 회원 중 아이디가 중복되는 회원이 있는지 검사합니다." data-container="body" data-animation="true"
																style="font-size : 1.2em;" value="아이디 중복체크" />
														</div>
													</div>
													<div class="row">
														<div class="col-12 col-sm-6">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															비밀번호</label>
															<input type="password" class="multisteps-form__input form-control" placeholder="******" id="empPswdFirst" />
														</div>
														<div class="col-12 col-sm-6 mt-3 mt-sm-0">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															비밀번호 확인</label>
															<input type="password" class="multisteps-form__input form-control" placeholder="******" id="empPswd" name="empPswd" />
														</div>
													</div>
													<div class="row mt-3">
														<div class="col mt-3 mt-sm-0">
															<label class="h5">
																<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-caret-right-fill" viewBox="0 0 16 16">
																  <path d="m12.14 8.753-5.482 4.796c-.646.566-1.658.106-1.658-.753V3.204a1 1 0 0 1 1.659-.753l5.48 4.796a1 1 0 0 1 0 1.506z"/>
																</svg>
															이메일주소</label>
															<table class="w-100">
																<tbody>
																	<tr>
																		<td>
																		<div class="row">
																				<div class="col-3 mx-1 px-1">
																					<input type="text"  class="multisteps-form__input form-control"
																						placeholder="gru_office" name="emailAddr1" id="emailAddr1" />
																				</div>
																				<div class="col-3 mx-1 px-1">
																					<input type="text" class="form-control"
																						style="display: block;"
																						name="emailAddr2" id="emailAddr2" value="@" />
																				</div>
																				<div class="col-5 mx-1 px-1">
																					<div class="col">
																						 <select class="form-control" name="choices-email" id="choices-email"></select>
																					</div>
																				</div>
																				<input type="hidden" name="empEmlAddr" id="empEmlAddr" />
																			</div>
																		</td>
																	</tr>
																</tbody>
															</table>
														</div>
													</div>
													<div class="row mt-3">
														<div class="col mt-3 mt-sm-0">
															<!-- 이메일 인증번호 -->
															<div class="row">
																<div class="col-8">
																	<input type="text" class="form-control w-100"
																		style="clear: both;" placeholder="이메일 인증번호 6자리 입력.."
																		id="emailChkInput" disabled maxlength="6" />
																</div>
																<div class="col-4">
																	<input type="button" class="btn btn-info w-100" style="font-size : 1.2em;"
																		value="인증" id="btnEmailChk" />
																	<input type="button" class="btn btn-info w-100" style="display:none;"
																		value="인증번호 입력" id="btnEmailChkNum" />
																</div>
															</div>
															<input type="hidden" id="emailChk" />
															<input type="hidden" id="emailChkNum" />
														</div>
													</div>
												<sec:csrfInput />
													<div class="button-row d-flex mt-5">
														<button type="button" class="btn bg-gradient-light mb-0 js-btn-prev"
															 title="Prev" onclick="fn_foldPopover()" >Prev</button>
															 <a onclick="fn_autoWrite2()">　</a>
														<input type="button"  class="btn bg-gradient-dark btn-lg ms-auto mb-0 btn-tooltip" data-bs-toggle="tooltip" data-bs-placement="top"
																title="작성하지 않은 항목이 있습니다." data-container="body" data-animation="true"
															id="btnJoin" value="회원가입" />
													</div>
												</div>
											</div>
										</form>
									<div class="mt-1"
										style="text-align: center; align-content: center;">
										<p class="text-sm mt-5 mb-1" style="clear: both;">
											기존 회원이신가요? <a href="/main"
												class="text-dark font-weight-bolder">로그인하러가기</a>
										</p>
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
</div>
<jsp:include page="/WEB-INF/views/tiles/footer.jsp" />

<script
	src="/resources/maincss/assets/js/plugins/multistep-form.js"></script>
<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>

<script>
	// 회원가입 버튼 클릭 시
	$("#btnJoin").on("click",function(){
		console.log("회원가입버튼 클릭");
		let year = $("#choices-year").val();
		let month = $("#choices-month").val();
		let day = $("#choices-day").val();
		if(month < 10){month = '0'+month;}
		if(day < 10){day = '0'+day;}

		let empJncmpYmd = year + '-' + month + '-' + day;
		console.log(empJncmpYmd);
		$("#empJncmpYmd").val(empJncmpYmd);

		let input = $("#emailChkInput").val();
		let chk = $("#emailChkNum").val();
		let empNo = $("#empNo").val();

		if(input == chk && empNo.length == 6){
			$("#joinFrm").submit();
		}
	});

	function chkPW(){
		var pw = $("#empPswd").val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

		if( (pw.length < 8) || (pw.length > 20) ){
			swal({
			      title: "패스워드 오류",
			      icon: "warning", //success, warning, error
			      text: "8자리 ~ 20자리 이내로 입력해주세요.",
			      button: "확인",
			   });
			return false;
		}else if(pw.search(/\s/) != -1){
			swal({
			      title: "패스워드 오류",
			      icon: "warning", //success, warning, error
			      text: "비밀번호는 공백 없이 입력해주세요.",
			      button: "확인",
			   }).then(function () {
//						   location.reload();
			    });
			return false;
		}else if(num < 0 || eng < 0 || spe < 0 ){
			swal({
			      title: "패스워드 오류",
			      icon: "warning", //success, warning, error
			      text: "영문,숫자, 특수문자를 혼합하여 입력해주세요.",
			      button: "확인",
			   });
			return false;
		}else {
			return true;
		}
	}

	// form 태그 작성 시 변화주는 함수
	$("#joinFrm").on("change",function() {
		let empNm = $("#empNm").val();
		let empMblTelno = $("#empMblTelno").val();

		let empRrno = $("#empRrno").val();
		let empZip = $("#empZip").val();
		let empDaddr = $("#empDaddr").val();
		let empAddr = $("#empAddr").val();

		let empPswdFirst = $("#empPswdFirst").val();
		let empPswd = $("#empPswd").val();

		// 비밀번호
		// 값이 들어가면 초록창이 뜨도록
		if( (empPswdFirst.length > 0 && empPswd.length > 0) &&(empPswdFirst == empPswd) ){
			if(chkPW()){
				$("#empPswdFirst").attr("class", "form-control multisteps-form__input is-valid");
				$("#empPswd").attr("class", "form-control multisteps-form__input is-valid");
				$("#pswdError").html("");
			}else{
				return;
			}
		}
		// 값이 없어지면 일반창으로 돌아오도록
		if( (empPswdFirst.length == 0 && empPswd.length == 0) ){
			$("#empPswdFirst").attr("class", "form-control multisteps-form__input");
			$("#empPswd").attr("class", "form-control multisteps-form__input");
			$("#pswdError").html("");
		}
		// 비밀번호 확인 => 값이 다르면 빨간창이 뜨도록
		if( (empPswdFirst.length > 0 && empPswd.length > 0) &&(empPswdFirst != empPswd) ){
			$("#empPswdFirst").attr("class", "form-control multisteps-form__input is-invalid");
			$("#empPswd").attr("class", "form-control multisteps-form__input is-invalid");
		}

		// 초록창 처리
		if ((empNm != null && empNm.length > 0)) {
			$("#empNm").attr("class", "form-control multisteps-form__input is-valid");
		}
		if ((empAddr != null && empAddr.length > 0)) {
			$("#empAddr").attr("class", "form-control multisteps-form__input is-valid");
		}
		if ((empDaddr != null && empDaddr.length > 0)) {
			$("#empDaddr").attr("class", "form-control multisteps-form__input is-valid");
		}
		if ((empZip.length == 5)) {
			$("#empZip").attr("class", "form-control multisteps-form__input is-valid");
			$("#sPage").attr("class","btn bg-gradient-dark btn-lg ms-auto mb-0 js-btn-next");
			$("#sPage").removeAttr("data-bs-original-title");
		}
		if ((empMblTelno.length > 0)) { // 전화번호 유효성 검사해야함
			$("#empMblTelno").attr("class", "form-control multisteps-form__input is-valid");
		}
		// 일반창 복귀
		if (empNm.length == 0) {
			$("#empNm").removeAttr("class");
			$("#empNm").attr("class", "form-control multisteps-form__input");
		}
		if (empAddr.length == 0) {
			$("#empAddr").removeAttr("class");
			$("#empAddr").attr("class", "form-control multisteps-form__input");
		}
		if (empDaddr.length == 0) {
			$("#empDaddr").removeAttr("class");
			$("#empDaddr").attr("class", "form-control multisteps-form__input");
		}
		if (empZip.length < 5 ) {
			$("#empZip").removeAttr("class");
			$("#empZip").attr("class", "form-control multisteps-form__input");
		}
		if (empMblTelno.length == 0) {
			$("#empMblTelno").removeAttr("class");
			$("#empMblTelno").attr("class", "form-control multisteps-form__input");
		}
	});


	// 아이디 중복 검사
	$("#idCheck").on("click",function(){
		console.log("아이디체크")
		let empNo = $("#empNo").val();
		console.log(empNo);

		if(empNo.length < 5){
			swal({
			      title: "아이디 입력",
			      icon: "warning", //success, warning, error
			      text: "아이디 길이는 6자로 입력하셔야합니다.",
			      button: "확인",
			   });
			return;
		}

		let empData = {"empNo" : empNo};

		$.ajax({
			url:"/idCheck",
			data : empData,
			type:"post",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(res){
				console.log("res : " + res);

				if(res > 0){
					// 아이디 중복
					swal({
					      title: "아이디 중복",
					      icon: "warning", //success, warning, error
					      text: "중복된 아이디입니다. 다른 아이디를 사용해주세요.",
					      button: "확인",
					   });
				}else{
					// 아이디 중복이 아닐 경우 사용할 지 여부 확인
					swal({
					  title: empNo + "를 아이디로 사용하시겠습니까?",
					  text: "확인을 누르면 입력한 정보로 회원가입이 진행됩니다.",
					  icon: "warning",
					  buttons: {
						  cancel : "취소",
						  modifyOK : {
							text : "확인",
							value : "idChk"
						  }
						},
					})
					.then((value) => {
					  switch (value) {
					    case "idChk":
							// 아이디  사용가능
							$("#idCheck").removeAttr("class");
							$("#idCheck").attr("class","btn btn-secondary btn-tooltip mx-0 px-1 mt-1");
							$("#idCheck").attr("disabled","true");
							$("#idCheck").attr("value","아이디 사용가능");

							$("empNo").attr("readonly","true");

					    	break;
					    default:
					  }
					});
				}
			}
		});
	})

	//다음 우편번호 검색
	$("#btnPostNo").on("click", function() {
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete : function(data) {
				//우편번호
				$("#empZip").val(data.zonecode);
				$("#empAddr").val(data.address);
				$("#empDaddr").val(data.buildingName);
			}
		}).open();
		$("#empDaddr").focus();
	});

	// 사업자등록번호 국세청 api
	$("#btnRegNo").on("click",function() {
		var bsnNo = $("#businessNo").val().trim();
		console.log(bsnNo);

		if(bsnNo.length == 0){
			swal({
			      title: "사업자등록번호 조회오류",
			      icon: "error", //success, warning, error
			      text: "번호를 입력해주세요.",
			      button: "확인",
			   }).then(function () {
//					   location.reload();
			    });
			return;
		}
		var data = { "b_no" : [ bsnNo ] };
		$.ajax({
			url : "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=wJ2KqwB83gBBil5vv7UkrzmmneoecRYudqCay6BvbnPUMFUyl8Bki78vfLe%2Begmr1T6nsIfc3OH%2FwWcz7pJXkA%3D%3D",
			type : "POST",
			data : JSON.stringify(data), // json 을 string으로 변환하여 전송
			dataType : "JSON",
			contentType : "application/json",
			accept : "application/json",
			success : function(res) {
				console.log(res);
				console.log(res.data);
				if (res.request_cnt == 1 && res.match_cnt == 1) {
// 			    	  alert("등록된 사업자 등록번호~!")
					$("#btnRegNo").attr("btn btn-secondary w-100");
					$("#btnRegNo").attr("disabled", "true");
					$("#businessNo").attr("readonly",true);
					// 테스트용 사업자 등록번호 7545200601
					// 테스트용 사업자 등록번호 4082420619

					swal({
					      title: "사업자등록번호 인증완료",
					      icon: "success", //success, warning, error
					      text: "사업자등록번호 인증이 완료되었습니다!",
					      button: "확인",
					   }).then(function () {
		//					   location.reload();
				    });

					$("#btnRegNo").attr("value", "인증완료");
					$("#businessNo").attr("readonly","true");

					$("#fPage").attr("class","btn bg-gradient-dark btn-lg ms-auto mb-0 js-btn-next");
					$("#fPage").attr("data-bs-original-title","");

				} else {
					swal({
				      title: "사업자등록번호 조회오류",
				      icon: "error", //success, warning, error
				      text: "등록되지 않은 사업자등록번호입니다.",
				      button: "확인",
				   }).then(function () {
//						   location.reload();
				    });
				}
			},
			error : function(res) {
				console.log(res.responseText); //responseText의 에러메세지 확인
			}
		});
	});

	// 메일 인증------------------------------------------------
	// 메일 select 반영
	$("#choices-email").on("change", function() {
		console.log($("#emailAddr2").val());
		$("#emailAddr2").val("");
		let addr = $("#choices-email").val()
		$("#emailAddr2").val(addr);

		if (addr == "직접 입력") {
			console.log("> 직접입력")
			$("#emailAddr2").removeAttr("readonly");
			$("#emailAddr2").attr("readonly",false);
			$("#emailAddr2").val("@");
		} else {
			console.log("> 이메일입력")
			$("#emailAddr2").attr("readonly", true);
		}
	})

	// 메일 인증
	$("#btnEmailChk").on("click", function() {
		// 인증번호 입력하는 창 활성화
		let email1 = $('#emailAddr1').val();
		let email2 =  $('#emailAddr2').val();
		if(email1.length == 0){
			swal({
			      title: "이메일 입력오류",
			      icon: "warning", //success, warning, error
			      text: "이메일을 입력해주세요.",
			      button: "확인",
			   }).then(function () {
//					   location.reload();
			    });
			$('#emailAddr1').focus();
			return;
		}
		if(email2.length == 0){
			swal({
			      title: "이메일 입력오류",
			      icon: "warning", //success, warning, error
			      text: "이메일 주소를 지정해해주세요.",
			      button: "확인",
			   }).then(function () {
//					   location.reload();
			    });
			$('#emailAddr2').focus();
			return;
		}

		// 이메일 주소값 얻어오기
		const email = email1.trim() + email2.trim();
		// 이메일 전체 주소 확인
		console.log('완성된 이메일 : ' + email);
		$("#empEmlAddr").val(email); // submit용 input태그 내에 채워둠

		// 등록된 메일인지 중복 체크
		$.ajax({
			url:"/emailDupliChk",
			type : "post",
			data:{"empEmlAddr" : email},
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
         	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success : function(res){
				console.log("res1 : " + res);

				if(res=="none"){
					// 등록되있지않은 메일일 경우 인증번호 발송
					$.ajax({
						type : "get",
						url : "/mailCheck",
						data : {"email" : email},
						beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			        	 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success : function(data) {
							console.log("data : " + data);
							$("#emailChkNum").val(data);
							swal({
							      title: "인증번호가 전송되었습니다.",
							      icon: "success", //success, warning, error
							      text: "입력한 이메일로 전송된 인증번호를 입력해주세요.",
							      button: "확인",
							   }).then(function () {
//									   location.reload();
							    });
							$("#btnEmailChk").hide();
							$("#btnEmailChkNum").show();
							$("#emailChkInput").removeAttr("disabled");

						}
					}); // end ajax
				}else{
					// 이미 등록된 이메일이라고 안내
					swal({
					      title: "이미 등록된 이메일주소",
					      icon: "error", //success, warning, error
					      text: "이미 사용중인 이메일 주소입니다. 다른 이메일 주소를 사용해주세요.",
					      button: "확인",
					   }).then(function () {
// 						   location.reload();
					    });
				}
			},
			error : function(xhr){
				console.log(xhr.status);
			}
		})
	}); // end send email

	// 인증번호 입력 확인
	$("#btnEmailChkNum").on("click",function(){
		let input = $("#emailChkInput").val();
		let chk = $("#emailChkNum").val();

		if(input == chk){
			$("#btnEmailChkNum").attr("class","btn btn-secondary w-100");
			$("#btnEmailChkNum").attr("value","인증완료");
			$("#btnEmailChkNum").attr("disabled",true);
			$("#btnJoin").removeAttr("aria-label");
			$("#btnJoin").removeAttr("data-bs-original-title");
		}else{
			swal({
			      title: "인증번호가 일치하지 않습니다.",
			      text: "입력된 이메일로 전송된 인증번호를 확인해주세요!",
			      icon: "error" //success, warning, error
			   });
		}
	});
</script>
<script>
	if (document.getElementById('choices-email')) {
		var email = document.getElementById('choices-email');
		setTimeout(function() {
			const example = new Choices(email);
		}, 1);

		var emailArray = new Array();
		emailArray[0] = "직접 입력";
		emailArray[1] = "@daum.net";
		emailArray[2] = "@gmail.com";
		emailArray[3] = "@naver.com";
		emailArray[4] = "@gruit.com";

		for (m = 0; m < emailArray.length; m++) {
			var optn = document.createElement("OPTION");
			optn.text = emailArray[m];
			// server side month start from one
			optn.value = emailArray[m];
			// if 직접입력 selected
			if (m == 0) {
				optn.selected = true;
			}
			email.options.add(optn);
		}
	}

	if (document.getElementById('choices-year')) {
		var year = document.getElementById('choices-year');
		setTimeout(function() {
			const example = new Choices(year);
		}, 1);

		for (y = 1960; y <= 2023; y++) {
			var optn = document.createElement("OPTION");
			optn.text = y;
			optn.value = y;

			if (y == 2023) {
				optn.selected = true;
			}
			year.options.add(optn);
		}
	}

	if (document.getElementById('choices-day')) {
		var day = document.getElementById('choices-day');
		setTimeout(function() {
			const example = new Choices(day);
		}, 1);

		for (y = 1; y <= 31; y++) {
			var optn = document.createElement("OPTION");
			optn.text = y;
			optn.value = y;

			if (y == 1) {
				optn.selected = true;
			}

			day.options.add(optn);
		}

	}

	if (document.getElementById('choices-month')) {
		var month = document.getElementById('choices-month');
		setTimeout(function() {
			const example = new Choices(month);
		}, 1);

		var d = new Date();
		var monthArray = new Array();
		monthArray[0] = "1";
		monthArray[1] = "2";
		monthArray[2] = "3";
		monthArray[3] = "4";
		monthArray[4] = "5";
		monthArray[5] = "6";
		monthArray[6] = "7";
		monthArray[7] = "8";
		monthArray[8] = "9";
		monthArray[9] = "10";
		monthArray[10] = "11";
		monthArray[11] = "12";
		for (m = 0; m <= 11; m++) {
			var optn = document.createElement("OPTION");
			optn.text = monthArray[m];
			// server side month start from one
			optn.value = (m + 1);
			// if june selected
			if (m == 1) {
				optn.selected = true;
			}
			month.options.add(optn);
		}
	}

	function visible() {
		var elem = document.getElementById('profileVisibility');
		if (elem) {
			if (elem.innerHTML == "Switch to visible") {
				elem.innerHTML = "Switch to invisible"
			} else {
				elem.innerHTML = "Switch to visible"
			}
		}
	}

	var openFile = function(event) {
		var input = event.target;

		// Instantiate FileReader
		var reader = new FileReader();
		reader.onload = function() {
			imageFile = reader.result;

			document.getElementById("imageChange").innerHTML = '<img width="200" src="' + imageFile + '" class="rounded-circle w-100 shadow" />';
		};
		reader.readAsDataURL(input.files[0]);
	};
</script>
<script>
	var win = navigator.platform.indexOf('Win') > -1;
	if (win && document.querySelector('#sidenav-scrollbar')) {
		var options = {
			damping : '0.5'
		}
		Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
	}
</script>

<script>
// 자동완성 기능
function fn_autoWrite1(){
	$("#empNm").val("DDIT405");
	$("#empMblTelno").val("042-222-8282");
	$("#businessNo").val("4082420619");
}

function fn_autoWrite2(){
	$("#emailAddr1").val("gru_office01");
	$("#emailAddr2").val("@naver.com");

}




</script>
