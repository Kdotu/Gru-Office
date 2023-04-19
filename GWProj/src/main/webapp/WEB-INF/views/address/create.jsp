<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

$(function(){
	//다음 우편번호 검색
	$("#btnPostno").on("click",function(){		
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete:function(data){
				//우편번호 ,주소, 상세주소
				$("#postno").val(data.zonecode);	// postNo가 아니라 postno로 되어 있음(id가)
				$("#cusAddr").val(data.address);
				$("#addrDet").val(data.buildingName);
			}
		}).open();
	});
});

</script>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>

<!-- 연락처 등록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/addressAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
		<h3>연락처 추가</h3>

		<!-- body_center -->
			<div class="card h-100">
				<div class="">
					<div
						class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						<div class="dataTable-top">
							<div class="dataTable-search"></div>
						</div>
						<div class="ct-example"
							style="position: relative;border: 2px solid #f5f7ff !important; padding: 1rem 1rem 1rem 1rem; margin-bottom: -1.25rem;">
							<form action="/address/createPost" id="crateForm"  method="post" name="crateForm">
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="이름" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" name="addrNm"
												id="addrNm" placeholder="이름을 입력해주세요"  required
												>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="회사" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" name="addrCoNm"
												id="exampleFormControlInput1" placeholder="회사를 입력해주세요"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="부서" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" name="addrDept"
												id="exampleFormControlInput1" placeholder="부서를 입력해주세요"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="직위" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" name="addrRank"
												id="exampleFormControlInput1" placeholder="직위를 입력해주세요"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="이메일" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="email" class="form-control" name="emlAddr"
												id="exampleFormControlInput1" placeholder="name@example.com"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="휴대폰" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" name="addrHp"
												id="exampleFormControlInput1" placeholder="010-0000-0000"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="회사전화" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" name="addrCoTelno"
												id="exampleFormControlInput1" placeholder="042-000-0000"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="회사주소" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									
									<div class="col-md-9">
										<div class="row">
											<div class="col-12">
												<label for="postno" class="form-label">우편번호</label><br/> 
												<input type="text" class="form-control" 
													id="postno" name="postno" placeholder="우편번호를 입력해주세요"
													style="width: 50% ; height:45%; float: left;" />
												<input class="btn btn-info" type="button" value="우편번호 검색" 
													style="width: 15%;float: left; text-align: center; padding-left : 10px;" id="btnPostno" onclick="openHomeSearch()"/>
											</div>
											<div class="col-12">
												<label for="cusAddr" class="form-label">주소</label><br/> 
												<input type="text" class="form-control" style="width: 50%; float: left;"
													id="cusAddr" name="cusAddr" placeholder="주소를 입력해주세요" />
											</div>
											<br/>
											<div class="col-12" style="margin-top: 20px;">
												<label for="addrDet" class="form-label">상세 주소</label><br/>  
												<input type="text" class="form-control" style="width: 50%; float: left;"
													id="addrDet" name="addrDet" placeholder="상세 주소를 입력해주세요" />
											</div>
										</div>
									</div>
									
									
									
									
									
<!-- 									<div class="col-md-7"> -->
<!-- 										<div class="form-group"> -->
<!-- 											<input type="text" class="form-control" name="addrCo" -->
<!-- 												id="exampleFormControlInput1" placeholder="회사주소를 입력해주세요" -->
<!-- 												onfocus="focused(this)" onfocusout="defocused(this)"> -->
<!-- 										</div> -->
<!-- 									</div> -->
									<div style="text-align: right;" class="my-2">
										<button type="button" class="btn btn-info" onclick="fn_sbm()">등록</button>
										<button type="button" class="btn btn-outline-dark">취소</button>
										<a href="/address/list" class="btn btn-secondary">목록</a>
									</div>
								</div>

							<sec:csrfInput/>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-8"></div>
		</div>
	</div>
</div>
<script type="text/javascript">
let regExpName = /^[가-힣]*$/;	//이름은 한글만 입력해주세요. +:1이상, *:0이상
let regExpPhone = /^\d{3}-\d{3,4}-\d{4}$/;	//연락처 형식을 확인해주세요. 010-123-1234, 010-1234-1234
let regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;//이메일 형식을 확인해주세요. [0-9a-zA-Z]->[xy]
	
function fn_sbm() {
		let form = document.crateForm;
		let name = form.addrNm.value;
		let phone = form.addrHp.value;
		let email = form.emlAddr.value;
	
	
		//아이디 입력값 
		let addrNm = $("#addrNm").val();
		//아이디 입력값 길이
		let addrNmLen = addrNm.length;
		console.log("addrNmLen는?" , addrNmLen);
		
		//2) 이름은 한글만 입력해주세요(루드비히 반 베토벤)
		console.log("::::::::::::::" + !regExpName.test(name));
		if(name == null || name == ""){
			alert("이름을 입력해주세요");
			form.addrNm.select();
			return;//함수 종료
		}
		if(!regExpName.test(name)){
			alert("이름은 한글만 입력해주세요");
			form.addrNm.select();
			return;//함수 종료		
		}
		
		//4) 연락처 형식을 확인해주세요
		if(!regExpPhone.test(phone)){
			alert("연락처 형식을 확인해주세요");
			return;//함수 종료			
		}
		//5) 이메일 형식을 확인해주세요
		if(!regExpEmail.test(email)){
			alert("이메일 형식을 확인해주세요");
			form.emlAddr.select();
			return;//함수종료		
		}
		
		form.submit();
}
</script>


























