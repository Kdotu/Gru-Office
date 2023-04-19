<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
  <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
  <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal.empVO" var="empVO" />



<script type="text/javascript">

	$(function(){
		$(document).on('click','#deleteFile',function(){
			let arcNo = $(this).data('info');
			let empNO = "${empVO.empNo}";
			let data = { "arcNo" : arcNo ,"empNO" : empNO};
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
						url : '/archive/deleteFile',
						type : 'post',
						data : JSON.stringify(data),
					    contentType : 'application/json; charset=UTF-8',
						beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success : function(result){
							if(result>0){
								swal({
									title: "삭제완료",
									text: "삭제처리가 완료되었습니다.\n",
									icon: "success", //success, warning, error
									button: "확인",
									closeOnClickOutside: false,
								}).then(function(){
			 						location.reload();
								})
							}
						}
					});
				}
			})
		});
	});

	//즐겨찾기 아이콘(별) 클릭시 이벤트
	function bMarkList(e) {
		var src = $(e).attr("src");
		var arcNo = $(e).attr("title");
		var empNo = "${empVO.empNo}";
		var data = { "arcNo" : arcNo, "empNo" : empNo };
		console.log("data : ", data);
		if(src == "/resources/image/starli.png"){
			//즐겨찾기 삭제
			$.ajax({
				url: '/archive/deleteBookmark',
				data: JSON.stringify(data),
		        dataType: 'json',
				type: 'post',
				beforeSend: function(xhr) {
			           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
			    },
				success: function (res) {
					if(res>0){
						swal({
							title: "즐겨찾기 삭제",
							text: "즐겨찾기 자료에서 삭제되었습니다\n",
							icon: "success", //success, warning, error
							button: "확인",
							closeOnClickOutside: false,
						}).then(function(){
	 						location.reload();
						})
					}
				}
			});
		}
		if(src == "/resources/image/starbl.png"){
			//즐겨찾기 등록
			$.ajax({
				url: '/archive/createBookmark',
				data: JSON.stringify(data),
				dataType: 'json',
				type: 'post',
				beforeSend: function(xhr) {
			           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
			           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
			    },
				success: function (res) {
						if(res>0){
							swal({
								title: "즐겨찾기 추가",
								text: "즐겨찾기 자료에 추가되었습니다\n",
								icon: "success", //success, warning, error
								button: "확인",
								closeOnClickOutside: false,
							}).then(function(){
		 						location.reload();
							})
						}
				}
			});
		}
	}
	</script>


<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/archiveAside.jsp" />
		</div>
		<div class="col-lg-10 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->

<div class="row">
	<div class="col-12">
		<div class="card mb-4">
			<div class="card-header pb-0 p-3">
				<div class="dropdown">
				<h2><img src="/resources/image/bm.png" style="width: 20px; margin-bottom: 8px;">&nbsp공용자료실</h2>
				</div>
				<p class="text-mb mb-0">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
		  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"></path>
		  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"></path>
					</svg>
					공용으로 올린 자료를 확인 할 수 있습니다.
				</p>
			</div>


			<div class="card-body p-3" style="margin-bottom: 40px;">
				<div class="row">
						<form action="" method="get" id="searchForm" style="text-align:right; ">
						<input type="hidden" name="page" id="page" />
						<select name="searchType" style="width:100px; height:31px;">
							<option value="arcOrgnlNm"
								<c:if test="${searchType == 'arcOrgnlNm' }">
				<c:out value="selected"/></c:if>>
								자료제목</option>
							<option value="empNm"
								<c:if test="${searchType == 'empNm' }">
				<c:out value="selected"/></c:if>>
								작성자</option>
						</select> <input type="text" name="searchWord" value="${searchWord}">
						<input type="submit" class="btn btn-outline-dark btn-xxs m-0 align-middle text-center" style="height:37px;"
							value="검색">
					</form>

						<c:set var="dataList" value="${pagingVO.dataMapList}" />
						<c:choose>
						<c:when test="${empty dataList}">
							<div>등록된 자료가 없습니다.</div>
						</c:when>
						<c:otherwise>
						<c:forEach var="list" items="${dataList}">
						<div class=" mb-xl-0 mb-4" style="border-radius: 10px; margin: 25px; border: 2px double #c8c8c8; width:20%;">
							<div class="card card-blog card-plain">
								<div class="card-body px-1 pb-0" >
									<div class="row">
										<div class="col-md-7" style="text-align:center;">
											<p class="text-gradient text-dark mb-2 text-sm"></p>
										</div>
										<div class="col-md-5" align="right" style="margin-top: -15px;">

											<button type="button" style="border: none; background: none; padding: 3px;"><img onclick="clip(this); return false;" alt="Image placeholder" src="/resources/image/share.png" title="PROJ016" style="width: 20px;"></button>
											<img onclick="bMarkList(this)" alt="Image placeholder" src="/resources/image/<c:if test="${list.BOOKMARK == 1}">starli</c:if><c:if test="${list.BOOKMARK == 0}">starbl</c:if>.png" title="${list.ARC_NO}" style="width: 20px;">
										</div>
									</div>
										<c:if test="${fn:contains(list.ARC_TYPE,'xls')}">
											<img src="/resources/image/excel.png" alt=".excel" class="mb-4" style="width:190px; height:210px; text-align: center; margin-left: 20px;"  />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'text')}">
											<img src="/resources/image/txt.png" alt=".txt" class="mb-4" style="width:190px; height:210px; text-align: center; margin-left: 20px;" />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'ppt')}">
											<img src="/resources/image/ppt2.png" alt=".ppt" class="mb-4" style="width:190px; height:210px; text-align: center; margin-left: 20px;" />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'hwp')}">
											<img src="/resources/image/hwp.png" alt=".ppt" class="mb-4" style="width:190px; height:210px; text-align: center; margin-left: 20px;" />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'jpeg')}">
											<img src="/resources/upload${list.ARC_STRG_NM}" alt=".jpg" class="mb-4" style="width:190px; height:210px; text-align: center;  margin-left: 20px;" />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'jpg')}">
											<img src="/resources/upload${list.ARC_STRG_NM}" alt=".jpg" class="mb-4" style="width:190px; height:210px; text-align: center;  margin-left: 20px;" />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'png')}">
											<img src="/resources/upload${list.ARC_STRG_NM}" alt=".png" class="mb-4" style="width:190px; height:210px; text-align: center;  margin-left: 20px;" />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'video')}">
											<img src="/resources/image/video.png" alt=".video" class="mb-4" style="width:190px; height:210px; text-align: center; margin-left: 20px;" />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'presentation')}">
											<img src="/resources/image/ppt2.png" alt=".video" class="mb-4" style="width:190px; text-align: center; margin-left: 20px;" />
										</c:if>
										<c:if test="${fn:contains(list.ARC_TYPE,'pdf')}">
											<img src="/resources/image/pdf.png" alt=".pdf" class="mb-4" style="width:190px; text-align: center; margin-left: 20px;" />
										</c:if>

									<h4>${list.ARC_ORGNL_NM}</h4>
										<h5>${list.DEPT_NM} > ${list.EMP_NM}</h5>
									<h5><fmt:formatNumber pattern="#,##0" value="${list.ARC_FILE_SZ* 0.00098}" />KB</h5>
									<div style="margin-bottom: 5px;  text-align:center;">
										<div class="mb-2" style="width: 100px; text-align: center; float: right; margin-right: 20px;">
										<a href="/upload/download?fileName=${list.ARC_STRG_NM}">
											<img src="/resources/image/download.png" style="width:30px;"/>
										</a>
										<c:if test="${list.EMP_NO eq empVO.empNo}">
										<button type="button" id="deleteFile" style="border: none; background: none; padding: 3px;" data-info="${list.ARC_NO}"><img src="/resources/image/trash3.svg" style="width:30px;"/></button>
										</c:if>
										</div>
									</div>
								</div>
							</div>
						</div>
						</c:forEach>
						</c:otherwise>
				</c:choose>
				</div>
				<hr style="border: 3px ridge gray; margin: 20px;">


							<div id="pagingArea">
							${pagingVO.pagingHTML}
						</div>

			</div>

		</div>
	</div>
</div>

		</div>
	</div>
</div>

</sec:authorize>

<script type="text/javascript">
$(function(){
	var searchForm = $("#searchForm");
	var pagingArea = $("#pagingArea");

	pagingArea.on("click", "a", function(event){
		event.preventDefault();
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
});

</script>
