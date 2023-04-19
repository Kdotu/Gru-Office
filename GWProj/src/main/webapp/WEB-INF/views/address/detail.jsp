<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
.form-control{
font-size:1.2em;
}

.form-label{
font-size:1.2em;
}
</style>

<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<!-- <script src="/resources/js/jquery-3.6.3.min.js"></script> -->
<script type="text/javascript">

$(function(){
	//다음 우편번호 검색
	$("#btnPostno").on("click",function(){		
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete:function(data){
				//우편번호 ,주소, 상세주소
				$("#postno").val(data.zonecode);	// postNo가 아니라 postno로 되어 있음(id가)
				$("#cusAddr").val(data.address);
				$("#addrDet").val(data.buildingName);
			}
		}).open();
	});
});
</script>

<script type="text/javascript">
	$(function(){
		//수정 버튼 클릭 -> spn1:none / spn2:block
		$("#edit").on("click",function(){
			$("#spn1").css("display","none");
			$("#spn2").css("display","block");
			//읽기전용 해제
			$(".form-control").removeAttr("readOnly");
		});
		//취소 버튼 클릭 -> spn1:block / spn2:none
		$("#cancel").on("click",function(){
			$("#spn1").css("display","block");
			$("#spn2").css("display","none");
			//읽기전용
			$(".form-control").attr("readOnly",true);
		});

		//삭제버튼 클릭
		$("#del").on("click", function(){
			//form의 action속성의 속성값을 /address/deletePost로 변경
			$("#frm").attr("action","/address/deletePost");

			//삭제여부 재확인
			//true(1) / false(0)
			let result = confirm("삭제하시겠습니까?");
			//submit
			if(result){//삭제실행
				$("#frm").submit();
			}else{//삭제안함
				alert("삭제가 취소되었습니다.");
			}
		});
		
		$("#ok").on("click",function(){
			$("#frm").attr("action", "/address/updatePost");
			$("#frm").submit();
		});
	});
</script>

<!-- 전사게시판 목록 -->
<!-- body_left -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/addressAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->
	<h3>주소록 상세보기</h3>
			<div class="card h-100">
				<div class="table-responsive h-100 mx-auto">
					<div
						class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						<div class="dataTable-top">
						</div>
						<div class="ct-example"
							style="position: relative; border: 2px solid #f5f7ff !important; padding: 1rem 1rem 1rem 1rem; margin-bottom: -1.25rem;">
							<form action="/address/createPost" id="frm"  method="post">
								<input type="hidden" name="addrNo" value="${data.addrNo}">
								<input type="hidden" name="mode" id="mode" value="update" />
								<div class="row">
									<div class="col-md-2">
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="이름" class="form-control"
												disabled="" onfocus="focused(this)" required
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" value="${data.addrNm}" name="addrNm"
												id="exampleFormControlInput1" placeholder="이름을 입력해주세요" readonly
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="회사" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" value="${data.addrCoNm}" name="addrCoNm"
												id="exampleFormControlInput1" placeholder="회사를 입력해주세요" readonly
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="부서" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" value="${data.addrDept}" name="addrDept"
												id="exampleFormControlInput1" placeholder="부서를 입력해주세요" readonly
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="직위" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" value="${data.addrRank}" name="addrRank"
												id="exampleFormControlInput1" placeholder="직위를 입력해주세요" readonly
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="이메일" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="email" class="form-control" value="${data.emlAddr}" readonly
												id="exampleFormControlInput1" placeholder="name@example.com" name="emlAddr"
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="휴대폰" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" value="${data.addrHp}" name="addrHp"
												id="exampleFormControlInput1" placeholder="010-0000-0000" readonly
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="회사전화" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									<div class="col-md-7">
										<div class="form-group">
											<input type="text" class="form-control" value="${data.addrCoTelno}" name="addrCoTelno"
												id="exampleFormControlInput1" placeholder="042-000-0000" readonly
												onfocus="focused(this)" onfocusout="defocused(this)">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-2">
										<div class="form-group">
											<input type="text" placeholder="회사주소" class="form-control"
												disabled="" onfocus="focused(this)"
												onfocusout="defocused(this)">
										</div>
									</div>
									
									
									<div class="col-md-9">
										<div class="row">
											<div class="col-12">
												<label for="postno" class="form-label">우편번호</label><br/> 
												<input type="text" class="form-control" value="${data.postno}" readonly
													id="postno" name="postno" placeholder="우편번호를 입력해주세요"
													style="width: 50% ; height:45%; float: left;" />
												<input class="btn btn-info" type="button" value="우편번호 검색" readonly
													style="width: 15%;float: left; text-align: center; padding-left : 20px; margin-left:10px; font-size:1.0em;" id="btnPostno" onclick="openHomeSearch()"/>
											</div>
											<div class="col-12">
												<label for="cusAddr" class="form-label">주소</label><br/> 
												<input type="text" class="form-control" style="width: 50%; float: left;" value="${data.cusAddr}" readonly
													id="cusAddr" name="cusAddr" placeholder="주소를 입력해주세요" />
											</div>
											<br/>
											<div class="col-12" style="margin-top: 20px;">
												<label for="addrDet" class="form-label">상세 주소</label><br/>  
												<input type="text" class="form-control" style="width: 50%; float: left;" value="${data.addrDet}" readonly
													id="addrDet" name="addrDet" placeholder="상세 주소를 입력해주세요" />
											</div>
										</div>
									</div>
									
<!-- 									<div> -->
<!-- 										<label for="postno" class="form-label">우편번호</label>  -->
<!-- 									</div> -->
<%-- 										<input type="text" class="form-control" name="postno" value="${data.postno}" readonly --%>
<!-- 											id="postno" name="postno" placeholder="우편번호를 입력해주세요" -->
<!-- 											style="width: 80%;float:left;" /> -->
<!-- 										<input class="btn btn-info" type="button" value="우편번호 검색" -->
<!-- 											style="width: 20%;float: right;" id="btnPostno" onclick="openHomeSearch()"/> -->
<!-- 									</div> -->
<!-- 									<div class="mb-3">	 -->
<!-- 										<label for="cusAddr" class="form-label">주소</label>  -->
<%-- 										<input type="text" class="form-control" name="cusAddr" value="${data.cusAddr}" readonly --%>
<!-- 											id="cusAddr" name="cusAddr" placeholder="주소를 입력해주세요" /> -->
<!-- 									</div> -->
<!-- 									<div class="mb-3"> -->
<!-- 										<label for="addrDet" class="form-label">상세 주소</label>  -->
<%-- 										<input type="text" class="form-control" name="addrDet" value="${data.addrDet}" readonly --%>
<!-- 											id="addrDet" name="addrDet" placeholder="상세 주소를 입력해주세요" -->
<!-- 											 /> -->
							
									
									
									
									<div style="text-align: right;" class="my-2">
										<!-- 일반모드 시작 -->
										<span id="spn1">
											<button type="button" id="edit" class="btn btn-info" style="font-size:1.0em;">수정</button>
											<button type="button" id="del" class="btn btn-dark" style="font-size:1.0em;">삭제</button>
											<a href="/address/list" class="btn btn-secondary" style="font-size:1.0em;">목록</a>
										</span>
										<!-- 수정모드 시작 -->
										<span id="spn2" style="display: none;">
											<button type="button" id="ok" class="btn btn-info" style="font-size:1.0em;">확인</button>
											<button type="button" id="cancle" class="btn btn-outline-dark" style="font-size:1.0em;">취소</button>
											<a href="/address/list" class="btn btn-secondary" style="font-size:1.0em;">목록</a>
										</span>
									</div>
								</div>
								<sec:csrfInput />
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-8"></div>
		</div>
	</div>
</div>
