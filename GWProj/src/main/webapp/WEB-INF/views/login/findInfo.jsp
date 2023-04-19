<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="/resources/maincss/assets/js/plugins/multistep-form.js"></script>
<!-- sweet alert  -->
<script src="/resources/js/sweetalert.min.js"></script> 


  <main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-50 pt-5 pb-11 m-3 border-radius-lg" style="background-image: url('/resources/image/laptop.jpg');">
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
        <div class="col-xl-4 col-lg-5 col-md-7 mx-auto mb-3">
          <div class="card z-index-0 mb-5">
            <div class="card-header text-center pt-4 mx-2 mt-2">
				<table class="mx-auto">
					<tr>
						<td width=""><img class="mx-3 mt-2 mb-2"
							style="width: 120px; height: 120px; float: left;"
							src="/resources/image/logo6.png" alt="bear-logo.png" /></td>
						<td>
							<h3>${title}</h3>
						</td>
					</tr>
					<tr>
						<td>
							<h5>GruOffice</h5>
						</td>
						<td></td>
					</tr>
				</table>
					</div>
				<div class="container-fluid py-3">
					<div class="row">
						<div class="col-12">
							<div class="multisteps-form">
								<div class="row">
									<div class="m-auto">
									<div class="multisteps-form__progress">
											<button class="multisteps-form__progress-btn js-active" type="button"
												title="emailInfo Input">정보 입력</button>
											<button class="multisteps-form__progress-btn" type="button" disabled
												title="Confirm Info">정보확인</button>
										</div>
										</div>
										</div>
								<div class="row">
									<div class="m-auto">
										<form rold="form" id="findFrm"
											class="multisteps-form__form mb-3" style="height: 225px;">
												<div class="multisteps-form__panel p-3 border-radius-xl bg-white js-active" id="fPage" data-animation="FadeIn">
						                			<div class="mb-3">
						                 			  <input  type="text" class="multisteps-form__input form-control form-control" placeholder="${placeholder}" aria-label="Name" name="${value}" id="${value}" />
						              			    </div>
						               				<div class="mb-3">
						               				  <input type="text" class="multisteps-form__input form-control form-control" placeholder="이메일 주소 입력..." aria-label="Email" name="empEmlAddr" id="empEmlAddr" />
					               					</div>
						                			<div class="text-center">
									                  <input type="button" class="btn bg-gradient-dark w-100 my-4 mb-2 ms-auto mb-0" value="<c:choose><c:when test='${btnName eq "btnIdFind"}'>아이디 찾기</c:when><c:otherwise>임시 비밀번호 발송</c:otherwise></c:choose>" id="${btnName}" 
									                   data-bs-toggle="tooltip" data-bs-placement="top" title="필요한 정보를 입력 후 진행해주세요." data-container="body" data-animation="true" />
									                </div>
								                </div>
												<div class="multisteps-form__panel p-3 border-radius-xl bg-white" id="sPage" data-animation="FadeIn">
													<div class="row">
														<div class="m-auto">
															<div class="m-2 p-3">
																<div id="resultMsg"></div>
															</div>
														</div>
													</div>
													<div class="text-center">
														<a href="/login"
															class="btn bg-gradient-info w-100 my-4 mb-2">
															로그인하러 가기</a>
													</div>
												</div>
				            			  </form>
									<div class="mt-1"
										style="text-align: center; align-content: center;">
										<p class="text-sm mt-3 mb-3 pb-2" style="text-align: center; align-content: center;">
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
	 </main>
<jsp:include page="/WEB-INF/views/tiles/footer.jsp" />
<script>
var chkCode = "";

if("<%="#"%>{value}" == 'empNo'){
	$("<%="#"%>${value}").attr(maxlength,"6");
}

// 폼이 변경될 때마다 체크
$("#findFrm").on("change",function(){
	let input1 = $("<%="#"%>${value}").val();
	let input2 = $("#empEmlAddr").val();
	
	console.log(input1);
	console.log(input2);
	
	
	// 항목이 적혀있으면 tooltip내용 제거
	if(input1.length > 0 && input2.length > 0){
		$("<%="#"%>${btnName}").removeAttr("aria-label");
		$("<%="#"%>${btnName}").removeAttr("data-bs-original-title");
		$("<%="#"%>${btnName}").removeAttr("data-bs-toggle");
	}
	if(input1.length == 0 || input2.length == 0){
		$("<%="#"%>${btnName}").attr("class","btn bg-gradient-dark w-100 my-4 mb-2 ms-auto mb-0");
		$("<%="#"%>${btnName}").attr("title","필요한 정보를 입력 후 진행해주세요.");
		$("<%="#"%>${btnName}").attr("aria-label","필요한 정보를 입력 후 진행해주세요.");
		$("<%="#"%>${btnName}").attr("data-bs-original-title","필요한 정보를 입력 후 진행해주세요.");
		$("<%="#"%>${btnName}").attr("data-bs-toggle","tooltip");
	}
});


$("#${btnName}").on("click",function(){
	console.log("체크");
	let empInfo = $("<%="#"%>${value}").val();
	var empNm = "";
	var empNo = "";
	
	if("${value}" == 'empNm'){ empNm = empInfo;}
	if("${value}" == 'empNo'){ empNo = empInfo;}
	
	let empEmlAddr = $("#empEmlAddr").val();
	console.log("empInfo : " + empInfo);
	console.log("empNm : " + empNm);
	console.log("empNo : " + empNo);
	console.log("param :  ${param.find}");
	
	let find = "${param.find}";
	
	$.ajax({
		url: "/findEmpInfo",
		type: "post",
		data:{"empNm" : empNm, "empNo": empNo, "empEmlAddr" : empEmlAddr, "find" : find},
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res){
			console.log("res---> " + res)
			if(res == "none"){
// 				alert("등록되지 않은 정보입니다. 확인하고 다시 입력해주세요.");
				swal({ 
				      title: "입력 오류",
				      icon: "error", //success, warning, error
				      text: "등록되지 않은 정보입니다. 입력하신 정보를 다시 확인하신 후 시도해주세요!",  
				      button: "확인",
				   }).then(function () {
//					   location.reload(); 
				    });
				
			}else{ 
				console.log("res find : " + find)
				$("<%="#"%>${btnName}").attr("class","btn bg-gradient-dark w-100 my-4 mb-2 ms-auto mb-0 js-btn-next");
				$("#sPage").attr("class","multisteps-form__panel p-3 border-radius-xl bg-white js-active");
				$("#fPage").attr("class","multisteps-form__panel p-3 border-radius-xl bg-white");
				if(find=="id"){
					// 아이디 알려주는 창이 나옴
					$("#resultMsg").html("입력하신 정보로 <br>등록된 아이디는 <b>" + res + "</b>입니다. <br>");
				}else{
					$("#resultMsg").html("입력하신 이메일주소 <b>" + empEmlAddr + "</b>로 <br>임시 비밀번호를 발송해드렸습니다.");
				}
			}
		},
		error : function(xhr){

			
			
			console.log(xhr.status);
		}
	});
})
</script>
