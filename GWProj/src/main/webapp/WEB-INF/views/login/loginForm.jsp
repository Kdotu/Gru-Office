<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="/resources/js/sweetalert.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<style>
.g-recaptcha div{
	margin : auto;

}

</style>
<main class="main-content  mt-0">
	<div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg"
		style="background-image: url('/resources/image/laptop.jpg');">
		<span class="mask bg-gradient-dark opacity-6"></span>
		<div class="container mt-5">
			<div class="row justify-content-center mt-5">
				<div class="col-lg-5 text-center mx-auto">
					<h1 class="text-white mb-2 mt-5">GruOffice</h1>
					<p class="text-lead text-white mb-0">시간과 장소에 얽매이지 않고 언제 어디에서나!</p>
					<p class="text-lead text-white">조직의 업무 환경을 더 효율적이고 편리하게</p>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row mt-lg-n10 mt-md-n11 mt-n10 justify-content-center">
			<div class="col-xl-5 col-lg-5 col-md-7 mx-auto">
				<div class="card z-index-0 mb-5">
					<div class="card-header text-center pt-4 mx-2 mt-2"
						style="align-content: center;">
					<table class="mx-auto w-100">
						<tbody>
						<tr>
							<td style="align:center; padding-left:50px;"><img class="px-auto mx-3 mt-2 mb-2" style="width: 120px; height: 120px; float: left;" src="/resources/image/logo6.png" alt="bear-logo.png"></td>
							<td rowspan="2">
								<h2 class="m-2">로그인</h2>
							</td>
						</tr>
						<tr>
							<td style="align-content:center; padding-right:50px;">
								<h5>GruOffice</h5>
							</td>
						</tr>
						</tbody>
					</table>
					</div>
					<div class="card-body">
						<form role="form" class="text-start" id="loginFrm" action="/login" method="post">
							<div class="mb-3 form-group">
								<input type="text" class="form-control" placeholder="아이디 입력.." maxlength="6" aria-label="Id" id="username" name="username" value="${empVO.empNo}" />
							</div>
							<div class="mb-3">
								<input type="password" class="form-control" placeholder="패스워드 입력.." aria-label="Password" id="password" name="password" />
							</div>
							<div class="form-check form-switch">
								<input class="form-check-input" type="checkbox" id="rememberMe" name="remember-me">
								<label class="form-check-label" for="rememberMe">Remember me</label>
							</div>
							<div style="float:right;">
								<input type="button" class="btn bg-gradient-secondary mb-0 h6" onclick="fn_loginEmp()" value="사원 로그인" style="margin-left:40px;" />
								<input type="button" class="btn bg-gradient-secondary mb-0 h6" onclick="fn_loginAdmin()" value="관리자 로그인" />
							</div>
							<div class="text-center">
								<input type="button"
									class="btn bg-gradient-info w-100 my-4 mb-2 h6"
									onclick="fn_login()" value="로그인">
							</div>
<!-- 							<div class="g-recaptcha" data-sitekey="6LdANMgjAAAAAHmf_gk1_0B0UIB4Izo6VKldkEDc"></div> -->
							<div class="mb-2 position-relative text-center">
								<p
									class="text-sm font-weight-bold mb-2 text-secondary text-border d-inline z-index-2 bg-white px-3">
									or</p>
							</div>
							<div class="text-center">
								<a href="/join"
									class="btn bg-gradient-dark w-100 mt-2 mb-4 h6">기업 회원가입</a>
							</div>
							 <sec:csrfInput/>
						</form>
						<table class="w-100" style="text-align: center;">
							<tr>
								<td><a href="/findInfo?find=id"
									class="mb-4 text-sm mx-auto text-info text-gradient font-weight-bold">아이디 찾기</a></td>
								<td><a href="/findInfo?find=pw"
									class="mb-4 text-sm mx-auto text-info text-gradient font-weight-bold">비밀번호 찾기</a></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/tiles/footer.jsp" />
<script>
function fn_loginEmp(){
	$("#username").val("202313");
	$("#password").val("1234");
	$("#loginFrm").submit();
}


function fn_loginAdmin(){
	$("#username").val("202316");
	$("#password").val("1234");
	$("#loginFrm").submit();

}





function fn_login() {
	function onSubmit() {
		if (grecaptcha.getResponse().length == 0) {
			swal({
			      title: "reCAPTCHA를 확인해 주세요!",
			      icon: "warning", //success, warning, error
			      button: "확인",
			   }).then(function () {
				   $('#username').focus();
		    });
			return false;
		}

		return true;
	}

	// 미입력시 뜨는 문구
	if ($('#username').val().trim() == '') {
		swal({
		      title: "아이디를 입력해주세요!",
		      icon: "warning", //success, warning, error
		      button: "확인",
		   }).then(function () {
			   $('#username').focus();
	    });
		return;
	} else if ($('#password').val().trim() == '') {
		swal({
		      title: "비밀번호를 입력해주세요!",
		      icon: "warning", //success, warning, error
		      button: "확인",
		   }).then(function () {
				$('#password').focus();
	    });
		return;
	}

	// 입력했지만 없는 회원정보일 때 뜨는 문구
	// 아이디 체크
	let empNo = $("#username").val();
	let empPswd = $("#password").val();

	$.ajax({
			url:"/loginCheck",
			type:"post",
			data : {"empNo" : empNo, "empPswd":empPswd},
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(res){
				var str = "";
				console.log(res);
				//sweetalert 처리하기
				if(res != null){
					if(res == "loginSuccess"){
						$("#loginFrm").submit();
					}else{
						if(res == "idError"){ str += "등록되지 않은 아이디입니다. 다시확인해주세요."; }
						if(res == "pwError"){ str += "틀린 비밀번호를 입력하셨습니다. 다시확인해주세요.";}
						swal({
						      title: "로그인 오류",
						      icon: "error", //success, warning, error
						      text: str,
						      button: "확인",
						   }).then(function () {
	// 						   location.reload();
						    });
					}
				} // end res.code if문
			} // end for success 문
		}) // end for ajax
	} // end for fn_login
</script>
<script>
grecaptcha.enterprise.ready(function() {
    grecaptcha.enterprise.execute('6Ld76AclAAAAALE0_pquzyOOKdSGo3grZB5JpPsI', {action: 'login'}).then(function(token) {
       ...
    });
});
</script>

