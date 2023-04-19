<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="/resources/js/jquery-3.6.0.js"></script>
<script src="/resources/maincss/assets/js/core/bootstrap.min.js"></script>
<link id="pagestyle"
	href="/resources/maincss/assets/css/soft-ui-dashboard.min.css?v=1.1.1"
	rel="stylesheet" />

<link rel="stylesheet" href="/resources/css/jquery.treeview.css" />
	<link rel="stylesheet" href="/resources/css/screen.css" />
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.min.js"></script>
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
	
<h1 id="banner"><a href="http://bassistance.de/jquery-plugins/jquery-plugin-treeview/">jQuery Treeview Plugin</a> Demo</h1>
	<div id="main">

<div class="input-group mb-3">
  <input type="text" id="search" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">
  <button class="btn btn-outline-primary mb-0" type="button" id="searchBtn">검색</button>
</div>
	
	<ul id="browser" class="filetree treeview-famfamfam" >
		<li><span class="folder">그루IT</span>
			<ul id="folder21">
				<li><a class="file" data-empno="230000" data-bs-toggle="modal" data-bs-target="#exampleModalMessage">김삼밥 대표</a></li>
				<li><a class="file" data-empno="230000" data-bs-toggle="modal" data-bs-target="#exampleModalMessage">유재석 이사</a></li>
			</ul>
			<ul>
				<li class="closed"><span class="folder">경영지원본부</span>
					<ul>
						<li class="closed"><span class="folder" data-deptno="dept001">재무팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">히여니 대리</span></li>
								<li><span class="file" data-empno="230000">보르미 부장</span></li>
							</ul>
						</li>
						<li class="closed"><span class="folder" data-deptNo="dept001">인사팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">김삼밥 부장</span></li>
								<li><span class="file" data-empno="230000">유재석 사원</span></li>
							</ul>
						</li>
						<li class="closed"><span class="folder" data-deptNo="dept001">총무팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">노홍철 과장</span></li>
								<li><span class="file" data-empno="230000">정형돈 주임</span></li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed"><span class="folder">영업본부</span>
					<ul>
						<li class="closed"><span class="folder" data-deptNo="dept001">영업팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">주지훈 부장</span></li>
								<li><span class="file" data-empno="230000">윤시윤 대리</span></li>
								<li><span class="file" data-empno="230000">김동욱 사원</span></li>
							</ul>
						</li>
						<li class="closed"><span class="folder" data-deptNo="dept001">마케팅팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">길성준 과장</span></li>
								<li><span class="file" data-empno="230000">이영진 대리</span></li>
							</ul>
						</li>
						<li class="closed"><span class="folder" data-deptNo="dept001">CS팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">이창수 부장</span></li>
								<li><span class="file" data-empno="230000">장그래 사원</span></li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed"><span class="folder">개발본부</span>
					<ul>
						<li class="closed"><span class="folder" data-deptNo="dept001">서비스개발팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">안영이 부장</span></li>
								<li><span class="file" data-empno="230000">김길동 사원</span></li>
							</ul>
						</li>
						<li class="closed"><span class="folder" data-deptNo="dept001">플랫폼운영팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">이볼음 부장</span></li>
								<li><span class="file" data-empno="230000">김히연 사원</span></li>
							</ul>
						</li>
						<li class="closed"><span class="folder" data-deptNo="dept001">디자인팀</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000">노히연 부장</span></li>
								<li><span class="file" data-empno="230000">서예준 사원</span></li>
							</ul>
						</li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>

<!-- 	<button id="add">추가</button> -->

</div>

<!-- 모달창  -->
    <!-- Modal -->
    <div class="modal fade" id="exampleModalMessage" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">New message to @CT</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body p-0">
            <div class="">
			<div class="">
				<div class="row">
					<div class="col-sm">
						<div class="card-body p-3 position-relative">
							<div class="mb-xl-0 mb-4">
								<div class="card card-blog card-plain">
									<div class="position-relative">
										<a class="d-block shadow-xl border-radius-xl"> <img src="/resources/image/laptop.jpg" alt="img-blur-shadow" class="img-fluid shadow border-radius-xl">
										</a>
									</div>
									<div class="card-body px-1 pb-0">
										<a href="javascript:;">
											<h5 class="text-center">구정모</h5>
										</a>
										<p class="text-gradient text-center text-dark mb-2 text-sm">그루IT 부사장</p>
										<p class="text-gradient text-center text-dark mb-2 text-sm">asdfsdf@gmail.com</p>
									</div>
									<div class="d-flex align-items-center">
										<table class="w-100">
											<tbody><tr>
												<td class="w-50 align-items-center"><a href="#" class="btn btn-lg p-4" data-bypass="true" style="margin-left:50px;"> <span class="ic_dashboard2 ic_create_survey" title="메일쓰기"><img class="img" alt="" src="/resources/maincss/assets/img/mail.png" style="width: 25px;"></span> <span class="txt" style="width:30px;">이메일</span>
												</a></td>
												<td class="w-50 align-items-center"><a href="#" class="btn btn-lg p-4" data-bypass="true" style="margin-left:30px;"> <span class="type"><span class="ic_dashboard2 ic_create_survey" title="일정등록">
																<img class="img" alt="" src="/resources/maincss/assets/img/cal.png" style="width: 25px;">
														</span></span> <span class="txt">일정</span>
												</a></td>
											</tr>
										</tbody></table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-sm">
						<div class="p-2">
							<div style="border: 2px solid #f5f7ff" class="p-3 h-auto">
							<table class="p-3 card card-blog card-plain">
							<tbody><tr>
							<th><h5>회사명</h5></th>
							<td>그루IT</td>
							</tr>
							<tr>
							<th><h5>직책/부서</h5></th>
							<td>부사장/-</td>
							</tr>
							<tr>
							<th><h5>연락처</h5></th>
							<td>010-1234-1234</td>
							</tr>
							
							<tr>
							<th><h5>더 추가할 정보</h5></th>
							<td>010-1234-1234</td>
							</tr>
							<tr>
							<th><h5>더 추가할 정보</h5></th>
							<td>010-1234-1234</td>
							</tr>
							<tr>
							<th><h5>더 추가할 정보</h5></th>
							<td>010-1234-1234</td>
							</tr>
							</tbody></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
       </div>
        </div>
      </div>
    </div>
  </div>
<script>
//부서는 계층형쿼리로 미리 뿌려두고 
//팀을 누를경우 사원을 불러오는것은 ajax 
$(function(){
	
	//사원 누를 경우 Modal창 띄우기 
	$('.file').on('click',function(){
		
		//이름 직위 따로 데이터를 불러올 것 
// 		var empNo = $(this).data('empno');
// 		alert(empNo);
		
		//이름 누르면 모달창 띄우기 
		//a태그로 바꾸고(빨간색 호버기능 적용) 
		//data-bs-toggle="modal" data-bs-target="#exampleModalMessage" 넣기 
		
		//기능 
		//ajax 호출(data로 empNo 넘기기)
		//모달창 코드에 해당 사원의 데이터 넣기 
		
		
	})
	
	//검색기능 
	//검색 버튼을 클릭하면 ajax로 목록데이터를 받아와 조직도 자리에 사원의 목록을 띄워줌 
	$('#searchBtn').on('click',function(){
		// val data = $('#search').val(); 
		
		//ajax호출
		//조직도 자리에 리스트 뿌리기 어짜피 다 ajax...
		
		
		
		
		
	})
})
</script>
