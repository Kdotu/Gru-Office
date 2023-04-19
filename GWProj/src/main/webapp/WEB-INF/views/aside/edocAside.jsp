<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<script type="text/javascript">

	$(function(){

		$('#edocFormSelect').on('click',function(){
	window.open("/edoc/edocFormSelect", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=200, left=200, width=470, height=600");
		});

	})

	</script>


<div class="card position-sticky top-10 mb-5 p-2">
	<div class="mt-2 mb-2 mx-2 pb-2 px-2 pt-2">
		<h4><a href="/edoc/main">전자결재</a></h4>
	</div>
	<ul
		class="nav flex-column bg-white border-radius-lg p-1 px-2 pb-2">
		<!-- 결재문서 메뉴 시작 -->
		<li class="nav-item">
			<button class="btn btn-lg btn-info w-100" id="edocFormSelect">기안하기</button>
		</li>
		<li class="nav-item">
			<div class="icon me-2">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard2" viewBox="0 0 16 16">
				  <path d="M3.5 2a.5.5 0 0 0-.5.5v12a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-12a.5.5 0 0 0-.5-.5H12a.5.5 0 0 1 0-1h.5A1.5 1.5 0 0 1 14 2.5v12a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-12A1.5 1.5 0 0 1 3.5 1H4a.5.5 0 0 1 0 1h-.5Z"/>
				  <path d="M10 .5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5.5.5 0 0 1-.5.5.5.5 0 0 0-.5.5V2a.5.5 0 0 0 .5.5h5A.5.5 0 0 0 11 2v-.5a.5.5 0 0 0-.5-.5.5.5 0 0 1-.5-.5Z"/>
				</svg>
			</div> <span class="text-xl h5"><b>결재문서</b></span>
			<div class>
				<ul class="nav flex-column bg-white border-radius-lg p-3">
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/edoc/draftingBox">
							<div class="icon me-2"></div> <span class="text-lg">기안한 문서</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/edoc/approve">
							<div class="icon me-2"></div> <span class="text-lg">결재할 문서</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/edoc/approved">
							<div class="icon me-2"></div> <span class="text-lg">결재진행문서</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/edoc/rejectBox">
							<div class="icon me-2"></div> <span class="text-lg">반려문서함</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/edoc/atrzRfrnc">
							<div class="icon me-2"></div> <span class="text-lg">참조문서함</span>
					</a></li>
				</ul>
			</div>
		</li>
		<!-- 결재문서 메뉴 끝 -->
		<!-- 완료문서함 메뉴 시작 -->
		<li class="nav-item">
			<div class="icon me-2">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard2-check" viewBox="0 0 16 16">
				  <path d="M9.5 0a.5.5 0 0 1 .5.5.5.5 0 0 0 .5.5.5.5 0 0 1 .5.5V2a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 2v-.5a.5.5 0 0 1 .5-.5.5.5 0 0 0 .5-.5.5.5 0 0 1 .5-.5h3Z"/>
				  <path d="M3 2.5a.5.5 0 0 1 .5-.5H4a.5.5 0 0 0 0-1h-.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1H12a.5.5 0 0 0 0 1h.5a.5.5 0 0 1 .5.5v12a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5v-12Z"/>
				  <path d="M10.854 7.854a.5.5 0 0 0-.708-.708L7.5 9.793 6.354 8.646a.5.5 0 1 0-.708.708l1.5 1.5a.5.5 0 0 0 .708 0l3-3Z"/>
				</svg>
			</div> <span class="text-xl h5"><b>완료문서</b></span>
			<div class>
				<ul class="nav flex-column bg-white border-radius-lg p-3">
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/edoc/completeBox">
							<div class="icon me-2"></div> <span class="text-lg">결재완료문서</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/edoc/atrzRfrncCompleteBox">
							<div class="icon me-2"></div> <span class="text-lg">참조완료문서</span>
					</a></li>
				</ul>
			</div>
		</li>






		<!-- 완료문서함 메뉴 끝 -->
	</ul>
</div>


