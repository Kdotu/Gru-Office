<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- 다음 우편번호  -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- sweet alert  -->
<script src="/resources/js/sweetalert.min.js"></script>
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
					<h4>기본 정보</h4>
					<p class="text-lg mb-0">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
			  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
			  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
						</svg>
						사원의 기본 정보를 확인할 수 있고 변경가능한 정보의 수정을 할 수 있습니다.
					</p>
				</div>
				<div class="card-body pt-0">
					<div class="row">
						<div class="col-12 col-sm-4 mx-auto">
							<div class="row" style="text-align: center;">
	                          <div class="position-relative mb-5 mt-5 mx-auto" id="imageSpace">
	                            <div id="showImage">
	                            	<c:choose>
										<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
											<input type="hidden" id="image_root" value="${empVO.fileGrVO.filesList[0].fileStrgNm}" />
				                            <img src="/resources/upload${empVO.fileGrVO.filesList[0].fileStrgNm}" class="border-radius-md" alt="${empVO.fileGrVO.filesList[0].fileOrgnlNm}" style="width:300px; height:auto;">
										</c:when>
										<c:otherwise>
				                            <img src="/resources/upload/emp/profile/default.png" class="border-radius-md" alt="default.png" style="width:300px; height:auto;">
										</c:otherwise>
	                            	</c:choose>
			                            <a onclick="fn_editImage()" class="position-absolute btn btn-sm btn-icon-only bg-gradient-light bottom-1 mb-n2 me-n2" style="width:35px;height:35px; right:110px;">
			                              <i class="m-1 fa fa-pen" data-bs-toggle="tooltip" data-bs-placement="top" title="" aria-hidden="true" data-bs-original-title="프로필 이미지 변경" aria-label="프로필 이미지 변경"></i><span class="sr-only"></span>
			                            </a>
		                        </div>
								<div id="drop-area" class="w-100" style="display:none;">
									<div id="gallery">
		                            	<c:choose>
											<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
					                            <img src="/resources/upload${empVO.fileGrVO.filesList[0].fileStrgNm}" class="border-radius-md" alt="${empVO.fileGrVO.filesList[0].fileOrgnlNm}" style="width:200px; height:auto;">
											</c:when>
											<c:otherwise>
					                            <img src="/resources/upload/emp/profile/default.png" class="border-radius-md" alt="default.png" style="width:200px; height:auto;">
											</c:otherwise>
		                            	</c:choose>
									</div>
										<form id="profileImageFrm" name="profileImageFrm" class="my-form mx-auto" style="width:200px;">
											<input type="file" id="fileElemlem" name="uploadFile" multiple accept="image/*" onchange="handleFiles(this.files)"><label style="width:100px;height:35px; right:10px;" class="button position-relative btn btn-sm btn-icon-only bg-gradient-light bottom-1 mb-n2 me-n2 pt-1 h6" for="fileElemlem">파일선택</label>
<!-- 											<input type="file" id="fileElem" name="uploadFile" accept="image/*" ><label style="width:100px;height:35px; right:10px;" class="button position-relative btn btn-sm btn-icon-only bg-gradient-light bottom-1 mb-n2 me-n2 pt-1 h6" for="fileElem">파일선택</label> -->
											<input type="hidden" name="empVO" value="${empVO.empNo}"/>
										<a onclick="fn_confirmImage()" class="position-relative btn btn-sm btn-icon-only bg-gradient-light bottom-1 mb-n2 me-n2" style="width:35px;height:35px;">
			                              <i class="" data-bs-toggle="tooltip" data-bs-placement="top" title="" aria-hidden="true" data-bs-original-title="이미지 변경 확인" aria-label="이미지 변경 확인">
				                              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-lg" viewBox="0 0 16 16">
												  <path d="M12.736 3.97a.733.733 0 0 1 1.047 0c.286.289.29.756.01 1.05L7.88 12.01a.733.733 0 0 1-1.065.02L3.217 8.384a.757.757 0 0 1 0-1.06.733.733 0 0 1 1.047 0l3.052 3.093 5.4-6.425a.247.247 0 0 1 .02-.022Z"/>
											  </svg>
			                              </i><span class="sr-only"></span>
			                            </a>

			                            <a onclick="fn_editBack()" class="position-relative btn btn-sm btn-icon-only bg-gradient-light bottom-1 mb-n2 me-n2" style="width:35px;height:35px; left:10px;">
			                              <i class="" data-bs-toggle="tooltip" data-bs-placement="top" title="" aria-hidden="true" data-bs-original-title="이미지 변경취소" aria-label="이미지 변경취소">
				                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-lg" viewBox="0 0 16 16">
											  <path d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
											</svg>
										 </i><span class="sr-only"></span>
		                            	</a>
										<sec:csrfInput/>
										</form>
									<progress id="progress-bar" max=100 value=0></progress>
								</div>
	                          </div>


                            </div>
							<label class="label text-lg pb-0 mb-0">직위 / 부서</label>
							<div class="pt-0 pb-2 mx-5 text-lg">${empVO.jbpsNm} / ${empVO.deptNm}</div>

							<label class="label pb-0 mb-0 text-lg">이름</label>
							<div class="pt-0 pb-2 mx-5 text-lg">${empVO.empNm}</div>

							<label class="label pb-0 mb-0 text-lg">소속회사</label>
							<div class="pt-0 pb-2 mx-5 text-lg"> 그루 IT</div>
	                     </div>


	                     <!-- 기본화면 -->
						 <div class="col-6 mx-auto" id="basicForm">
							<label class="form-label text-lg">생년월일</label>
							<div class="input-group py-2">
								<div class="pt-0 pb-2 mx-5 text-lg" ><fmt:formatDate pattern='yyyy-MM-dd' value='${empVO.empBrdt}' /></div>
							</div>
							<label class="form-label text-lg">이메일주소</label>
							<div class="input-group py-2">
								<div class="pt-0 pb-2 mx-5 text-lg">${empVO.empEmlAddr}</div>
							</div>
							<label class="form-label text-lg">휴대 전화번호</label>
							<div class="input-group py-2 ">
								<div class="pt-0 pb-2 mx-5 text-lg">${empVO.empMblTelno}</div>
							</div>
							<label class="form-label text-lg">사내 전화번호</label>
							<div class="input-group py-2 ">
								<div class="pt-0 pb-2 mx-5 text-lg">${empVO.empCoTelno}</div>
							</div>
							<div class="input-group py-2"></div>
								<div class="col">
									<label class="form-label text-lg">기본주소</label>
									<div class="pt-0 pb-2 mx-5 text-lg">${empVO.empAddr}</div>
								</div>
								<div class="col">
									<label class="form-label text-lg">상세주소</label>
									<div class="pt-0 pb-2 mx-5 text-lg">${empVO.empDaddr}</div>
								</div>
								<div class="col row">
									<div class="col-6 mt-3 mt-sm-0">
										<label class="form-label text-lg">우편번호</label>
										<div class="pt-0 pb-2 mx-5 text-lg">${empVO.empZip}</div>
									</div>
								</div>
								 <div class="px-auto mx-auto row" style="float:right;">
								 	<div class="col">
									 	<button class="pt-3 mt-5 btn btn-lg btn-dark" onclick="fn_modifyOn()" type="button" style="font-size: 1.3em; ">수정</button>
								 	</div>
								 </div>
							 </div>
					<!-- 수정폼 -->
						 <div class="col-6 mx-auto" style="display:none;" id="modifyForm">
							<form action="/modifyInfo" method="post" id="modifyFrm">
							<label class="form-label text-lg">생년월일</label>
							<div class="input-group">
								<input name="" class="form-control text-lg" type="text" placeholder="Alec" value="<fmt:formatDate pattern='yyyy-MM-dd' value='${empVO.empBrdt}' />" />
							</div>
							<label class="form-label text-lg">이메일주소</label>
							<div class="input-group">
								<input id="empEmlAddr" name="empEmlAddr" class="form-control text-lg" type="text" value="${empVO.empEmlAddr}"/>
							</div>
							<label class="form-label text-lg">휴대 전화번호</label>
							<div class="input-group">
								<input id="empMblTelno" name="empMblTelno" class="form-control text-lg" type="text" value="${empVO.empMblTelno}"/>
							</div>
							<label class="form-label text-lg">사내 전화번호</label>
							<div class="input-group">
								<input id="empCoTelno" name="empCoTelno" class="form-control text-lg" type="text" value="${empVO.empCoTelno}"/>
							</div>
								<div class="col">
									<label class="form-label text-lg">기본주소</label>
									<input type="text" class="form-control text-lg" name="empAddr" id="empAddr" placeholder="기본주소 입력..." value="${empVO.empAddr}" />
								</div>

								<div class="col">
									<label class="form-label text-lg">상세주소</label>
									<input type="text" class="form-control text-lg"  name="empDaddr" id="empDaddr" placeholder="상세주소 입력..." value="${empVO.empDaddr}" />
								</div>
								<div class="col row">
									<div class="col-6 mt-3 mt-sm-0">
									<label class="form-label text-lg">우편번호</label>
									<input type="text" class="form-control text-lg" placeholder="우편번호 입력..." maxlength="5"  name="empZip" id="empZip" value="${empVO.empZip}" />
									</div>
									<div class="col-6 mt-3 mt-sm-0">
										<div class="modifyInfo">
											<label class="text-lg">우편번호 검색</label>
											<input type="button" class="w-100 btn btn-info" value="검색" onclick="fn_postNo()" id="btnPostNo" style="font-size: 1.1em; height: 42px;"/>
										</div>
									</div>
								</div>
							 <div class="px-auto mx-auto row" style="float:right;">
							 	<div class="col-6">
								 	<button class="pt-3 mt-5 btn btn-lg btn-dark" onclick="modifySave()" type="button" style="font-size: 1.1em; height: 50px;">저장</button>
							 	</div>
							 	<div class="col-6">
								 	<button class="pt-3 mt-5 btn btn-lg bg-gradient-default" onclick="fn_modifyReset()" type="reset" style="font-size: 1.1em; height: 50px;">취소</button>
							 	</div>
							 </div>
							 <input type="hidden" name="empNo" value="${empVO.empNo}" />
							 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
		    	break;

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
<script>
// 프로필 사진 수정모드
function fn_editImage(){
	$("#showImage").hide();
	$("#drop-area").show();
}
// 프로필 사진 열람모드
function fn_editBack(){
	// 갤러리 div에 원래 담겨있던 프로필 사진으로 되돌려놓기
	let img_res = $("#image_root").val();
	let img =  '<img src="/resources/upload' + img_res + '" class="border-radius-md" alt="team-2" style="width:200px; height:auto;">';
	
	$("#gallery").html(img);
	$("#showImage").show();
	$("#drop-area").hide();
}

function fn_confirmImage(){

	var formData = new FormData($("#profileImageFrm")[0]);

    $.ajax({
        url : "/emp/modifyFile",
      	type : "POST",
      	processData : false,
      	contentType : false,
      	data : formData,
    	beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
        success:function(res) {
        	// 파일업로드 성공시
        	// gallery랑 showImage id 부분 다시 로드
//         	$("#imageSpace")load("${contextPath}/myPage/modifyInfo #gallery");
//         	$("#imageSpace")load("${contextPath}/myPage/modifyInfo #showImage");
          swal({
	 		    	title: "프로필 사진 변경 완료",
	 		    	icon :"success",

	 		    }).then((value) => {


	 		    });
          console.log(res);
          fn_editBack();

      }
      ,error: function (xhr)
      {
          alert(xhr.responseText);
      }
  });
}

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
  files = [...files];
  initializeProgress(files.length);
  files.forEach(uploadFile);
  files.forEach(previewFile);
}

function previewFile(file) {
  let reader = new FileReader()
  reader.readAsDataURL(file)
  reader.onloadend = function() {
    let img = document.createElement('img')
    img.src = reader.result
    $("#gallery").empty();
    $("#gallery").append(img);

  }
}

function uploadFile(file, i) {
  var url = '/emp/modifyFile'
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