<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="card position-sticky top-10 mb-5 p-2 w-100">
	<div class="mt-2 mb-2 mx-2 pb-2 px-2 pt-2">
		<div class="icon me-2" style="margin-left:10px;">
			<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-clock text-dark mb-2" viewBox="0 0 16 16">
			  <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71V3.5z"/>
			  <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z"/>
			</svg>
		</div>
				<span style="width: 24px; margin-left: 10px;" class="h4">예약 관리</span>
	</div>
	<hr class="horizontal dark mt-0">
	<ul class="nav flex-column bg-white border-radius-lg p-1 px-2 pb-2">
		<!-- 나의 예약현황 메뉴 시작 -->
		<li class="nav-item pt-2 pb-2">
			<div class="icon me-2" style="margin-left:10px;">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-check text-dark mb-2" viewBox="0 0 16 16">
			  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
			  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
			</svg>
			</div> <a href="/reserve/myres"><span class="text-xl h5"><b>나의 예약 현황</b></span></a>

			<div class>
				<ul class="nav flex-column bg-white border-radius-lg p-3">
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/reserve/myres">
							<div class="icon me-2"></div> <span class="text-lg">나의 예약 현황</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/reserve/room">
							<div class="icon me-2"></div> <span class="text-lg">회의실 예약</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/reserve/car">
							<div class="icon me-2"></div> <span class="text-lg">차량 예약</span>
					</a></li>
				</ul>
			</div>
		</li>
		<!-- 나의 예약현황 메뉴 끝 -->
	</ul>
</div>
