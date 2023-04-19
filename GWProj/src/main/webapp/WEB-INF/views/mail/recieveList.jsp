<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- jQuery -->
<!-- <script src="/resources/js/jquery-3.6.0.js"></script> -->
<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>
<script src="/resources/maincss/assets/js/plugins/datatables.js"></script>

<script src="/resources/js/sweetalert.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
th{
font-size:1.3em;
}
</style>



<script type="text/javascript">
	$(function(){
		$.ajax({
			url:"/mail/totalCnt",
			type:"get",
			success:function(result){
				console.log("totalCnt result :" , result);
				$("#totalCnt").text(result);
			}
		});


	});
</script>

<script type="text/javascript">
function refresh(){
   location.reload();
}
$(function(){

	$.ajax({
		url:"/mail/unReadCnt",
		type:"get",
		success:function(result){
			console.log("unReadCnt result:" , result);
			$("#unCnt").text(result);
		}
	});

	$("#selectType").on("change",function(){
		console.log("개똥이");

		//태그가 선택된 값
		let selectType = $("#selectType").val();

		console.log("selectType : " + selectType);

		let emlNoArr = [];
		//체크박스의 기본키 데이터 : data-eml-no="EML0435"
		//체크박스의 class : addrNo
		$(".addrNo").each(function(index){
			//체크박스를 반복하면서 포커스 된 바로 그 체크박스가 체크가 되었는가?
			if($(this).is(":checked")){//체크 되었다면..
// 				console.log("emlNo : " + $(this).data("emlNo"));
				emlNoArr.push($(this).data("emlNo"));
			}
		});

		console.log("emlNoArr : " + emlNoArr);

		//data : {"selectType":"EML_TAG01","emlNoArr":["EML0435","EML0430"]}
		let data = {"emlTagNo":selectType,"emlNoArray":emlNoArr};

		console.log("data : " + JSON.stringify(data));

		//아작났어유.. 피씨다타써
		$.ajax({
			url:"/mail/insertTag",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	           xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        success:function(result){
	        	console.log("result : " + JSON.stringify(result));
// 	        	alert("태그 선택 완료");
				swal({
				      title: "태그 선택 완료!",
				      icon: "success", //success, warning, error
				      button: "확인"
				   }).then(function () {
			        	refresh();
				   });
	        }
		});
	});
});
</script>

<script type="text/javascript">
$(function(){
	$("#delete").on("click",function(){
		let emlNoArray = [];

		$("input:checkbox[name='emlNo']:checked").each(function(index,data){
			let emlNo = $(this).data("emlNo");
			console.log("emlNo : " + emlNo);

			emlNoArray.push(emlNo);
		});

		let data = {"emlNoArray":emlNoArray};

		$.ajax({
			url:"/mail/delTrashPost",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(result){
            	console.log("result : " + result);
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

<!-- 받은메일함 -->
<!-- body_left -->
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/mailAside.jsp" />
		</div>
		<div class="col-lg-9">


			<!-- body_center -->
			<div class="row">
				<div class="col-2">
					<h4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="/resources/image/rmail.png" style="width: 25px; margin-right: 5px; margin-top: 0px;"/>받은 메일함</h4>
				</div>
				<div class="col-10">
					<p style="font-size:1.2em;">
						전체메일 <span id="totalCnt" style="color: blue; font-size:1.2em;">0</span> / 안읽은메일 <span id="unCnt" style="font-size:1.2em;">0</span>
					</p>
				</div>
			</div>
			<div class="table-responsive">
				<!-- dataTables -->
				<div class="container-fluid">
							<div class="card">
								<!-- Card header -->
								<div class="card-header">
									<div style="float: left;">
										<select class="form-control btn btn-outline-success" name="searchType"
											id="selectType" placeholder="Departure" style="font-size:1.0em;">
											<option value="" disabled="" selected="">태그선택</option>
											<option value="EML_TAG01">경영자료</option>
											<option value="EML_TAG02">참고자료</option>
											<option value="EML_TAG03">회계자료</option>
										</select>

									</div>
									<div style="float: left; margin-left: 15px; ">
										<button type="button" class="btn btn-outline-danger" style="width: 90px; font-size:1.0em;"
											id="delete">삭제</button>
									</div>
								</div>
								<div class="table-responsive" >
									<table class="table table-flush" id="datatable-search" >
										<thead style="text-align: left;">
											<tr style="text-align: left;">
												<th class="text-secondary font-weight-bolder " style="width: 5%;"></th>
												<th class="text-secondary font-weight-bolder" style="width: 5%; font-size:1.3em;">중요</th>
												<th class="text-secondary font-weight-bolder " style="width: 5%; font-size:1.3em;">라벨</th>
												<th class="text-secondary font-weight-bolder " style="width: 50%; font-size:1.3em;">제목</th>
												<th class="text-secondary font-weight-bolder " style="width: 5%; font-size:1.3em;">첨부파일</th>
												<th class="text-secondary font-weight-bolder" style="width: 5%; font-size:1.3em;">확인여부</th>
												<th class="text-secondary font-weight-bolder" style="width: 10%; font-size:1.3em;">발신자</th>
												<th class="text-secondary font-weight-bolder " style="width: 15%; font-size:1.3em;">발신일자</th>

											</tr>
										</thead>
										<tbody>
											<!-- data 없을 때 보여줄 문구 조건문 -->
											<c:if test="${fn:length(data)<1}">
												<tr style="text-align:center;">
													<td colspan="8">No Data Found</td>
												</tr>
											</c:if>
											<c:forEach var="mailVO" items="${data}" varStatus="stat">
												<fmt:formatDate value="${mailVO.emlTrsmDt}"
													pattern="yyyy-MM-dd" var="day1" />
												<c:if test="${mailVO.rslt == 1 }">
													<tr>
														<td class="font-weight-normal table-secondary" style="font-size:1.2em;" colspan="8">${day1}</td>
													</tr>
												</c:if>
												<tr>
													<td>
														<div class="form-check">
															<input class="form-check-input addrNo" type="checkbox"
																data-eml-no="${mailVO.emlNo}" name="emlNo"
																value="${mailVO.emlNo}">
														</div>
													</td>
													<td>
														<c:if test="${mailVO.emlImporYn eq '중요'}">
															<img src="/resources/image/star.png"
																style="width: 25px;">
														</c:if>
														<c:if test="${mailVO.emlImporYn eq '기본'}">
															<img src="/resources/image/starbl.png"
																style="width: 25px;">
														</c:if>
													</td>
													<td class="font-weight-normal" style="font-size:1.4em;"><c:if
															test="${mailVO.emlTagcol eq '빨강'}">
															<i class="ni ni-tag" style="color: red"></i>
														</c:if> <c:if test="${mailVO.emlTagcol eq '초록'}">
															<i class="ni ni-tag" style="color: green"></i>
														</c:if> <c:if test="${mailVO.emlTagcol eq '보라'}">
															<i class="ni ni-tag" style="color: purple"></i>
														</c:if></td>

													<td class="font-weight-normal" style="font-size:1.2em;"><a
														href="/mail/detail?emlNo=${mailVO.emlNo}">${fn:substring(mailVO.emlTtl,0,15)}
                                                            <c:if test="${fn:length(mailVO.emlTtl) > 15}">...</c:if></a></td>
													<td class="font-weight-normal" style="font-size:1.2em;"><c:if
															test="${mailVO.fileGroupNo!=null}">
															<img alt="" src="/resources/image/clip.png"
																style="width: 25px;">
														</c:if></td>
													<td class="font-weight-normal" style="font-size:1.2em;"><c:if
															test="${mailVO.rcvrYn eq '미확인'}">
															<img alt="" src="/resources/image/mail_or.png"
																style="width: 25px;">
														</c:if> <c:if test="${mailVO.rcvrYn eq '확인'}">
															<img alt="" src="/resources/image/mail_rd.png"
																style="width: 25px;">
														</c:if></td>
													<td class="font-weight-normal" style="font-size:1.2em;">${mailVO.empNm}</td>
													<td class="font-weight-normal" style="font-size:1.2em;"><fmt:formatDate
															value="${mailVO.emlTrsmDt}"
															pattern="yyyy-MM-dd HH:mm" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
							</div>

				</div>


				<!-- </div> -->



			</div>
		</div>
	</div>
</div>




<script type="text/javascript">

const dataTableSearch = new simpleDatatables.DataTable("#datatable-search", {
    searchable: true,
    fixedHeight: true
  });

  document.querySelectorAll(".export").forEach(function(el) {
    el.addEventListener("click", function(e) {
      var type = el.dataset.type;

      var data = {
        type: type,
        filename: "근태현황",
      };

      if (type === "csv") {
        data.columnDelimiter = "|";
      }

      dataTableSearch.export(data);
    });
  });
  </script>
<script>
		var win = navigator.platform.indexOf('Win') > -1;
		if (win && document.querySelector('#sidenav-scrollbar')) {
			var options = {
				damping : '0.5'
			}
			Scrollbar.init(document.querySelector('#sidenav-scrollbar'),
					options);
		}



</script>









