<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script> 


<style>
.form-control{
font-size: 1.1em;
}

.choices__inner{
width:250px;
}

.choices__list--single{
font-size : 1.2em;
}

.folder{
font-size:1.3em;
}
</style>

<!-- 다음 우편번호 검색 api -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<!-- 조직도 스크립트 -->
<!-- 조직도 스크립트 css만 주석처리하면 우리 부트스트랩 css랑 충돌안남 -->
<!--  <link rel="stylesheet" href="/resources/css/jquery.treeview.css" />  -->
<!--  	<link rel="stylesheet" href="/resources/css/screen.css" />  -->
	
	
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/js/jquery.cookie.js"></script>
<script src="/resources/js/jquery.treeview.js"></script>

	<script type="text/javascript" src="/resources/js/demo.js"></script>
	

	<script type="text/javascript">
	$(document).ready(function(){
		$("#browser").treeview({
			toggle: function() {
				console.log("%s was toggled.", $(this).find(">span").text());
			}
		});

		$("#add").click(function() {
			var branches = $("<li><span class='folder'>New Sublist</span><ul>" +
				"<li><span class='file'>Item1</span></li>" +
				"<li><span class='file'>Item2</span></li></ul></li>").appendTo("#browser");
			$("#browser").treeview({
				add: branches
			});
		});
	});
</script>
<!-- 조직도 스크립트 끝-->

<style>
ul{
   list-style:none;
   }

/* 직위 부분 css 수정 */ 
.choices{
	margin-top:13px;
	}

.choices__inner{
	width: 290px;
	}

.form-label{
font-size: 0.9em;
}
</style>

<form action="/admin/updateEmp" onsubmit="return chkAuth();" method="post">
<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
</sec:authorize>
<div class="modal fade" id="selectDept" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">조직도</h5>
        <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div id="orgList">
	<ul id="browser" class="filetree treeview-famfamfam" >
		<li class="dropdownLi" style="margin-left:-20px;"><i class="ni ni-zoom-split-in fa-lg fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team"  data-deptno="DEPT001" >그루IT</span>
			<ul id="folder21" class="adminEmp">
			</ul>
			<ul>
				<li class="closed dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder">경영지원본부</span>
					<ul>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT003">재무팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT004">인사팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT005">총무팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder ">영업본부</span>
					<ul>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT011">영업팀</span>
							<ul id="folder21"></ul>
						</li>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT012">마케팅팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList dropdownLi group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT013">CS팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder">개발본부</span>
					<ul>
						<li class="closed empList group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT007">서비스개발팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT008">플랫폼운영팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList group"><i class="ni ni-zoom-split-in fa-lg" style="color: #088ff7;"></i>&nbsp;<span class="folder team" data-deptno="DEPT009">디자인팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>
	</div>
      </div>
    </div>
  </div>
</div>






<div class="row" style="width:100%; margin-left:-200px;">
		<div class="col-4 justify-content-end align-items-end">
			<div class="col-sm-auto col-12">
				<div class="avatar avatar-xl position-relative">
					
				</div>
			</div>
			
		</div>

	<div class="col-7 card mt-4" id="basic-info" style="width:900px;">
		<div class="card-body pt-0">
			<div class="row" style="margin-top: 20px;">
				<div class="col-6">
					<label class="form-label" style="font-size:1.3em;">사원번호</label>
					<div class="input-group">
						<input id="empNo" name="empNo" value="${empvo.empNo}" class="form-control" type="text" required="required" readonly="readonly" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
				<div class="col-6">
					<label class="form-label" style="font-size:1.3em;">사원명</label>
					<div class="input-group">
						<input id="empNm" name="empNm" value="${empvo.empNm}" readonly="readonly" class="form-control" type="text" required="required" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
			</div>
			
			<div class="row">
				
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">부서</label>
						<button type="button" id="orgBtn" style="display:none; font-size:1.0em;" class="btn btn-secondary" data-bs-toggle="modal" data-bs-target="#selectDept">조직도</button>
						<input id="deptNm" name="deptNm" value="${empvo.deptNm}" class="form-control" type="text" readonly="readonly" placeholder="조직도에서 선택하면 자동으로 입력됩니다" onfocus="focused(this)" onfocusout="defocused(this)">
					<input type="hidden" id="deptNo" name="deptNo" value="${empvo.deptNo}">
				</div>
				<div class="col-4">
					<label class="form-label mt-4" style="font-size:1.3em;">직위</label>
					<select id="jbpsNo" name="jbpsNo" class="select"></select>
					<input id="jbpsVal" type="hidden" value="${empvo.jbpsNo}" />
				</div>
			</div>
		</div>
		<div class="card-body pt-0">
			<div class="row">
				<div class="col-6">
					<label class="form-label" style="font-size:1.3em;">주민번호</label>
					<div class="input-group">
						<input id="empRrno" name="empRrno" value="${empvo.empRrno}" readonly="readonly" class="form-control" type="text" placeholder="ex)123456-2134534" required="required" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
				<div class="col-6">
					<label class="form-label" style="font-size:1.3em;">생년월일</label>
					<div class="input-group">
						<fmt:formatDate value="${empvo.empBrdt}" pattern="yyyy-MM-dd" var="empBrdt" />
						<input id="empBrdt" name="empBrdt" value="${empBrdt}" class="form-control" type="date" placeholder="ex)1970/10/02" readonly="readonly"  required="required" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
			</div>
			
			<div class="row">
				
				<div class="col-4">
					<label class="form-label mt-4" style="font-size:1.3em;">성별</label>
					<div class="input-group">
					<select id="empGender" name="empGender" class="select" ></select>
					<input type="hidden" id="genderVal" value="${empvo.empGender}">
					</div>
				</div>
				<div class="col-3" style="margin-top:10px; margin-left:30px;">
					<label class="form-label mt-4" style="font-size:1.3em;">휴대전화</label>
					<div class="input-group">
						<input id="empMblTelno" name="empMblTelno" value="${empvo.empMblTelno}"  readonly="readonly" class="form-control" type="text" placeholder="ex)010-0000-0000" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
				<div class="col-4" style="margin-top:10px;">
					<label class="form-label mt-4" style="font-size:1.3em;">사내전화</label>
					<div class="input-group">
						<input id="empCoTelno" name="empCoTelno" value="${empvo.empCoTelno}" readonly="readonly" class="form-control" type="text" placeholder="ex)042-0000-0000" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
			</div>
			
			<div class="col-12">
					<label class="form-label mt-4" style="font-size:1.3em;">이메일</label>
					<div class="input-group">
						<input id="empEmlAddr" name="empEmlAddr" value="${empvo.empEmlAddr}" readonly="readonly"  class="form-control" type="email" placeholder="example@gruOffice.com" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
			</div>
			
			<div class="row">
				
				<div class="col-12">
					<label class="form-label mt-4" style="font-size:1.3em;">우편번호</label>
					<div class="row">
					<div class="col-5 input-group" style="width:500px; height:40px;">
						<input id="zipCode" name="empZip" value="${empvo.empZip}" readonly="readonly" class="form-control" type="text" placeholder="주소 검색하면 자동 입력됩니다" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
						<div class="col-2" style="margin-top:-8px;">
						<button type="button" style="display:none;" id="zipSearch" class="btn btn-secondary" style="width:88px; height:35px; margin-left:10px; margin-top:10px;">검색</button>
						</div>
					</div>
				</div>
				<div class="col-12">
					<label class="form-label mt-4" style="font-size:1.3em;">주소</label>
					<div class="input-group">
						<input id="empAddr" name="empAddr"  value="${empvo.empAddr}" readonly="readonly" class="form-control" type="text" placeholder="주소 검색하면 자동 입력됩니다" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
				<div class="col-12">
					<label class="form-label mt-4" style="font-size:1.3em;">상세주소</label>
					<div class="input-group">
						<input id="empDaddr" name="empDaddr"  value="${empvo.empDaddr}" readonly="readonly" class="form-control" type="text" placeholder="상세주소를 입력해주세요" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
			</div>
			
			<div class="row">
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">입사일</label>
					<div class="input-group">
						<fmt:formatDate value="${empvo.empJncmpYmd}" pattern="yyyy-MM-dd" var="empJncmpYmd" />
						<input id="empJncmpYmd" name="empJncmpYmd" value="${empJncmpYmd}" readonly="readonly" class="form-control" type="date" placeholder="example@email.com" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
				
				<c:if test="${null ne empvo.empRsgntnYmd}">
				<div class="col-6">
					<label class="form-label mt-4" style="font-size:1.3em;">퇴사일</label>
					<div class="input-group">
						<fmt:formatDate value="${empvo.empRsgntnYmd}" pattern="yyyy-MM-dd" var="empRsgntnYmd" />
						<input id="empRsgntnYmd" name="empRsgntnYmd" value="${empRsgntnYmd}" readonly="readonly" class="form-control" type="date"  style="color:red;" placeholder="example@email.com" onfocus="focused(this)" onfocusout="defocused(this)">
					</div>
				</div>
				</c:if>
				
				<div class="row">
					<div class="col-12">
						<label class="form-label mt-4" style="font-size:1.3em;">권한</label>
						<div class="row" style="margin-left: 20px;">
							
							<c:forEach var="AuthrtVO" items="${empvo.empAuthVOList }" varStatus="stat">
							<input type="hidden" id="auth${stat.count }" value="${AuthrtVO.authrtNm}"> 
							</c:forEach>
								
							<div class="form-check form-switch col-4">
							  <input class="form-check-input" name="empAuthVOList[0].authrtNm" value="AUTH_MEM" type="checkbox" id="AUTH1" disabled>
							  <input type="hidden" name="empAuthVOList[0].empNo" id="empNo1" value="${empvo.empNo }" >
							  <label class="form-check-label" for="flexSwitchCheckDefault" style="font-size:1.1em;">일반직원</label>
							</div>
							<div class="form-check form-switch col-4">
							  <input class="form-check-input" name="empAuthVOList[1].authrtNm" value="AUTH_MID" type="checkbox" id="AUTH2" disabled>
							  <input type="hidden" name="empAuthVOList[1].empNo" id="empNo2" value="${empvo.empNo }" >
							  <label class="form-check-label" for="flexSwitchCheckDefault" style="font-size:1.1em;">중간관리자</label>
							</div>
							<div class="form-check form-switch col-4">
							  <input class="form-check-input" name="empAuthVOList[2].authrtNm" value="AUTH_ADMIN" type="checkbox" id="AUTH3" disabled>
							  <input type="hidden" name="empAuthVOList[2].empNo" id="empNo3" value="${empvo.empNo }" >
							  <label class="form-check-label" for="flexSwitchCheckDefault" style="font-size:1.1em;">관리자</label>
							</div>
				
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
			<div class="row">
				<div class="col-12" style="text-align: center; margin-left: 220px;">
					<div class="ct-example" style="position: relative; !important;border-bottom: none !important;padding: 1rem 1rem 2rem 1rem;margin-bottom: -1.25rem;">
						<div>
						<button type="button" id="updateBtn" class="btn bg-info btn-lg text-lg" style="font-size:1.1em;color:white;">수정</button>
						<!-- submit 할 때 직위가 '선택'이면 못 넘어가도록  -->
						<button type="submit" id="updateSubmit"  class="btn bg-info btn-lg text-lg" style="display:none; font-size:1.1em; color:white;">확인</button>
						<button type="button" class="btn bg-secondary btn-lg text-lg" onclick="location.href='/admin/empList'" style="font-size:1.1em; color:white;">취소</button>
						<button type="button" id="exit" class="btn btn-outline-danger" style="display:none; font-size:1.0em; ">퇴사처리</button>
						<button type="button" id="reJoinCom" class="btn btn-outline-danger" style="display:none; font-size:1.0em;">복구처리</button>
						</div>
					</div>
				</div>
			</div>
</div>
	<sec:csrfInput/>

	
</form>
<script src="/resources/maincss/assets/js/plugins/choices.min.js"></script>


<script>


function chkAuth(){
	if($('#AUTH1').is(':checked') == false){
		swal({ 
		      title: "최소권한 '일반직원'은 체크되어야 합니다!",
		      icon: "warning", //success, warning, error
		      button: "확인"
		   })
	  return false; 
	}else{
		return true; 
	}
}



$(function(){

	//수정버튼을 누를경우 sweet alert창 띄우기
	const urlParams = new URL(location.href).searchParams;
	const updateComp = urlParams.get('updateComp');
	if(updateComp == 'Comp'){
		swal({ 
		      title: "정상적으로 수정되었습니다!",
		      icon: "success", //success, warning, error
		      button: "확인"
		   })
	}
	
auth = []; 
AUTH = []; 
	
auth[1] = $('#auth1').val(); 
auth[2] = $('#auth2').val(); 
auth[3] = $('#auth3').val(); 


AUTH[1] = $('#AUTH1').val(); 
AUTH[2] = $('#AUTH2').val(); 
AUTH[3] = $('#AUTH3').val();  



// alert(auth[1]);
// alert(auth[2]);
// alert(auth[3]);
// alert(AUTH[1]);
// alert(AUTH[2]);
// alert(AUTH[3]);


//만약 2중 반복문을 돌리다가 VALUE값이 맞으면 CHECKED 속성 추가 

for(i=1 ; i<4 ; i++){
	for(j=1; j<4 ; j++){
		if(auth[i] == AUTH[j]){
			$('#AUTH'+j).attr("checked",true); 
		}
	}
}


	


//부서 선택 시 선택한 값이 부서 input태그에 들어가도록
$(document).on('click','.team',function(){
	deptNo = $(this).data('deptno'); //hidden에 담을 것 
	deptNm = $(this).text(); 
	
	$('#deptNo').val(deptNo); 
	$('#deptNm').val(deptNm);
	
	
});

// 퇴사처리 누르면 컨펌 창 띄우고 퇴사 처리 되었다는 문구 띄우기 
$('#exit').on('click', function(){
	
	swal({
	      title: "정말 퇴사처리하시겠습니까?",
	      icon: "warning", //success, warning, error
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
	             className: "btn btn-danger"
	           }
	        },
	      closeOnClickOutside: false
	   }).then(function(result){
		   if(result == true){
			   swal({ 
			 	      title: "정상적으로 퇴사처리되었습니다!",
			 	      icon: "success", //success, warning, error
			 	      button: "확인"
			 	   }).then(function(result){
			 		  //ajax로 해당 사원 퇴사처리하기 
					  //사원 번호 변수에 담기 
				    empNo = '${empvo.empNo}'
					data = {"empNo" : empNo};
					
					$.ajax({
						url:"/admin/empExit",
						type:"post",
						data: JSON.stringify(data),
						contentType:"application/json;charset=utf-8",
						beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success:function(result){
						
					
					}
							
				   })
			 		   
			 		  location.href = "/admin/empList"; 
			 	   }); 
			   
			
		   }else{
			   return false; 
		   }
	 	   
	   });
	
	

	
});

		 	
		 	


// 	직위를 선택하면 그에 해당하는 약속된 권한들이 체크가 되도록하기 
	$('#jbpsNo').on('change',function(){
		
		//직위를 선택하면 초기화
		//직위를 변경해도 다시 고르면 체크여부가 false가 되어야하는데 안되는 거 같음.. 
		$('#AUTH3').attr("checked", false);
		$('#AUTH2').attr("checked", false);
		$('#AUTH1').attr("checked", false);
		
		let jbps = $(this).text();
		
		
	
		switch (jbps){
		  case '이사' :
		  case '대표' :
			$('#AUTH3').attr("checked", true);
			$('#AUTH2').attr("checked", true);
			$('#AUTH1').attr("checked", true);
		    break; 
		   
		  case '과장' :
		  case '부장' : 
			$('#AUTH2').attr("checked", true);
			$('#AUTH1').attr("checked", true);
			break; 
			
		  case '주임' :
		  case '사원' : 
		  case '대리' : 
			$('#AUTH1').attr("checked", true);
			break; 
		}
		
	})

//다음 우편번호 검색
	$("#zipSearch").on("click",function(){
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete:function(data){
				//우편번호
				$("#zipCode").val(data.zonecode);
				$("#empAddr").val(data.address);
			}
		}).open();
	});

//사원번호 get
// 			$.ajax({
// 				url:"/admin/getEmpNo",
// 				type:"post",
// 				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
// 	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 				},
// 				success:function(result){
// 					console.log(result.empNo);
					
// 					$('#empNo').val(result.empNo);
					
// 					$('#empNo1').val(result.empNo); 
// 					$('#empNo2').val(result.empNo); 
// 					$('#empNo3').val(result.empNo); 
// 				}
// 			});

})

//복구 버튼 누를시 재직으로 하고 퇴사일은 null로 하기 
//사원 번호 변수에 담기 
$('#reJoinCom').on('click',function(){
	
	swal({
	      title: "정말 복구처리하시겠습니까?",
	      icon: "warning", //success, warning, error
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
	             className: "btn btn-danger"
	           }
	        },
	      closeOnClickOutside: false
	   }).then(function(result){
		   if(result == true){
		 	swal({ 
	 	      title: "정상적으로 복구처리되었습니다!",
	 	      icon: "success", //success, warning, error
	 	      button: "확인"
	 	   }).then(function(result){
	 		  empNo = '${empvo.empNo}'
	 				data = {"empNo" : empNo};
	 				
	 				$.ajax({
	 					url:"/admin/empRejoin",
	 					type:"post",
	 					data: JSON.stringify(data),
	 					contentType:"application/json;charset=utf-8",
	 					beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	 		                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	 					},
	 					success:function(result){
	 					
	 				
	 				}
	 				
	 			})
	 		   
	 		   location.href = "/admin/empList"; 
	 	   });
		   }else{
			   return false; 
		   }
	   });
	
	
    	
})
	

//수정 버튼 누를 시 페이지 바꾸기 
$('#updateBtn').on('click', function(){
	
	$('.form-control').attr('readonly',false);
	$('#empNo').attr('readonly',true); 
	
	//직위, 성별 select 요소에 disabled 속성은 추가가능하지만 remove는 안먹어서 pass 
// 	$('.is-disabled').attr('class','choices is-disabled');
// 	$('#jbpsNo').removeAttr('disabled'); 
	
	$('#updateBtn').attr('style', "display:none;");
	
	$('#updateSubmit').attr('style', "display:inline;");
	$('#updateSubmit').attr('style', "font-size:1.1em;color:white;");
	
	if('${empvo.empHdofYn}' == 'HDOF0001'){
		$('#exit').attr('style', "display:inline;");
		$('#exit').attr('style', "font-size:1.1em;;");
	}else{
		//복구버튼 활성화 
		$('#reJoinCom').attr('style', "display:inline;");
		$('#reJoinCom').attr('style', "font-size:1.1em;;");
	}
	
	$('#AUTH1').removeAttr('disabled'); 
	$('#AUTH2').removeAttr('disabled'); 
	$('#AUTH3').removeAttr('disabled'); 
	
	//조직도 버튼과 우편주소 버튼 활성화 
	$('#orgBtn').attr('style', "display:inline; margin-left:8px; font-size:1.0em;");
	$('#zipSearch').attr('style', "display:inline; font-size:1.0em;");
})


</script>

<script>

jbpsVal = $('#jbpsVal').val(); 
genderVal = $('#genderVal').val(); 


if (document.getElementById('jbpsNo')) {
	var jbps = document.getElementById('jbpsNo');
	setTimeout(function() {
		const example = new Choices(jbps);
	}, 1);

	var jbpsArray = new Array();
	jbpsArray[0] = "대표";
	jbpsArray[1] = "이사";
	jbpsArray[2] = "부장";
	jbpsArray[3] = "과장";
	jbpsArray[4] = "대리";
	jbpsArray[5] = "주임";
	jbpsArray[6] = "사원";
	jbpsArray[7] = "선택";
	
	
	var jbpsValArray = new Array();
	jbpsValArray[0] = "JBPS001";
	jbpsValArray[1] = "JBPS002";
	jbpsValArray[2] = "JBPS003";
	jbpsValArray[3] = "JBPS004";
	jbpsValArray[4] = "JBPS005";
	jbpsValArray[5] = "JBPS006";
	jbpsValArray[6] = "JBPS007";
	jbpsValArray[7] = "-";
	
	for (m = 0; m < jbpsArray.length; m++) {
		var optn = document.createElement("OPTION");
		optn.text = jbpsArray[m];
		optn.value = jbpsValArray[m];
		if (jbpsValArray[m] == jbpsVal) {
			optn.selected = true;
		}
		jbps.options.add(optn);
	}
}


if (document.getElementById('empGender')) {
	var gender = document.getElementById('empGender');
	setTimeout(function() {
		const example = new Choices(gender);
	}, 1);

	var genderArray = new Array();
	genderArray[0] = "여성";
	genderArray[1] = "남성";
	
	var genderValArray = new Array();
	genderValArray[0] = "GENDER0002";
	genderValArray[1] = "GENDER0001";
	
	for (m = 0; m < genderArray.length; m++) {
		var optn = document.createElement("OPTION");
		optn.text = genderArray[m];
		optn.value = genderValArray[m];
		if (genderValArray[m] == genderVal) {
			optn.selected = true;
		}
		gender.options.add(optn);
	}
}


var win = navigator.platform.indexOf('Win') > -1;
if (win && document.querySelector('#sidenav-scrollbar')) {
	var options = {
		damping : '0.5'
	}
	Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
}

</script>

