<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="/resources/css/sweetalert2.min.css" />
<script text="text/javascript" src="/resources/js/sweetalert2.min.js"></script>

<style>
.dropdown-menu {
  width: 400px;
}
</style>

<nav class="navbar navbar-main navbar-expand-lg position-sticky mt-4 top-1 px-0 mx-4 shadow-none border-radius-xl z-index-sticky"
	id="navbarBlur" data-scroll="true">
	<div class="container-fluid py-1 px-3">
		<div class="sidenav-toggler sidenav-toggler-inner d-xl-block d-none" style="margin-right:30px;">
			<a href="javascript:;" class="nav-link text-body p-0">
				<div class="sidenav-toggler-inner">
					<i class="sidenav-toggler-line"></i> <i
						class="sidenav-toggler-line"></i> <i class="sidenav-toggler-line"></i>
				</div>
			</a>
		</div>
		<nav aria-label="breadcrumb" >
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
				<li class="nav-item px-2 d-flex align-items-center">
					<a href="/note/recieveList" class="nav-link text-body p-0">
					<img class="img" alt=""
						src="/resources/maincss/assets/img/paper.png"
						style="width: 30px;">
					</a>
				</li>
			<!-- 체크리스트 시작 -->
				<li class="nav-item dropdown px-2 d-flex align-items-center">
					<a href="#" class="nav-link text-body p-0" id="dropdownMenuButton"
						data-bs-toggle="dropdown" aria-expanded="false"
						data-bs-auto-close="false" >
						<img class="img" alt="" style="width: 30px;"
						src="/resources/maincss/assets/img/check-list.png">
					</a>
					<ul class="dropdown-menu dropdown-menu-end pb-1 pt-1 px-2 py-3 me-sm-n4"
						aria-labelledby="dropdownMenuButton">

					<!-- 체크리스트 전체 감싸는 부분 : script에서 보낼 데이터 받는 부분으로 삭제 주의 -->
						<li>
						<div class="accordion" id="accordionRental">
							<div class="accordion-item mb-1" id="chkContainer">
							</div>
						</div>
						</li>
					<!-- 체크리스트 전체 감싸는 부분 끝 -->

					</ul>
				</li>
		<!-- 체크리스트 끝 -->

		<!-- 알림 시작 -->
				<li class="nav-item dropdown px-2 d-flex align-items-center">
				<a href="#" class="nav-link text-body p-0" id="dropdownMenuButton"
					data-bs-toggle="dropdown" aria-expanded="false"> <img class="img" alt=""
					src="/resources/maincss/assets/img/bell2.png" style="width: 30px;">
						<span id="alarmCount"
						class="badge badge-md badge-circle badge-floating badge-danger border-white"
						style="margin-left: -12px;">
						</span>
				</a>
					<ul id="headerAlarm" class="dropdown-menu dropdown-menu-end px-2 py-3 me-sm-n4"
						aria-labelledby="dropdownMenuButton" style="font-size: 1.2em;">
					</ul>
				</li>
				<!-- 알림 끝 -->

				<!----------------------- 로그인 함 시작 ----------------------->
				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal.empVO" var="empVO" />
					<li class="nav-item dropdown d-flex px-3 align-items-center">
						<a href="#" class="nav-link text-body p-0" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
			           	<c:choose>
							<c:when test="${not empty empVO.fileGrVO.fileGroupNo}">
			                 	<img src="/resources/upload${empVO.fileGrVO.filesList[0].fileStrgNm}" class="avatar rounded-circle me-3 img" alt="${empVO.fileGrVO.filesList[0].fileOrgnlNm}" style="width: 50px; border-radius: 50px; object-fit:cover;">
							</c:when>
							<c:otherwise>
			                	<img src="/resources/upload/emp/profile/default.png" class="avatar rounded-circle me-3 img" alt="default.png" style="width: 50px; border-radius: 50px; object-fit:cover;">
							</c:otherwise>
			            </c:choose>
						</a>
						<ul class="dropdown-menu dropdown-menu-end px-2 py-3 me-sm-n4"
							aria-labelledby="dropdownMenuButton" data-bs-popper="static">
							<li class="mb-2"><a class="dropdown-item border-radius-md"
								href="/myPage/main">
									<div class="d-flex py-1">
										<div class="d-flex flex-column justify-content-center">
											<h6 class="text-lg font-weight-normal mb-1">
												<span class="font-weight-bold">마이페이지</span>
											</h6>
										</div>
									</div>
							</a></li>
						<sec:authorize access="hasAuthority('AUTH_ADMIN')">
							<li class="mb-2"><a class="dropdown-item border-radius-md" href="/admin/empList">
									<div class="d-flex py-1">
										<div class="d-flex flex-column justify-content-center">
											<h6 class="text-lg font-weight-normal mb-1">
												<span class="font-weight-bold">관리자페이지</span>
											</h6>
										</div>
									</div>
							</a></li>
						</sec:authorize>
							<li class="mb-2"><a class="dropdown-item border-radius-md"
								href="/Todo/main">
									<div class="d-flex py-1">
										<div class="d-flex flex-column justify-content-center">
											<h6 class="text-lg font-weight-normal mb-1">
												<span class="font-weight-bold">체크리스트</span>
											</h6>
										</div>
									</div>
							</a></li>
							<li class="mb-2"><a class="dropdown-item border-radius-md"
								href="/alarm/main">
									<div class="d-flex py-1">
										<div class="d-flex flex-column justify-content-center">
											<h6 class="text-lg font-weight-normal mb-1">
												<span class="font-weight-bold">알림 목록</span>
											</h6>
										</div>
									</div>
							</a></li>
							<li class="mb-2"><a class="dropdown-item border-radius-md"
								href="/note/recieveList">
									<div class="d-flex py-1">
										<div class="d-flex flex-column justify-content-center">
											<h6 class="text-lg font-weight-normal mb-1">
												<span class="font-weight-bold">쪽지함</span>
											</h6>
										</div>
									</div>
							</a></li>
							<li class="mb-2"><a class="dropdown-item border-radius-md"
								onclick="fn_logout()">
									<div class="d-flex py-1">
										<div class="d-flex flex-column justify-content-center">
											<h6 class="text-lg font-weight-normal mb-1">
												<span class="font-weight-bold">로그아웃</span>
											</h6>
										</div>
									</div>
							</a></li>
						</ul></li>
					<form action="/logout" method="post" id="logoutFrm">
						<sec:csrfInput />
					</form>
				</sec:authorize>

				<sec:authorize access="isAuthenticated()">
					<sec:authentication property="principal.empVO" var="empVO" />
					<div style="float: left; margin-left: 10px; text-align: center;">
						<span class="d-sm-inline d-none s"
							style="font-size: 1.2em; color: black;">${empVO.empNm}</span><br />
						<span class="d-sm-inline d-none s"
							style="font-size: 1.2em; color: gray;">${empVO.deptNm}</span>
					</div>
				</sec:authorize>
<!-- 					</a> -->
<!-- 				</li> -->
				<!----------------------- 로그인 함 끝 ----------------------->
			</ul>
		</div>
	</div>
</nav>
<script>
	function fn_logout() {
		$("#logoutFrm").submit();
	}

var loop_flag = false;

$(function () {
	//7초마다 한번씩 알림 배지 새로고침
	//작업중에는 주석 처리 해둘게여!!!
	const loop = function () {
		var cnt1 = $('#alarmCount').text();
		var cnt2 = 0;

		$.ajax({
			url: "/alarm/alarmCount",
			type: "post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		         xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		  	},
			success:function(res){
				$('#alarmCount').text(res);
				cnt2 = res;
			}
		});

		$.ajax({
			url: "/alarm/mainHeader",
			type: "post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
		         xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		  	},
			success:function(res){
				var str= "";
				str += "<li class='mb-2'>";
				str += "	<a class='dropdown-item border-radius-md' href='/alarm/main'>";
				str += "		<div class='d-flex py-1'>알림 전체보기</div>";
				str += "	</a>";
				str += "</li>";
				for (let i = 0; i < res.length; i++) {
					str += "<li class='mb-2 haLink'>";
					str += "	<input class='haNo' type='hidden' value='"+ res[i].alarmNo +"'/>";
					if(res[i].alarmClsf == '메일'){
						str += "	<a class='dropdown-item border-radius-md' href='/mail/detail?emlNo="+ res[i].alarmLink +"'>";
					}
					if(res[i].alarmClsf == '설문조사'){
						str += "	<a class='dropdown-item border-radius-md' href='/survey/detail?srvyNo="+ res[i].alarmLink +"'>";
					}
					if(res[i].alarmClsf == '전자결재 승인'){
						str += "	<a class='dropdown-item border-radius-md' href='/edoc/completeBox'>";
					}
					if(res[i].alarmClsf == '전자결재 대기'){
						str += "	<a class='dropdown-item border-radius-md' href='/edoc/approve'>";
					}
					if(res[i].alarmClsf == '전자결재 참조'){
						str += "	<a class='dropdown-item border-radius-md' href='/edoc/atrzRfrnc'>";
					}
					if(res[i].alarmClsf == '전자결재 반려'){
						str += "	<a class='dropdown-item border-radius-md' href='/edoc/rejectBox'>";
					}
					if(res[i].alarmClsf == '쪽지'){
						str += "	<a class='dropdown-item border-radius-md' href='/note/rcvNtDetail?msgNo="+ res[i].alarmLink +"'>";
					}
					str += "		<div class='d-flex py-1'>";
					str += "			<div class='my-auto'>";
					if(res[i].fileStrgNm == null){
						str += "			<img src='/resources/upload/emp/profile/default.png' class='avatar avatar-sm  me-3' alt='user image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='"+ res[i].empTitle +"'>";
					}else{
						str += "			<img src='/resources/upload" + res[i].fileStrgNm + "' class='avatar avatar-sm  me-3' alt='user image' data-bs-toggle='tooltip' data-bs-placement='bottom' title='"+ res[i].empTitle +"'>";
					}
					str += "			</div>";
					str += "			<div class='d-flex flex-column justify-content-center'>";
					str += "				<h6 class='text-md font-weight-normal mb-1'><span class='font-weight-bold'>새로운 ["+ res[i].alarmClsf +"]에 대한 알림</span></h6>";
					str += "				<p class='text-sm text-secondary mb-0'><i class='fa fa-clock me-1'></i>"+ res[i].alarmDt +"</p>";
					str += "			</div>";
					str += "		</div>";
					str += "	</a>";
					str += "</li>";
				};


				$('#headerAlarm').html(str);


				//새로운 알림이 생겼을 때 토스트 알림 띄우기
			    if(loop_flag && cnt1 < cnt2){
					let Toast = Swal.mixin({
						toast:true,
						position:'top-right',
						showConfirmButton:false,
						timer:6000
					});
					Toast.fire({
						icon:'info',
						title:'새로운 ['+ res[0].alarmClsf +']에 대한 알림'
					});
			    }
				loop_flag = true;
			}
		});

	};

	loop();
	setInterval(loop, 3000);





	//헤더알림목록에서 알림 클릭시 알림 확인 처리
	$(document).on('click', '.haLink', function(){
		var alarmNo = $(this).find('.haNo').val();
		var data = {'alarmNo':alarmNo};

		$.ajax({
			url: '/alarm/checkAlarm',
			data: JSON.stringify(data),
			dataType: 'json',
			type: 'post',
			beforeSend: function(xhr) {
		           xhr.setRequestHeader('Content-Type', 'application/json;charset=utf-8');
		           xhr.setRequestHeader('${_csrf.headerName}', '${_csrf.token}');
		    },
			success: function (res) {

			}
		});
	});


	// 로드될 때마다 헤더에 체크리스트를 받아 출력하는 메소드입니다.
	$.ajax({
		url: "/Todo/mainHeader",
		type: "get",
		success:function(res){
			var data= "";
			for (let i = 0; i < res.length; i++) {
				data = "<h5 class='accordion-header' id='headingOne'>"
				+"<button class='accordion-button pb-1 pt-1 border-bottom font-weight-bold collapsed'"
				+"type='button' data-bs-toggle='collapse'"
				+"data-bs-target='#collapse" +i+ "' aria-expanded='false'"
				+"aria-controls='collapse" +i+ "'>"
				+"<div class='d-flex flex-column justify-content-center'>"
				+"<h6 class='text-lg font-weight-normal mb-0'>"
				+"<span class='font-weight-bold'>"+res[i].todoNm+"</span>"
				+"</h6>"
				+"</div>"
				+"<i class='collapse-close fa fa-plus text-xs position-absolute end-0 me-3'"
				+"aria-hidden='true'></i>"
				+"<i class='collapse-open fa fa-minus text-xs position-absolute end-0 me-3'"
				+"aria-hidden='true'></i>"
				+"</button></h5>"
				+"<div id='collapse" +i+ "' class='accordion-collapse collapse'"
				+"aria-labelledby='headingOne' data-bs-parent='#accordionRental1'>"
				+"<div class='accordion-body text-md pt-1 pb-1 opacity-8'>";
				var chkVOList = res[i].chkVOList;//아래for문에서 씀

				  for (let j = 0; j < chkVOList.length; j++) {
					data +="<div class='form-check'>"
						 +"<label class='custom-control-label' for='customCheck1'>";

						 if(chkVOList[j].chkSsts == 'Y'){
							 data+="<input class='form-check-input chkbtn' type='checkbox' value='' name='chk1' id='chk_"+chkVOList[j].chkNo+"' checked>";
						 }
						 if(chkVOList[j].chkSsts == 'N'){
							 data+="<input class='form-check-input chkbtn' type='checkbox' value='' name='chk1' id='chk_"+chkVOList[j].chkNo+"'>";
						 }

					data+="<span class='text' style='font-size: 1.5em;' data-bs-toggle='modal' data-bs-target='#updateCheckModal'>" +chkVOList[j].chkCn+ "</span>"
						+ "</label>"
						+ "<button type='button' value='" +chkVOList[j].chkNo+ "' class='btn-close text-dark myChk'>"
						+ "</button>"
						+ "</div>";
				  }
				data +="</div></div>";
				$("#chkContainer").append(data);
			};
			chkbtnTextDecoration();
		}
	});


	//체크버튼 클릭 시 업데이트
	$(document).on("click", ".chkbtn",function() {
		var chkbtnMy = '';
		 var chkbtnId = $(this).parent().parent().find('.myChk').val();

		if($(this).prop("checked")){
		   // 체크된 상태일 때 실행할 코드
		   chkbtnMy = "Y";
		} else {
		   // 체크되지 않은 상태일 때 실행할 코드
		   chkbtnMy = "N";
		}

		data = {
			chkSsts : chkbtnMy,
			chkNo : chkbtnId
		};

		$.ajax({
		    url: "/Todo/updateChkYN",
		    contentType:"application/json;charset:utf-8",
		    data:JSON.stringify(data),
		    type:"post",
   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
		    success: function(response) {
		    	$("#chkContainer").load("/tiles/header #chkContainer", function(){
		 			chkbtnTextDecoration();
		    	});
		    	$("#2fa").load("/Todo/main #2fa", function(){
	 			    chkbtnTextDecoration();
		    	});

		    }
		});
	});
})

     	//체크리스트에 맞춰 취소선 주기
	function chkbtnTextDecoration(){
   		var chkList = $(".chkbtn");
		for (var i = 0; i < chkList.length; i++) {
			if (chkList.eq(i).prop("checked")){
				chkList.eq(i).siblings(".text").css("text-decoration", "line-through");
			} else {
				chkList.eq(i).siblings(".text").css("text-decoration", "none");
			};
		};
	}
</script>