<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.s{
	font-size: 1.4em;
	color: #5C67F5;
	font-weight: bold;
}

.d{
	margin-left: 10px;
	margin-right: 15px;
}

.nl:hover {
	background: #FAE58C;
}

.img {
	filter: opacity(0.5) drop-shadow(0 0 0 #5C67F5);
}

ul{
   list-style:none;
   }
   

   
</style>


<!-- 조직도 스크립트 -->
<!-- 조직도 스크립트 css만 주석처리하면 우리 부트스트랩 css랑 충돌안남 -->
<!--  <link rel="stylesheet" href="/resources/css/jquery.treeview.css" />  -->
<!--  	<link rel="stylesheet" href="/resources/css/screen.css" />  -->
	
	
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

<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3 ps " id="sidenav-main" style="background: white;">
<div class="sidenav-header" style="height: 200px; text-align: center;">
<i class="fas fa-times p-3 cursor-pointer text-secondary opacity-5 position-absolute end-0 top-0 d-none d-xl-none" aria-hidden="true" id="iconSidenav"></i>
<a class="navbar-brand m-0" href="#" target="_blank">
<div style="height:100px;">
<img class="img" src="/resources/image/logo6.png" alt="main_logo" style="width: 70%; height: 100%; margin-top: 17px;">
</div>
<div style="height:50px; margin-top: 25px;">
<span class="ms-1 font-weight-bolder s" style="font-size: 2.0em;">Gru<span style="font-size: 1.0em; font-weight: normal;">Office</span></span>
</div>
</a>

</div>

<hr class="horizontal dark mt-0">
<div class="collapse navbar-collapse  w-auto h-auto" id="sidenav-collapse-main">
<ul class="navbar-nav">
<li class="nav-item">

<li class="nav-item">

<a href="/main" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/home1.png" style="width: 25px;">
</div>
<span class="nav-link-text lg-1 s" >홈</span>
</a>

<a href="/mail/recieveList" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/mail.png" style="width: 25px;">
</div>
<span class="nav-link-text lg-1 s" >메일</span>
</a>

<a href="/address/list" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/phn.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s">주소록</span>
</a>

<a href="/cal/calendar" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/cal.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s">일정</span>
</a>

<a href="/work/workList" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/bag.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s">근태</span>
</a>

<a href="/projects/projList" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/works.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s">Works</span>
</a>

<a href="/edoc/main" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/sign.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s">전자결재</span>
</a>

<a href="/board/main" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/board.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s">게시판/설문조사</span>
</a>



<a href="/archive/main" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/cloud.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s">자료실</span>
</a>

<a href="/reserve/main" class="nav-link nl" role="button" aria-expanded="false">
<div class="d" >
<img class="img" alt="" src="/resources/maincss/assets/img/res.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s">예약관리</span>
</a>

<a href="#" class="nav-link nl" role="button" aria-expanded="false" style="position: absolute; bottom: 30px; border: 1px solid #5C67F5; width: 85%; border-radius: 10px;"
data-bs-toggle="modal" data-bs-target="#exampleModalMessage">
<div style="margin-right: 20px;">
<img class="img" alt="" src="/resources/maincss/assets/img/org.png" style="width: 25px;">
</div>
<span class="nav-link-text ms-1 s" style="color: #5C67F5">조직도</span>
</a>

</aside>

<!-- 조직도 모달창  -->
    <!-- Modal -->
    <div class="modal fade" id="exampleModalMessage" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">조직도</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div id="main">

<div class="input-group mb-3">
  <input type="text" id="search" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">
  <button class="btn btn-outline-primary mb-0" type="button" id="searchBtn">검색</button>
</div>
	
	<div id="orgList">
	<ul id="browser" class="filetree treeview-famfamfam" >
		<li><img src="/resources/image/folder.gif"><span class="folder">그루IT</span>
			<ul id="folder21" class="adminEmp">
			</ul>
			<ul>
				<li class="closed"><img src="/resources/image/folder.gif"><span class="folder">경영지원본부</span>
					<ul>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT003">재무팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT004">인사팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT005">총무팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed"><img src="/resources/image/folder.gif"><span class="folder">영업본부</span>
					<ul>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT011">영업팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT012">마케팅팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT013">CS팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
				<li class="closed"><img src="/resources/image/folder.gif"><span class="folder">개발본부</span>
					<ul>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT007">서비스개발팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT008">플랫폼운영팀</span>
							<ul id="folder21">
							</ul>
						</li>
						<li class="closed empList"><img src="/resources/image/folder.gif"><span class="folder" data-deptno="DEPT009">디자인팀</span>
							<ul id="folder21">
							</ul>
						</li>
					</ul>
				</li>
			</ul>
		</li>
	</ul>
	</div>

<!-- 	<button id="add">추가</button> -->

</div>
        </div>
      </div>
    </div>
  </div>
  <!-- 모달창 끝 -->

  
<script>
$(function(){
	
	  
	//회사 바로 밑에 대표/이사 사원 출력 
		$.ajax({
			url:"/org/orgAdminEmp",
			type:"post",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				//result : List<empVO> empVOList
				let str = "";
				console.log(result);
				
					
				$.each(result,function(i,v){
					str+= "<li><img src='/resources/image/file.gif'><a class='file' data-empno='"+v.empNo+"' data-bs-toggle='modal' data-bs-target='#exampleModalMessage'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
				});
				
				$(".adminEmp").append(str);
			}
		});
	
	//.empList를 선택하면 (this) 아작스 호출해서 해당 태그 자식에 요소 append 
		$('.empList').on('click',function(){
			
			//부서 번호 변수에 담기 
			let deptNo = $(this).children('span').data('deptno'); 
			
			let data = {"deptNo" : deptNo};
			
			$.ajax({
				url:"/org/orgEmp",
				type:"post",
				data: JSON.stringify(data),
				contentType:"application/json;charset=utf-8",
				beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
	                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					//result : List<empVO> empVOList
					let str = "";
					console.log(result);
					
					$.each(result,function(i,v){
						str+= "<li><img src='/resources/image/file.gif'><a class='file' data-empno='"+v.empNo+"' data-bs-toggle='modal' data-bs-target='#exampleModalMessage'>"+v.empNm+" "+v.jbpsNm+"</a></li>"
					});
					
					
//	 				console.log("str : " + str);
					//.html() : 새로고침 / .append() : 누적
					
					console.log($(this));
					
					$(this).children('ul').append(str);
				}
			});
			
			
			
		})
	
	
	
})
</script>

