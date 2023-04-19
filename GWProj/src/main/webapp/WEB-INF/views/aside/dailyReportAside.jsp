<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<div class="card position-sticky top-10 mb-5 p-2">
	<div class="mt-2 mx-2 px-2 pt-2">
		<a class="nav-link text-body" data-scroll="" href="/dailyReport/main">
			<div class="icon me-2">
				<img class="img mb-2" alt="" src="/resources/maincss/assets/img/business-report.png" style="width: 25px;">
			</div><span class="text-dark h4" style="margin-left : 5px;">일일업무보고</span>
			<hr class="horizontal dark mt-0">
		</a>
	</div>
		<!-- 일일업무보고 메뉴 시작 -->
		<ul class="nav flex-column bg-white border-radius-lg p-3 pt-1">
			<li class="nav-item mb-3">
				<div class="icon me-2">
					<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-person-fill text-dark mb-1" viewBox="0 0 16 16">
					  <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z"/>
					</svg>
				</div>
				<a href="/dailyReport/main"> <span class="h5 mb-3 text-dark"><b>일일업무보고</b></span></a>
			</li>
			<li class="nav-item">
				<a href="/dailyReport/create" class="btn btn-lg btn-info w-100 px-3" style="font-size: 1.1em;">보고 작성</a>
			</li>
			<li class="nav-item pt-2"><a class="nav-link text-body"
				data-scroll="" a href="/dailyReport/main">
					<div class="icon me-2"></div> <span class="text-lg">일일업무보고 메인</span>
			</a></li>
			<li class="nav-item pt-2"><a class="nav-link text-body"
				data-scroll="" href="/dailyReport/list">
					<div class="icon me-2"></div> <span class="text-lg">이전 보고 조회</span>
			</a></li>
		</ul>
	<!-- 관리자의 경우 보이는 버튼 -->
	<sec:authorize access="hasAuthority('AUTH_MID')">
	<ul class="nav flex-column bg-white border-radius-lg p-3 pt-1">
		<!-- 부서별 메뉴 시작 -->
		<li class="nav-item">
			<div class="icon me-2">
				<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-people-fill text-dark" viewBox="0 0 16 16">
				  <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
				</svg>
			</div>
			<a href="/dailyReport/deptReport"><span class="h5 text-dark"><b>부서별</b></span></a>
		 </li>
		<li class="nav-item pt-2">
			<a class="nav-link text-body px-2" data-scroll="" href="/dailyReport/deptReport">
				<div class="icon me-2"></div> <span class="text-lg">부서 업무보고 현황</span>
			</a>
		</li>
		<li class="nav-item pt-2">
			<a class="nav-link text-body px-2" data-scroll="" href="/dailyReport/deptlist">
				<div class="icon me-2"></div> <span class="text-lg">부서 업무보고 조회</span>
			</a>
		</li>
	</ul>
	</sec:authorize>
	</div>
		<!-- 부서별 메뉴 끝 -->
















