<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">
//새로고침 하는 함수
function refresh(){
	   location.reload();
	}

$(function(){
//  	$("#reply").on("click",function(){

//  		//가져오는법
//  		let sender = document.querySelector("th[name='sender']").innerText;//위와같음(jquery와 비슷)
//  		let sender = document.getElementsByName("sender")[0].innerText;//name은 여러개일 수 있으니 인덱스가 필수
//  		document.querySelector("th[name='sender']")//이름값 가져오기
//  		document.querySelectorAll(".sender")//클래스는 여러개니까 All붙여주기
//  		document.querySelector("#sender")//아이디값가져오기
//  		console.log("sender : " , sender);

//   		location.href="/note/reply";
//  	});
	$("#deliver").on("click",function(){
//  		$("#frm").attr("action", "/note/deliver");
//  		console.log($("#frm").attr("action"));
//  		$("#frm").submit();

		let msgNo = $(this).data("msgNo");
		let msgCn = $(this).data("msgCn");
		console.log("msgNo : " ,msgNo);
		console.log("msgCn : " ,msgCn);
		data={	"msgNo":msgNo,
				"msgCn":msgCn
			};
		console.log("data : " ,JSON.stringify(data));

		$.ajax({
			url:"/note/deliver",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(result){
            	console.log("result" , JSON.stringify(result));
            	let msgNo = result.msgNo;
            	console.log("msgNo" + msgNo);
            	let msgCn = result.msgCn;

            	location.href="/note/deliverNo?msgNo="+msgNo;
            }

            });
 	});

	$("#del").on("click",function(){
		let msgNo = $(this).data("msgNo");
		console.log("msgNo : " ,msgNo);
		data={"msgNo":msgNo};

		$.ajax({
			url:"/note/detailDelete",
			contentType:"application/json;charset:utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend : function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success:function(result){
            	if(result>0){
            		console.log("삭제성공");
            		swal({
						title: "쪽지가 삭제되었습니다.",
						icon: "success", //success, warning, error
						button: "확인",
					}).then(function () {
	            		location.href="/note/recieveList";
					});
            	}else{
            		swal({
						title: "쪽지가 삭제되지 않았습니다.",
						icon: "error", //success, warning, error
						button: "확인",
					});
            	}
            }
		});
 	});
  });
</script>

<!-- 전체게시판 목록 -->
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
			<div class="container-fluid py-4">
				<div class="row">
						<div class="dataTable-top mb-0">
						<a href="javascript:;" class="card-title h5 d-block text-darker">
							쪽지 상세</a>
						<p class="text-sm mb-0">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle"viewBox="0 0 16 16">
				  				<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
				  				<path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z" />
							</svg>
							받은 쪽지의 상세내용을 조회할 수 있습니다.
						</p>
						</div>
<!-- 						<form action="" name="frm" id="frm" method=""> -->
							<div class="row mx-0">
								<div class="col-9"></div>
								<div class="col-3 w-100 px-0" style="text-align:right;">
									<a href="/note/reply?msgNo=${data.msgNo}&sender=${data.sender}&empNoSndpty=${data.empNoSndpty}&empNoRcvr=${data.empNoRcvr}" class="btn btn-outline-dark btn-sm my-0"
											style="background-color:white;" >답장</a>
									<button type="button" class="btn btn-outline-dark btn-sm my-0" id="deliver" style="background-color:white;"
											data-msg-no="${data.msgNo}" data-msg-cn="${data.msgCn}">전달</button>
									<button type="button" class="btn btn-outline-danger btn-sm my-0" id="del" data-msg-no="${data.msgNo}" style="background-color:white;">삭제</button>
									<a href="/note/keep" class="btn btn-outline-dark btn-sm my-0" style="background-color:white;">목록</a>
								</div>
							</div>

							<div class="card-body pt-2">
								<div>
									<div class="author align-items-center"></div>
									<div class="row" style="padding: 10px;">
										<div class="col">
											<div class="card-body"></div>
											<div class="card">
												<div class="table-responsive mx-5 my-5 mt-3">
<!-- 													<form action="/note/detailDelete" name="frm" id="frm" method="post"> -->
														<input type="hidden" name="msgNo" value="${param.msgNo}">
														<input type="hidden" name="msgCn" value="${data.msgCn}">
														<div style="margin: 10px;">
																<table style="text-align: center; border : 1px solid #FFE08C; border-radius : 10px;" class="table align-items-center mb-0">
																<thead>
																	<tr>
																		<th style="background-color: #FAE58C;border-radius : 10px;" class="text-uppercase text-secondary text font-weight-bolder ">보낸사람</th>
																		<th class="text-uppercase text-secondary text font-weight-bolder  ps-2" name="sender">${data.sender}</th>
																		<th style="background-color: #FAE58C;border-radius : 10px;" class="text-uppercase text-secondary text font-weight-bolder ">보낸시간</th>
																		<th class="text-uppercase text-secondary text font-weight-bolder  ps-2">
																		<fmt:formatDate value="${data.msgDsptchDt}" pattern="yyyy-MM-dd HH:mm:ss"/>
																		</th>
																	</tr>
																</thead>
																<tbody>
																</tbody>
																</table>
															</div>
															<div style="border: 1px solid #FAE58C; border-radius : 10px; margin: 10px; height: 200px;">
																<div class="p-3" style="text-align: center">${data.msgCn}</div>
															</div>
															<sec:csrfInput />
												</div>
											</div>
											<div class="author align-items-center"></div>
										</div>
									</div>
								</div>
							</div>
<!-- 					</form> -->
				</div>
			</div>
		</div><!-- end for row의 2번째 부분 -->
	</div>
</div>
