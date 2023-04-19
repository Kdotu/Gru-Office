<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
//새로고침 하는 함수
function refresh(){
	   location.reload();
	}
	$(function() {

		$("#del").on("click", function() {
			let wholBbsNo = $(this).data("wholBbsNo");

		let data = {"wholBbsNo" : wholBbsNo};

		console.log("wholBbsNo : " , wholBbsNo);

		$.ajax({
			url:"/board/delWholB",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(result){
            	if(result>0){
            		console.log("삭제성공");
            		swal({
						title: "쪽지가 삭제되었습니다.",
						icon: "success", //success, warning, error
						button: "확인",
					});
            		location.href="/board/wholBList";
            	}else{
            		swal({
						title: "쪽지가 삭제되었습니다.",
						icon: "error", //success, warning, error
						button: "확인",
					});
            	}
            }
		});
    });

});
</script>




<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-3">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->

			<!-- div 밖으로 글씨 뺀거  -->
			<div class="col-12">
<!-- 				<a href="javascript:;" class="card-title h5 d-block text-darker"> -->
<!-- 					공지게시판</a> -->
				<div class="col-12" id="commentSpace">
					<div class="card h-100" id="commentUpdate">
						<div class="card-header pb-0 p-3">
							<div class="row">
								<div style="margin: 10px">
									<!-- 							<button type="button" class="btn btn-outline-dark btn-sm">글쓰기</button> -->
									<!-- 									<button type="button" class="btn btn-outline-dark btn-sm">이동</button>									 -->
									<!-- 									<button type="button" class="btn btn-outline-dark btn-sm">메일발송</button> -->



										<button type="button" class="btn btn-outline-dark btn-sm" id="modi"
											data-whol-bbs-no="${data.wholBbsNo}" style="font-size: 1.1em; height: 38px;">수정</button>
										<button type="button" class="btn btn-outline-danger btn-sm"
											id="del" data-whol-bbs-no="${data.wholBbsNo}" style="font-size: 1.1em; height: 38px;">삭제</button>


									<!-- 									<button type="button" class="btn btn-secondary btn-sm">목록</button> -->
									<a href="/board/admNoticeList" class="btn btn-secondary btn-sm" style="font-size: 1.1em; height: 38px;">목록</a>
								</div>
								<hr style="border: 2px double gray; width: 95%;">
								<div class="col-md-10 d-flex align-items-center">

									<h4 class="mb-0">${data.wholBbsTtl}</h4>
								</div>
								<div class="col-md-2 d-flex align-items-center">
									<p style="font-size: 1.1em;">
										조회수<span>  ${data.wholBbsInqCnt}</span>
									</p>
								</div>
								<hr style="border: 2px double gray; width: 95%;">
								<div class="card-body p-3 row" style="margin-left: 15px;">
									<div class="col-3">
										<p class="text-lg" style="font-weight: bold;">
											게시글 작성자 : <span style="color: black;">${data.empNm}</span>
										</p>
									</div>
									<div class="col-9">
										<p class="text-lg" style="font-weight: bold;">
											게시글 등록일시 : <span style="color: black;"> <fmt:formatDate
													value="${data.wholBbsRegYmd}" pattern="yyyy-MM-dd hh:MM:ss" /></span>
										</p>
									</div>
									<div style="width: 95%; margin-bottom: 10px; border: 2px double gray; padding: 20px;">

										<span style="color: black; font-size: 1.5em;">${data.wholBbsCn}</span>
										<c:if test="${not empty fileVOList}">
							              <c:forEach var="fileVO" items="${fileVOList}" varStatus="stat">
							              	<c:if test="${fileVO.fileOrgnlNm != null}">
								              <img alt="Image placeholder" src="/resources/upload${fileVO.fileStrgNm}" class="img-fluid border-radius-lg shadow-lg"
								              	 style="width:250px;">
							                </c:if>
							              </c:forEach>
						              </c:if>
									</div>


									<%-- <div style="width: 95%; margin-bottom: 30px; margin-top: 20px;">
												멘션 자리 : <span style="color: black;">${data.wholBbsCn}</span>
											</div> --%>


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