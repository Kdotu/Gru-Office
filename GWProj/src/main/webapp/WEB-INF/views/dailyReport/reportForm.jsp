<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>
<style>
pre{
	font-family: 'Dovemayo_gothic';
}

ft-up-3{
	font-size : 1.3em;
}

</style>

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/dailyReportAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->
		<form id="document_content" class="form_doc_editor editor_view" action="/" method="post" >
		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal.empVO" var="empVO" />
			<div class="row">
				<div class="card m-2 mb-5 pb-7 col-8">
					<!-- 문서 내용 표시 테스트 -->
						<table class="px-5 mx-5  mt-3" style="border: 0px solid rgb(0, 0, 0); border-image: none; width: 650px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
							<!-- Header -->
							<colgroup>
								<col width="310">
								<col width="490">
							</colgroup>
							<tbody>
								<tr>
									<td style="padding: 5px auto; background: white; padding: 0px !important; border: 0px currentColor; height: 90px; text-align: center; color: black; font-size: 36px; font-weight: bold; vertical-align: middle;"
										colspan="2">일 일 업 무 보 고</td>
								</tr>
								<tr>
									<td
										style="background: white; padding: 0px !important; border: currentColor; border-image: none; text-align: left; color: black; font-size: 12px; font-weight: normal; vertical-align: top;">
										<div id="agreementWrap" class="sign_type1 sign_type_new"></div>
										<h5 class="px-0 mb-0">기본사항</h5>
										<hr class="px-0 mx-0 mt-0" style="background-color: gray; height: 2px;" /> <!-- table 내 table 묶음 시작 -->
										<table class="mx-auto" style="border: 1px solid rgb(0, 0, 0); border-image: none; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
											<!-- User -->
											<colgroup>
												<col width="120">
												<col width="200">
												<col width="120">
												<col width="200">
											</colgroup>
											<tbody>
												<tr>
													<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none;
														height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: bold; vertical-align: middle;">작성자
													</td>
													<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0);  font-size: 1.5em;  font-weight: normal; vertical-align: middle;">
														<input type="text" style="vertical-align: middle; width: 100%; border: 0px; box-shadow: inset 0px 0px 0px rgba(150, 150, 150, 0.2)" value="<c:choose><c:when test="${not empty reportEmpList[0]}">${reportEmpList[0].empNm}</c:when><c:otherwise>${empVO.empNm}</c:otherwise>
														</c:choose>">
														<input type="hidden" name="empNo" id="empNo" value="<c:choose><c:when test="${not empty reportEmpList[0]}">${reportEmpList[0].empNo}</c:when><c:otherwise>${empVO.empNo}</c:otherwise></c:choose>">
														<input type="hidden" name="rptpNo" id="rptpNo" value="<c:choose><c:when test="${not empty dailyReportVO}">${dailyReportVO.rptpNo}</c:when></c:choose>">
														<input type="hidden" name="rptpCmptnYn" id="rptpCmptnYn" value="<c:choose><c:when test="${not empty dailyReportVO}">${dailyReportVO.rptpCmptnYn}</c:when></c:choose>">
													</td>
													<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none;
														height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: bold; vertical-align: middle;">작성일
													</td>
													<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none;
														text-align: left; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: normal; vertical-align: middle;">
														<input type="text" style="vertical-align: middle; width: 100%; border: 0px; box-shadow: inset 0px 0px 0px rgba(150, 150, 150, 0.2)" value="<c:choose><c:when test="${not empty dailyReportVO}"><fmt:formatDate pattern="yyyy-MM-dd (E)" value="${dailyReportVO.rptpWrtYmd}" /></c:when><c:otherwise>${serverDate}</c:otherwise></c:choose>">
														<input type="hidden" name="deptNo" id="deptNo" value="<c:choose><c:when test="${not empty reportEmpList[0]}">${reportEmpList[0].deptNo}</c:when><c:otherwise>${empVO.deptNo}</c:otherwise></c:choose>">
													</td>
												</tr>

												<tr>
													<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 18px; text-align: center; color: rgb(0, 0, 0);font-size: 1.5em;font-weight: bold; vertical-align: middle;">
														부서
													</td>
													<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: normal; vertical-align: middle;">
														<input type="text" style="vertical-align: middle; width: 100%; border: 0px; box-shadow: inset 0px 0px 0px rgba(150, 150, 150, 0.2)"
															   value="<c:choose><c:when test="${not empty reportEmpList[0]}">${reportEmpList[0].deptNm}</c:when><c:otherwise>${empVO.deptNm}</c:otherwise></c:choose>">
													</td>
													<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 1.5em;font-weight: bold; vertical-align: middle;">
														직위
													</td>
													<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: normal; vertical-align: middle;">
														<input type="text" style="vertical-align: middle; width: 100%; border: 0px; box-shadow: inset 0px 0px 0px rgba(150, 150, 150, 0.2)"
															   value="${empVO.jbpsNm}" />
													</td>
												</tr>
											</tbody>
										</table> <br class="mt-5 pt-5" />
										<h5 class="px-0 mb-0 mt-4">금일실시사항</h5>
										<hr class="px-0 mx-0 mt-0"
											style="background-color: gray; height: 2px;" />
										<table
											style="border: 0px solid rgb(0, 0, 0); border-image: none; width: 700px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 10px; border-collapse: collapse;">
											<colgroup>
												<col width="190">
												<col width="230">
												<col width="190">
												<col width="330">
											</colgroup>
											<tbody>
												<tr>
													<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 1.5em;font-weight: bold; vertical-align: middle;">
														금일업무목표</td>
													<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0);font-size: 1.5em; font-weight: normal; vertical-align: middle;"
														colspan="3">
														<textarea class="modi" rows="20" cols="100" id="rptpTaskGoal" name="rptpTaskGoal" style="width: 100%; height: 120px;" ${readonly} >${dailyReportVO.rptpTaskGoal}</textarea>
													</td>
												</tr>
											</tbody>
										</table>
										<table
											style="border: 0px solid rgb(0, 0, 0); border-image: none; width: 700px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 10px; border-collapse: collapse;">
											<colgroup>
												<col width="190">
												<col width="230">
												<col width="190">
												<col width="330">
											</colgroup>
											<tbody>
												<tr>
													<td
														style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: bold; vertical-align: middle;">
														현재진행업무</td>
													<td
														style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: normal; vertical-align: middle;"
														colspan="3">
														<textarea class="modi" rows="20" cols="100" id="rptpPrgrsTask" name="rptpPrgrsTask" style="width: 100%; height: 120px;" ${readonly}>${dailyReportVO.rptpPrgrsTask}</textarea>
													</td>
												</tr>
												<tr>
													<td
														style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: bold; vertical-align: middle;">
														익일예정업무</td>
													<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: normal; vertical-align: middle;"
														colspan="3">
														<textarea class="modi" rows="20" cols="100" id="rptpPrnmntTask" name="rptpPrnmntTask" style="width: 100%; height: 120px;" ${readonly} >${dailyReportVO.rptpPrnmntTask}</textarea>
													</td>
												</tr>
											</tbody>
										</table>
										<table style="border: 0px solid rgb(0, 0, 0); border-image: none; width: 700px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 10px; border-collapse: collapse;" class="mt-5 pt-3">
											<colgroup>
												<col width="190">
												<col width="230">
												<col width="190">
												<col width="330">
											</colgroup>
											<tbody>
												<tr>
													<td style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 50px; text-align: center; color: rgb(0, 0, 0);font-size: 1.5em;font-weight: bold; vertical-align: middle;">
														특이점 및 보고사항</td>
													<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 1.5em; font-weight: normal; vertical-align: middle;" colspan="3">
														<textarea class="modi" rows="20" cols="100" id="rptpEtc" name="rptpEtc" style="width: 100%; height: 100px;"></textarea>
													</td>
												</tr>
											</tbody>
										</table> <!-- table 내 table 묶음 끝 -->
									</td>
								</tr>
							</tbody>
						</table>
						</div><!-- end for col-8 -->
						<div class="card m-2 mb-5 pb-7 col-3 col-sm">
							<div class="container-fluid py-4">
						            <div class="card-header pb-0">
						              <h4>일일업무보고 현황</h4>
						              <hr class="horizontal dark mt-0">
						            </div>
						            <div class="mx-auto">
							            <a href="/dailyReport/list" type="button" class="btn btn-outline-dark m-1 p-2 h6 py-1" style="width: 80px;">목록</a>
							            <button type="button" class="btn btn-outline-dark m-1 p-2 h6 py-1" id="btnForm" style="width: 80px;">${btnForm}</button>
										<button type="button" class="btn btn btn-outline-info m-1 p-2 h6 py-1" id="btnConfirm" onclick="fn_confirmSave()" style="display:none; width: 80px;">확인</button>
										<button type="reset" class="btn btn-outline-dark m-1 p-2 h6 py-1"  style="width: 80px;display:none;">취소</button>
								<sec:authorize access="hasAuthority('AUTH_MID')">
									<sec:authentication property="principal.empVO" var="empVO" />
										<c:if test='${not empty reportEmpList[0] and empVO.empNo ne reportEmpList[0].empNo}'>
											<button type="button" class="btn btn-outline-dark m-1 p-2 h6 py-1" onclick="fn_confirmReport()" <c:if test="${dailyReportVO.rptpCmptnYn eq 'Y'}">disabled</c:if> style="width: 100px;">
													보고확인</button>
										</c:if>
								</sec:authorize>
									</div>
						            <div class="card-body p-3" id="reloadSpace">
						            <hr class="horizontal dark mt-0">
						              <div class="timeline timeline-one-side" data-timeline-axis-style="dotted" id="reloadInput">
						                <div class="timeline-block mb-3">
						                  <span class="timeline-step">
						                    <i class="ni ni-bell-55 text-success text-gradient"></i>
						                  </span>
						                  <div class="timeline-content">
						                    <h5 class="text-dark text font-weight-bold mb-0">등록일시</h5>
						                    <p class="text-secondary font-weight-bold text mt-1 mb-0"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${dailyReportVO.rptpWrtYmd}" /></p>
						                    <p class="text-lg my-1 mt-3 badge badge-secondary">금일업무목표 : </p>
						                    <pre class="text mb-2">${dailyReportVO.rptpTaskGoal}</pre>
						                    <button class="btn btn-outline-dark m-1 p-2 h6 py-1"  id="reportChk" onclick="fn_reportChk()" style="width: 130px;" disabled>작성 보고 확인</button>
						                  </div>
						                </div>
						                <div class="timeline-block">
						                  <span class="timeline-step">
						                    <i class="ni ni-check-bold text-info text-gradient"></i>
						                  </span>
						                  <div class="timeline-content">
						                    <h5 class="text-dark text font-weight-bold mb-0">보고 확인</h5>
						                    <c:choose>
						                    	<c:when test="${dailyReportVO.rptpCmptnYn eq 'Y'}">
						                    		<span class="badge badge-success text-lg">확인</span>
							                    	<p class="text mt-2 mb-0 h6">${dailyReportVO.rptpCmptnPicDeptNm} ${dailyReportVO.rptpCmptnPicNm} ${dailyReportVO.rptpCmptnPicJbpsNm}</p>
							                    	<p class="text-secondary font-weight-bold text h6 mb-2"><fmt:formatDate pattern="yyyy-MM-dd hh:mm:ss" value="${dailyReportVO.rptpCmptnDt}" /></p>
					                    		</c:when>
						                    	<c:otherwise><span class="badge badge-warning text-lg">미확인</span></c:otherwise>
						                    </c:choose>
						                  </div>
						                </div>
						                <div class="timeline-block">
						                  <span class="timeline-step">
						                    <i class="ni ni-check-bold text-info text-gradient"></i>
						                  </span>
						                  <div class="timeline-content">

						                  </div>
						                </div>
						              </div>
						            </div>
						          </div>
						<hr class="horizontal dark mt-0">
						</div>
					</div>
				</sec:authorize>
				<sec:csrfInput/>
			</form>
		</div>
	</div>
</div>


<script>
// Toast창으로 결과 띄우기
if("${status}"=="수정완료"){
		let Toast = Swal.mixin({
			toast:true,
			position:'middle-middle',
			showConfirmButton:false,
			timer:3000
		});
		Toast.fire({
			icon:'success',
			title:'수정 완료!'
		});
	}
if("${status}"=="등록완료"){
		let Toast = Swal.mixin({
			toast:true,
			position:'middle-middle',
			showConfirmButton:false,
			timer:3000
		});
		Toast.fire({
			icon:'success',
			title:'일일업무보고 등록 완료!'
		});
	}

// 페이지 들어갔을때 초기 설정----------------------------------
if("${btnForm}"=="작성"){
	let empNo = $("#empNo").val();
	console.log("작성페이지");
	$.ajax({
		url:"/dailyReport/reportRegistCheck",
		type:"post",
		data:{"empNo" : empNo},
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success : function(res){
			if(res==1){
				$("#rptpTaskGoal").attr("disabled",true);
				$("#rptpPrgrsTask").attr("disabled",true);
				$("#rptpPrnmntTask").attr("disabled",true);
				$("#rptpEtc").attr("disabled",true);
				$("#btnForm").attr("disabled",true);
				$("#btnForm").text("작성완료");
				$("#reportChk").show();
				$("#reportChk").attr("disabled",false);
			}
		},
		error : function(xhr){
			alert(xhr.status);
		}
	})
	$("#btnForm").attr("onclick","fn_create()");
	$("#document_content").attr("action","/dailyReport/createReport");
	$("inputy[type=reset]").show();
}
if("${btnForm}"=="수정"){
	$("#reportChk").hide();
	$("#btnForm").attr("onclick","fn_modify()");
	$("#btnForm").attr("class","btn btn-outline-dark m-1 p-2 h6 py-1");
}
//-------------------------------------------------------------

// 등록
function fn_create(){
	let rptpTaskGoal= $("#rptpTaskGoal").val();
	let rptpPrgrsTask= $("#rptpPrgrsTask").val();

	if( (rptpTaskGoal==null  || rptpTaskGoal.length == 0) ||
		(rptpPrgrsTask==null || rptpPrgrsTask.length == 0) ){
		alert("작성된 내용이 없습니다.");
		return;
	}
	swal({
		  title: "일일업무보고를 등록하시겠습니까?",
		  text: "확인을 누르면 입력한 보고가 등록됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "작성",
				value : "createOk"
			  }
			},
		})
		.then((value) => {
		  switch (value) {
		    case "createOk":
				$("#document_content").attr("action","/dailyReport/createReport");
				$("#document_content").submit();
		    	break;
		    default:
		      swal({
	 		    	title: "일일업무보고 등록 취소!",
	 		    	icon :"error"
	 		    });
		 	 }
		});
	}

// 수정
function fn_modify(){
	$(".modi").removeAttr("readonly");
	$("#document_content").attr("action","/dailyReport/modify");
	$("#btnForm").hide();
	$("#btnConfirm").show();
}

// 확인
function fn_confirmSave(){
	swal({
		  title: "일일업무보고를 수정하시겠습니까?",
		  text: "확인을 누르면 입력한 보고가 수정됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "수정",
				value : "createOk"
			  }
			},
		})
		.then((value) => {
		  switch (value) {
		    case "createOk":
				$("#document_content").attr("action","/dailyReport/modify");
				$("#document_content").submit();
		    	break;
		    default:
		      swal({
	 		    	title: "일일업무보고 등록 취소!",
	 		    	icon :"error"
	 		    });
		 	 }
		});
	}


// 이전 작성 보고 확인
function fn_reportChk(){
	let empNo = $("#empNo").val();

	$.ajax({
		url:"/dailyReport/reportChk",
		data : {"empNo": empNo},
		type:"post",
		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(res){
			location.href="/dailyReport/detail?rptpNo="+res;
		},
		error : function(xhr){
			alert(xhr.stats);
		}
	})
}

// 보고 확인 함수
function fn_confirmReport(){
	console.log("보고 확인 처리");
	let rptpNo = "${param.rptpNo}";
	console.log(rptpNo);

	swal({
		  title: "해당 보고를 확인 처리 하시겠습니까?",
		  text: "확인을 누르면 입력한 보고가 확인 처리됩니다.",
		  icon: "warning",
		  buttons: {
			  cancel : "취소",
			  modifyOK : {
				text : "확인",
				value : "confirmOk"
			  }
			},
		})
		.then((value) => {
			  switch (value) {
			    case "confirmOk":
			    	let rptpCmptnYn = "${dailyReportVO.rptpCmptnDt}";
			    	if(rptpCmptnYn != null){ rptpCmptnYn = 'Y'}

			    	let data = {"rptpNo":rptpNo, "rptpCmptnYn":rptpCmptnYn};
			    	console.log(data);
			    	$.ajax({
			    		url:"/dailyReport/confirmReport",
			    		data: data,
			    		type:"post",
			    		beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			    		},
			    		success:function(res){
			    			console.log(res);
			    			if(res > 0){ // 확인 완료
			    			      swal({
			    		 		    	title: "보고 확인 완료!",
			    		 		    	icon :"success"
			    		 		    });
			    			$("#reloadSpace").load("${contextPath}/dailyReport/detail?rptpNo=${dailyReportVO.rptpNo} #reloadInput");
			    			console.log("reload테스트");
			    			}else{ // 확인 실패
			    			      swal({
			    		 		    	title: "보고 확인 실패!",
			    		 		    	icon :"error"
			    		 		    });
			    			}
			    		},
			    		error:function(xhr){
			    			alert(xhr.status);
			    		}
			    	})

			    	break;
			    default:
			      swal({
		 		    	title: "일일업무보고 보고확인 취소",
		 		    	icon :"error"
		 		    });
			 	 }
			});
		}

</script>
