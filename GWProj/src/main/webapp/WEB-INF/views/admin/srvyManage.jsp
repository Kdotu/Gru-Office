<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script src="/resources/js/sweetalert.min.js"></script>
<style>
 .card-border{
	border : 1px solid gray;
 }
</style>

<!-- 해시태그 수정용 모달창 시작 -->
 <div class="modal fade modal-sm" id="ModifyHashModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel2">해시태그 수정</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="/" method="post" id="hashTagFrm2">
              <div class="form-group">
                <label for="hashTagNm" class="text-lg col-form-label">해시태그명</label>
                <input type="text" class="form-control" name="hashTagNm" id="modiHashTagNm" >
                <input type="hidden" id="modiHashTagNo" />
                <span id="tagNameUse"></span>
              </div>
              <sec:csrfInput/>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn bg-gradient-info" id="modiSubmitBtn">수정</button>
          </div>
        </div>
      </div>
    </div>
<!-- 해시태그 수정용 모달창 끝 -->

<!-- 해시태그 추가용 모달창 시작 -->
 <div class="modal fade modal-sm" id="CreateHashModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">해시태그 추가</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <form action="/" method="post" id="hashTagFrm">
              <div class="form-group">
                <label for="hashTagNm" class="text-lg col-form-label">해시태그명</label>
                <input type="text" class="form-control" name="hashTagNm" id="hashTagNm" >
                <span id="tagNameUse"></span>
              </div>
              <div class="form-group">
                <label for="useYn" class="text-lg col-form-label">사용여부</label>
                <div class="form-check form-switch col-2 mx-auto">
                	<input class="form-check-input" type="checkbox" name="useYn" id="useYn" value="Y" />
                </div>
              </div>
              <sec:csrfInput/>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn bg-gradient-info" id="submitBtn">등록</button>
          </div>
        </div>
      </div>
    </div>
<!-- 해시태그 추가용 모달창 끝 -->



<!-- 전체게시판 목록 -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid mx-0 px-0">
	<div class="mb-5">
<!-- 		<div class="col-lg-2"> -->
<%-- 			<jsp:include page="/WEB-INF/views/aside/surveyAside.jsp" /> --%>
<!-- 		</div> -->

	<div class="card col-11 mb-0">
		<div class="card-body pt-2 pb-0">
			<br>
			<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2 Heads">Reserve List</span>
			<h3 class="card-title d-block text-darker Heads" >설문조사 관리</h3>
					<p class="explains Heads">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
							  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
							  1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
							  0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
						</svg>
						등록된 설문조사와 설문조사 등록 시 사용할 해시태그를 관리할 수 있습니다.
					</p>
			<a class="btn bg-gradient-info text-lg" href="/admin/srvyManage">해시태그 관리</a>
			<a class="btn bg-gradient-info text-lg" href="/admin/srvyList">설문조사 관리</a>
				<div>
			</div>
		</div>
	</div>
	<div class="row col-11 mt-4">
		<div class="col-10">
			<div class="m-3 pt-3 mb-0">
				<h4 class="mb-0">해시태그 관리</h4>
				<p class="text-lg mb-0">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
					  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
					  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
					</svg>
					설문조사 등록 시 사용할 해시태그를 관리할 수 있습니다.
				</p>
			</div>
		</div>
		<div class="col-2">
			<button type="button" class="btn bg-gradient-info btn-block text-lg mt-5 mb-0" style="float:right;" data-bs-toggle="modal" data-bs-target="#CreateHashModal">해시태그 추가</button>
		</div>
	</div>
	<div class="col-11">
			<div class="card card-body pt-2 pb-5 my-3">
					<div class="table-responsive"  id="hashContent">
						<table class="table align-items-center my-5 px-5" id="hashTable">
							<thead>
								<tr>
									<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">순번</th>
									<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">등록번호</th>
									<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">해시태그명</th>
									<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">사용여부</th>
									<th class="text-uppercase text-center text-secondary text-lg font-weight-bolder opacity-7">수정/삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="hashTagListVO" items="${hashTagListVOList}" varStatus="stat">
									<tr class="tagRow">
										<td class="align-middle text-center">
											<span class="text-secondary text-lg">${stat.count}</span>
										</td>
										<td class="align-middle text-center tagNo">
											<span class="text-secondary text-lg">${hashTagListVO.hashTagNo}</span>
										</td>
										<td class="align-middle text-center tagNm">
											<h6 class="mb-0 text-lg">${hashTagListVO.hashTagNm}</h6>
										</td>
										<td class="align-middle text-center">
											<div class="form-check form-switch col-2 mx-auto">
												<input class="form-check-input useYn" type="checkbox" name="useYn" value="Y" <c:if test="${hashTagListVO.useYn eq 'Y'}">checked</c:if> id="flexSwitchCheckDefault1">
											 </div>
										</td>
										<td class="align-middle text-center">
										<a onclick="fn_hashTagModify(this)" class="mx-3" data-bs-toggle="tooltip" data-bs-original-title="해시태그명 수정" data-bs-toggle="modal" data-bs-target="#ModifyHashModal">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" style="color:#8392ab;" class="mb-1" viewBox="0 0 512 512"><path d="M441 58.9L453.1 71c9.4 9.4 9.4 24.6 0 33.9L424 134.1 377.9 88 407 58.9c9.4-9.4 24.6-9.4 33.9 0zM209.8 256.2L344 121.9 390.1 168 255.8 302.2c-2.9 2.9-6.5 5-10.4 6.1l-58.5 16.7 16.7-58.5c1.1-3.9 3.2-7.5 6.1-10.4zM373.1 25L175.8 222.2c-8.7 8.7-15 19.4-18.3 31.1l-28.6 100c-2.4 8.4-.1 17.4 6.1 23.6s15.2 8.5 23.6 6.1l100-28.6c11.8-3.4 22.5-9.7 31.1-18.3L487 138.9c28.1-28.1 28.1-73.7 0-101.8L474.9 25C446.8-3.1 401.2-3.1 373.1 25zM88 64C39.4 64 0 103.4 0 152V424c0 48.6 39.4 88 88 88H360c48.6 0 88-39.4 88-88V312c0-13.3-10.7-24-24-24s-24 10.7-24 24V424c0 22.1-17.9 40-40 40H88c-22.1 0-40-17.9-40-40V152c0-22.1 17.9-40 40-40H200c13.3 0 24-10.7 24-24s-10.7-24-24-24H88z"/></svg>
										</a>
										<a onclick="fn_hashTagDelete(this)" data-bs-toggle="tooltip" data-bs-original-title="해시태그 삭제">
											<i class="fas fa-trash text-secondary" aria-hidden="true"></i>
										</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

<script>
console.log("resMsg : ${resMsg}");
if("${resMsg}" !=''){
     swal({
    	title: "${resMsg}",
    	icon :"success"
    });
}

// 사용여부 체크 시 상태 변경하는 메서드
$(document).on("change",".useYn",function(){
	console.log("상태여부 업데이트 하러왔어요")
	console.log(this);
	let tagNm =$(this).parents(".tagRow").find(".tagNm h6").text();
	let tagNo =$(this).parents(".tagRow").find(".tagNo span").text();
	let useYn = "";
	if($(this).attr("checked") == 'checked'){
		useYn = "N";
	}else{
		useYn = "Y";
	}
	console.log("this : " + $(this).attr("checked"));
	console.log("useYn : " + useYn);
	console.log("tagNm : " + tagNm);
	console.log("tagNo : " + tagNo);

	let data = {
		"hashTagNo" : tagNo,
		"hashTagNm" : tagNm,
		"useYn" : useYn
	}
	$.ajax({
		url : "/survey/modifyUseYn",
		type: "POST",
		data :data,
		beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res){
			$("#hashContent").load("${contextPath}/admin/srvyManage #hashTable");
		}
	})
});

// 해시태그 추가 시 중복 체크
$(document).on("change","#hashTagFrm",function(){
	let hashTagNm = $("#hashTagNm").val();
	let data = {"hashTagNm" : hashTagNm};

	if(hashTagNm == "" || hashTagNm.length == 0){
		$("#tagNameUse").html("");
		$("#submitBtn").attr("disabled",true);
		return false;
	}
	$.ajax({
		url: "/survey/hashTagNmChk",
		type : "POST",
		data : data,
	 	beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res){
			console.log("res : " + res);
			// 중복일 때 (사용불가 메시지 띄우기)
			if(res == "use"){
				$("#tagNameUse").html("<span class='text-xs' style='color:red; float:right;'>이미 사용중인 해시태그명입니다!</span>")
				$("#submitBtn").attr("disabled",true);
			}
			// 중복이 아닐때 (사용가능 메시지 띄우기)
			if(res == "ok"){
				$("#tagNameUse").html("<span class='text-xs' style='color:green; float:right;'>사용가능한 해시태그명입니다!</span>")
				$("#submitBtn").attr("disabled",false);
			}
		} // end for success
	}) // end for ajax
})
$(document).on("click","#modiSubmitBtn",function(){
	let modiHashTagNm = $("#modiHashTagNm").val();
	let modiHashTagNo = $("#modiHashTagNo").val();

	swal({
		  title: "'" + modiHashTagNm +"' 해시태그를 수정하시겠습니까?",
		  text: "확인을 누르면 해시태그가 수정됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "수정",
				value : "modifyOk"
			  }
			},
		})
		.then((value) => {
		  switch (value) {
		    case "modifyOk":
		    	$.ajax({
		    		url : "/survey/modifyUseYn",
		    		type : "POST",
		    		data : {"hashTagNm": modiHashTagNm, "hashTagNo": modiHashTagNo},
		    		beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		    			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    		},
		    		success : function(res){
		  		      swal({
			 		    	title: "해시태그 수정완료!",
			 		    	icon :"success"
			 		    });
		  		   		$("#hashContent").load("${contextPath}/admin/srvyManage #hashTable");
		    		}
				  }) // end for ajax
		    	break;
		    default:
		      swal({
	 		    	title: "해시태그 삭제 취소!",
	 		    	icon :"error"
	 		    });
		 	 }
		});
	$("#ModifyHashModal").modal("hide");
	})

$(document).on("click","#submitBtn",function(){
	let hashTagNm = $("#hashTagNm").val();
	let useYn = $("#useYn:checked").val();
	if(useYn == null){
		useYn = 'N';
	}
	let data = {"hashTagNm" : hashTagNm,
				"useYn" : useYn};

	console.log("-----------------data");
	console.log(data);
	$.ajax({
		url: "/survey/createHashTag",
		type:"POST",
		data : data,
	 	beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res){
			location.href="/admin/srvyManage";
		}// end for success
	}) // end for ajax
});

// 해시태그 수정
function fn_hashTagModify(obj){
	let tagNm =$(obj).parents(".tagRow").find(".tagNm h6").text();
	let tagNo = $(obj).parents(".tagRow").find(".tagNo span").text();
	$("#modiHashTagNm").val("");
	$("#modiHashTagNm").val(tagNm);
	$("#modiHashTagNo").val(tagNo);
	$("#ModifyHashModal").modal("show");
}
// 해시태그 삭제
function fn_hashTagDelete(obj){
	let tagNm =$(obj).parents(".tagRow").find(".tagNm h6").text();

	swal({
		  title: "'" + tagNm +"' 해시태그를 삭제하시겠습니까?",
		  text: "확인을 누르면 해시태그가 삭제됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "삭제",
				value : "deleteOk"
			  }
			},
		})
		.then((value) => {
		  switch (value) {
		    case "deleteOk":
		    	let tagNo = $(obj).parents(".tagRow").find(".tagNo span").text();
		    	let data = {"hashTagNo" : tagNo};

		    	$.ajax({
		    		url: "/survey/deleteHashTag",
		    		type:"POST",
		    		data : data,
		    	 	beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		    			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		    		},
		    		success : function(res){
		    			location.href="/admin/srvyManage";
		    		}// end for success
				}) // end for ajax
		    	break;
		    default:
		      swal({
	 		    	title: "해시태그 삭제 취소!",
	 		    	icon :"error"
	 		    });
		 	 }
		});
} // end for delete function

</script>