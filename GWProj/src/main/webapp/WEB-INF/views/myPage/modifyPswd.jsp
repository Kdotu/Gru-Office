<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="/resources/js/sweetalert.min.js"></script>

	<sec:authorize access="isAuthenticated()">
		<sec:authentication property="principal.empVO" var="empVO" />
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
<form id="pswdFrm" method="post" action="/modifyInfo">
		<div class="container-fluid py-4">
			<div class="card mt-4" id="basic-info">
				<div class="card-header">
					<h4 class="mb-1">비밀번호 변경</h4>
					<p class="text-lg mb-0">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
			  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
			  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
						</svg>
						기존 비밀번호를 입력하여 확인 후 새로운 비밀번호를 설정할 수 있습니다.
					</p>
				</div>
				<div class="row card-body pt-0">
						<div class="col-1 mx-4"></div>
						<div class="col-5 col-md p-3 w-50 mx-2 mb-5 pb-5">
							<label class="form-label text-lg">기존 비밀번호</label>
							<div class="form-group oldPswd">
								<input class="form-control text-lg" type="password" placeholder="기존 비밀번호 입력..." id="oldPswd" />
								<span id="chkMsg"></span>
							</div>
							<div class="newPswd">
								<label class="form-label text-lg">새 비밀번호</label>
								<div class="form-group">
									<input class="form-control text-lg" type="password" placeholder="새 비밀번호 입력..." id="newPswd" />
								</div>
								<label class="form-label text-lg">새 비밀번호 확인</label>
								<div class="form-group">
									<input class="form-control text-lg" type="password" placeholder="새 비밀번호 확인..." id="newPswdChk"
									 name="empPswd" />
								</div>
								<span id="chkPswdMsg"></span>
							</div>
							<sec:csrfInput/>
							<input type="hidden" id="oldPswd_confirm" value="0"/>
							<input type="hidden" id="newPswd_confirm" value="0"/>
							<input type="hidden" id="empNo" name="empNo" value="${empVO.empNo}"/>
							<button type="button" id="btnSubmit" class="btn btn-dark w-100 mb-0 mt-3" style="font-size: 1.1em;">비밀번호 변경</button>
						</div>
						<div class="col-3 col-sm mx-3">
				              <h5 class="mt-5">비밀번호 변경 조건</h5>
				              <p class="text-muted mb-2 text-lg"> 비밀번호 작성 시 해당 요건을 반드시 포함해야합니다.</p>
				              <ul class="text-muted ps-4 mb-0 float-start">
				                <li>
				                  <span class="text-md"><i class="ni ni-check-bold mx-2"></i>8자리 ~ 20자리 이내로 작성</span>
				                </li>
				                <li>
				                  <span class="text-md"><i class="ni ni-check-bold mx-2"></i>공백 없이 입력</span>
				                </li>
				                <li>
				                  <span class="text-md"><i class="ni ni-check-bold mx-2"></i>영문,숫자, 특수문자를 혼합하여 입력</span>
				                </li>
				              </ul>
			              </div>
					</div>
				 </div>
			  </div>
			</form>
	      </div><!-- end for row의 2번째 부분 -->
	  </div>
  </div>
</sec:authorize>

<script>
if("${resultMsg}" != null && "${resultMsg}" !=''){
	swal({
	      title: "${resultTitle}",
	      icon: "${resultIcon}", //success, warning, error
	      text: "${resultMsg}",
	      button: "확인",
	   }).then(function () {
// 						   location.reload();
	    });
}

// 기존 비밀번호 체크
$(".oldPswd").on("change",function(){
// 	console.log("비밀번호가 맞는지 체크");
	let old = $("#oldPswd");
	let oldPswd = old.val();

	if(oldPswd.length == 0){
		// 값이 없을 경우
		$("#chkMsg").empty();
		old.attr("class","form-control");
		$("#oldPswd_confirm").val("0");
		return;
	}

	// 입력한 기존 비밀번호 맞는지 체크
	$.ajax({
		url:"/pswdChk",
		type:"post",
		data:{"empPswd":oldPswd},
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res){
			console.log(res);
			if(res == "correct"){
				old.attr("class","form-control is-valid");
				$("#oldPswd_confirm").val("1");
				return;
			}else{
				old.attr("class","form-control is-invalid");
				$("#chkMsg").html("<p style='color:red;float:right;'>비밀번호가 일치하지 않습니다. 다시 확인해주세요.</p>");
				$("#oldPswd_confirm").val("0");
				return;
			}
		}
	})
});

// 입력한 새 비밀번호가 2개가 서로 일치하는지 체크
$(".newPswd").on("change",function(){
	let old = $("#oldPswd");
	let oldPswd = old.val();
	let newPswd = $("#newPswd");
	let newPswdChk = $("#newPswdChk");

	if(oldPswd == newPswd.val()){
		newPswd.attr("class","form-control is-invalid");
		$("#newPswd_confirm").val("0");
		$("#chkPswdMsg").html("<p style='color:red;float:right;'>기존 비밀번호와 일치합니다.</p>");
		return;
	}else{
		$("#chkPswdMsg").html("");
	}

	console.log("newPswd : " + newPswd);
	console.log("newPswdChk : " + newPswdChk);

	if(newPswd.val().length > 0 && newPswdChk.val().length > 0){
		if(newPswd.val()==newPswdChk.val()){
			if(chkPW()){
				newPswd.attr("class","form-control is-valid");
				newPswdChk.attr("class","form-control is-valid");
				$("#newPswd_confirm").val("1");
			}else{
				return;
			}
		}else{
			newPswd.attr("class","form-control is-invalid");
			newPswdChk.attr("class","form-control is-invalid");
			$("#newPswd_confirm").val("0");
		}
	}else{
		newPswd.attr("class","form-control");
		newPswdChk.attr("class","form-control");
		$("#newPswd_confirm").val("0");
		return;
	}
})

// 모두 맞는 정보를 입력했다면 submit
$("#btnSubmit").on("click",function(){
	let oldP = $("#oldPswd_confirm").val();
	let newP = $("#newPswd_confirm").val();

	let oldPswd = $("#oldPswd").val();
	let newPswd = $("#newPswd").val();
	let newPswdChk = $("#newPswdChk").val();

	if(oldPswd.length > 0 && newPswd.length > 0 && newPswdChk.length > 0){
		if(oldP=="1" && newP == "1"){
// 			console.log("통과");
			$("#pswdFrm").submit();
		}

		if(oldP=="0"){ // sweetAlert으로 알려줘야지
			swal({
			      title: "기존 비밀번호 입력",
			      icon: "error", //success, warning, error
			      text: "기존 비밀번호를 인증하셔야 비밀번호 수정 진행이 가능합니다.",
			      button: "확인",
			   }).then(function () {
	// 						   location.reload();
			    });
		}
		if(newP=="0"){ // sweetAlert으로 알려줘야지
			swal({
			      title: "새로운 비밀번호 미입력",
			      icon: "error", //success, warning, error
			      text: "새 비밀번호가 일치하도록 기입해주세요.",
			      button: "확인",
			   }).then(function () {
	//						   location.reload();
			    });
		}
	}else{
		swal({
		      title: "정보 미입력",
		      icon: "error", //success, warning, error
		      text: "필요한 정보를 입력해야 비밀번호 수정 진행이 가능합니다.",
		      button: "확인",
		   }).then(function () {
//						   location.reload();
		    });
	}
})

function chkPW(){
		var pw = $("#newPswd").val();
		var num = pw.search(/[0-9]/g);
		var eng = pw.search(/[a-z]/ig);
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

		if( (pw.length < 8) || (pw.length > 20) ){
			swal({
			      title: "패스워드 오류",
			      icon: "warning", //success, warning, error
			      text: "8자리 ~ 20자리 이내로 입력해주세요.",
			      button: "확인",
			   }).then(function () {
// 						   location.reload();
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
			   }).then(function () {
//						   location.reload();
			    });
			return false;
		}else {
			return true;
		}
	}


</script>
