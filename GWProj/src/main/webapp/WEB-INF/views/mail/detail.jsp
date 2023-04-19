<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
.text-sm{
font-size : 1.5em;
}
</style>



<script type="text/javascript">
$(function(){
// 	function refresh(){
// 		   location.reload();
// 		}	
	$("#delEml").on("click",function(){
		let emlNo = $(this).data("emlNo");
		console.log("왔어?:",emlNo);
		let data={"emlNo" : emlNo};
		
		$.ajax({
			url:"/mail/delEml",
		    contentType : 'application/json; charset=UTF-8',
			type:"post",
			dataType:"json",
			data : JSON.stringify(data),
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log("왔어?:",result);
				if(result>0){
					swal({
						title : "삭제 되었습니다.",
						icon : "success", //success, warning, error
						button : "확인",
					}).then(function () {
						location.href="/mail/recieveList";
				    });
				}
			}
		});
	});
});
</script>


<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/mailAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
			<!-- 2번째 사이드바 -->
			<div class="row">
				<div class="col">
					<div class="card-body pt-2">
						<a href="javascript:;" class="card-title h5 d-block text-darker">
							받은메일함</a>
						<!-- 전체메일/안읽은메일 불러오기..? -->

						<div class="card">

							<!-- 모달창으로 해야함 (태그) ?-->
							<div style="margin: 10px;">
<!-- 								<button type="button" class="btn btn-outline-dark btn-sm">태그</button> -->
								<a href="/mail/sendImp?emlNo=${param.emlNo}" class="btn btn-outline-dark btn-sm" style="font-size:1.0em;">중요메일함 이동</a>
<!-- 								<button type="button" class="btn btn-outline-dark btn-sm">이동</button> -->
								<button type="button" class="btn btn-outline-danger btn-sm" id="delEml" data-eml-no="${data.emlNo}" style="font-size:1.0em;">삭제</button>
								<a href="/mail/recieveList" class="btn btn-secondary btn-sm" style="font-size:1.0em;">목록</a>								
<!-- 								<button type="button" class="btn btn-secondary btn-sm">목록</button> -->
							</div>
							<div class="col-12">
								<div class="card h-100">
									<div class="card-body p-3 row" style="margin-left: 15px;">
										<div class="row">
											<div class="col-md-1 d-flex align-items-center">
												<h4>제목</h4>
											</div>
											<div class="col-md-10 d-flex align-items-start" align="left">
												<p style="font-size:1.4em;">${data.emlTtl}</p>
											</div>
										</div>
										<div class="col-1" align="right">
											<p class="" style="font-weight: bold; font-size:1.2em; margin-left:-15px;">보낸 사람 :</p>
											<p class="" style="font-weight: bold; font-size:1.2em; margin-left:-15px;">보낸 날짜 :</p>
										</div>
										<div class="col-11">
											<p class="" style="font-size:1.2em;">${data.emlSndrNo}</p>
											<p class="" style="font-size:1.2em;"><fmt:formatDate value="${data.emlTrsmDt}" pattern="yyyy-MM-dd HH:mm" /></p>
										</div>
										<hr style="border: 2px double gray; width: 95%;">

										<div class="dataTable-top">
											<div class="row">
												<div class="col-md-12 d-flex align-items-center">
													<h5>첨부파일</h5>
												</div>
											</div>
											<div class="col-sm-10" style="font-size:1.2em;">
												<c:if test="${not empty fileVOList}">
								             		<c:forEach var="fileVO" items="${fileVOList}" varStatus="stat">
								              			<c:if test="${fileVO.fileOrgnlNm != null}">
									             			<a href="/resources/upload${fileVO.fileStrgNm}" download>${fileVO.fileOrgnlNm}</a><br/>
								                		</c:if>
								              		</c:forEach>
							              		</c:if>
											
												<!-- 							    <input type="button" name="file" id="file" value="파일선택" > -->
												<!-- 							     <input type="file" class="form-control" id="inputfile3" placeholder="여기에 첨부파일을 끌어오세요. 또는 파일선택"> -->
<!-- 												<form action="/file-upload" class="form-control dropzone" -->
<!-- 													id="dropzone" /> -->
<!-- 												<div class="fallback"> -->
<!-- 													<input name="file" type="file" id="file" multiple /> -->
<!-- 												</div> -->
<!-- 												</form> -->
											</div>
										</div>



									<div class="row">
										<div class="col-md-1 d-flex align-items-center">
											<h5>내용</h5>
										</div>
										<div class="col-md-10 d-flex align-items-center" style="width: 95%; margin-bottom: 10px;
													 padding:20px; font-size:1.3em; border: 2px double gray;">
											<span>${data.emlCn}</span>											
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
</div>
