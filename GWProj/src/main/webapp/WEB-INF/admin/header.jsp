<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<nav
	class="navbar navbar-main navbar-expand-lg position-sticky mt-4 top-1 px-0 mx-4 shadow-none border-radius-xl z-index-sticky"
	id="navbarBlur" data-scroll="true">
	<div class="container-fluid py-1 px-3">

		<div class="sidenav-toggler sidenav-toggler-inner d-xl-block d-none ">
			<a href="javascript:;" class="nav-link text-body p-0">
				<div class="sidenav-toggler-inner">
					<i class="sidenav-toggler-line"></i> <i
						class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i>
				</div>
			</a>
		</div>
		<nav aria-label="breadcrumb" style="margin-left:30px;">
			<ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
				<li class="breadcrumb-item text-sm" style="margin-top:4px;"><a class="opacity-3 text-dark" href="/main">
					<svg width="17px" height="17px" class="mb-1" viewBox="0 0 45 40" version="1.1"
						xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
						<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
						<g transform="translate(-1716.000000, -439.000000)" fill="#252f40" fill-rule="nonzero">
						<g transform="translate(1716.000000, 291.000000)">
						<g transform="translate(0.000000, 148.000000)">
							<path d="M46.7199583,10.7414583 L40.8449583,0.949791667 C40.4909749,0.360605034 39.8540131,0 39.1666667,0 L7.83333333,0 C7.1459869,0 6.50902508,0.360605034 6.15504167,0.949791667 L0.280041667,10.7414583 C0.0969176761,11.0460037 -1.23209662e-05,11.3946378 -1.23209662e-05,11.75 C-0.00758042603,16.0663731 3.48367543,19.5725301 7.80004167,19.5833333 L7.81570833,19.5833333 C9.75003686,19.5882688 11.6168794,18.8726691 13.0522917,17.5760417 C16.0171492,20.2556967 20.5292675,20.2556967 23.494125,17.5760417 C26.4604562,20.2616016 30.9794188,20.2616016 33.94575,17.5760417 C36.2421905,19.6477597 39.5441143,20.1708521 42.3684437,18.9103691 C45.1927731,17.649886 47.0084685,14.8428276 47.0000295,11.75 C47.0000295,11.3946378 46.9030823,11.0460037 46.7199583,10.7414583 Z"></path>
							<path d="M39.198,22.4912623 C37.3776246,22.4928106 35.5817531,22.0149171 33.951625,21.0951667 L33.92225,21.1107282 C31.1430221,22.6838032 27.9255001,22.9318916 24.9844167,21.7998837 C24.4750389,21.605469 23.9777983,21.3722567 23.4960833,21.1018359 L23.4745417,21.1129513 C20.6961809,22.6871153 17.4786145,22.9344611 14.5386667,21.7998837 C14.029926,21.6054643 13.533337,21.3722507 13.0522917,21.1018359 C11.4250962,22.0190609 9.63246555,22.4947009 7.81570833,22.4912623 C7.16510551,22.4842162 6.51607673,22.4173045 5.875,22.2911849 L5.875,44.7220845 C5.875,45.9498589 6.7517757,46.9451667 7.83333333,46.9451667 L19.5833333,46.9451667 L19.5833333,33.6066734 L27.4166667,33.6066734 L27.4166667,46.9451667 L39.1666667,46.9451667 C40.2482243,46.9451667 41.125,45.9498589 41.125,44.7220845 L41.125,22.2822926 C40.4887822,22.4116582 39.8442868,22.4815492 39.198,22.4912623 Z"></path>
						</g>
						</g>
						</g>
						</g>
					</svg>
				</a></li>
				<li class="breadcrumb-item" style="font-size:1.2em;"><a
					class="opacity-5 text-dark" href="/main">${pageMain}</a></li>
				<li class="breadcrumb-item text-dark active"
					aria-current="page" style="font-size:1.2em;">${pageDetail}</li>
			</ol>
			<h6 class="font-weight-bolder mb-0" style="font-size:1.4em;">${pageName}</h6>
		</nav>
		<div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4"
			id="navbar">
			<div class="ms-md-auto pe-md-3 d-flex align-items-center"></div>
			<ul class="navbar-nav  justify-content-end">
				<li class="nav-item dropdown d-flex px-3 align-items-center">
					<a href="#" class="nav-link text-body p-0" id="dropdownMenuButton"
						data-bs-toggle="dropdown" aria-expanded="false"> 
						<img class="img" alt="" src="/resources/maincss/assets/img/user1.png" style="width: 50px;">
					</a>
					<ul class="dropdown-menu dropdown-menu-end px-2 py-3 me-sm-n4"
						aria-labelledby="dropdownMenuButton" data-bs-popper="static">
						<li class="mb-2">
							<a class="dropdown-item border-radius-md" href="/main">
								<div class="d-flex py-1">
									<div class="d-flex flex-column justify-content-center">
										<h6 class="text-sm font-weight-normal mb-1">
											<span class="font-weight-bold">사원 페이지</span>
										</h6>
									</div>
								</div>
							</a>
						</li>
						<li class="mb-2">
							<a class="dropdown-item border-radius-md" onclick="fn_logout()">
								<div class="d-flex py-1">
									<div class="d-flex flex-column justify-content-center">
										<h6 class="text-sm font-weight-normal mb-1">
											<span class="font-weight-bold">로그아웃</span>
										</h6>
									</div>
								</div>
							</a>
						</li>
					</ul></li>
				<div style="float: left; margin-left: 10px; text-align: center;">
					<span class="d-sm-inline d-none s" style="font-size: 1.2em; color: black;">관리자</span><br />
					<span class="d-sm-inline d-none s" style="font-size: 1.2em; color: gray;">그루IT(회사정보)</span>
				</div>
			</ul>
		</div>
	</div>
</nav>
<form action="/logout" method="post" id="logoutFrm">
	<sec:csrfInput />
</form>
<script>
	function fn_logout() {
		$("#logoutFrm").submit();
	}
</script>
