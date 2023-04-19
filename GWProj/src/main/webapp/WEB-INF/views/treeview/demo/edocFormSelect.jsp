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


		//업무기안
		$('#drft').on('click',function(){
			window.open("/edoc/drft?form=업 무 기 안&edoFormClsf=EDOCFORM01", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=800, height=1100");
		});

		//증명서신청
		$('#cert').on('click',function(){
			window.open("/edoc/drft?form=증명서 신청&edoFormClsf=EDOCFORM03", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=800, height=1100");
		});

		//품의서
		$('#expnd').on('click',function(){
			window.open("/edoc/drft?form=품 의 서&edoFormClsf=EDOCFORM04", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=800, height=1100");
		});

		//지출결의서
		$('#expnd2').on('click',function(){
			window.open("/edoc/drft?form=지출결의서&edoFormClsf=EDOCFORM05", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=800, height=1100");
		});

		//휴가기안서
		$('#holi').on('click',function(){
			window.open("/edoc/holi?edoFormClsf=EDOCFORM06", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=800, height=1100");
		}) ;

		//법인카드사용신청서
		$('#card').on('click',function(){
			window.open("/edoc/drft?form=법인카드 사용신청서&edoFormClsf=EDOCFORM07", "_blank", "toolbar=yes, scrollbars=yes, resizable=yes, top=500, left=500, width=800, height=1100");
		}) ;


	});
	</script>

<h1 style="font-size:30px;">결재양식</h1>
	<div id="main">

<div class="input-group mb-3">
  <input type="text" id="search" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">
  <button class="btn btn-outline-primary mb-0" type="button" id="searchBtn">검색</button>
</div>

	<ul id="browser" class="filetree treeview-famfamfam" >
		<li><span class="folder2" style="font-size : 2.3em; font-weight : bold;">전체양식</span>
			<ul>
						<li class=""><span class="folder" data-deptno="dept001" style="font-size : 2.1em; font-weight : bold;">일반기안</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000" id="drft" style="font-size : 1.8em;">업무기안</span></li>
							</ul>
						</li>
						<li class=""><span class="folder" data-deptNo="dept001" style="font-size : 2.1em; font-weight : bold;">지원</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000" id="cert" style="font-size : 1.8em;">증명서신청</span></li>
							</ul>
						</li>
						<li class=""><span class="folder" data-deptNo="dept001" style="font-size : 2.1em; font-weight : bold;">품의</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000" id="expnd" style="font-size : 1.8em;">품의서</span></li>
							</ul>
						</li>
						<li class=""><span class="folder" data-deptNo="dept001" style="font-size : 2.1em; font-weight : bold;">지출결의</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000" id="expnd2" style="font-size : 1.8em;">지출결의서</span></li>
							</ul>
						</li>
						<li class=""><span class="folder" data-deptNo="dept001" style="font-size : 2.1em; font-weight : bold;">휴가/인사</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000" id="holi" style="font-size : 1.8em;">휴가기안서</span></li>
							</ul>
						</li>
						<li class=""><span class="folder" data-deptNo="dept001" style="font-size : 2.1em; font-weight : bold;">총무/회계</span>
							<ul id="folder21">
								<li><span class="file" data-empno="230000" id="card" style="font-size : 1.8em;">법인카드사용신청서</span></li>
							</ul>
						</li>
			</ul>
		</li>
	</ul>

<!-- 	<button id="add">추가</button> -->

</div>

<!-- 모달창  -->
 <div class="col-md-4" id="empModal">
    <!-- Button trigger modal -->
    <button type="button" class="btn bg-gradient-success btn-block mb-3" data-bs-toggle="modal" data-bs-target="#exampleModalMessage" style="display:none;">
      Message Modal
    </button>

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
