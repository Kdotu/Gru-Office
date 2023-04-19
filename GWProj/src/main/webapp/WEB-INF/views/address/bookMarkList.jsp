<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery-3.6.3.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<!-- 전사게시판 목록 -->
<!-- body_left -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->

<style>
.form-control{
font-size:1.1em;
}
</style>


<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/addressAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4 mb-4">
		<h3>즐겨찾기 주소록</h3>
			<div class="card mt-3">
				<div class="table-responsive">
					<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						<form action="/address/list" name="frm" id="frm" method="get">
							<div class="row my-5 mb-3" style="margin: 20px;">
								<div class="col-6">
									<button type="button" id="send" class="btn btn-outline-dark" style="font-size:1.0em;">메일발송</button>
									<button type="button" id="delete" class="btn btn-outline-dark" style="font-size:1.0em;">삭제</button>
								</div>
								<div class="col-2" align="right">
									<select class="form-control" name="searchType" id="searchType" placeholder="Departure" style="font-size:1.0em;">
									  <option value="" disabled selected>검색조건 선택&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;▼</option>
									  <option value="addrNm" ${searchType=='addrNm' ? 'selected' : '' }>이름</option>
									  <option value="addrRank" ${searchType=='addrRank' ? 'selected' : '' }>직위</option>
									  <option value="addrCoNm" ${searchType=='addrCoNm' ? 'selected' : '' }>회사명</option>
									</select>
								</div>

								<div class="col-4" align="right">
										<div class="row">
											<div class="col-8 form-group my-auto" align="right" >
										        <div class="input-group">
										          <span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
										          <input class="form-control" placeholder="Search" type="text" name="keyword" value="${param.keyword}">
										        </div>
										      </div>
											<div class="col-4 my-auto" align="left" >
												<button type="submit" class="btn ctn-primary my-0" style="font-size:1.0em;">검색</button>
											</div>
										</div>
								</div>
								</div>
							</form>
						</div>
						<div class="ct-example"
							style="position: relative; border: 2px solid #f5f7ff !important; border-bottom: none !important; padding: 1rem 1rem 2rem 1rem; margin-bottom: -1.25rem;">
							<form action="/address/createPost" method="post">
								<div class="row">
									<div class="col-md-2">
										<div class="form-group"
											style="text-align: center; background: lightgray; border-radius: 10px; height: 42px;">
											<h5 style="color: white; padding-top: 7px;">빠른 등록</h5>
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<input type="text" class="form-control" name="addrNm"
												id="exampleFormControlInput1" placeholder="이름" required
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<input type="email" placeholder="이메일" class="form-control"	name="emlAddr"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-3">
										<div class="form-group">
											<input type="text" placeholder="휴대폰 번호" class="form-control" name="addrHp"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-1">
										<div class="form-group">
											<button type="submit"
												style="border: 1px solid #5C67F5; color:#5C67F5; font-weight:bold; height:40px;  border-radius: 10px; background: none; ">+ 추가</button>
											<input type="hidden" placeholder="휴대폰 번호" class="form-control" name="addrCoNm" onfocus="focused(this)" onfocusout="defocused(this)">
											<input type="hidden" placeholder="휴대폰 번호" class="form-control" name="addrCo" onfocus="focused(this)" onfocusout="defocused(this)">
											<input type="hidden" placeholder="휴대폰 번호" class="form-control" name="addrRank" onfocus="focused(this)" onfocusout="defocused(this)">
											<input type="hidden" placeholder="휴대폰 번호" class="form-control" name="addrDept" onfocus="focused(this)" onfocusout="defocused(this)">
											<input type="hidden" placeholder="휴대폰 번호" class="form-control" name="addrCoTelno" onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>

								</div>
								<sec:csrfInput />
							</form>
						</div>
						<div class="dataTable-container mx-4">
							<table class="table table-flush dataTable-table"
								id="datatable-search">
								<thead>
									<tr >
										<th class="text-secondary opacity-7" style="font-size: 1.3em;"></th>
										<th class="text-secondary opacity-7" style="font-size: 1.3em;">이름</th>
										<th class="text-secondary opacity-7" style="font-size: 1.3em;">직위</th>
										<th class="text-secondary opacity-7" style="font-size: 1.3em;">휴대폰</th>
										<th class="text-secondary opacity-7" style="font-size: 1.3em;">이메일</th>
										<th class="text-secondary opacity-7" style="font-size: 1.3em;">부서</th>
										<th class="text-secondary opacity-7" style="font-size: 1.3em;">회사</th>
									</tr>
								</thead>
								<tbody>
									<!-- data : ArticlePage
										data.content : List<AddrVO> addrList
									-->
									<c:forEach var="addrVO" items="${data.content}" varStatus="stat">
									<tr>
										<td style="font-size: 1.1em;">
											<div class="d-flex align-items-center">
												<div class="form-check">
													<input class="form-check-input addrNo" type="checkbox"
														data-addr-no="${addrVO.addrNo}"
														id="customCheck1" name="addrNo" value="${addrVO.addrNo}">
												</div>
												<p class="text-xs font-weight-bold ms-2 mb-0"></p>
											</div>
										</td>
										<td class="font-weight-bold">
											<span class="my-2 text-lg">
												<a href="/address/detail?addrNo=${addrVO.addrNo}">${addrVO.addrNm}</a>
											</span>
										</td>
										<td class="text-lg font-weight-bold">
											<div class="d-flex align-items-center">
												<c:if test="${addrVO.addrRank ne null}">
													<span>${addrVO.addrRank}</span>
												</c:if>
												<c:if test="${addrVO.addrRank eq null}">
													<span>&nbsp;&nbsp;&nbsp;-</span>
												</c:if>
											</div>
										</td>
										<td class="text-lg font-weight-bold">
											<div class="d-flex align-items-center">
												<span>${addrVO.addrHp}</span>
											</div>
										</td>
										<td class="text-lg font-weight-bold">
											<div class="d-flex align-items-center">
												<span>${addrVO.emlAddr}</span>
											</div>
										</td>
										<td class="text-lg font-weight-bold">
											<div class="d-flex align-items-center">
												<c:if test="${addrVO.addrDept ne null}">
													<span>${addrVO.addrDept}</span>
												</c:if>
												<c:if test="${addrVO.addrDept eq null}">
													<span>&nbsp;&nbsp;&nbsp;-</span>
												</c:if>		
											</div>
										</td>
										<td class="text-lg font-weight-bold">
											<div class="d-flex align-items-center">
												<c:if test="${addrVO.addrCoNm ne null}">
													<span>${addrVO.addrCoNm}</span>
												</c:if>
												<c:if test="${addrVO.addrCoNm eq null}">
													<span>&nbsp;&nbsp;&nbsp;-</span>
												</c:if>		
											</div>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
						<!-- 페이징 시작 -->
<!-- 						<div class="dataTable-bottom col-sm-12 col-md-7"> -->
<!-- 							<div class="dataTables_paginate paging_simple_numbers" -->
<!-- 								id="dataTable_paginate"> -->
<!-- 								<ul class="pagination"> -->
<%-- 									<li class="paginate_button page-item previous --%>
<%-- 										<c:if test='${data.startPage lt 6}'> disabled</c:if> --%>
<%-- 										" id="dataTable_previous"> --%>
<!-- 										keyword=22 : 파라미터(param) -->
<%-- 										 <a href="/address/list?currentPage=${data.startPage-5}&keyword=${param.keyword}&searchType=${param.searchType}" --%>
<!-- 										aria-controls="dataTable" data-dt-idx="0" tabindex="0" -->
<!-- 										class="page-link">‹</a></li> -->

<%-- 									<c:forEach var="pNo" begin="${data.startPage}" end="${data.endPage}"> --%>
<%-- 									<li class="paginate_button page-item --%>
<%-- 											<c:if test='${param.currentPage==pNo}'>active</c:if> --%>
<%-- 											"> --%>
<%-- 									<a href="/address/list?currentPage=${pNo}&keyword=${param.keyword}&searchType=${param.searchType}" --%>
<!-- 										aria-controls="dataTable" data-dt-idx="1" tabindex="0" -->
<%-- 										class="page-link">${pNo}</a></li> --%>
<%-- 									</c:forEach> --%>

<%-- 									<li class="paginate_button page-item next --%>
<%-- 										<c:if test='${data.endPage ge data.totalPages}'>disabled</c:if> --%>
<%-- 									" id="dataTable_next"><a --%>
<%-- 										href="/address/list?currentPage=${data.startPage+5}&keyword=${param.keyword}&searchType=${param.searchType}" --%>
<!-- 										aria-controls="dataTable" data-dt-idx="7" tabindex="0" -->
<!-- 										class="page-link">›</a></li> -->
<!-- 								</ul> -->
<!-- 							</div> -->
<!-- 						</div> -->
						<!-- 페이징 끝 -->
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-8"></div>
		</div>
	</div>

<script type="text/javascript" defer="defer">
$(function(){

// 	console.log("개똥이");
	$("create-btn").on("click",function(){
			location.href("/WEB-INF/views/address/create.jsp");
	});

	$("#delete").on("click",function(){
// 		console.log("왔다");

		let addrNoArray = [];

		//input type="checkbox" name="addrNo" 이것들을 모드 선택하는데 그 중에서 checked된 것들만 선택
		//index,data는 의미는 없음..
		$("input:checkbox[name='addrNo']:checked").each(function(index,data){
			//data-addr-no="11"
			let addrNo = $(this).data("addrNo");	//11
			console.log("addrNo : " + addrNo);
			//push로 배열에 값을 넣음
			addrNoArray.push(addrNo);
		});

		//json object
		let data = {"addrNoArray" : addrNoArray};

		console.log("delete data : ", data);
		console.log("delete data : ", JSON.stringify(data));

		//아작났어유..피씨다타써
		//contentType : 보내는 타입
		//dataType : 응답 타입
		$.ajax({
			url:"/address/bookmarkDel",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
			success:function(result){
				//return result;
				//result : 1
				console.log("result : ", result);
				
				if(result>0){
					swal({
						title : "즐겨찾는 주소록에서 삭제 되었습니다.",
						icon : "success", //success, warning, error
						button : "확인",
					}).then(function () {
						location.href="/address/bookMarkList";
				    });
				}
				
				
				
				
				
				
				

// 				if(result>0){//성공
// 					location.href="/address/bookMarkList";
// 					refresh();
// 				}else{//삭제 실패
// 					alert("삭제가 실패했습니다.");
// 				}
			}
		});
	});
	$("#send").on("click", function(){
		window.open("/address/addrMail", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=200, left=200, width=700, height=700");
	});

});
</script>


















