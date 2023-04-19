<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>


<style>
.hr1{
	height: 2px;
	background-color: gray;
	margin: 5px;
}

.imgIcon{
	width: 20px;
}


</style>

<script>


function refresh(){
	location.reload();
}

//즐겨찾기 아이콘(별) 클릭시 이벤트
function bMarkList(e) {
	var src = $(e).attr("src");
	var projNo = $(e).attr("title");
	var data = {
		       'projNo' : projNo
		       };

	if(src == "/resources/image/starli.png"){

		//즐겨찾기 삭제
		$.ajax({
			url: '/projects/deleteBookmark',
			data: JSON.stringify(data),
	        dataType: 'json',
			type: 'post',
			beforeSend: function(xhr) {
		           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		    },
			success: function (res) {
				refresh();
			}
		});
	}
	if(src == "/resources/image/starbl.png"){

		//즐겨찾기 등록
		$.ajax({
			url: '/projects/createBookmark',
			data: JSON.stringify(data),
			dataType: 'json',
			type: 'post',
			beforeSend: function(xhr) {
		           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		    },
			success: function (res) {
				refresh();
			}
		});
	}
}


function clip(e){
	var projNo = $(e).attr("title");

	var url = '';
	var textarea = document.createElement("textarea");
	document.body.appendChild(textarea);
	url = 'localhost/projects/projDetail?projNo=' + projNo;
	textarea.value = url;
	textarea.select();
	document.execCommand("copy");
	document.body.removeChild(textarea);
	alert("URL이 복사되었습니다.")
}

//프로젝트 삭제
function projDelete(e) {
	var projNo = $(e).attr("title");
	var data = {
		       'projNo' : projNo
		       };
	$.ajax({
		url: '/projects/ingTask',
		data: JSON.stringify(data),
        dataType: 'json',
		type: 'post',
		beforeSend: function(xhr) {
	           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
	           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
	    },
		success: function (res) {
			if(res > 0){
				swal({
					title: "삭제 불가",
					text: "진행중인 태스크가 있어 삭제할 수 없습니다.\n(진행중인 태스크 : " + res + "개)",
					icon: "error", //success, warning, error
					button: "확인",
					closeOnClickOutside: false,
				});

			}else{
				swal({
					title: "프로젝트를 삭제하시겠습니까?",
					icon: "warning", //success, warning, error
					buttons: {
						cancel: {
						    text: "취소",
						    value: false,
						    visible: true,
						    className: "btn btn-secondary"
						  },
						  confirm: {
						    text: "삭제",
						    value: true,
						    className: "btn btn-danger"
						  }
					  },
					closeOnClickOutside: false,
				}).then(function (result) {
						if(result){
							var projNo = $(e).attr("title");
							var data = {
								       'projNo' : projNo
								       };

							$.ajax({
								url: '/projects/projDelete',
								data: JSON.stringify(data),
						        dataType: 'json',
								type: 'post',
								beforeSend: function(xhr) {
							           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
							           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
							    },
								success: function (res) {
									swal({
										title: "프로젝트가 삭제되었습니다",
										icon: "success", //success, warning, error
										button: "확인",
										closeOnClickOutside: false,
									}).then(function () {
										refresh();
									});
								}
							});

						}
			    });
			}
		}
	});
}

//프로젝트 복구
function remake(e) {
	swal({
		title: "프로젝트를 복구하시겠습니까?",
		icon: "warning", //success, warning, error
		buttons: {
			cancel: {
			    text: "취소",
			    value: false,
			    visible: true,
			    className: "btn btn-secondary"
			  },
			  confirm: {
			    text: "복구",
			    value: true,
			    className: "btn btn-info"
			  }
		  },
		closeOnClickOutside: false,
	}).then(function (result) {
			if(result){
				var projNo = $(e).attr("title");
				var data = {
					       'projNo' : projNo
					       };

				$.ajax({
					url: '/projects/remake',
					data: JSON.stringify(data),
			        dataType: 'json',
					type: 'post',
					beforeSend: function(xhr) {
				           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
				           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
				    },
					success: function (res) {
						swal({
							title: "프로젝트가 복구되었습니다",
							icon: "success", //success, warning, error
							button: "확인",
							closeOnClickOutside: false,
						}).then(function () {
							refresh();
						});
					}
				});

			}
    });
}
</script>

<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
<div class="row mt-4">
	<div class="col-12">
		<div class="card mb-4">
			<div class="card-header pb-0 p-3">
				<div class="dropdown">
					<button class="btn bg-gradient-dark dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" style="font-size: 1.2em;">
				    	Works
					</button>
					<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton" style="font-size: 1.2em;">
						<p style="color: gray; text-align: center; margin-top: 10px;">Works</p>
						<hr class="hr1">&nbsp;&nbsp;
						<button type="button"  data-bs-toggle="modal" data-bs-target="#projCreate" style="background: none; border: none;">
							<img alt="" src="/resources/image/add.png" class="imgIcon">&nbsp;&nbsp;새 프로젝트 만들기
						</button>
						<hr class="hr1">
						<a class="dropdown-item" href="/projects/projList" style="color: black;"><img alt="" src="/resources/image/home1.png" class="imgIcon">&nbsp;&nbsp;Works 홈</a><hr class="hr1">
						&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" src="/resources/image/starbl.png" class="imgIcon">&nbsp;&nbsp;<span style="color: black;">즐겨찾는 프로젝트</span>
						<div id="bookMark"></div>
						<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
						<c:if test="${projVO.bookmark == 1}">
							<div style="margin-left: 27px;">
								<a class="dropdown-item" href="/projects/projDetail?projNo=${projVO.projNo}">${projVO.projTtl}</a>
							</div>
						</c:if>
						</c:forEach>
						<hr class="hr1">
						&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" src="/resources/image/ing.png" class="imgIcon">&nbsp;&nbsp;<span style="color: black;">진행중인 프로젝트</span>
						<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
						<c:if test="${projVO.cdNm eq '진행중'}">
							<div style="margin-left: 27px;">
								<a class="dropdown-item" href="/projects/projDetail?projNo=${projVO.projNo}">${projVO.projTtl}</a>
							</div>
						</c:if>
						</c:forEach>
						<hr class="hr1">
						&nbsp;&nbsp;&nbsp;&nbsp;<img alt="" src="/resources/image/done.png" class="imgIcon">&nbsp;&nbsp;<span style="color: black;">완료된 프로젝트</span>
						<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
						<c:if test="${projVO.cdNm eq '종료'}">
						<div style="margin-left: 27px;">
							<a class="dropdown-item" href="/projects/projDetail?projNo=${projVO.projNo}">${projVO.projTtl}</a>
						</div>
					</c:if>
					</c:forEach>
					</ul>
				</div>
				<p class="text-lg mb-0">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
		  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
		  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
					</svg>
					프로젝트 등록자 또는 담당자만 해당 프로젝트를 삭제할 수 있습니다.
				</p>
			</div>


			<div class="card-body p-3" style="margin-bottom: 40px; margin-top: 10px;">
				<h4><img src="/resources/image/bm.png" style="width: 20px; margin-bottom: 8px;">  즐겨찾는 프로젝트</h4>
				<div class="row">
					<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
					<c:if test="${projVO.bookmark == 1 && (projVO.projSsts == 'PROJ0001' || projVO.projSsts == 'PROJ0002')}">
						<div class="col-xl-3 col-md-6 mb-xl-0 mb-4" style="border-radius: 10px; margin: 20px; border: 2px double #c8c8c8; ">
							<div class="card card-blog card-plain">
								<div class="card-body px-1 pb-0">
									<div class="row">
										<div class="col-md-7">
											<p class="text-gradient text-dark mb-2 text-md">프로젝트 #${projVO.projNo}</p>
										</div>
										<div class="col-md-5" align="right" style="margin-top: -15px;">
											<c:if test="${empVO.empNo eq projVO.empNo}">
												<button type="button" style="border: none; background: none; padding: 3px;"><img onclick="projDelete(this)" alt="Image placeholder" src="/resources/image/waste.png" title="${projVO.projNo}" style="width: 23px;"></button>
											</c:if>
											<button type="button" style="border: none; background: none; padding: 3px;"><img onclick="clip(this); return false;" alt="Image placeholder" src="/resources/image/share.png" title="${projVO.projNo}" style="width: 23px;"></button>
											<button type="button" style="border: none; background: none; padding: 3px;"><img onclick="bMarkList(this)" alt="Image placeholder" src="/resources/image/starli.png" title="${projVO.projNo}" style="width: 23px;"></button>
										</div>
									</div>
									<h4>${projVO.projTtl}</h4>
									<div class="d-flex align-items-right justify-content-between" >
										<div class="avatar-group mt-2" style="margin-bottom: 15px;">
											<c:forEach var="prtpntVO" items="${projVO.projPrtpntVOList}" varStatus="stat">
												<c:if test="${empty prtpntVO.pempno}"></c:if>
												<c:if test="${not empty prtpntVO.pempno}">
												<a href="javascript:;" class="avatar avatar-sm rounded-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="${prtpntVO.empNm} ${prtpntVO.empJbps}" data-bs-original-title="${prtpntVO.empNm} ${prtpntVO.empJbps}">
													<c:choose>
														<c:when test="${not empty prtpntVO.fileStrgNm}">
										                 	<img alt="Image placeholder" src="/resources/upload${prtpntVO.fileStrgNm}" >
														</c:when>
														<c:otherwise>
										                	<img src="/resources/upload/emp/profile/default.png" alt="default.png" >
														</c:otherwise>
									        	    </c:choose>
												</a>
												</c:if>
											</c:forEach>
										</div>
									</div>
									<div style="margin-bottom: 15px;">
										<a href="/projects/projDetail?projNo=${projVO.projNo}" class="badge badge-info" style="font-weight: bolder; font-size: 1.1em; height: 35px; width: 130px; padding-top: 11px;">프로젝트 보기</a>
										<div style="width: 100px; text-align: center; float: right; margin-right: 20px;">
											<span class="badge badge-secondary endYmd" style="font-weight: bolder; font-size: 1.0em; height: 35px; padding-top: 11px;">${projVO.projEndYmd}</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:if>
					</c:forEach>
				</div>
			</div>


			<div class="card-body p-3" style="margin-bottom: 40px;">
				<h4><img src="/resources/image/ping.png" style="width: 20px; margin-bottom: 6px;">  진행중인 프로젝트</h4>
				<div class="row">
					<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
					<c:if test="${projVO.cdNm eq '진행중'}">
						<div class="col-xl-3 col-md-6 mb-xl-0 mb-4" style="border-radius: 10px; margin: 20px; border: 2px double #c8c8c8;">
						<div class="card card-blog card-plain">
							<div class="card-body px-1 pb-0">
								<div class="row">
									<div class="col-md-7">
										<p class="text-gradient text-dark mb-2 text-md">프로젝트 #${projVO.projNo}</p>
									</div>
									<div class="col-md-5" align="right" style="margin-top: -15px;">
										<c:if test="${empVO.empNo eq projVO.empNo}">
											<button type="button" style="border: none; background: none; padding: 3px;"><img onclick="projDelete(this)" alt="Image placeholder" src="/resources/image/waste.png" title="${projVO.projNo}" style="width: 23px;"></button>
										</c:if>
										<button type="button" style="border: none; background: none;"><img onclick="clip(this); return false;" alt="Image placeholder" src="/resources/image/share.png" title="${projVO.projNo}" style="width: 23px;"></button>
										<button type="button" style="border: none; background: none;">
											<img onclick="bMarkList(this)" alt="Image placeholder" src="/resources/image/<c:if test="${projVO.bookmark == 1}">starli</c:if><c:if test="${projVO.bookmark == 0}">starbl</c:if>.png" title="${projVO.projNo}" style="width: 23px;">
										</button>
									</div>
								</div>
								<h4>${projVO.projTtl}</h4>
								<div class="d-flex align-items-right justify-content-between" >
									<div class="avatar-group mt-2" style="margin-bottom: 15px;">
										<c:forEach var="prtpntVO" items="${projVO.projPrtpntVOList}" varStatus="stat">
										<c:if test="${empty prtpntVO.pempno}"></c:if>
										<c:if test="${not empty prtpntVO.pempno}">
										<a href="javascript:;" class="avatar avatar-sm rounded-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="${prtpntVO.empNm} ${prtpntVO.empJbps}" data-bs-original-title="${prtpntVO.empNm} ${prtpntVO.empJbps}">
											<c:choose>
												<c:when test="${not empty prtpntVO.fileStrgNm}">
								                 	<img alt="Image placeholder" src="/resources/upload${prtpntVO.fileStrgNm}" >
												</c:when>
												<c:otherwise>
								                	<img src="/resources/upload/emp/profile/default.png" alt="default.png" >
												</c:otherwise>
							        	    </c:choose>
										</a>
										</c:if>
										</c:forEach>
									</div>
								</div>
								<div style="margin-bottom: 15px;">
									<a href="/projects/projDetail?projNo=${projVO.projNo}" class="badge badge-info" style="font-weight: bolder; font-size: 1.1em; height: 35px; width: 130px; padding-top: 11px;">프로젝트 보기</a>
									<div style="width: 100px; text-align: center; float: right; margin-right: 20px;">
										<span class="badge badge-secondary endYmd" style="font-weight: bolder; font-size: 1.0em; height: 35px; padding-top: 11px;">${projVO.projEndYmd}</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					</c:if>
					</c:forEach>


					<div class="col-xl-3 col-md-6 mb-xl-0 mb-4" style="border-radius: 10px; margin: 20px;">
						<div class="card h-100 card-plain border">
							<div class="card-body d-flex flex-column justify-content-center text-center">
								<button type="button"  data-bs-toggle="modal" data-bs-target="#projCreate" style="background: none; border: none;">
									<i class="fa fa-plus text-secondary mb-3" aria-hidden="true"></i>
									<h5 class=" text-secondary"> 새 프로젝트 추가 </h5>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="card-body p-3" style="margin-bottom: 40px;">
				<h4><img src="/resources/image/end.png" style="width: 20px; margin-bottom: 6px;">  종료된 프로젝트</h4>
				<div class="row">
				<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
					<c:if test="${projVO.cdNm eq '종료'}">
						<div class="col-xl-3 col-md-6 mb-xl-0 mb-4" style="border-radius: 10px; margin: 20px; border: 2px double #c8c8c8; ">
						<div class="card card-blog card-plain">
							<div class="card-body px-1 pb-0">
								<div class="row">
									<div class="col-md-7">
										<p class="text-gradient text-dark mb-2 text-md">프로젝트 #${projVO.projNo}</p>
									</div>
									<div class="col-md-5" align="right" style="margin-top: -15px;">
										<c:if test="${empVO.empNo eq projVO.empNo}">
											<button type="button" style="border: none; background: none; padding: 3px;"><img onclick="projDelete(this)" alt="Image placeholder" src="/resources/image/waste.png" title="${projVO.projNo}" style="width: 23px;"></button>
										</c:if>
										<button type="button" style="border: none; background: none;"><img onclick="clip(this); return false;" alt="Image placeholder" src="/resources/image/share.png" title="${projVO.projNo}" style="width: 23px;"></button>
										<button type="button" style="border: none; background: none;"><img onclick="bMarkList(this)" alt="Image placeholder" src="/resources/image/<c:if test="${projVO.bookmark == 1}">starli</c:if><c:if test="${projVO.bookmark == 0}">starbl</c:if>.png" title="${projVO.projNo}" style="width: 23px;"></button>
									</div>
								</div>
								<h4>${projVO.projTtl}</h4>
								<div class="d-flex align-items-right justify-content-between" >
									<div class="avatar-group mt-2" style="margin-bottom: 15px;">
										<c:forEach var="prtpntVO" items="${projVO.projPrtpntVOList}" varStatus="stat">
										<c:if test="${empty prtpntVO.pempno}"></c:if>
										<c:if test="${not empty prtpntVO.pempno}">
										<a href="javascript:;" class="avatar avatar-sm rounded-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="${prtpntVO.empNm} ${prtpntVO.empJbps}" data-bs-original-title="${prtpntVO.empNm} ${prtpntVO.empJbps}">
											<c:choose>
												<c:when test="${not empty prtpntVO.fileStrgNm}">
								                 	<img alt="Image placeholder" src="/resources/upload${prtpntVO.fileStrgNm}" >
												</c:when>
												<c:otherwise>
								                	<img src="/resources/upload/emp/profile/default.png" alt="default.png" >
												</c:otherwise>
							        	    </c:choose>
										</a>
										</c:if>
										</c:forEach>
									</div>
								</div>
								<div style="margin-bottom: 15px;">
									<a href="/projects/projDetail?projNo=${projVO.projNo}" class="badge badge-info" style="font-weight: bolder; font-size: 1.1em; height: 35px; width: 130px; padding-top: 11px;">프로젝트 보기</a>
									<div style="width: 100px; text-align: center; float: right; margin-right: 20px;">
										<span class="badge badge-secondary endYmd" style="font-weight: bolder; font-size: 1.0em; height: 35px; padding-top: 11px;">${projVO.projEndYmd}</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					</c:if>
				</c:forEach>
				</div>
			</div>
			<hr style="border: 3px ridge gray; margin: 20px;">
			<div class="card-body p-3" style="margin-bottom: 15px;">
				<h4><img src="/resources/image/del.png" style="width: 20px; margin-bottom: 5px;">  휴지통</h4>
				<div class="row">
				<c:forEach var="projVO" items="${projVOList}" varStatus="stat">
					<c:if test="${projVO.cdNm eq '삭제'}">
						<div class="col-xl-3 col-md-6 mb-xl-0 mb-4" style="border-radius: 10px; margin: 20px; border: 2px double #c8c8c8; background: #dcdcdc;">
						<div class="card card-blog card-plain">
							<div class="card-body px-1 pb-0">
								<div class="row">
									<div class="col-md-7">
										<p class="text-gradient text-dark mb-2 text-md">프로젝트 #${projVO.projNo}</p>
									</div>
									<div class="col-md-5" align="right" style="margin-top: -15px;">
									<c:if test="${empVO.empNo eq projVO.empNo}">
										<button type="button" onclick="remake(this)" title="${projVO.projNo}"  class="btn btn-outline-dark" style="padding: 10px; font-weight: bold; border: none; background: white; font-size: 1.0em;">
											<img alt="Image placeholder" src="/resources/image/remake.png" style="width: 20px; padding: 0px;">&nbsp;복구
										</button>
									</c:if>
									</div>
								</div>
								<h4>${projVO.projTtl}</h4>
								<div class="d-flex align-items-right justify-content-between" >
									<div class="avatar-group mt-2" style="margin-bottom: 15px;">
										<c:forEach var="prtpntVO" items="${projVO.projPrtpntVOList}" varStatus="stat">
										<c:if test="${empty prtpntVO.pempno}"></c:if>
										<c:if test="${not empty prtpntVO.pempno}">
										<a href="javascript:;" class="avatar avatar-sm rounded-circle" data-bs-toggle="tooltip" data-bs-placement="bottom" aria-label="${prtpntVO.empNm} ${prtpntVO.empJbps}" data-bs-original-title="${prtpntVO.empNm} ${prtpntVO.empJbps}">
											<c:choose>
												<c:when test="${not empty prtpntVO.fileStrgNm}">
								                 	<img alt="Image placeholder" src="/resources/upload${prtpntVO.fileStrgNm}" >
												</c:when>
												<c:otherwise>
								                	<img src="/resources/upload/emp/profile/default.png" alt="default.png" >
												</c:otherwise>
							        	    </c:choose>
										</a>
										</c:if>
										</c:forEach>
									</div>
								</div>
								<div style="margin-bottom: 15px;">
									<a href="/projects/projDetail?projNo=${projVO.projNo}" class="badge badge-info" style="font-weight: bolder; font-size: 1.1em; height: 35px; width: 130px; padding-top: 11px;">프로젝트 보기</a>
									<div style="width: 100px; text-align: center; float: right; margin-right: 20px;">
										<span class="badge badge-secondary endYmd" style="font-weight: bolder; font-size: 1.0em; height: 35px; padding-top: 11px;">${projVO.projEndYmd}</span>
									</div>
								</div>
							</div>
						</div>
					</div>
					</c:if>
				</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 새 프로젝트 등록 모달창 -->
<div class="modal fade" id="projCreate" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title" id="exampleModalLabel">새 프로젝트 등록하기</h4>
				<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<p class="text-lg mb-0" style="margin: 10px;">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
	  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
	  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
				</svg>
				프로젝트 등록자가 프로젝트 담당자로 자동 설정됩니다.
			</p>
			<form action="/projects/create?${_csrf.parameterName}=${_csrf.token}" id="frm" name="frm" method="post">
				<div class="modal-body" style="font-size: 1.3em;">
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">이름</label>
							<input type="text" style="font-size: 0.8em;" class="form-control" id="projTtl" name="projTtl" placeholder="프로젝트 이름을 입력하세요" required>
						</div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">기한일</label>
							<input type="date"  style="font-size: 0.8em;" class="form-control endYmd" id="projEndYmd" name="projEndYmd"  placeholder="프로젝트 기한일을 선택하세요" required>
						</div>
				</div>
				<div class="modal-footer">
		            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal" style="font-size: 1.2em;">취소</button>
		            <button type="button" class="btn bg-gradient-primary" style="background: #5C67F5; font-size: 1.2em;" onclick="showSwal()">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>
</sec:authorize>

<script>
var now_utc = Date.now() // 지금 날짜를 밀리초로
//getTimezoneOffset()은 현재 시간과의 차이를 분 단위로 반환
var timeOff = new Date().getTimezoneOffset()*60000; // 분단위를 밀리초로 변환
//new Date(now_utc-timeOff).toISOString()은 '2022-05-11T18:09:38.134Z'를 반환
var today = new Date(now_utc-timeOff).toISOString().split("T")[0];
document.getElementById("projEndYmd").setAttribute("min", today);
</script>

<script>
function showSwal() {
	swal({
		title: "새 프로젝트가 등록되었습니다",
		icon: "success", //success, warning, error
		button: "확인",
	}).then(function () {
        $('#frm').submit();
    });

}
</script>