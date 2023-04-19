<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
html {
	background-color: #BDBDBD;
}

.s {
	font-size: 1.4em;
	color: white;
	font-weight: bold;
}

.d {
	margin-left: 10px;
	margin-right: 15px;
}

.nl:hover {
	background: #FAE58C;
}
</style>

<aside
	class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 ps "
	id="sidenav-main" style="background: #376996;">
	<div class="sidenav-header" style="height: 200px; text-align: center;">
		<i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
			aria-hidden="true" id="iconSidenav"></i>
		<a class="navbar-brand m-0" href="#" target="_blank">
			<div style="height: 100px;">
				<img class="img" src="/resources/image/logo7.png" alt="main_logo"
					style="width: 70%; height: 100%; margin-top: 17px; color: #5C67F5;">
			</div>
			<div style="height: 50px; margin-top: 25px;">
				<span class="ms-1 font-weight-bolder s" style="font-size: 2.0em;">Gru<span style="font-size: 1.0em; font-weight: normal;">Office</span></span>
			</div>
		</a>
	</div>

	<hr class="horizontal dark mt-0">
	<div class="collapse navbar-collapse  w-auto h-auto" id="sidenav-collapse-main" style="margin-left: -20px;">
		<ul class="navbar-nav">
			<li class="nav-item">
				<a href="#" class="nav-link nl pb-0 pt-0" role="button" aria-expanded="false">
					<div class="d"></div> <span class="nav-link-text lg-1 s" style="font-size:1.8em;"><i class="ni ni-badge"></i>&nbsp;&nbsp;&nbsp;&nbsp;조직관리</span>
				</a>
	<!-- 				<ul class="nav flex-column border-radius-lg p-3 pt-0 mx-3 text-center" style="color : white;"> -->
	<!-- 					<li>조직설계</li> -->
	<!-- 					<li>인사관리</li> -->
	<!-- 					<li>직위체계</li> -->
	<!-- 				</ul> -->
				<ul class="nav flex-column border-radius-lg p-3 pt-0 mx-1 text-center" style="color : white;">
					<ul class="nav flex-column border-radius-lg p-3 pt-0 pb-0 mx-3 text-center" style="color : white;">
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/empList">
							<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">인사관리</span>
						</a></li>
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/deptStatisAdmin">
							<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">근태관리</span>
						</a></li>
					</ul>
				</ul>

			</li>

			<!-- 근태관리 메뉴는 없어짐 -->
<!-- 			<li class="nav-item"> -->
<!-- 				<a href="#" class="nav-link nl pb-0 pt-0" role="button" aria-expanded="false"> -->
<!-- 					<div class="d"></div> <span class="nav-link-text lg-1 s">근태관리</span> -->
<!-- 				</a> -->
<!-- 				<ul class="nav flex-column border-radius-lg p-3 pt-0 mx-3 text-center" style="color : white;"> -->
<!-- 					<ul class="nav flex-column border-radius-lg p-3 pt-0 pb-0 mx-3 text-center" style="color : white;"> -->
<!-- 						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/org"> -->
<!-- 						<div class="icon me-2"></div> <span class="text-sm keepAll" style="color : white;">근태현황</span></a></li> -->
<!-- 						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/org"> -->
<!-- 						<div class="icon me-2"></div> <span class="text-sm keepAll" style="color : white;">연차현황</span></a></li> -->
<!-- 					</ul> -->
<!-- 				</ul> -->
<!-- 			</li> -->

			<li class="nav-item">
				<a href="#" class="nav-link nl pb-0 pt-0" role="button" aria-expanded="false">
					<div class="d"></div> <span class="nav-link-text ms-1 s" style="font-size:1.8em;"><i class="ni ni-chart-bar-32"></i>&nbsp;&nbsp;&nbsp;&nbsp;통계/차트 관리</span>
				</a>
				<ul class="nav flex-column border-radius-lg p-3 pt-0 mx-1 text-center" style="color : white;">
					<ul class="nav flex-column border-radius-lg p-3 pt-0 pb-0 mx-3 text-center" style="color : white;">
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/workDeptChart">
						<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">근태</span></a></li>
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/slsChart">
						<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">매출</span></a></li>
					</ul>
				</ul>
			</li>
			<li class="nav-item">
				<a href="#" class="nav-link nl pb-0 pt-0" role="button" aria-expanded="false">
					<div class="d"></div> <span class="nav-link-text ms-1 s" style="font-size:1.8em;"><i class="ni ni-bullet-list-67"></i>&nbsp;&nbsp;&nbsp;&nbsp;메뉴 관리</span>
				</a>
				<ul class="nav flex-column border-radius-lg p-3 pt-0 mx-1 text-center" style="color : white;">
					<ul class="nav flex-column border-radius-lg p-3 pt-0 mx-3 text-center" style="color : white;">
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/admNoticeList">
							<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">공지게시판</span>
						</a></li>
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/wholBList">
							<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">전사게시판</span>
						</a></li>
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/depBList">
							<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">부서게시판</span>
						</a></li>
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/srvyList">
							<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">설문조사</span>
						</a></li>
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/reserveList">
							<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">예약/자원관리</span>
						</a></li>
						<li class="nav-item"><a class="nav-link text-body" data-scroll="" href="/admin/calFrame">
							<div class="icon me-2"></div> <span class="keepAll" style="color : white; font-size:1.5em;">일정관리</span>
						</a></li>
					</ul>
<!-- 					<li>예약</li> -->
<!-- 					<li>캘린더</li> -->
<!-- 					<li>설문조사</li> -->
				</ul></li>
		</ul>
	</div>
</aside>