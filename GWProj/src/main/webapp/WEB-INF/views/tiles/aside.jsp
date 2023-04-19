<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
aside {
  overflow: hidden;
  over-flow-x :  hidden;
  overflow-x:auto;
}
.s{
	font-size: 1.6em;
	color: #376996;
	font-weight: bold;
	margin-left: 10px;

}

.d{
	margin-left: 10px;
/* 	margin-right: 15px; */
}

.nl:hover {
	background: #bef6eb;
}

.img {
/* 	filter: opacity(0.5) drop-shadow(0 0 0 #5C67F5); */
}

/* <!--조직도에서 ul css 없애는 스타일 --!> */
ul{
   list-style:none;
   }
</style>




<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 ps" id="sidenav-main" style="background: white;">
	<div class="sidenav-header" style="height: 80px; text-align: center;">
		<i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>

	<div class="collapse navbar-collapse  w-auto h-auto" id="">
		<ul class="navbar-nav">
			<li class="nav-item">
			</li>
			<li class="nav-item">
		<a href="/main" class="nav-link nl mt-3" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" src="/resources/image/GruOffice_logo01.png" alt="main_logo" style="width: 35px;  height: 80%;">
			</div>
			<span class="nav-link-text lg-1 s mt-1" style="margin-left:10px;" >GruOffice</span>
<!-- 			<span class="lg-1 font-weight-bolder s" style="font-size: 1.5em;">Gru<span style="font-size: 1.0em; font-weight: normal;">Office</span></span> -->
		</a>
		</li></ul></div>

<!-- 		<a class="navbar-brand m-0" href="#" target=""> -->
<!-- 			<div style="height:100px;"> -->
<!-- 				<img class="img" src="/resources/image/logo6.png" alt="main_logo" style="width: 70%; height: 80%;"> -->
<!-- 			</div> -->
<!-- 			<div> -->
<!-- 				<span class="lg-1 font-weight-bolder s" style="font-size: 2.0em;">Gru<span style="font-size: 1.0em; font-weight: normal;">Office</span></span> -->
<!-- 			</div> -->
<!-- 		</a> -->
	<hr class="horizontal dark mt-3">

	<div class="collapse navbar-collapse  w-auto h-auto ps" id="sidenav-collapse-main">
		<ul class="navbar-nav">
			<li class="nav-item">
			</li>
			<li class="nav-item">

		<a href="/main" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/home1.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s" >홈</span>
		</a>

		<a href="/address/list" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/phn.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">주소록</span>
		</a>

		<a href="/mail/recieveList" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/mail.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s" >메일</span>
		</a>

		<a href="/cal/calFrame" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/cal.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">일정</span>
		</a>

		<a href="/work/workList" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/bag.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">근태</span>
		</a>

		<a href="/dailyReport/main" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/business-report.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">일일업무보고</span>
		</a>

		<a href="/projects/projList" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/works.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">Works</span>
		</a>

		<a href="/edoc/main" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/sign.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">전자결재</span>
		</a>

		<a href="/board/totalList" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/board.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">게시판</span>
		</a>

		<a href="/survey/main" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/survey.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">설문조사</span>
		</a>

		<a href="/archive/bookmark" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/cloud.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">자료실</span>
		</a>

		<a href="/reserve/myres" class="nav-link nl" role="button" aria-expanded="false">
			<div class="d" >
				<img class="img" alt="" src="/resources/maincss/assets/img/res.png" style="width: 25px;">
			</div>
			<span class="nav-link-text lg-1 s">예약관리</span>
		</a>

		<div id="empModal">

		</div>
			</li>
		</ul>
	</div>
</div>
</aside>
