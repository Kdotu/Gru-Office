<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 

<style>
.choices__list--single{
font-size : 1.2em;
}


</style>





<script>
//1초에 한번씩 pCt요소의 text를 현재시각으로 변경해보자
setInterval(function () {
	//요청URI : /getCurrentTime
	//응답데이터타입 : json
	
	//아작났어유..피씨다타써
	//ajax(Asynchronous Javascript And XML)
	//processType:false, : let f = new FormData();
	//contentType:, : 보내는 데이터 타입
	//data:, : 보내는 데이터
	//dataType:"json", : 응답데이터타입(Controller에서 String으로 리턴 시 생략)
	$.ajax({
		url : '/work/getCurrentTime',
		type : 'get',
		success : function (res) {
			//append() : 누적 / html() : 새로고침
			$('#pCt').text(res);
		}
	});
}, 1000);


</script>	

<script>
$(function(){
	
let todayy = new Date();   

let year = todayy.getFullYear(); // 년도
let month = todayy.getMonth() + 1;  // 월 1월은 0으로 표현됨을 주의해야 합니다. (0~11)
let date = todayy.getDate();  // 날짜
let day = todayy.getDay();  // 요일 //일요일이 0, 월요일이1, 토요일이 6으로 표현됩니다.
 

var weekday = new Array(7);
weekday[0] = "일";
weekday[1] = "월";
weekday[2] = "화";
weekday[3] = "수";
weekday[4] = "목";
weekday[5] = "금";
weekday[6] = "토";

for(let i = 0; i < weekday.length; i++){
	if(day == i){
		day = weekday[i]
	}
}

if(month<10){
	month = '0'+month;
}

var ymd = year + '-' + month + '-' + date + '(' + day + ')'

$('#ymd').text(ymd);


//ajax로 출근시간, 퇴근시간, 주간누적 데이터 받아오기 
//주간 누적시간을 받아올 땐 오늘 날짜를 같이 보내면 그에 해당하는 주의 모든 근무시간을 더해서 가져오도록 한다.  

//출근하기 버튼을 누르면 근태관리 테이블에 insert 
$('#gotoworkBtn').on('click',function(){
	let $target = $(this); 
	console.log($target);

	$.ajax({
			url:"/work/insertgw",
			type:"post",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log(result);
				//sweetalert 처리하기
				
				var str = ""; 
					
				  if(result.workMngDtlCn=="지각"){
			    	 str += result.workMngDtlCn+"이네요! 다음번에는 늦지 마세요!!"  
		    	  }else{
		    		 str += result.workMngDtlCn+"으로 등록되었어요~! 시간맞춰 잘 오셨어요!"
		    	  }
					
				swal({ 
				      title: "출근이 처리되었습니다!",
				      icon: "success", //success, warning, error
				      text: str,  
				      button: "확인",
				   }).then(function () {
					   location.reload(); 
				    });
				
			}
		});
})

//시연용 출근버튼 이벤트 
$('#pptGoWork').on('click',function(){

	$.ajax({
			url:"/work/pptGoWork",
			type:"post",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log(result);
				//sweetalert 처리하기
				
				var str = ""; 
					
				
		    		 str += "정상출근으로 등록되었어요~! 시간맞춰 잘 오셨어요!"
					
				swal({ 
				      title: "출근이 처리되었습니다!",
				      icon: "success", //success, warning, error
				      text: str,  
				      button: "확인",
				   }).then(function () {
					   location.reload(); 
				    });
			}
		});
})

//퇴근하기 버튼을 누르면 근태관리 테이블 update 
$('#gotohomeBtn').on('click',function(){
	let $target = $(this); 
	console.log($target);

	$.ajax({
			url:"/work/insertgh",
			type:"post",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log(result);
				//sweetalert 처리하기
				swal({ 
				      title: "퇴근이 처리되었습니다!",
				      icon: "success", //success, warning, error
				      button: "확인",
				   }).then(function () {
					   location.reload();
				    });
			}
		});
})

//시연용 퇴근하기 버튼을 누르면 저녁 6시로 퇴근 처리가 되고 정상근무 및 근무시간 업데이트 
$('#pptGoHome').on('click',function(){

	$.ajax({
			url:"/work/pptGoHome",
			type:"post",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log(result);
				//sweetalert 처리하기
				swal({ 
				      title: "퇴근이 처리되었습니다!",
				      icon: "success", //success, warning, error
				      button: "확인",
				   }).then(function () {
					   location.reload();
				    });
			}
		});
	
	
})


//근무상태 버튼이 change가 되면 근태관리 테이블 insert
$('#choices-work').on('change', function(){
	let value = $(this).val(); 
	let data = {"workMngSsts" : value};
	
	$.ajax({
			url:"/work/updateSsts",
			type:"post",
			data: JSON.stringify(data),
			contentType:"application/json;charset=utf-8",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log(result);
				
				if(result==0){
					//sweetalert 처리하기
					swal({ 
					      title: "출근 후 상태변경이 가능합니다!",
					      icon: "warning", //success, warning, error
					      button: "확인",
					   }).then(function () {
						   location.reload(); 
					    });
				}else{
					swal({ 
					      title: "근무상태 변경이 완료되었습니다!",
					      icon: "success", //success, warning, error
					      button: "확인",
					   }).then(function () {
						   location.reload(); 
					    });
				}
			}
		});
	
})

var workMngSsts; // 전역변수 선언

//페이지 요청시 로그인한 사원의 출근,퇴근,근무상태를 가져오는 ajax 
$.ajax({
	url:"/work/selectTime",
	type:"post",
	async:false, // 이 한줄만 추가해주시면 됩니다.
	beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	},
	success:function(result){
		
		console.log(result);
		
		$('#gwT').text(result.workMngBgngDt);
		$('#ghT').text(result.workMngEndDt);
		
		workMngSsts = result.workMngSsts;
		
		
	}//success 끝
});

//근무상태 select
if (document.getElementById('choices-work')) {
	var work = document.getElementById('choices-work');
	setTimeout(function() {
		const example = new Choices(work);
	}, 1);

	var workArray = new Array();
	workArray[0] = "상태변경";
	workArray[1] = "업무중";
	workArray[2] = "업무종료";
	workArray[3] = "외근중";
	workArray[4] = "출장중";
	workArray[5] = "자리비움";
	
	var workCdArray = new Array();
	workCdArray[0] = "WSSTS0005";
	workCdArray[1] = "WSSTS0001";
	workCdArray[2] = "WSSTS0002";
	workCdArray[3] = "WSSTS0004";
	workCdArray[4] = "WSSTS0006";
	workCdArray[5] = "WSSTS0007";
	
	
	for (m = 0; m < workArray.length; m++) {
		var optn = document.createElement("OPTION");
		optn.text = workArray[m];
		optn.value = workCdArray[m];
		if (workArray[m] == workMngSsts) {
			optn.selected = true;
		}
		work.options.add(optn);
	}
}

//출근여부에 따른 출근버튼 비활성화 
$.ajax({
	url:"/work/countWork",
	type:"post",
	beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	},
	success:function(result){
		
		if(result.workMngNo==1){
			//이미 출근한 상태라면 출근버튼 비활성화 
				$('#gotoworkBtn').prop("disabled", true);
			if(result.workMngEndDt != null){
		    //출근한 상태이면서 퇴근도 했을 경우 퇴근 버튼도 비활성화 
				$('#gotohomeBtn').prop("disabled", true);
		    //퇴근했으면 근무상태가 자동으로 '업무종료'가 됨(트리거 사용)
		    //select 기능 막는 방법을 모르겠음 
		    $('#choices-work').disabled = true; 
		    
			}
		}if(result.workMngNo==0){
			//출근도 전이라면 퇴근버튼 비활성화 
			$('#gotohomeBtn').prop("disabled", true);
		}
		
	}//success 끝
});

//오늘 날짜 기준 누적근무시간 받아오기 
$.ajax({
	url:"/work/getWeekTime",
	type:"post",
	beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	},
	success:function(result){
		result.result
		
		$('#getWeekTime').text(result.result); 
		
	}//success 끝
});
})
</script>

<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />

<div class="card position-sticky top-10 mb-5 p-3" style="width:260px;">
		<div class="row">
			<h4>
				<img class="img mx-2 mb-1" alt=""
					src="/resources/maincss/assets/img/bag.png"
					style="width: 25px; magin-right: 5px;">근태관리
			</h4>
		</div>
	<hr class="horizontal dark mt-0">	
		<h5 id="ymd"></h5>
<h1 id="pCt" style="margin-left: 10px; margin-top: 10px;"></h1>
<div class="row">
	<div class="col-5">
		<h5>출근 시간</h5>
		<h5>퇴근 시간</h5>
		<h5>주간 누적</h5>
	</div>
	<div class="col-7" style="text-align: right: ;">
		<h5 id="gwT">00:00:00</h5>
		<h5 id="ghT">00:00:00</h5>
		<h6 id="getWeekTime">0h 00m 00s</h6>
	</div>
</div>
<hr style="border: 4px dotted gray;">
<div class="row" style="margin-bottom: 20px; margin-left: -20px;">
	<div class="col-6">
		<button id="gotoworkBtn" type="button" class="btn btn-info" style="width: 110px; border-radius: 20px; font-size: 1.1em;">출근하기</button>
		<button id="pptGoWork" type="button" class="btn btn-info" style="width: 80px; margin-top:-10px; margin-left:10px; height:30px; border-radius: 20px; font-size: 0.7em;">시연용</button>
	</div>
	<div class="col-6" >
		<button id="gotohomeBtn" type="button" class="btn btn-info" style="width: 110px; border-radius: 20px; font-size: 1.1em;">퇴근하기</button>
		<button id="pptGoHome" type="button" class="btn btn-info" style="width: 80px; margin-top:-10px; margin-left:15px; height:30px; border-radius: 20px; font-size: 0.7em;">시연용</button>
	</div>
	<div class="col-12" >
		<select class="form-control" name="choices-work"
		 id="choices-work" ></select> 
	</div>
	
</div>
	<ul class="nav flex-column bg-white border-radius-lg p-1 px-2 pb-2 mx-2">
		<!-- 근태관리 메뉴 시작 -->
		<li class="nav-item">
			<div class="icon me-2">
				<i class="ni ni-briefcase-24"></i>
			</div> <span class="text-lg" ><b style="font-size:1.2em;">근태관리</b></span>
			<div class>
				<ul class="nav flex-column bg-white border-radius-lg p-3">
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/work/workList">
							<div class="icon me-2"></div> <span class="text-xl" style="font-size:1.1em;">내 근태
								현황</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/work/holyList">
							<div class="icon me-2"></div> <span class="text-xl" style="font-size:1.1em;">내 연차
								내역</span>
					</a></li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/work/empDetail">
							<div class="icon me-2"></div> <span class="text-xl" style="font-size:1.1em;">내 인사
								정보</span>
					</a></li>
				</ul>
			</div>
		</li>
		<!-- 근태관리 메뉴 끝 -->
		<!-- 부서근태관리 메뉴 시작 -->
            <c:forEach var="AuthrtVO" items="${empVO.empAuthVOList}" >
            <c:if test="${AuthrtVO.authrtNm == 'AUTH_MID' || 'AUTH_ADMIN'}">
			<li class="nav-item">
			<div class="icon me-2">
				<i class="ni ni-briefcase-24"></i>
			</div>
             <span class="text-lg"><b style="font-size:1.2em;">부서 근태관리</b></span>
				<div class>
				<ul class="nav flex-column bg-white border-radius-lg p-3">
					<li class="nav-item pt-2">
						<p class="text-xl" style="margin-left:-10px;" >
							<b id="team" style="font-size:1.1em;">  </b>
							<hr class="horizontal dark mt-0">
						</p> <a class="nav-link text-body" data-scroll="" href="/work/deptWorkList">
							<div class="icon me-2"></div> <span class="text-xl" style="font-size:1.1em;">부서 근태
								현황</span>
					</a>
					</li>
					<li class="nav-item pt-2"><a class="nav-link text-body"
						data-scroll="" href="/work/deptStatis">
							<div class="icon me-2"></div> <span class="text-xl" style="font-size:1.1em;">부서 근태
								통계</span>
					</a></li>
				</ul>
			</div>
            </c:if>
            </c:forEach>
		</li>
		<!-- 부서 근태관리 메뉴 끝 -->
	</ul>
</div>
</sec:authorize>

<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>
<script>

//팀과 상위 부서 팀 이름을 가져오는 ajax 
	$.ajax({
			url:"/work/getTeam",
			type:"post",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				
				console.log(result); 
				$('#team').text(result.upDeptNm +" > " + result.deptNm);
				
			}
		});
	


</script>
<script>
	var win = navigator.platform.indexOf('Win') > -1;
	if (win && document.querySelector('#sidenav-scrollbar')) {
		var options = {
			damping : '0.5'
		}
		Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
	}
</script>