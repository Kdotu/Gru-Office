<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 다음 우편번호  -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- sweet alert  -->
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
	
		<div class="container-fluid py-4">
			<div class="card mt-4" id="basic-info">
				<div class="card-header">
					<h5>기본 정보</h5>
					<p class="text-sm mb-0">사원의 기본 정보를 확인할 수 있고 변경가능한 정보의 수정을 할 수 있습니다.</p>
				</div>
				<div class="card-body pt-0">
					<div class="row">
						<div class="col-12 col-sm-4 mx-auto">
							<div class="row" style="text-align: center;">
	                          <div class="position-relative mb-5 mt-5 mx-auto">
	                            <img src="/resources/upload/emp/profile/${empVO.empNo}.png" class="border-radius-md" alt="team-2" style="width:200px; height:auto;">
		                           <a href="#" class="position-absolute btn btn-sm btn-icon-only bg-gradient-light bottom-1 mb-n2 me-n2" style="width:35px;height:35px; right:110px;">
		                              <i class="m-1 fa fa-pen" data-bs-toggle="tooltip" data-bs-placement="top" title="" aria-hidden="true" data-bs-original-title="Edit Image" aria-label="Edit Image"></i><span class="sr-only">Edit Image</span>
		                            </a>
	                          </div>
                            </div>
							<label class="label pb-0 mb-0">직위 / 부서</label>
							<div class="pt-0 pb-2 mx-5">${empVO.jbpsNm} / ${empVO.deptNm}</div>
							
							<label class="label pb-0 mb-0">이름</label>
							<div class="pt-0 pb-2 mx-5">${empVO.empNm}</div>
							
<%-- 							<label class="label pb-0 mb-0">소속회사</label> --%>
<%-- 							<div class="pt-0 pb-2 mx-5">${empVO.empOgdpCoNm}</div> --%>
	                     </div>
	                     
	                     
	                     <!-- 기본화면 -->
						 <div class="col-6 mx-auto" id="basicForm">
							<label class="form-label">생년월일</label>
							<div class="input-group py-2">
								<div class="pt-0 pb-2 mx-5"><fmt:formatDate pattern='yyyy-MM-dd' value='${empVO.empBrdt}' /></div>
							</div>
							<label class="form-label">이메일주소</label>
							<div class="input-group py-2">
								<div class="pt-0 pb-2 mx-5">${empVO.empEmlAddr}</div>
							</div>
							<label class="form-label">휴대 전화번호</label>
							<div class="input-group py-2">
								<div class="pt-0 pb-2 mx-5">${empVO.empMblTelno}</div>
							</div>
							<label class="form-label">사내 전화번호</label>
							<div class="input-group py-2">
								<div class="pt-0 pb-2 mx-5">${empVO.empCoTelno}</div>
							</div>
							<div class="input-group py-2"></div>								
								<div class="col">
									<label class="form-label">기본주소</label>
									<div class="pt-0 pb-2 mx-5">${empVO.empAddr}</div>
								</div>
								<div class="col">
									<label class="form-label">상세주소</label>
									<div class="pt-0 pb-2 mx-5">${empVO.empDaddr}</div>
								</div>
								<div class="col row">
									<div class="col-6 mt-3 mt-sm-0">
										<label class="form-label">우편번호</label>
										<div class="pt-0 pb-2 mx-5">${empVO.empZip}</div>
									</div>
								</div>
								 <div class="px-auto mx-auto row" style="float:right;">
								 	<div class="col">
									 	<button class="pt-3 mt-5 btn btn-lg btn-dark" onclick="fn_modifyOn()" type="button">수정</button>
								 	</div>
								 </div>
							 </div>
					<!-- 수정폼 -->
						 <div class="col-6 mx-auto" style="display:none;" id="modifyForm">
							<form action="/modifyInfo" method="post" id="modifyFrm">
							<label class="form-label">생년월일</label>
							<div class="input-group">
								<input name="firstName" class="form-control" type="text" placeholder="Alec" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${empVO.empBrdt}' />" />
							</div>
							<label class="form-label">이메일주소</label>
							<div class="input-group">
								<input id="empEmlAddr" name="empEmlAddr" class="form-control" type="text" value="${empVO.empEmlAddr}"/>
							</div>
							<label class="form-label">휴대 전화번호</label>
							<div class="input-group">
								<input id="empMblTelno" name="empMblTelno" class="form-control" type="text" value="${empVO.empMblTelno}"/>
							</div>
							<label class="form-label">사내 전화번호</label>
							<div class="input-group">
								<input id="empCoTelno" name="empCoTelno" class="form-control" type="text" value="${empVO.empCoTelno}"/>
							</div>
								<div class="col">
									<label class="form-label">기본주소</label>
									<input type="text" class="form-control" name="empAddr" id="empAddr" placeholder="기본주소 입력..." value="${empVO.empAddr}" />
								</div>
		
								<div class="col">
									<label class="form-label">상세주소</label>
									<input type="text" class="form-control"  name="empDaddr" id="empDaddr" placeholder="상세주소 입력..." value="${empVO.empDaddr}" />
								</div>
								<div class="col row">
									<div class="col-6 mt-3 mt-sm-0">
									<label class="form-label">우편번호</label>
									<input type="text" class="form-control" placeholder="우편번호 입력..." maxlength="5"  name="empZip" id="empZip" value="${empVO.empZip}" />
									</div>
									<div class="col-6 mt-3 mt-sm-0">
										<div class="modifyInfo">
											<label>주소 검색</label>
											<input type="button" class="w-100 btn btn-info" value="검색" onclick="fn_postNo()" id="btnPostNo" />
										</div>
									</div>
								</div>
							 <div class="px-auto mx-auto row" style="float:right;">
							 	<div class="col-6">
								 	<button class="pt-3 mt-5 btn btn-lg btn-dark" onclick="modifySave()" type="button">저장</button>
							 	</div>
							 	<div class="col-6">
								 	<button class="pt-3 mt-5 btn btn-lg bg-gradient-default" onclick="fn_modifyReset()" type="reset">취소</button>
							 	</div>
							 </div>
							 <sec:csrfInput/>
							 </form>
						 </div>
					</div>
				</div>
			 </div>
		  </div>
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

// 수정모드로 전환
function fn_modifyReset(){
	$("#basicForm").css("display","");
	$("#modifyForm").css("display","none");
}
	
function fn_modifyOn(){
	$("#basicForm").css("display","none");
	$("#modifyForm").css("display","");
}

// 수정사항 확인
function modifySave(){
	swal({
		  title: "정보를 수정하시겠습니까?",
		  text: "확인을 누르면 입력한 정보로 정보가 수정됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "확인",
				value : "modifyOK"
			  }
			},
		})
		.then((value) => {
		  switch (value) {
		    case "modifyOK":
		    	$("#modifyFrm").submit();
		    default:
		      swal({
	 		    	title: "회원정보 수정 취소!",
	 		    	icon :"error"
	 		    });
		  }
		});
};


//다음 우편번호 검색
function fn_postNo(){
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
	
}


</script>
