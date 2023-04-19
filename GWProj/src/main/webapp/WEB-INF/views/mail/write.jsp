<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<style>
label{
font-size: 1.2em;
width : 130px;

}

.form-check{
margin-left: 20px;
}

#file{
margin-left:-60px;
font-size:1.2em;
}

.form-check-label{
font-size: 1.1em;

}

input{
font-size : 1.1em;
}

.form-control{
font-size: 1.2em;
}

.cke_editable{
margin-left : 30px;
}

#modal-title-default{
font-size : 1.2em;
}

#srh{
font-size : 1.0em;
width : 100px;
}

.col-7 form-group{
margin-left : -20px;
}

.modal-content{
width : 1000px;
}
</style>


<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>
<script type="text/javascript">


$(function(){
	$("#srh").on("click",function(){
		var searchType =  $("#searchType").val();
		var keyword = $("#keyword").val();

		//json객체
		let data = {
			"searchType" : searchType,
			"keyword":keyword
		};
		console.log("data : " + JSON.stringify(data));

		$.ajax({
			url:"/mail/addrAjax?searchType=" + searchType + "&keyword=" + keyword,
			contentType:"application/json,charset:utf-8",
			type:"get",
			dataType:"JSON",
			success:function(result){
				let str = "";
				console.log(result);
				$.each(result,function(index,addrVO){
					str+=" 	<tr>																				";
					str+=" 	<td style='font-size: 1.1em;'>														";
					str+=" 		<div class='d-flex align-items-center'>											";
					str+=" 			<div class='form-check'>													";
					str+=" 				<input class='form-check-input addrNo' type='checkbox'  				";
					str+=" 					data-addr-no='"+addrVO.addrNo+"'										";
					str+=" 					id='customCheck1' name='addrNo' value='"+addrVO.addrNo+"'>			";
					str+=" 			</div>																		";
					str+=" 			<p class='text-xs font-weight-bold ms-2 mb-0'></p>							";
					str+=" 		</div>																			";
					str+=" 	</td>																				";
					str+=" 	<td class='font-weight-bold'>														";
					str+=" 		<span class='my-2 text-sm'>														";
					str+=" 			<a href='/address/detail?addrNo="+addrVO.addrNo+"'>" + addrVO.addrNm+"</a>		";
					str+=" 		</span>																			";
					str+=" 	</td>																				";
					str+=" 	<td class='text-sm font-weight-bold'>												";
					str+=" 		<div class='d-flex align-items-center'>											";
					str+=" 			<span>"+addrVO.addrRank+"</span>												";
					str+=" 		</div>																			";
					str+=" 	</td>																				";
					str+=" 	<td class='text-sm font-weight-bold'>												";
					str+=" 		<div class='d-flex align-items-center'>											";
					str+=" 			<span>" + addrVO.emlAddr + "</span>												";
					str+=" 		</div>																			";
					str+=" 	</td>																				";
					str+=" 	<td class='text-sm font-weight-bold'>												";
					str+=" 		<div class='d-flex align-items-center'>											";
					str+=" 			<span>"+addrVO.addrDept+"</span>												";
					str+=" 		</div>																			";
					str+=" 	</td>																				";
					str+=" </tr>																				";
				});
				console.log("str : " + str);
				$("#trAdd").html(str);
			},
// 			error: function(xhr){
// 				alert(xhr.status);
// 			}
		});
	});

	$(function(){
		//선택버튼 누르면 이벤트 발생
		$("#sel").on("click",function(){
// 			console.log("click..");
			let addrNoArray = [];
			//체크된 박스들 반복문 돌려서 배열에 넣기
			$("input:checkbox[name='addrNo']:checked").each(function(i,d){
				let addrNo = $(this).data("addrNo");
				console.log("addrNo : " + addrNo);
				addrNoArray.push(addrNo);
			});
			//json객체에 담기
			let data = {"addrNoArray":addrNoArray};

				console.log("data : " + JSON.stringify(data));
				//비동기 처리
				$.ajax({
					url:"/mail/checkAddr",
					type:"post",
					contentType:"application/json;charset:utf-8",
					data:JSON.stringify(data),
					dataType:"json",
					beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		            },
					success:function(result){
						console.log("result : " + JSON.stringify(result));

							$("#inputEmail3").val(result);

							$('#modal-default').modal('hide');
					}

			});
		});
	});
	//나에게 보내기 체크한 경우 이벤트
 	$("#gridCheck1").on("change",function(){
 		if($("input:checkbox[name='gridCheck1']:checked").val()){
//			console.log($("input:checkbox[name='gridCheck1']:checked").val());
			$.ajax({
				url:"/mail/myEmail",
				type:"post",
				contentType:"application/json;charset:utf-8",
				dataType: "text",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	            },
				success:function(result){
					console.log("result : " + result);
					$("#inputEmail3").val(result);
				}
			});
 		}else{
 			console.log();
 			$("#inputEmail3").val("");
 		}
	});
 	
	//uri의 파람값 가져오기
	$(function(){
		const urlParams = new URL(location.href).searchParams;
		const empNo = urlParams.get('empNo');
		
		console.log("empNo 이거 : " ,empNo);
		
		var data = {'empNo' : empNo};
		
		$.ajax({
			url:"/mail/write",
			type:"get",
			contentType : 'application/json; charset=UTF-8',			
			dataType:"json",
			data : JSON.stringify(data),
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log("result: " , result)
// 				$(#inputEmail3)
			}
		});
	});
	
	let emlAddr = $("#inputEmail3").val();
	$("input[name='gridCheck1']").innerText

});
</script>



<style>
.lb{
	width: 100px;
}
</style>
<!-- 현재로그인된 사원의 정보를 가져옴. -->
<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
<!-- 메일쓰기 -->
<!-- body_left -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/mailAside.jsp" />
		</div>
		<div class="col-lg-9">
<!-- 2번째 사이드바 -->

			<!-- body_center -->
			<form action="/mail/writePost?${_csrf.parameterName}=${_csrf.token}&code=close" 
					enctype="multipart/form-data" method="post" name="writeMail">
				<div class="card">
					<div class="table-responsive">
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<div class="" style="float: left">
									<button type="submit" id="sendBtn" style="width: 120px; font-size: 1.0em;"  class="btn btn-outline-dark btn-sm">보내기</button>
<!-- 									<a href="/mail/temp" style="width: 125px;" class="btn btn-outline-dark btn-sm">임시저장</a> -->
									<!-- <button type="button" style="width: 125px;" class="btn btn-success btn-sm">임시저장</button> -->
								</div>
							</div>
							<div class="dataTable-top" >
									<!-- 받는 사람 시작 -->
								  <div class="form-group row" style="float:inherit;" >
									  <div class="col-1">
										    <label  for="inputEmail3">받는사람</label>
									  </div>

								      <div class="form-check col-1" >
								        	<input class="form-check-input" type="checkbox" id="gridCheck1" name="gridCheck1" value="true">
									        <label class="form-check-label" for="gridCheck1">
									        	  나에게
									        </label>
								      </div>
								      <div class="col-8" >
								     		 <!-- 바꿈. name="emailRcvrVOList[0].emlRcvrAddr"  -->
								        	<input type="text" class="form-control" 
								        		name="emailRcvrVOList[0].emlRcvrAddr" 	value="${emlAddr}"							        		
								        		id="inputEmail3" placeholder="Email"  />
								      </div>
								      <div class="col" >							<!-- 오토자리에 px로 너비 조정 -->
								        	<input class="btn btn-outline-info" style="width: 100px; font-size:0.9em; margin-top:-5px;"  type="button" value="주소록" data-bs-toggle="modal" data-bs-target="#modal-default"/>
								      </div>
								  </div>
									<!-- 받는 사람 끝 -->



<!-- 									참조시작 -->
<!-- 								  <div class="form-group row"> -->

<!-- 									  <div class="col-2"> -->
<!-- 									    <label  for="inputReperences3" >참조</label>					     -->
<!-- 									  </div> -->

<!-- 									  <div class="col-8"> -->
<!-- 									      <input type="text" name="emlRfrncNo" class="form-control col" id="inputReperences3" placeholder="Reperences" /> -->
<!-- 									  </div> -->

<!-- 									  <div class="col" >							오토자리에 px로 너비 조정 -->
<!-- 									        	<input class="btn btn-outline-info" style="width: auto;"  type="button" value="주소록" data-bs-toggle="modal" data-bs-target="#modal-default"/> -->
<!-- 								      </div> -->
<!-- 								  </div> -->
<!-- 									참조 끝 -->


									<!-- 제목 시작 -->
								  <div class="form-group row" style="float:inherit;">
								<div class="col-1">
										    <label for="inputtitle3" >제목</label>
										  </div>

										  <div class="form-check col-1" >
								        	<input class="form-check-input" name="emlImporYn" type="checkbox" id="gridCheck2" value="중요">
									        <label class="form-check-label" for="gridCheck2">중요
									        	 <img alt="" src="/resources/image/star.png" style="width: 15px;">
									        </label>
								      </div>
							        	<div class="col-8">
							        		<input type="text" name="emlTtl" class="form-control" id="inputtitle3" placeholder="Title" style="width:100%;" />
							        	</div>
								   </div>
									<!-- 제목 끝 -->


								  </div>

								  <div class="dataTable-top">
								    <label for="inputfile3" style="font-size:1.3em;" class="col-sm-2 col-form-label lb">파일첨부</label>
								    <div class="col-sm-10">
									    <input name="uploadFile" type="file" id="file" name="file" multiple />
								    </div>
								  </div>

							</div>
						</div>
						<!-- ckeditor -->
						<div class="form-group row cke_editable" >
							<label class="col-sm-2"></label>
							<div style="width:90%;">
							<!-- 세로 : cols, 가로 : rows -->
								<textarea class="form-control" cols="70" rows="2" id="description" name="emlCn"></textarea>
							</div>
						</div>
					</div>
				</form>
			</div>


		</div>
	</div>
<!-- </div>	 없음 -->

<!-- 주소록 모달 -->
<div class="modal fade" id="modal-default" tabindex="-1" role="dialog" aria-labelledby="modal-default" aria-hidden="true">
      <div class="modal-dialog modal- modal-dialog-centered modal-" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h6 class="modal-title" id="modal-title-default">주소록</h6>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body" style="height: 500px; overflow: auto">
            <!-- 검색창 -->
            <form action="/mail/write" name="frm" id="frm" method="get">
			<div class="row" style="margin: 20px;">
	            <div class="row" style="margin: 20px;">
				<div class="col-5" >
					<select style="padding-left: 20px; font-size: 1.0em;" class="form-control" name="searchType" id="searchType" placeholder="Departure">
					  <option value="" disabled selected>검색조건 선택&nbsp;&nbsp;▼</option>
					  <option value="addrNm" ${searchType=='addrNm' ? 'selected' : '' }>이름</option>
					  <option value="addrRank" ${searchType=='addrRank' ? 'selected' : '' }>직위</option>
					</select>
				</div>
				<div class="col-7" align="right">
						<div class="row">
							<div class="col-7 form-group" align="right" >
						        <div class="input-group mb-4">
						          <span class="input-group-text"><i class="ni ni-zoom-split-in"></i></span>
						          <input class="form-control" placeholder="Search" type="text" name="keyword" id="keyword" value="${param.keyword}">
						        </div>
						      </div>
							<div class="col-5" align="left" >
								<button type="button" class="btn btn-sm bg-gradient-secondary mb-0" id="srh">검색</button>
							</div>
						</div>
				</div>
				</div>
			</div>
			</form>
            <!-- 주소록 list -->
            <div class="ct-example" style="position: relative; border: 2px solid #f5f7ff !important; border-bottom: none !important; padding: 1rem 1rem 2rem 1rem; margin-bottom: -1.25rem;">

			</div>
				<div class="dataTable-container" style="font-size: 1.1em;">
					<table class="table table-flush dataTable-table"
						id="datatable-search">
						<thead>
							<tr >
								<th class="text-secondary" style="font-size: 1.3em;"></th>
								<th class="text-secondary" style="font-size: 1.3em;">이름</th>
								<th class="text-secondary" style="font-size: 1.3em;">직위</th>
								<th class="text-secondary" style="font-size: 1.3em;">이메일</th>
								<th class="text-secondary" style="font-size: 1.3em;">부서</th>
							</tr>
						</thead>
						<tbody id="trAdd">
							<!-- data : ArticlePage
								data.content : List<AddrVO> addrList
							-->
							<c:forEach var="addrVO" items="${data}" varStatus="stat">
							<tr>
								<td style="font-size: 1.1em;">
									<div class="d-flex align-items-center">
										<div class="form-check">
											<input class="form-check-input addrNo" type="checkbox"
												data-addr-no="${addrVO.addrNo}"
												id="customCheck1" name="addrNo" value="${addrVO.addrNo}">
										</div>
										<p class="font-weight-bold ms-2 mb-0"></p>
									</div>
								</td>
								<td class="font-weight-bold">
									<span class="my-2" style="font-size: 1.1em;">
										<a href="/address/detail?addrNo=${addrVO.addrNo}">${addrVO.addrNm}</a>
									</span>
								</td>
								<td class="font-weight-bold">
									<div class="d-flex align-items-center" >
										<span style="font-size: 1.1em;">${addrVO.addrRank}</span>
									</div>
								</td>
								<td class="font-weight-bold">
									<div class="d-flex align-items-center">
										<span style="font-size: 1.1em;">${addrVO.emlAddr}</span>
									</div>
								</td>
								<td class="font-weight-bold">
									<div class="d-flex align-items-center">
										<span style="font-size: 1.1em;">${addrVO.addrDept}</span>
									</div>
								</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>

          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-info h6" id="sel">선택</button>
            <button type="button" class="btn bg-gradient-secondary h6" data-bs-dismiss="modal">취소</button>
          </div>
        </div>
      </div>
    </div>
</sec:authorize>



<script type="text/javascript">
CKEDITOR.replace('description');

CKEDITOR.resize("300px", "500px");
</script>

