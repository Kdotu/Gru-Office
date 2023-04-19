<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="card position-sticky top-10 mb-5 pt-2 p-2">
	<div class="mt-2 mb-2 mx-2 pb-2 px-2 pt-2">
		<a href="/myPage/main"><span class="text-xl h4">마이페이지</span></a>
	</div>
	<ul class="nav flex-column bg-white border-radius-lg p-1 px-2 pb-2">
		<!-- 기본정보 메뉴 시작 -->
		<li class="nav-item">
			<div class="icon me-2">
			<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-person-fill-gear" viewBox="0 0 16 16">
			  <path d="M11 5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm-9 8c0 1 1 1 1 1h5.256A4.493 4.493 0 0 1 8 12.5a4.49 4.49 0 0 1 1.544-3.393C9.077 9.038 8.564 9 8 9c-5 0-6 3-6 4Zm9.886-3.54c.18-.613 1.048-.613 1.229 0l.043.148a.64.64 0 0 0 .921.382l.136-.074c.561-.306 1.175.308.87.869l-.075.136a.64.64 0 0 0 .382.92l.149.045c.612.18.612 1.048 0 1.229l-.15.043a.64.64 0 0 0-.38.921l.074.136c.305.561-.309 1.175-.87.87l-.136-.075a.64.64 0 0 0-.92.382l-.045.149c-.18.612-1.048.612-1.229 0l-.043-.15a.64.64 0 0 0-.921-.38l-.136.074c-.561.305-1.175-.309-.87-.87l.075-.136a.64.64 0 0 0-.382-.92l-.148-.045c-.613-.18-.613-1.048 0-1.229l.148-.043a.64.64 0 0 0 .382-.921l-.074-.136c-.306-.561.308-1.175.869-.87l.136.075a.64.64 0 0 0 .92-.382l.045-.148ZM14 12.5a1.5 1.5 0 1 0-3 0 1.5 1.5 0 0 0 3 0Z"/>
			</svg>
			</div> <span class="text-xl h5"><b>기본정보</b></span>
			<div class>
				<ul class="nav flex-column bg-white border-radius-lg px-3">
					<li class="nav-item pt-2">
					<a class="nav-link text-body" data-scroll="" href="/myPage/modifyInfo">
						<div class="icon me-2"></div> <span class="text-lg">기본정보 수정</span>
					</a>
					</li>
					<li class="nav-item pt-2">
						<a class="nav-link text-body" data-scroll="" href="/myPage/modifyPswd">
							<div class="icon me-2"></div> <span class="text-lg">비밀번호 변경</span>
						</a>
					</li>
				</ul>
			</div>
		</li>
		<!-- 기본정보 메뉴 끝 -->
		<!-- 체크리스트 메뉴 시작 -->
		<li class="nav-item  pt-2">
			<div class="icon me-2">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard-check" viewBox="0 0 16 16">
			  <path fill-rule="evenodd" d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
			  <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1v-1z"/>
			  <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5h3zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0h-3z"/>
			</svg>
			</div> <a href="/Todo/main"><span class="text-xl h5"><b>체크리스트</b></span></a>
		</li>
		<!-- Todo 메뉴 끝 -->
		<!-- 알림목록 메뉴 시작 -->
		<li class="nav-item pt-2">
			<div class="icon me-2">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
			  <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2zM8 1.918l-.797.161A4.002 4.002 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4.002 4.002 0 0 0-3.203-3.92L8 1.917zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5.002 5.002 0 0 1 13 6c0 .88.32 4.2 1.22 6z"/>
			</svg>

			</div> <a href="/alarm/main"><span class="text-xl h5"><b>알림목록</b></span></a>
		</li>
		<!-- 알림목록 메뉴 끝 -->
		<!-- 쪽지함 메뉴 시작 -->
		<li class="nav-item pt-2 pb-2">
			<div class="icon me-2">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-send" viewBox="0 0 16 16">
			  <path d="M15.854.146a.5.5 0 0 1 .11.54l-5.819 14.547a.75.75 0 0 1-1.329.124l-3.178-4.995L.643 7.184a.75.75 0 0 1 .124-1.33L15.314.037a.5.5 0 0 1 .54.11ZM6.636 10.07l2.761 4.338L14.13 2.576 6.636 10.07Zm6.787-8.201L1.591 6.602l4.339 2.76 7.494-7.493Z"/>
			</svg>
			</div> <a href="/note/recieveList"><span class="text-xl h5"><b>쪽지함</b></span></a>

			<div class>
				<ul class="nav flex-column bg-white border-radius-lg p-3 pt-1">
					<li class="nav-item pb-0">
						<a href="/note/write" class="btn btn-outline-info w-100 h6 my-1 mt-1">쪽지 작성</a>
					</li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/note/recieveList">
							<div class="icon me-2"></div> <span class="text-lg">받은 쪽지함</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/note/send">
							<div class="icon me-2"></div> <span class="text-lg">보낸 쪽지함</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/note/keep">
							<div class="icon me-2"></div> <span class="text-lg">쪽지보관함</span>
					</a></li>
				</ul>
			</div>
		</li>
		<!-- 쪽지함 메뉴 끝 -->
		<!-- 로그아웃 버튼 -->
			<li class="mb-2">
			  <div class="d-flex py-1">
				<div class="d-flex flex-column justify-content-center">
					 <div class="icon me-2">
					 </div><a class="dropdown-item border-radius-md" onclick="fn_logout()">
					 	<span class="text-xl h5">
							<a onclick="fn_logout()">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-left" viewBox="0 0 16 16">
								  <path fill-rule="evenodd" d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0v2z"/>
								  <path fill-rule="evenodd" d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z"/>
								</svg>
								<span class="text-xl h4">로그아웃</span></a>
						</span></a>
					</div>
				</div>
			</li>
		<!-- 로그아웃 버튼 -->
	</ul>
</div>
<script>
	function fn_logout() {
		$("#logoutFrm").submit();
	}
</script>