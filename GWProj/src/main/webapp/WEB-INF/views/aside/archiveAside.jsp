<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script>
<script src="/resources/js/sweetalert.min.js"></script>

<style>
 .card-border{
	border : 1px solid gray;
 }
 .nav-item{
 	margin: 10px;
 }
</style>

<c:set var="personalSize" value="${mapAchive.personalSize/1024/1024}" />
<fmt:formatNumber value="${personalSize}" type="number" pattern="0.0000" var="personalUsage" />

<c:set var="deptSize" value="${mapAchive.deptSize/1024/1024}" />
<fmt:formatNumber value="${deptSize}" type="number" pattern="0.0000" var="deptUsage" />

<c:set var="publicSize" value="${mapAchive.publicSize/1024/1024}" />
<fmt:formatNumber value="${publicSize}" type="number" pattern="0.0000" var="publicUsage" />

<c:set var="ImageSize" value="${mapAchive.ImageUsage/1024/1024}" />
<fmt:formatNumber value="${ImageSize}" type="number" pattern="0.0000" var="ImageUsage" />

<c:set var="docSize" value="${mapAchive.docUsage/1024/1024}" />
<fmt:formatNumber value="${docSize}" type="number" pattern="0.0000" var="docUsage" />

<c:set var="mediaSize" value="${mapAchive.mediaUsage/1024/1024}" />
<fmt:formatNumber value="${mediaSize}" type="number" pattern="0.0000" var="mediaUsage" />

<script type="text/javascript">
$(function(){

	//개인자료실 사용량
	let personalUsage = "${personalUsage}";
	$('#personal1').text(personalUsage);

	//부서자료실 사용량
	let deptUsage = "${deptUsage}";
	$('#dept1').text(deptUsage);

	//공용자료실 용량
	let publicUsage = "${publicUsage}";
	$('#public1').text(publicUsage);
});

</script>


<script type="text/javascript">
	$(function(){

		$('#insert').on('click',function(){
			swal({
				title: "등록하시겠습니까?",
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
				//result는뭘까 true
				console.log('result는뭘까',result);
				if(result){
					swal({
						title: "등록완료",
						text: "등록이 완료되었습니다.\n",
						icon: "success", //success, warning, error
						button: "확인",
						closeOnClickOutside: false,
					}).then(function(){
						$('#frm').submit();
					});

				}
			});
		});


		const handler = {
		        init() {
		            const fileInput = document.querySelector('#myFile');
		            const preview = document.querySelector('#preview');
		            fileInput.addEventListener('change', () => {
		                console.dir(fileInput)
		                const files = Array.from(fileInput.files);
		                var randomIndex = 1;
		                files.forEach(file => {
		                	console.log(file.name);
		                    preview.innerHTML += '<p id="'+(file.lastModified)+'">'+file.name+'&nbsp&nbsp&nbsp&nbsp'+file.size+'KG'+'&nbsp&nbsp&nbsp&nbsp'+'<button data-index="'+(file.lastModified)+'" class="file-remove">삭제</button></p>';
		                    randomIndex++;
		                });
		            });
		        },

		        removeFile: () => {
		            document.addEventListener('click', (e) => {
		            if(e.target.className !== 'file-remove') return;
		            const removeTargetId = e.target.dataset.index;
		            const removeTarget = document.getElementById(removeTargetId);
		            const files = document.querySelector('#myFile').files;

		            const dataTranster = new DataTransfer();
		            Array.from(files)
		                .filter(file => file.lastModified != removeTargetId)
		                .forEach(file => {
		                dataTranster.items.add(file);
		             });

		            document.querySelector('#myFile').files = dataTranster.files;

		            removeTarget.remove();
		        })
		        }
		    }

		    handler.init();
		    handler.removeFile();
	});
</script>

<div class="card position-sticky top-10 mb-5 p-2">
	<div class="mt-2 mx-2 px-2 pt-2">
		<a class="nav-link text-body" data-scroll="" href="/archive/bookmark">
			<div class="">
				<h4>자료실</h4>
			</div>
		</a>
	</div>
	<!-- 즐겨찾는 자료 시작 -->
	<ul
		class="nav flex-column bg-white border-radius-lg p-1 px-2 pb-2">
		<li class="nav-item">
			<button class="btn btn-lg btn-info w-100 px-0" style="font-size: 1.1em;" id="" data-bs-toggle="modal" data-bs-target="#archiveInsert">
			<i class="ni ni-cloud-download-95 mx-1"></i>업로드
			</button>
		</li>
		<!-- 즐겨찾는 자료 시작 -->
		<li class="nav-item">
			<div class="icon me-2">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill text-dark" viewBox="0 0 16 16">
		  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
		</svg>
			</div> <a href="/archive/bookmark"><span class="text-xl h5"><b>즐겨찾는 자료</b></span></a>
		</li>
		<!-- 즐겨찾는 자료 끝 -->
		<!-- 개인 자료실 시작 -->
		<li class="nav-item">
			<div class="icon me-2">
                   <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-fill text-dark" viewBox="0 0 16 16">
					  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
					</svg>
			</div> <a href="/archive/personal"><span class="text-xl h5"><b>개인 자료실</b></span></a>
		</li>
		<!-- 개인 자료실 끝 -->
		<!-- 부서 자료실 시작  -->
		<li class="nav-item">
			<div class="icon me-2">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-collection-fill text-dark" viewBox="0 0 16 16">
  <path d="M0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zM2 3a.5.5 0 0 0 .5.5h11a.5.5 0 0 0 0-1h-11A.5.5 0 0 0 2 3zm2-2a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 0-1h-7A.5.5 0 0 0 4 1z"/>
</svg>
			</div> <a href="/archive/dept"><span class="text-xl h5"><b>부서 자료실</b></span></a>
		</li>
		<!-- 부서 자료실 끝 -->
		<!-- 공용 자료실 시작 -->
		<li class="nav-item">
			<div class="icon me-2">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="text-dark bi bi-people-fill" viewBox="0 0 16 16">
				  <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
				</svg>
			</div> <a href="/archive/public"><span class="text-xl h5"><b>공용 자료실</b></span></a>
		</li>
		<!-- 공용 자료실 끝 -->
	</ul>
	<!-- 자료실 용량 시작 -->
	<div class="card card-border h-100 mt-3">
		<div class="card-header pb-0 p-3">
			<h6 class="mb-0" style="font-size: 1.4em;">자료실 용량</h6>
		</div>
		<div class="card-body pb-0 p-3">
			<ul class="list-group">
				<li
					class="list-group-item border-0 d-flex align-items-center px-0 mb-0">
					<div class="w-100">
						<div class="d-flex mb-2">
							<span class="me-2 font-weight-bold text-capitalize"  style="font-size:1.1em;">개인자료실
								용량 </span> <span class="ms-auto font-weight-bold" style="font-size:1.0em;">3%</span>
						</div>
						<div>
							<div class="progress progress-md">
								<div class="progress-bar bg-gradient-info w-5"
									role="progressbar" aria-valuenow="5" aria-valuemin="10"
									aria-valuemax="10"></div>
							</div>
							<span class="ms-auto text-sm font-weight-bold" style="font-size: 1.1em;"
								style="text-align: right;">사용량 <span id="personal1"></span> KB /5GB</span>
						</div>
					</div>
				</li>
				<li
					class="list-group-item border-0 d-flex align-items-center px-0 mb-2">
					<div class="w-100">
						<div class="d-flex mb-2">
							<span class="me-2 font-weight-bold text-capitalize" style="font-size: 1.1em;">부서
								자료실용량 </span> <span class="ms-auto text-sm font-weight-bold">4%</span>
						</div>
						<div>
							<div class="progress progress-md">
								<div class="progress-bar bg-gradient-dark w-5"
									role="progressbar" aria-valuenow="10" aria-valuemin="10"
									aria-valuemax="10"></div>
							</div>
							<span class="ms-auto  text-sm font-weight-bold" style="font-size: 1.1em;"
								style="text-align: right;">사용량 <span id="dept1"></span> KB/5GB</span>
						</div>
					</div>
				</li>
				<li
					class="list-group-item border-0 d-flex align-items-center px-0 mb-2">
					<div class="w-100">
						<div class="d-flex mb-2">
							<span class="me-2 font-weight-bold text-capitalize" style="font-size: 1.1em;">공용
								자료실 용량 </span> <span class="ms-auto text-sm font-weight-bold">3%</span>
						</div>
						<div>
							<div class="progress progress-md">
								<div class="progress-bar bg-gradient-danger w-5"
									role="progressbar" aria-valuenow="5" aria-valuemin="0"
									aria-valuemax="100"></div>
							</div>
							<span class="ms-auto text-sm font-weight-bold"
								style="text-align: right;">사용량 <span id="public1"></span> KB/10GB</span>
						</div>
					</div>
				</li>
			</ul>
		</div>
		<div class="card-footer pt-0 p-3 d-flex align-items-center">
			<div class="w-100">
				<table>
				<tr>
					<td class="w-50"><p class="text-md"><b>이미지</b></p></td>
					<td class="w-25"><p class="text-md" style="text-align: right;">${ImageUsage}KB</p></td>
					<td class="w-25"><p class="text-md" style="text-align: right;">${mapAchive.get("ImageCount")}개</p></td>
				</tr>
				<tr>
					<td class="w-50"><p class="text-md"><b>문서</b></p></td>
					<td class="w-25"><p class="text-md" style="text-align: right;">${docUsage}KB</p></td>
					<td class="w-25"><p class="text-md" style="text-align: right;">${mapAchive.get("docCount")}개</p></td>
				</tr>
				<tr>
					<td class="w-50"><p class="text-md"><b>미디어</b></p></td>
					<td class="w-25"><p class="text-md" style="text-align: right;">
					${mediaUsage}KB</p></td>
					<td class="w-25"><p class="text-md" style="text-align: right;">${mapAchive.get("mediaCount")}개</p></td>
				</tr>
				</table>
			</div>
		</div>
	</div>
	<!-- 자료실 용량 끝 -->





</div>




<div class="modal fade modal-lg" id="archiveInsert" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered " role="document" >
		<div class="modal-content" >
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">파일업로드</h5>
				<button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
			</div>
			<p class="text-sm mb-0" style="margin: 10px;">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
	  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
	  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
				</svg>
				업로드할 파일과 정보를 입력해주세요
			</p>
		<form:form modelAttribute="ArchiveVO" id="frm"
			action="/archive/create?${_csrf.parameterName}=${_csrf.token}"
			enctype="multipart/form-data" method="post">
				<div class="modal-body">
							  <div class="form-group">
								    <label class="col-form-label" for="exampleFormControlSelect1">자료실 그룹</label>
								    <select class="form-control" id="exampleFormControlSelect1" name="arcGroupNm">
								      <option value="ARC0001">개인자료실</option>
								      <option value="ARC0002">부서자료실</option>
								      <option value="ARC0003">공용자료실</option>
								    </select>
								  </div>
						<div class="form-group">
							<label for="recipient-name" class="col-form-label">파일입력</label>
							<input type="file" class="form-control" id="myFile" name="uploadFile"  multiple>
						</div>



	<table class="table table-sm  align-items-center">
  <thead>
    <tr style="padding:0">
      <th class="col-1" style="padding:0">파일정보</th>
    </tr>
  </thead>
</table>

<div id="preview" style="height:auto;">
</div>

				</div>
				<div class="modal-footer">
		            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">취소</button>
		            <button type="button" class="btn bg-gradient-primary" style="background: #5C67F5" id="insert">등록</button>

				</div>
			</form:form>
		</div>
	</div>
</div>
