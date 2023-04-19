<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
.deleteCmnt, .editCmnt{
	display: none;
}
#cmntText{
	resize: none;
}
</style>


<script type="text/javascript">
//새로고침 하는 함수
function refresh(){
	   location.reload();
	}
	$(function() {
		//좋아요 기능
		$("#goodImg").on("click", function() {
			console.log("조아요");
// 			let good = $("#good").text();

// 			good = good + 1;

// 			console.log("good :" + good);

			let wholBbsNo = ${param.wholBbsNo}
			console.log("wholBbsNo :" + wholBbsNo);

			let data = {"wholBbsNo":wholBbsNo};

			$.ajax({
				url : "/board/wholBLikeUp",
				contentType:"application/json;charset:utf-8",
				type : "post",
				data : JSON.stringify(data),
				dataType : "json",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
				success : function(result) {
					console.log("result : " + result);

					result = Number($("#good").text()) + result;
					$("#good").text(result);

					refresh();
				}
			});
		});
		//글 삭제
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
						title: "게시글이 삭제되었습니다.",
						icon: "success", //success, warning, error
						button: "확인",
					}).then(function () {
						location.href="/board/wholBList";
				    });
            	}else{
            		swal({
						title: "게시글이 삭제되었습니다.",
						icon: "error", //success, warning, error
						button: "확인",
					});
            	}
            }
		});
    });
		//댓글등록
		$("#cmntCreate").on("click",function(){
			let textarea = $("#cmntText").val();
			let wholBbsNo = ${param.wholBbsNo}

			console.log("cmntCn : " , textarea);
			console.log("cmntClsf : " , wholBbsNo);
			//변수로 들어갈 이름과 같게 해준다.
			let data = {"cmntCn" : textarea
						,"cmntClsf" : wholBbsNo
						};
			$.ajax({
				url:"/board/createCmnt",
				type:"post",
				contentType:"application/json;charset:utf-8",
				data:JSON.stringify(data),
				dataType:"json",
				beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					console.log("여기왔어?");

					if(result>0){
						//댓글 쓴 후  입력란은  다시 비어있는상태로 돌려준다.
						cmntText="";

					}
					// jQuery의 .load() 메소드는 주어진 URL로부터 HTML 데이트를 받에서 jQuery 셀력터로 선택된 위에에 넣어 줌으로써 동적으로 페이지의 내용을 교체하는 작업을 함.
					$("#commentSpace").load("${contextPath}/board/wholBDetail?wholBbsNo=${data.wholBbsNo} #commentUpdate");
				}
			});
		});
		//수정버튼 클릭시
		$(".editCmnt").on("click",function(){
			$(document).off("mouseover",".commentZone");

			console.log("수정왔어요??");
			var oc = $(this).prev().prev();
			var tc = $(this).next();
			var mc = $(this).next().next();
			var x = $(this).prev();
			var img = $(this);
			console.log("oc : ", oc);
			console.log("tc : ", tc);
			console.log("mc : ", mc);
			oc.css('display', 'none');//댓글내용보이는곳 숨기기
			tc.css('display','block');//숨겨둔 textarea 보이기
			mc.css('display','block');//저장 취소 버튼이 있는 div 보이기
			x.css('display','none');
			img.css('display','none');
		});
		//취소버튼 클릭시 수정버튼과 반대
		$(".btnMCmntX").on("click", function(){
			commentMouseEvent();
			console.log("취소왔어요??");
			var oc = $(this).parent().prev().prev();
			var tc = $(this).parent().prev();
			var mc = $(this).parent();
			let cmntNo = $("input[name='cmntNo']").val();

			oc.css('display', 'block');
			tc.val('');//댓글 수정하려고 적은거 없애기
			tc.css('display','none');
			mc.css('display','none');
		})

		//저장버튼 클릭시
		$(".btnMCmnt").on("click",function(){
			commentMouseEvent();

			let cmntNo = $(this).prev().val();
			console.log("cmntNo?? : ", cmntNo);

// 			let cmntCn = $(".updCmntCn").val();
			let cmntCn = $(this).parent().prev().val();
			console.log("cmntCn?? : ", cmntCn);

			let data={"cmntNo":cmntNo
					, "cmntCn":cmntCn
					};

			$.ajax({
				url:"/board/updateCmnt",
				type:"post",
				contentType:"application/json;charset:utf-8",
				data:JSON.stringify(data),
				dataType:"json",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
				success:function(result){
					console.log("result 니?  : ", result);

					var oc = $(this).parent().prev().prev();
					var tc = $(this).parent().prev();
					var mc = $(this).parent();
					console.log("oc");
					console.log("tc");
					console.log("mc");


					oc.css('display', 'block');
					tc.css('display','none');
					mc.css('display','none');


					oc.text(cmntCn);
					refresh();

				}
			});
		});
		//댓글 삭제
		$(".deleteCmnt").on("click",function(){
			let p = $(this);
			console.log("p 나와유?? : ",p);

			let cmntNo = $(this).val();

			console.log("cmntNo : ",cmntNo);

			var data={"cmntNo":cmntNo};

			$.ajax({
				url:"/board/deleteCmnt",
				type:"post",
				contentType:"application/json;charset:utf-8",
				data:JSON.stringify(data),
				dataType:"json",
				beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
	            success:function(result){
	            	console.log("result : " , result);
	            	if(result>0){
	            		p.remove();
	            		refresh();
	            	}
	            }

				});
			});
// 		});
	$("#modi").on("click",function(){
		let wholBbsNo = $(this).data("wholBbsNo");
		console.log("wholBbsNo : " , wholBbsNo);
		data={"wholBbsNo":wholBbsNo};

		$.ajax({
			url:"/board/wholBModi",
			type:"post",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			dataType:"json",
			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log("result");
			}

		});
	});

});
</script>

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/boardAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->

			<!-- div 밖으로 글씨 뺀거  -->
			<div class="col-12">

				<div class="col-12" id="commentSpace">
					<div class="card h-100" id="commentUpdate">
						<div class="card-header pb-0 p-3">
							<div class="row">
								<div>
									<!-- 							<button type="button" class="btn btn-outline-dark btn-sm">글쓰기</button> -->
<!-- 									<button type="button" class="btn btn-outline-dark btn-sm">이동</button>									 -->
<!-- 									<button type="button" class="btn btn-outline-dark btn-sm">메일발송</button> -->
									<button type="button" class="btn btn-dark btn" id="modi" data-whol-bbs-no="${data.wholBbsNo}" style="font-size:1.0em;">수정</button>
									<button type="button" class="btn btn-outline-danger btn"
										id="del" data-whol-bbs-no="${data.wholBbsNo}" style="font-size:1.0em;">삭제</button>
<!-- 									<button type="button" class="btn btn-secondary btn-sm">목록</button> -->
									<a href="/board/wholBList" class="btn btn-secondary btn" style="font-size:1.0em;">목록</a>
								</div>
								<hr style="border: 2px double gray; width: 95%;">
								<div class="col-md-10 d-flex align-items-center" style="height: 100%;">
									<h4 class="">${data.wholBbsTtl}</h4>
								</div>
								<div class="col-md-2 d-flex align-items-center">
									<p style="font-size:1.2em;">
										조회수&nbsp;&nbsp;<span>${data.wholBbsInqCnt}</span>
									</p>
								</div>
								<hr style="border: 2px double gray; width: 95%;">
							</div>
						</div>
						<div class="card-body p-3 row" style="margin-left: 15px;" >
							<div class="col-3">
								<p class="" style="font-weight: bold; font-size:1.2em;">
									게시글 작성자 :&nbsp;&nbsp;&nbsp; <span style="color: black;">${data.empTitle}</span>
								</p>
							</div>
							<div class="col-9">
								<p class="" style="font-weight: bold; font-size:1.2em;">
									게시글 등록일시 :&nbsp;&nbsp;&nbsp; <span> <fmt:formatDate
											value="${data.wholBbsRegYmd}" pattern="yyyy-MM-dd hh:MM:ss" /></span>
								</p>
							</div>
							<div style="width: 95%; margin-bottom: 10px; padding:20px; font-size:1.3em; border: 2px double gray;">
								<span style="color: black; font-size:1.3em;">${data.wholBbsCn}</span>
									<!-- 파일첨부..
									fileVOList : List<FilesVO>
									 -->
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

							<div class="col-sm-6" style="margin-top: 30px;">
								<div class="d-flex">
									<div class="d-flex align-items-center">
										<i class="ni ni-chat-round me-1 cursor-pointer" style="font-size:1.3em;"></i> <span
											class=" me-3" style="font-size:1.3em;">${cmntCnt}</span>
									</div>
									<div class="d-flex align-items-center">
										<!-- 좋아요 클릭 시 색 변경 -->
										<c:if test="${goodCnt == 1}">
											<i class="ni ni-like-2 me-1 cursor-pointer" id="goodImg" style="font-size:1.3em; color:orange"></i>
											<span class="me-3" id="good" style="font-size:1.3em;">${data.cntGood}</span>
										</c:if>
										<c:if test="${goodCnt == 0}">
											<i class="ni ni-like-2 me-1 cursor-pointer" id="goodImg" style="font-size:1.3em;"></i>
											<span class="me-3" id="good" style="font-size:1.3em;">${data.cntGood}</span>
										</c:if>
									</div>
								</div>
							</div>
							<hr style="border: 2px double gray; width: 95%;">
							<!-- 댓글 -->
							<div class="mb-1">
								 <c:choose>
						              <c:when test="${not empty data.boardCmntList}">
										<c:forEach var="cmntVO" items="${data.boardCmntList}" varStatus="stat">
											<div class="d-flex commentZone">
												<div class="flex-shrink-0">
													<c:choose>
														<c:when test="${not empty cmntVO.cmntProfile}">
										                 	<img alt="${cmntVO.cmntProfile}" class="avatar rounded-circle me-3" src="/resources/upload${cmntVO.cmntProfile}" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${cmntVO.empNo}">
														</c:when>
														<c:otherwise>
										                	<img src="/resources/upload/emp/profile/default.png" class="avatar rounded-circle me-3 img" alt="default.png" style="width: 50px; border-radius: 50px; object-fit:cover;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${cmntVO.empNo}">
														</c:otherwise>
								         	  		</c:choose>
<%-- 								         	  			<input type="hidden" name="cmntNo" value="${cmntVO.cmntNo}" /> --%>
<%-- 								         	  			<input type="hidden" name="empNo" value="${data.empNo}" /> --%>
												</div>

												<!-- 댓글 내용 부분 -->
												<div class="flex-grow-1 ms-3" style="margin-bottom: 10px;">
													<span class="updCmntCn" style="font-size:1.2em;">${cmntVO.cmntCn}</span><br/>
<%-- 														${cmntVO.empNo}&nbsp;&nbsp;&nbsp;&nbsp; --%>
													<span>${cmntVO.cmntRegYmd}</span>
													<!-- 수정/삭제 부분 시작 -->
<!-- 												 	<div class="col-4 commentUpdate" style="display:none;"> -->
<%-- 												 		<input type="hidden" name="cmntNo" value="${cmntVO.cmntNo}" /> --%>
<%-- 								         	  			<input type="hidden" name="empNo" value="${cmntVO.empNo}" /> --%>
								                    <button type='button' value="${cmntVO.cmntNo}" style='float:right; display: none; margin-top: -23px; margin-right: 700px;' class='btn-close text-dark deleteCmnt'>
														<span aria-hidden='true' class='delCBtn' style="font-size: 2.0em;">×</span>
													</button>
													<button type='button' value="${cmntVO.cmntNo}" style='float:right; display: none; margin-top: -13px; ' class='btn-close text-dark editCmnt'>
														<img src='/resources/image/editC.png' style='width:17px; margin-left:-15px; ' class='editCBtn'>
													</button>
<!-- 								                    </div>	 -->
													<!-- 수정/삭제 부분 끝 -->

													<!-- 댓글 수정 버튼 클릭시 보이는 부분 -->
													<textarea class='form-control tCmntModi' rows='4' style='display:none;'>${cmntVO.cmntCn}</textarea>
													<div class='modiCmnt' style='margin-top: 8px; display:none;'>
														<input type="hidden" name="cmntNo" value="${cmntVO.cmntNo}" />
														<button type='button' value='${cmntVO.cmntCn}' class='btn btn-info btn-sm btnMCmnt' >저장</button>
														<button type='button' class='btn btn-secondary btn-sm btnMCmntX'>취소</button>
													</div>
													<!-- 댓글 수정 버튼 클릭시 보이는 부분 -->
												</div>
											</div>
										</c:forEach>
									</c:when>
									 <c:otherwise>
						                	<div>등록된 댓글이 없습니다.</div>
						                </c:otherwise>
					                </c:choose>

								<div class="d-flex mt-2">
									<div class="flex-shrink-0">
									<!-- 로그인한 사원의 프로필 사진 -->
									<sec:authorize access="isAuthenticated()">
										<sec:authentication property="principal.empVO" var="empVO" />
									<c:choose>
										<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
						                 	<img src="/resources/upload${empVO.fileGrVO.filesList[0].fileStrgNm}" class="avatar rounded-circle me-3 img" alt="${empVO.fileGrVO.filesList[0].fileOrgnlNm}" style="width: 50px; border-radius: 50px; object-fit:cover; " data-bs-toggle="tooltip" data-bs-placement="bottom" title="${empVO.empNm} ${empVO.jbpsNm}">
										</c:when>
										<c:otherwise>
						                	<img src="/resources/upload/emp/profile/default.png" class="avatar rounded-circle me-3 img" alt="default.png" style="width: 50px; border-radius: 50px; object-fit:cover;" data-bs-toggle="tooltip" data-bs-placement="bottom" title="${empVO.empNm} ${empVO.jbpsNm}">
										</c:otherwise>
						            </c:choose>
									</sec:authorize>
									</div>
									<div class="flex-grow-1 my-auto">

											<div class="row">
												<div class="col-9">
													<textarea class="form-control"
														placeholder="댓글을 입력해주세요" rows="1" id="cmntText" style="font-size: 1.2em;"></textarea>
												</div>
												<div class="col-3">
<!-- 													<img alt="" src="/resources/image/folder.gif" -->
<!-- 														style="width: 30px; margin-bottom: 10px;">&nbsp;&nbsp;&nbsp; -->
													<button type="button" class="btn btn-warning btn-sm"
														style="margin-top: 7px;" id="cmntCreate">댓글등록</button>
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
</div>


<script>

function commentMouseEvent() {
	// 댓글 수정/삭제모드
	$(document).on("mouseover",".commentZone",function(){
		$(this).find(".editCmnt").css("display","block");
		$(this).find(".deleteCmnt").css("display","block");
	});
}
commentMouseEvent();

$(document).on("mouseout",".commentZone",function(){
	$(this).find(".editCmnt").css("display","none");
	$(this).find(".deleteCmnt").css("display","none");
});
</script>