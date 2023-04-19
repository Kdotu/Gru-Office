<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- 조직도 스크립트 -->
<script type="text/javascript" src="/resources/js/demo.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#browser").treeview({
		toggle: function() {
			console.log("%s was toggled.", $(this).find(">span").text());
		}
	});

	$("#add").click(function() {
		var branches = $("<li><span class='folder'>New Sublist</span><ul>" +
			"<li><span class='file'>Item1</span></li>" +
			"<li><span class='file'>Item2</span></li></ul></li>").appendTo("#browser");
		$("#browser").treeview({
			add: branches
		});
	});
});
</script>

<!-- 대상자 추가 모달창 -->
<div class="row">
	<div class="col-md-2">
		<div class="modal fade" id="modal-default" tabindex="-1" role="dialog"
			aria-labelledby="modal-default" aria-hidden="true">
			<div class="modal-dialog modal- modal-dialog-centered modal-lg"
				role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="modal-title-default">쪽지 대상자 추가</h4>
						<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
							<span class="h5" aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body" style="height: 600px;">
						<div class="nav-wrapper position-relative end-0 mb-3">
							<div class="row">
								<div class="col-lg-5 col-5">
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
														<li class="closed dropdownLi">
															<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
															class="folder" data-deptno="DEPT002">경영지원본부</span>
															<ul>
																<li class="closed suvyEmpList dropdownLi">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT003">재무팀</span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList dropdownLi">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT004">인사팀</span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList dropdownLi">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT005">총무팀</span>
																	<ul id="folder21">
																	</ul></li>
															</ul></li>
														<li class="closed dropdownLi">
															<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
															class="folder" data-deptno="DEPT010">영업본부</span>
															<ul>
																<li class="closed suvyEmpList dropdownLi">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT011">영업팀</span>
																	<ul id="folder21"></ul></li>
																<li class="closed suvyEmpList dropdownLi">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT012">마케팅팀</span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList dropdownLi">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT013">CS팀</span>
																	<ul id="folder21">
																	</ul></li>
															</ul></li>
														<li class="closed">
															<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
															class="folder" data-deptno="DEPT006">개발본부</span>
															<ul>
																<li class="closed suvyEmpList">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT007">서비스개발팀</span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT008">플랫폼운영팀</span>
																	<ul id="folder21">
																	</ul></li>
																<li class="closed suvyEmpList">
																	<i class="ni ni-zoom-split-in" style="color: #088ff7;"></i>&nbsp;<span
																	class="folder" data-deptno="DEPT009">디자인팀</span>
																	<ul id="folder21">
																	</ul></li>
															</ul></li>
													</ul></li>
											</ul>
										</div>
									</div>
								</div>
								<!-- 추가된 대상자 확인하는 공간 시작 -->
								<div class="col-lg-7 col-7">
									<div class="border-1 border-secondary border-radius-md">
										<div class="card-body">
											<div class="row">
												<div class="col-12">
													<div class="table-responsive">
														<div class="border-dashed border-1 border-secondary border-radius-md py-3 px-3 m-1" style="height: 560px;">
															<div>
																<h5>쪽지 대상자</h5>
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
						<button type="button" class="btn btn-outline-dark" id="reset">초기화</button>
						<button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal" onclick="fn_addTarget()">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 전체게시판 목록 -->
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
			<form id="frm" name="frm" action="/note/writePost" method="post">
			<div class="row">

					<div class="dataTable-top">
						<a href="javascript:;" class="card-title h5 d-block text-darker">
							쪽지작성</a>
					</div>
					<div class="card card-body mt-4">

						<div class="row mt-4" style="margin-bottom: 15px;">
							<div class="col-12 col-md-6">
								<div class="form-check">
								  <input class="form-check-input" type="checkbox" value="긴급" id="msgCateTag"  name="msgCateTag" >
								  <label class="custom-control-label" for="customCheck1" style="font-size: 1.1em;"><span class="badge badge-danger">긴급</span></label>
								  <!-- value="MSGT0002" -->
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-2">
								<label class="form-label" style="font-size: 1.1em;">수신자</label>
							</div>
							<div class="col-8">
								<!-- 이거!! -->
								<div style="border:2px solid #f5f7ff; width:750px; height:50px;" id="surveyTargetList"></div>
<!-- 								<input -->
<!-- 									class="form-control datetimepicker flatpickr-input" type="text" -->
<!-- 									id="empNoRcvrShow" name="empNoRcvrShow" 									 -->
<!-- 									placeholder="" data-input="" -->
<!-- 									onfocus="focused(this)" onfocusout="defocused(this)"> -->
<!-- 								<input -->
<!-- 									class="form-control datetimepicker flatpickr-input" type="hidden" -->
<!-- 									id="noteList[0].empNoRcvr" name="noteList[0].empNoRcvr" /> -->
							</div>
							<div class="col-2">
							<input type="button" class="btn btn-lg btn-outline-secondary mt-1 mx-auto my-auto px-2 " value="조직도"
										id="noteList[0].empNoRcvr" name="noteList[0].empNoRcvr"
									 style="width: 100px;" data-bs-toggle="modal" data-bs-target="#modal-default">

											<!-- 이거!! -->
<!-- 											<div style="border:2px solid #f5f7ff; width:auto; height:100px;" id="surveyTargetList"></div> -->
<!-- 								<button type="button" id="orgBtn" class="btn btn-outline-info" data-bs-toggle="modal" data-bs-target="#writeModal">조직도</button> -->
							</div>
						</div>
						<div class="row" style="margin-top: 15px;">
							<div class="col-2">
								<label class="form-label" style="font-size: 1.1em;">내용</label>
							</div>
							<div class="col-9">
								<textarea class="form-control" cols="100" rows="2" id="msgCn" name="msgCn">${noteVO.msgCn}</textarea>
							</div>
						</div>
						<div class="d-flex justify-content-center mt-4">
							<button type="button" name="button" class="btn btn-secondary" style="font-size: 1.1em;">취소</button>
							<button type="submit"
								class="btn btn-outline-dark ms-2" style="font-size: 1.1em;">전송</button>
						</div>
					</div>

				</div>
				<sec:csrfInput/>
				</form>
			</div>
		</div><!-- end for row의 2번째 부분 -->
	</div>
</div>

<script>


$(function(){
	//회사 바로 밑에 대표/이사 사원 출력
	$.ajax({
		url:"/org/orgAdminEmp",
		type:"post",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			//result : List<empVO> empVOList
			let str = "";
			console.log(result);


			$.each(result,function(i,v){
				str+= "<li><i class='fas fa-user text-secondary text-sm' ></i>&nbsp;<a class='fileNote' data-empno='"+v.empNo+"'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
			});

			$(".adminEmpNote").append(str);
		}
	});

	//.empList를 선택하면 (this) 아작스 호출해서 해당 태그 자식에 요소 append
		$('.empListNote').on('click',function(){

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
				//result : List<empVO> empVOList
				let str = "";
				console.log(result);

				$.each(result,function(i,v){
					str+= "<li><i class='fas fa-user text-secondary text-sm' ></i>&nbsp;<a class='fileNote' data-empno='"+v.empNo+"'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
				});


				//console.log("str : " + str);
				//.html() : 새로고침 / .append() : 누적

				$($_target).find('ul').html(str);
			}
		});

	});
	//<a class="fileNote" data-empno="202302">조현준 대표</a>
	$(document).on('click','.fileNote',function(){
		let empNo = $(this).data('empno');
		let empNm = $(this).text();
		/*
		<span class="folder" data-deptno="DEPT003">재무팀</span>
		<ul id="folder21" style="">
			<li>
				<img src="/resources/image/file.gif"><a class="fileNote" data-empno="202304">이보름  부장</a>
			</li>
			<li>
				<img src="/resources/image/file.gif"><a class="fileNote" data-empno="202319">민이언 사원</a>
			</li>
		</ul>
		*/
		let deptNo = $(this).parent().parent().prev().data('deptno');
		let deptNm = $(this).parent().parent().prev().text();
		//empNo : 202304, empNm : 이보름  부장, deptNo : DEPT003, deptNm : 재무팀
		console.log("empNo : " + empNo + ", empNm : " + empNm + ", deptNo : " + deptNo + ", deptNm : " + deptNm);

		//val : <input type="text" id="empNoRcvr" value="" />
		//text(덮어쓰기) : <div id="empNoRcvr"></div>
		//append(누적) : <div id="empNoRcvr"></div>
		$("#empNoRcvrShow").val($("#empNoRcvrShow").val() + empNm + ",");	//사원명(보여주기용)
		$("#empNoRcvr").val($("#empNoRcvr").val() + empNo + ",");	//사원번호(실제데이터)
	});

});
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
		//result : List<empVO> empVOList
		let str = "";
// 		console.log(result);
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
			//result : List<empVO> empVOList
			let str = "";
			console.log(result);

			$.each(result,function(i,v){
				str+= "<li><i class='fas fa-user text-secondary text-sm' ></i><a class='srvyFile' data-empno='"+v.empNo+"'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
			});
			$($_target).find('ul').html(str);
		}
	});
})

$(document).on('click', '.srvyFile', function() {
	console.log("comein")
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
	 let tempNo = $("#srvyTarget span").data("empno");
	 let tdeptno = $("#srvyTarget span").data("deptno");

	var ele = document.getElementById('srvyTarget');
	var spanIndex = ele.childElementCount;
	console.log("spanIndex 1 : " , spanIndex);

//       console.log('spanIndex 1 : ',spanIndex);
//       var trContent = $($("#srvyTarget span").get(0)).text().trim();

      // 설문대상 부서 추가
	if(deptNo != null){
	      console.log("2");
	      code += "<span class='m-1 srvyTarget badge badge-secondary' data-deptNo='" + deptNo + "' style='padding-right:10px;'>";
	      code += "<input type='hidden' name='noteList[" + spanIndex + "].deptNo' value='" + deptNo + "' />"+ deptNm;
	      code += "<span style='margin-left:10px;' class='deleteTarget'><i class='fa-lg ni ni-fat-remove'></i></span></span></i>";
	      console.log("3");
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

		 // 인덱스 수정해야함!-------------------------------------------------------------------------★
// 	      console.log('spanIndex 2 : ',spanIndex);
// 	      var trContent = $($("#srvyTarget span").get(0)).text().trim();

    	  // 설문대상 사원 추가
	      if(result.empNo != null){
	    	  console.log("0");
		      code += "<span class='m-1 srvyTarget badge badge-secondary' data-empNo='" + result.empNo + "' style='padding-right:10px;'>";
		      code += "<input type='hidden' name='noteList[" + spanIndex + "].empNoRcvr' value='" + result.empNo + "' />" + result.empNm + " " + result.deptNm + " " + result.jbpsNm;
		      code += "<span style='margin-left:10px;' class='deleteTarget'><i class='fa-lg ni ni-fat-remove'></i></span></span></i>";
		      console.log("1");
	      }

	      code += "";
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











