<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

	<style type="text/css">
/* 		.card{  */
/* 			margin: 10px;  */
/* 			box-shadow: 5px 5px 5px gray;  */
/* 		}  */
		.delBtn {
			display: none;
		}
		.newCheckText { 
 			display: none; 
 		}
 		ul,li {margin:0; padding:0;}
	</style>
	
	<!-- 모달 시작 -->
			
		<div class="col-md-4">

    <!-- Modal -->
	    <form action="/Todo/createTodo" method="post" id="frm">
		    <div class="modal fade" id="newTodoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
		      <div class="modal-dialog modal-dialog-centered" role="document">
		        <div class="modal-content">
		          <div class="modal-header">
		            <h5 class="modal-title" id="exampleModalLabel">새 체크리스트 작성</h5>
		            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
		              <span aria-hidden="true">×</span>
		            </button>
		          </div>
		          <div class="modal-body">
		              <div class="form-group">
		                <label for="recipient-name" class="col-form-label">제목</label>
		                <input type="text" class="form-control" name="todoNm" value="새로운 할 일" placeholder="제목은 없어도 괜찮아요" id="recipient-name">
		              </div>
		              <div class="form-group">
		                <label for="message-text" class="col-form-label">처음 쓸 내용</label>
		                <textarea class="form-control" name="firChkCn" id="message-text" placeholder="메모할 내용을 써주세요"></textarea>
		              </div>
		          </div>
		          <div class="modal-footer">
		            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
		            <button type="button" id="FirstTodo" class="btn bg-gradient-warning">작성</button>
		          </div>
		        </div>
		      </div>
		    </div>
		    <sec:csrfInput/>
	    </form>
	    
	  </div>
	<!-- 모달 끝 -->
	
	<!-- 모달 2 시작 -->		
			
	<div class="col-md-4">
    <!-- Modal -->
    <div class="modal fade" id="updateTodoModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">제목 수정</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <input type="hidden" class="form-control" id="updateTodoNo">
                <input type="text" placeholder="제목은 없어도 괜찮아요" class="form-control" value="" id="updateTodoNm">
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn bg-gradient-warning" data-bs-toggle="modal" id="changeTodoBtn">확인</button>
          </div>
        </div>
      </div>
    </div>
  </div>
			
	<!-- 모달 2 끝 -->		
	
	<!-- 모달 3 시작 -->		
			
	<div class="col-md-4">
    <!-- Modal -->
    <div class="modal fade" id="updateCheckModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalMessageTitle" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">체크리스트 수정</h5>
            <button type="button" class="btn-close text-dark" data-bs-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">×</span>
            </button>
          </div>
          <div class="modal-body">
            <form>
              <div class="form-group">
                <input type="hidden" class="form-control" value="" id="updateCheckId">
                <input type="text" class="form-control" value="" id="updateCheckNm">
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn bg-gradient-secondary" data-bs-dismiss="modal">닫기</button>
            <button type="button" class="btn bg-gradient-warning" data-bs-toggle="modal" id="changeCheckBtn">확인</button>
          </div>
        </div>
      </div>
    </div>
  </div>
			
	<!-- 모달 3 끝 -->		
			
	

<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">

	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/myPageAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->
<!-- 상단에 들어가는 마이페이지 회원정보 시작 -->
	<jsp:include page="/WEB-INF/views/aside/myPageSection.jsp" />
<!-- 상단에 들어가는 마이페이지 회원정보 끝 -->			


	<div class="card card-body mt-4 mb-4" align="left">
					<div class="card-body pt-2 pb-2">
					<span class="text-gradient text-info text-uppercase text-xs font-weight-bold my-2">CheckList</span>
					<h3 class="mb-0 font-weight-bolder">체크리스트</h3>
						<div>
							<p class="explains mb-0">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-info-circle"
									viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
								  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105
								   1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275
								    0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
								</svg>
								내 할 일을 추가하고 체크리스트를 작성할 수 있습니다.
							</p>
						</div>
				</div>
				<!--------------------------- todo리스트----------------------------->
				<div class="row lg-4 mt-0 mb-0" id="2fa">
					<div class="card-body pt-0 pb-0" align="left">
						<div class="row">
	
	
	
	<!-- 카드 시작 -->
	<c:forEach items="${todoVOList}" var="TodoVO" varStatus="status">
		<div class="col-lg-4 col-md-6 mb-3 ${status.index}" style="float: left;" >
			<div class="card m-1" style="background-color: #bef6eb;">
				<div class="card-body p-3 pt-4">
					<div class="d-flex">
						<div class="ms-3 my-auto">
							<h4>${TodoVO.getTodoNm()}</h4>
							<div>
								<ul>
									<c:forEach items="${TodoVO.getChkVOList()}" var="chkVOList"  varStatus="status">
										<li class="deleteBtn ${status.index}">
											<label class="custom-control-label" for="customCheck1">
											<c:set var="check" value="${chkVOList.chkSsts}" />
											<c:if test="${check eq 'Y'}">
												<input class="form-check-input chkbtn" type="checkbox" value="" name="chk1" id="chkP_${chkVOList.chkNo}" checked>
											</c:if>
											<c:if test="${check eq 'N'}">
												<input class="form-check-input chkbtn" type="checkbox" value="" name="chk1" id="chkP_${chkVOList.chkNo}">
											</c:if>
												<span class="text h6" data-bs-toggle="modal" data-bs-target="#updateCheckModal">${chkVOList.chkCn}</span> 
											</label>
											<button type="button" value="${chkVOList.chkNo}" class="btn-close text-dark deleteChk">
								              <span aria-hidden="true" class="delBtn">×</span>
								            </button>
										</li>
									</c:forEach>
	
								</ul>
							</div>
	
						</div>
						<div class="ms-auto">
							<div class="dropdown">
								<button class="btn btn-link text-secondary ps-0 pe-2"
									id="navbarDropdownMenuLink3" data-bs-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false">
									<i class="fa fa-ellipsis-v text-lg" aria-hidden="true"></i>
								</button>
								<div class="dropdown-menu dropdown-menu-end me-sm-n4 me-n3"
									aria-labelledby="navbarDropdownMenuLink3">
									<button class="dropdown-item updateTodo" data-bs-toggle="modal" 
									data-bs-target="#updateTodoModal" value="${TodoVO.getTodoNo()}">제목 수정</button> 
									<button class="dropdown-item deletTodo" value="${TodoVO.getTodoNo()}">체크리스트 삭제</button> 
								</div>
							</div>
						</div>
					</div>
					<hr class="horizontal dark">
					<div align="center" class="createChk">
							<input type="hidden" value="${TodoVO.getTodoNo()}" name="todoNo">
							<input type="text" class="newCheckText form-control" name="chk" onkeypress="createChk(event)"/>
							<br>
						<span class=" text-secondary createNewCheck"> 
						<i class="fa fa-plus text-secondary mb-3" aria-hidden="true">
						</i> 새 체크리스트 추가
						</span>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
	<!-- 카드 끝 -->
	
	<!-- 새 할일 추가 -->
							<div class="col-lg-4 col-md-6 mb-3">
								<div class="m-1">
									<div class="card" style="background-color: lightgray;">
										<div
											class="card-body d-flex flex-column justify-content-center text-center"
											 id="newTodoModalOpen" data-bs-toggle="modal" data-bs-target="#newTodoModal">
											<a href="javascript:;"> <i
												class="fa fa-plus text-secondary mb-3" aria-hidden="true"></i>
												<h5 class="text-secondary">새 할일</h5>
											</a>
										</div>
									</div>
								</div>
							</div>
	<!-- 새 할일 추가 -->
	
						</div>
					</div>
				</div>
				<!--------------------------- todo리스트 끝----------------------------->
			
			</div>
				<!--------------------------- 전체 감싸는 틀 끝 ----------------------------->
		</div><!-- end for row의 2번째 부분 -->
	</div>
</div>

<!-------------------------- 전체 감싸는 사이드바 끝 --------------------------->
	<script src="/resources/js/jquery-3.6.0.js"></script>	
    <script type="text/javascript">
    
		// 새 체크리스트 추가
        function createChk(e){
        	  var currentInput = event.target;
        	  var inputValue = currentInput.value;
        	  var code = e.code;
       		  // 이벤트가 발생한 input 요소의 상위 요소인 div.card-body 찾기
       		  var cardBody = $(event.target).closest('.card-body');
       		  // cardBody 내에서 name="todoNo"를 가진 input 찾아 값 가져오기
       		  var todoNo = cardBody.find('input[name="todoNo"]').val();
				
       		var eventData = {
      			todoNo:todoNo,
      			chkCn:inputValue
       		}
       		 
       	//엔터 치는 순간 아래 함수 실행 (새 체크리스트 저장 후 페이지 리셋)
           if(code == 'Enter'){
        		console.log(inputValue);
                if (inputValue === '') {
                    alert('내용은 뭐라도 써주세요...')
                    return;
                }
        		console.log(todoNo);
        		console.log(eventData);
        		
    			$.ajax({
    			    url: "/Todo/createChk",
    			    contentType:"application/json;charset:utf-8",
    			    data:JSON.stringify(eventData),
    			    type:"post",
    	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    				},
    			    success: function(response) {
    			    	$("#2fa").load("/Todo/main #2fa", function(){
	     			    	chkbtnTextDecoration();
    			    	});
    			    }
    			});
        		
           }
        };
		
        //입력창 전체 숨김
        function hideToggle() {
        	$(".createNewCheck").prev().prev().hide();
        }
        
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
        
        $(function() {
        	
        	    $("#FirstTodo").click(function() {
        	        var result = $.trim($("#message-text").val());
        	        if (result==='') {
        	          alert("내용은 뭐라도 써주세요...");
        	          return;
        	        }
        	          document.getElementById('frm').submit();
        	    })
        	
        	//체크리스트 추가 눌렀을 때 입력창 보임
        	$(document).on("click", ".createNewCheck", function(e){
        		e.preventDefault();
        		e.stopPropagation();
        		hideToggle();
        		$(this).prev().prev().val("");
        		var NewCheck = $(this).prev().prev().show();
        	});
        	
        	// 문서 어디든 클릭할 때 열린 입력창 다시 숨김
        	$(document).click(function(event) {
        	  // 클릭한 요소가 span 요소가 아니면 보이는 요소를 숨김
        	  if (!$(event.target).hasClass("newCheckText")){
        	    $(".createNewCheck").prev().prev().hide();
        	  }
        	});
        	
        	chkbtnTextDecoration();
        	
        	//체크리스트 수정
        	$(document).on("click", ".text", function(){
        		var chktext = $(this).text();
        		var chkbtnId = $(this).closest('li').find('.deleteChk').val();
        		$("#updateCheckNm").val(chktext);
        		$("#updateCheckId").val(chkbtnId);
        	});
        	
        	//모달 확인버튼 클릭 시 체크리스트 업데이트
        	$(document).on("click", "#changeCheckBtn", function(){
        		var chkNm = $("#updateCheckNm").val();
        		var chkId = $("#updateCheckId").val();
                if (chkNm === '' ||chkNm == null) {
                    alert('내용은 뭐라도 써주세요...')
                    return;
                }
        		var data = {
					chkNo : chkId,
					chkCn : chkNm
        		};
    			$.ajax({
    			    url: "/Todo/updateChk",
    			    contentType:"application/json;charset:utf-8",
    			    data:JSON.stringify(data),
    			    type:"post",
    	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    				},
    			    success: function(response) {
    			    	$("#2fa").load("/Todo/main #2fa", function(){
	     			    	chkbtnTextDecoration();
    			    	});
    			    }
    			});
        	});
        	
        	
        	//체크버튼 클릭 시 업데이트
        	$(document).on("click", ".chkbtn",function() {
        		var chkbtnMy = '';
        		 var chkbtnId = $(this).parent().parent().find('.deleteChk').val();
				   console.log("체크버튼 클릭...", chkbtnId);
				   
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
				   console.log(data);
				   
				let chkId = $(this).attr("id");
				console.log("chkId : " + chkId);
				chkId = chkId.replace("chkP_","");
				console.log("chkId : " + chkId);
				
				console.log("부모 : " + $("#chkP_"+chkId).prop("checked"));
				console.log("헤더 : " + $("#chk_"+chkId).prop("checked"));
				
				//부모의 체크 여부와 헤더의 체크 여부를 동기화 시킴
				$("#chk_"+chkId).prop("checked",$("#chkP_"+chkId).prop("checked"));
				
    			$.ajax({
    			    url: "/Todo/updateChkYN",
    			    contentType:"application/json;charset:utf-8",
    			    data:JSON.stringify(data),
    			    type:"post",
    	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    				},
    			    success: function(response) {
    			    	$("#2fa").load("/Todo/main #2fa", function(){
    			    	  	$("#chkContainer").load("/tiles/header #chkContainer", function(){
    			 			    chkbtnTextDecoration();
    			    		});
    			    	});
    			    	
    			    }
    			});
				
        	});
        	
        	//버튼 위에 마우스 있을때만 x버튼 보임
        	$(document).on("mouseover", ".deleteBtn", function(){
        		$(this).find(".delBtn").show();
        	});
        	$(document).on("mouseout", ".deleteBtn", function(){
        		$(this).find(".delBtn").hide();
        	});
        	
        	//체크리스트 삭제버튼 클릭 시 해당 체크리스트 삭제
        	$(document).on("click", ".deleteChk", function(){
        		console.log(this.value);
        		var data ={
        			chkNo:this.value	
        		}
        		
    			$.ajax({
    			    url: "/Todo/deleteChk",
    			    contentType:"application/json;charset:utf-8",
    			    data:JSON.stringify(data),
    			    type:"post",
    	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    				},
    			    success: function(response) {
    			    	$("#2fa").load("/Todo/main #2fa", function(){
	     			    	chkbtnTextDecoration();
    			    	});
    			    }
    			});
            	
            });
            
        	//할일 삭제
        	$(document).on("click", ".deletTodo", function(){
        		console.log(this.value);
        		var data ={
        			todoNo:this.value	
        		}
        		
    			$.ajax({
    			    url: "/Todo/deleteTodo",
    			    contentType:"application/json;charset:utf-8",
    			    data:JSON.stringify(data),
    			    type:"post",
    	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    				},
    			    success: function(response) {
    			    	$("#2fa").load("/Todo/main #2fa", function(){
	     			    	chkbtnTextDecoration();
    			    	});
    			    }
    			});
            	
            });
            
            // Todo 업데이트 버튼 클릭
            $(document).on('click', '.updateTodo', function(){
                var myTodoNm = $(this).parents('.d-flex').find('h6').text(); // 부모 요소 찾기 + 하위 요소의 값을 가져오기
        		$("#updateTodoNo").val(this.value);
        		$("#updateTodoNm").val(myTodoNm);
        		console.log("myTodoNm", myTodoNm)
            });
            
            //Todo 업데이트 실행
            $("#changeTodoBtn").click(function(){
        		var todoNo = $("#updateTodoNo").val();
        		var todoNm = $("#updateTodoNm").val();
        		
        		var data ={
        			todoNo:todoNo,
        			todoNm:todoNm
        		};
        		
        		console.log(data);
            	
    			$.ajax({
    			    url: "/Todo/updateTodo",
    			    contentType:"application/json;charset:utf-8",
    			    data:JSON.stringify(data),
    			    type:"post",
    	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
    					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    				},
    			    success: function(response) {
    			    	$("#2fa").load("/Todo/main #2fa", function(){
	     			    	chkbtnTextDecoration();
    			    	});
    			    }
    			});
            	
            });
            
      });

    </script>
