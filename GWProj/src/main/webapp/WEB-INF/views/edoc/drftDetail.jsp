<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script src="/resources/ckeditor/ckeditor.js"></script>

<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery.cookie.js"></script>
<script src="/resources/js/jquery.treeview.js"></script>

<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<script type="text/javascript" src="/resources/js/demo.js"></script>
<sec:authorize access="isAuthenticated()">
<sec:authentication property="principal.empVO" var="empVO" />


<script type="text/javascript">
	$(function() {
		$('#cancel').on('click', function() {
			swal({
				title: "취소하시겠습니까?",
				icon: "success", //success, warning, error
				buttons: {
					cancel: {
					    text: "취소",
					    value: false,
					    visible: true,
					    className: "btn btn-secondary"
					  },
					  confirm: {
					    text: "확인",
					    value: true,
					    className: "btn btn-success"
					  }
				  },
				closeOnClickOutside: false,
			}).then(function(result){
				if(result>0){
				window.close();
				}
			})
		});

		$("#approveLine").on("click", function(index, obj) {
			$("#atrzz").show();
			$("#atrzz22").hide();
		});

		$("#referenceLine").on("click", function(index, obj) {
			$("#atrzz").hide();
			$("#atrzz22").show();

			let edocNo = "${list.edocVO.edocNo}";
			//참조자리스트 가져오기
			$.ajax({
				url : '/edoc/getAtrzRfrnc',
				type:'post',
				data: {'edocNo' : edocNo},
				beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(list){
					code ="";
					if(list.length > 0){
						$.each(list,function(i,v){
	 						code+= "<tr class=><td class='align-middle text-center'>"+v.ATRZ_RFRNC_NO+"</td>";
							code+= "<td class='align-middle text-center'>"+v.EMP_NM+"</td>";
							code+= "<td class='align-middle text-center'>"+v.JBPS_NM+"</td>";
							code+= "<td class='align-middle text-center'>"+v.DEPT_NM+"</td>";
						});
					}else{
						code += "<tr class><td class='align-middle text-center m-4' colspan='4'>참조자가 존재하지 않습니다.</td></tr>";

					}

						$('#referenceEmp').html(code);
				},
				error : function(xhr){
					alert(xhr.status);
				}
			});

			let referLength =  $('#referenceEmp').find('tr').length;
			console.log("referenceEmp",referLength);

			if(referLength==0){
				$('#referenceEmp').html("<tr class='delete2'><td colspan='5'>참조자가 없습니다.</td></tr>");
			}
		});

		$("#btnApproveLine").on("click", function() {
			$(".moving-tab").css("width", "375px");
			let edocNo = "${list.edocVO.edocNo}";
			$.ajax({
				url : '/edoc/getAtrz',
				type:'post',
				data: {'edocNo' : edocNo},
				beforeSend : function(xhr) { // 데이터 전송 전  헤더에 csrf값 설정
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(list){
					code ="";
					$.each(list,function(i,v){
						let res ="";
						if(v.ATRZ_YN == 'Y'){
							res = "결재";
						}
						if(v.ATRZ_YN == 'Y' && v.ATRZ_SEQ == 1){
							res = "기안";
						}
						if(v.ATRZ_YN == 'Z'){
							res = "반려";
						}
						if(v.ATRZ_YN ==null){
							res = "-";
						}
 						code+= "<tr class=><td class='align-middle text-center'>"+v.ATRZ_SEQ+"</td>";
						code+= "<td class='align-middle text-center'>"+v.EMP_NM+"</td>";
						code+= "<td class='align-middle text-center'>"+v.JBPS_NM+"</td>";
						code+= "<td class='align-middle text-center'>"+v.DEPT_NM+"</td>";
						code+= "<td class='align-middle text-center'>"+res+"</td>";
						code+= "<td class='align-middle text-center'>"+(v.ATRZ_DT || '-')+"</td></tr>";
					});

						$('#approveEmp').html(code);

				},
				error : function(xhr){
					alert(xhr.status);
				}
		});
		});

		$('#modalHide').on('click',function(){
			$('#modal-default').modal('hide');
		});

		//결재하기
		$('#appro').on('click',function(){

			let lineInfoNo = "${list.edocVO.atrzLineInfoNo}";
			let empNo = "${empVO.empNo}";
			let infoData = {"lineInfoNo": lineInfoNo, "empNo": empNo};

			swal({
				title: "결재하시겠습니까?",
				icon: "success", //success, warning, error
				buttons: {
					cancel: {
					    text: "취소",
					    value: false,
					    visible: true,
					    className: "btn btn-secondary"
					  },
					  confirm: {
					    text: "확인",
					    value: true,
					    className: "btn btn-success"
					  }
				  },
				closeOnClickOutside: false,
			}).then(function (result) {
					if(result){
						$.ajax({
							url : '/edoc/approval',
							type : 'post',
							data : JSON.stringify(infoData),
						    contentType : 'application/json; charset=UTF-8',
							beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
					            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
							},
							success : function(result){
								if(result>0){
									swal({
										title: "결재완료",
										text: "결재가 완료되었습니다.\n",
										icon: "success", //success, warning, error
										button: "확인",
										closeOnClickOutside: false,
									}).then(function(){
										location.href="/edoc/edocDetail?edocVO.edocNo=${list.edocVO.edocNo}&edocVO.edocFormClsf=${list.edocVO.edocFormClsf}&approve=3";
										//부모창새로고침
										opener.location.reload();
									})


								}
							}
						});

					}
		    });
		});


		//모달창 열어서 반려의견가져오기
		$('#clickReject').on('click',function(){
			$('#getrejectModal').modal('show');
			let empNo = "${empVO.empNo}";
			let edocNo = "${list.edocVO.edocNo}";
			let infoData = {"edocNo" : edocNo, "empNo" : empNo};

			$.ajax({
				url : '/edoc/getRjctRsn',
				type : 'post',
				data : JSON.stringify(infoData),
			    contentType : 'application/json; charset=UTF-8',
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success : function(result){
					console.log(result);
					let rjctRsn = result.ATRZ_RJCT_RSN;
					let code = "<td style='font-size : 1.3em;'>"+rjctRsn+"</td>";
						$('#attach').html(code);

				}
			});
		});



		//반려를 누르면
		$('#reject').on('click',function(){

			let lineInfoNo = "${list.edocVO.atrzLineInfoNo}";
			let empNo = "${empVO.empNo}";
			let opinion = $('#opinion').val();
			let infoData = {"lineInfoNo": lineInfoNo, "empNo": empNo, "opinion" : opinion};
			console.log('opinion는?',opinion);
			console.log('infoData는?',infoData);



			swal({
				title: "반려하시겠습니까?",
				icon: "success", //success, warning, error
				buttons: {
					cancel: {
					    text: "취소",
					    value: false,
					    visible: true,
					    className: "btn btn-secondary"
					  },
					  confirm: {
					    text: "확인",
					    value: true,
					    className: "btn btn-success"
					  }
				  },
				closeOnClickOutside: false,
			}).then(function(result){
					if(result>0){
						$.ajax({
							url : '/edoc/reject',
							type : 'post',
							data : JSON.stringify(infoData),
						    contentType : 'application/json; charset=UTF-8',
							beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
					            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
							},
							success : function(result){
								if(result>0){
									swal({
										title: "반려처리완료",
										text: "반려처리가 완료되었습니다.\n",
										icon: "success", //success, warning, error
										button: "확인",
										closeOnClickOutside: false,
									}).then(function(){
						                  location.href="/edoc/edocDetail?edocVO.edocNo=${list.edocVO.edocNo}&edocVO.edocFormClsf=${list.edocVO.edocFormClsf}&approve=3";
						                  //부모창새로고침
						                  opener.location.reload();
									})
								}
							}
						});
					}
			})
		});
		//반려된문서삭제하기
		$('#deleteEdoc').on('click',function(){

			let edocNo = "${list.edocVO.edocNo}";
			console.log("문서번호",edocNo);

			swal({
				title: "삭제하시겠습니까?",
				icon: "success", //success, warning, error
				buttons: {
					cancel: {
					    text: "취소",
					    value: false,
					    visible: true,
					    className: "btn btn-secondary"
					  },
					  confirm: {
					    text: "확인",
					    value: true,
					    className: "btn btn-success"
					  }
				  },
				closeOnClickOutside: false,
			}).then(function(result){
				if(result>0){

					$.ajax({
						url : '/edoc/deleteEdoc',
						data : edocNo,
						type : 'post',
						beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success : function(result2){
							swal({
								title: "삭제완료",
								text: "문서삭제가 완료되었습니다.\n",
								icon: "success", //success, warning, error
								button: "확인",
								closeOnClickOutside: false,
							}).then(function(){
								window.close();
								//부모창새로고침
								opener.location.reload();
							})
						},
					});

				}
			})
		});

		$('#reapprove').on('click',function(){
			swal({
				title: "재기안하시겠습니까?",
				icon: "success", //success, warning, error
				buttons: {
					cancel: {
					    text: "취소",
					    value: false,
					    visible: true,
					    className: "btn btn-secondary"
					  },
					  confirm: {
					    text: "확인",
					    value: true,
					    className: "btn btn-success"
					  }
				  },
				closeOnClickOutside: false,
			}).then(function(result){
				if(result>0){
		               location.href="/edoc/updateEdoc?edocVO.edocNo=${list.edocVO.edocNo}&edocVO.edocFormClsf=${list.edocVO.edocFormClsf}&approve=3";
				}
			})
		});


		//참조완료처리
		$('#atrzRfrncY').on('click',function(){
			swal({
				title: "완료처리하시겠습니까?",
				icon: "success", //success, warning, error
				buttons: {
					cancel: {
					    text: "취소",
					    value: false,
					    visible: true,
					    className: "btn btn-secondary"
					  },
					  confirm: {
					    text: "확인",
					    value: true,
					    className: "btn btn-success"
					  }
				  },
				closeOnClickOutside: false,
			}).then(function(result){
				if(result>0){
					let lineInfoNo = "${list.atrzLineInfoNo}";
					let empNo = "${empVO.empNo}";
					let infoData = {"lineInfoNo": lineInfoNo, "empNo": empNo};
					$.ajax({
						url : '/edoc/atrzRfrncY',
						type : 'post',
						data : JSON.stringify(infoData),
					    contentType : 'application/json; charset=UTF-8',
						beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success : function(result){
							if(result>0){
								swal({
									title: "완료",
									text: "참조완료처리가 완료되었습니다.\n",
									icon: "success", //success, warning, error
									button: "확인",
									closeOnClickOutside: false,
								}).then(function(){
									location.href="/edoc/edocDetail?edocVO.edocNo=${list.edocVO.edocNo}&edocVO.edocFormClsf=${list.edocVO.edocFormClsf}&approve=3";
									//부모창새로고침
									opener.location.reload();
								})
							}
						}
					});
				}
			})
		});



	});
</script>

<style>
ul {
	list-style: none;
}
</style>



	<table class="m-2"
		style="border: 0px solid rgb(0, 0, 0); border-image: none; width: 100px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
		<tr>
			<td><button type="button" class="btn btn-outline-dark"
					id="btnApproveLine" style="font-size:1.2em; width: 130px;" data-bs-toggle="modal"
					data-bs-target="#modal-default">결재정보</button></td>

			<c:if test="${approve eq '1'}" >
			<td>
			<button type="button" class="btn btn-outline-dark" id="appro"
					style="font-size:1.2em; width: 130px;">결재</button></td>
			<td>
			<button type="button" class="btn btn-outline-dark"  data-bs-toggle="modal" data-bs-target="#rejectModal"
					style="font-size:1.2em; width: 130px;">반려</button></td>
			</c:if>
			<c:if test="${approve eq '2'}" ><td>
			<button type="button" class="btn btn-outline-dark" id="atrzRfrncY"
					style="font-size:1.2em; width: 130px;">완료처리</button></td>
			</c:if>

			<c:if test="${approve eq '4'}" >
			<td><button type="button" class="btn btn-outline-dark" id="clickReject"
					style="font-size:1.2em; width: 130px;">반려의견</button></td>
			<td><button type="button" class="btn btn-outline-dark" id="reapprove"
					style="font-size:1.2em; width: 130px;">재기안</button></td>
			<td><button type="button" class="btn btn-outline-dark" id="deleteEdoc"
					style="font-size:1.2em; width: 130px;">삭제</button></td>
			</c:if>

			<td><button type="button" class="btn btn-outline-dark"
					style="font-size:1.2em; width: 130px;" id="cancel">취소</button></td>
		</tr>
	</table>

	<div class="card m-2 mb-0 pb-7">
		<!-- 문서 내용 표시 테스트 -->

		<table class="px-5 mx-5 mx-auto"
			style="border: 0px solid rgb(0, 0, 0); border-image: none; width: 100%; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
			<!-- Header -->
			<colgroup>
				<col width="310">
				<col width="490">
			</colgroup>
			<tbody>
				<tr>
					<td
						style="background: white; padding: 0px !important; border: 0px currentColor; height: 180px; text-align: center; color: black; font-size: 50px; font-weight: bold; vertical-align: middle;"
						colspan="2">${form}</td>
				</tr>
				<tr>
					<td
						style="background: white; padding: 0px !important; border: currentColor; border-image: none; text-align: left; color: black; font-size: 16px; font-weight: normal; vertical-align: top;">
						<div id="agreementWrap" class="sign_type1 sign_type_new"></div>

						<table class="px-5 mx-5 mx-auto"
							style="border: 1px solid rgb(0, 0, 0); border-image: none; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 1px; border-collapse: collapse;">
							<!-- User -->
							<colgroup>
								<col width="90">
								<col width="220">
							</colgroup>
							<tbody>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 16px; font-weight: bold; vertical-align: middle;">기안자</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 16px; font-weight: normal; vertical-align: middle;">
										&nbsp${empInfo.EMP_NM}
									</td>
								</tr>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 16px; font-weight: bold; vertical-align: middle;">
										소속</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 16px; font-weight: normal; vertical-align: middle;">
										&nbsp${empInfo.DEPT_NM}
									</td>
								</tr>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 16px; font-weight: bold; vertical-align: middle;">
										기안일</td>
									<td style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 16px; font-weight: normal; vertical-align: middle;">
										&nbsp<fmt:formatDate pattern='yyyy-MM-dd' value='${list.edocVO.edocDt}' />
									</td>
								</tr>
								<tr>
									<td
										style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 18px; text-align: center; color: rgb(0, 0, 0); font-size: 16px; font-weight: bold; vertical-align: middle;">
										문서번호</td>
									<td
										style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 16px; font-weight: normal; vertical-align: middle;">
										&nbsp${list.edocVO.edocNo}
									</td>
								</tr>
							</tbody>
						</table>
					</td>
			</tbody>
		</table>

		<table class="px-5 mx-5 mx-auto"
			style="border: 0px solid rgb(0, 0, 0); border-image: none; width: 960px; font-family: malgun gothic, dotum, arial, tahoma; margin-top: 10px; border-collapse: collapse;">
			<!-- Draft -->
			<colgroup>
				<col width="120">
				<col width="230">
				<col width="120">
				<col width="330">
			</colgroup>
			<tbody>
				<tr>
					<br />
					<td
						style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 16px; font-weight: bold; vertical-align: middle;">
						제목</td>
					<td
						style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 16px; font-weight: normal; vertical-align: middle;"
						colspan="3">&nbsp${list.edocVO.edocTtl}</td>
				</tr>

				<tr>
				<td
						style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 16px; font-weight: bold; vertical-align: middle;">
						내용</td>
					<td
						style="background: rgb(255, 255, 255); border-width: medium 1px 1px; border-style: none solid solid; border-color: currentColor black black; padding: 5px; height: 550px; text-align: left; color: rgb(0, 0, 0); font-size: 16px; font-weight: normal; vertical-align: top;"
						colspan="4">
						${list.edocVO.dfrtVO.drftCn}
						</td>
				</tr>
			</tbody>

			<tr>
				<td
					style="background: rgb(221, 221, 221); padding: 5px; border: 1px solid black; border-image: none; height: 25px; text-align: center; color: rgb(0, 0, 0); font-size: 16px; font-weight: bold; vertical-align: middle;">
					첨부파일</td>

				<td
					style="background: rgb(255, 255, 255); padding: 5px; border: 1px solid black; border-image: none; text-align: left; color: rgb(0, 0, 0); font-size: 16px; font-weight: normal; vertical-align: middle;"
					colspan="3">
					<c:set var="fileList" value="${list.edocVO.fileGrVO.filesList}" />
					<c:choose>
						<c:when test="${empty fileList}">
							<p>첨부된 파일이 없습니다.</p>
						</c:when>
						<c:otherwise>
							<c:forEach var="file" items="${fileList}">
							<a href="/resources/upload${file.fileStrgNm}" download>${file.fileOrgnlNm}</a><br />
							</c:forEach>
						</c:otherwise>
					</c:choose>

				</td>
			</tr>
		</table>
	</div>


<!-- 결재정보 모달창 -->
<div class="row">
	<div class="col-md-2">
		<div class="modal fade" id="modal-default" tabindex="-1" role="dialog"
			aria-labelledby="modal-default" aria-hidden="true">
			<div class="modal-dialog modal- modal-dialog-centered modal-xl"
				role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="modal-title-default">결재정보</h4>
						<button type="button" class="btn-close text-dark"
							data-bs-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">×</span>
						</button>
					</div>
					<div class="modal-body" style="height: 600px;">
						<div class="nav-wrapper position-relative end-0 mb-3">
							<ul class="nav nav-pills nav-fill p-1 mb-3" role="tablist">
								<li class="nav-item"><a
									class="nav-link mb-0 px-0 py-1 active" id="approveLine"
									data-bs-toggle="tab" href="#atrzz" role="tab"
									aria-controls="profile" aria-selected="true">결재자</a></li>
								<li class="nav-item"><a class="nav-link mb-0 px-0 py-1"
									id="referenceLine" data-bs-toggle="tab" href="#atrzz22"
									role="tab" aria-controls="dashboard" aria-selected="false">참조자
								</a></li>
							</ul>
							<div class="row" id="atrzz">
								<div class="col-lg-12 col-12">
									<div class="border-1 border-secondary border-radius-md py-3">
										<div class="card-body">
											<div class="row">
												<div class="col-12">
													<div class="table-responsive">
														<table class="table text-right">
															<thead class="">
																<tr class="text-center">
																	<th style="width:5%;">순번</th>
																	<th style="width:10%;">성명</th>
																	<th style="width:10%;">직위</th>
																	<th style="width:10%;">부서</th>
																	<th style="width:10%;">처리상태</th>
																	<th style="width:10%;">처리일시</th>
																</tr>
															</thead>
															<tbody class="text-center" id="approveEmp">
<!-- 																 <tr> -->
<!-- 																	<td colspan="5"></td> -->
<!-- 																</tr> -->
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<div class="row" id="atrzz22" style="display: none;">
								<div class="col-lg-12 col-12">
									<div class="border-1 border-secondary border-radius-md py-3">
										<div class="card-body">
											<div class="row">
												<div class="col-12">
													<div class="table-responsive">
														<table class="table text-right">
															<thead class="">
																<tr class="text-center">
																	<th style="width:18%;">순번</th>
																	<th style="width:10%;">성명</th>
																	<th style="width:18%;">직위</th>
																	<th style="width:18%;">부서</th>
																</tr>
															</thead>
															<tbody class="text-center" id="referenceEmp">

															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-outline-dark" id="modalHide">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>








<!-- 결재반려 모달 -->
<div class="row">
  <div class="col-md-4">
    <div class="modal fade" id="rejectModal" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
      <div class="modal- modal-dialog modal- modal-dialog-centered modal-" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h3 class="modal-title" id="modal-title-default">반려하기</h3>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">

          <div class="content">
	<table class="w-100">
		<tbody>
			<tr>
				<th style="font-size : 1.3em;">
					결재문서명
				</th>
				<td style="font-size : 1.3em;">
				 ${list.edocVO.edocTtl}
				</td>
			</tr>
			<tr>
				<th style="font-size : 1.3em;">
						반려결재의견
				</th>
				<td>
					<div class="w-100">
						<textarea  id="opinion" name="description" placeholder="반려의견을 입력해주세요" rows="4"
							style="height:100px; font-size : 1.3em; margin-left:0px; padding-left : 0px;" class="w-90 my-3"></textarea>
					</div>
				</td>
			</tr>
		</tbody>
	</table>
</div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-lg bg-gradient-info" id="reject"
            		style="font-size:1.3em;" >반려</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>






<!-- 결재반려의견 불러오기 -->
<div class="row">
  <div class="col-md-4">
    <div class="modal fade" id="getrejectModal" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
      <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
        <div class="modal-content" style="height:350px;">
          <div class="modal-header">
            <h4 class="modal-title" id="modal-title-default">반려의견보기</h4>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body mx-4 mt-3" >

          <div class="content">
	<table class="w-100 h-100 mt-2">
		<tbody>
			<tr>
				<th  style="font-size : 1.3em;">
					문서명
				</th>
				<td  style="font-size : 1.3em;">
				 ${list.edocVO.edocTtl}
				</td>
			</tr>
			<tr style="height:20px;">
				<td></td>
				<td></td>
			</tr>
			<tr style="height:90%;">
				<th  style="font-size : 1.3em;">
						반려의견
				</th>
				<td id="attach">
				</td>
			</tr>
		</tbody>
	</table>
</div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-lg bg-gradient-info" data-bs-dismiss="modal" id=""
             		style="font-size:1.2em;" >확인</button>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>

</sec:authorize>
