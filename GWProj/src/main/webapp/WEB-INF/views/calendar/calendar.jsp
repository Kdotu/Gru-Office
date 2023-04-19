<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>FullCalendar Example</title>
	<script src="/resources/js/jquery-3.6.0.js"></script>
    <link rel=" shortcut icon" href="/resources/FullCalendar/WebContent/image/favicon.ico">

    <link rel="stylesheet" href="/resources/FullCalendar/WebContent/vendor/css/fullcalendar.min.css" />
    <link rel="stylesheet" href="/resources/FullCalendar/WebContent/vendor/css/bootstrap.min.css">
    <link rel="stylesheet" href='/resources/FullCalendar/WebContent/vendor/css/select2.min.css' />
    <link rel="stylesheet" href='/resources/FullCalendar/WebContent/vendor/css/bootstrap-datetimepicker.min.css' />

    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

    <link rel="stylesheet" href="/resources/FullCalendar/WebContent/css/main.css">

	<style> 
	.fc-sun {
	  background-color: #FCEBEB;
	}
	.fc-sat {
	  background-color: #E4F0FA;
	}
	.fc-widget-header {
	 background-color: white;
	}
	.select2-container--default .select2-selection--multiple{
	 width: 150px;
	 min-width: 150px;
	}
	.caldiv{
		width: 100%;
	}
	.fc-title{
		font-size: 18px;
	}
	
	</style>
	
	<!-- authorize 부분 시작. 중요! -->	
	<sec:authorize access="isAuthenticated()">
	<!-- CustomUser.java에서 private EmpVO empVO() 멤버변수를 principal 객체를 통해 사용 가능 -->
	<sec:authentication property="principal.empVO" var="empVO" />
	
    <input  id="userno" name="userno" type="hidden" value="${empVO.empNo}">
    <input  id="username"  name="username" type="hidden" value="${empVO.empNm}">
    
	<input type="hidden" id="csrfHeaderName" value="${_csrf.headerName}">
	<input type="hidden" id="csrfToken" value="${_csrf.token}">
	
	<!-- 일자 클릭시 메뉴오픈 -->
        <div id="contextMenu" class="dropdown clearfix">
            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
                style="display:block;position:static;margin-bottom:5px;">
                <li><a tabindex="-1" href="#">업무관련</a></li>
                <li><a tabindex="-1" href="#">개인일정</a></li>
                <li><a tabindex="-1" href="#">개발일정</a></li>
                <li><a tabindex="-1" href="#">개발계획</a></li>
                <li><a tabindex="-1" href="#">기타일정</a></li>
                <li class="divider"></li>
                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
            </ul>
        </div>
	<!-- 일자 클릭시 메뉴오픈 -->
        
	<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2" style="margin-top:80px;">
			<!-- aside 시작 -->
			   <div class="panel panel-default">
		
		            <div class="panel-heading">
		                <h3 class="" style="margin-bottom: 0px; margin-top: 0px;">필터</h3>
		            </div>
		
		            <div class="panel-body" style="margin-left:10px;">
		                <div class="row" style="padding:5px;margin-bottom:10px;">
		                    <h4><label for="calendar_view">카테고리 별</label></h4>
		                    <div class="input-group">
		                        <select class="filter" id="type_filter" multiple="multiple" style="min-width: 200px;">
									<option value="업무관련">업무관련</option>
									<option value="개인일정">개인일정</option>
									<option value="개발일정">개발일정</option>
									<option value="개발계획">개발계획</option>
									<option value="기타일정">기타일정</option>
									<option value="공통일정">공통일정</option>
		                        </select>
		                    </div>
		                </div>
		
		                <div class="row" style="padding:5px;">
		                    <h4><label for="calendar_view">등록구분 별</label></h4>
		                    <div class="input-group">
		                    	<label class="checkbox-inline"><input class='filter' type="checkbox" value="true" checked>공개 일정</label>
		                    	<label class="checkbox-inline" style="margin-left: 0;"><input class='filter' type="checkbox" value="false" checked>비공개 일정</label>
		                    </div>
		                </div>
		            </div>
		        </div>
		        <!-- aside 끝 -->
			</div>
		<div class="col-lg-10 mt-lg-0 mt-4 mb-4">
    <div class="container caldiv">
    <div class="row">
	<!-- 주로 쓰는 정보 모음 -->
        
        
        <div class="col">
    	

        <div id="wrapper">
            <div id="loading"></div>
            <div id="calendar"></div>
        </div>


        <!-- 일정 추가 MODAL -->
        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <div class="col-xs-12">
                                <input class='inputModal' id="edit-userno" name="edit-userno" type="hidden" value="${empVO.empNo}">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-xs-12">
                                <input class='inputModal' id="edit-username"  name="edit-username" type="hidden" value="${empVO.empNm}">
                            </div>
                        </div>

						<!-- <input class="calOpenNewEvent" id="edit-calOpen" type="checkbox"> -->
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-calOpen">공개여부</label>
                                <input class='calOpenNewEvent' id="edit-calOpen" type="checkbox"></label>
                            </div>
                        </div>
                        
                        <!-- <input class="allDayNewEvent" id="edit-allDay" type="checkbox"> -->
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-allDay">하루종일</label>
                                <input class='allDayNewEvent' id="edit-allDay" type="checkbox"></label>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">일정명</label>
                                <input class="inputModal" type="text" name="edit-title" id="edit-title"
                                    required="required" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start">시작</label>
                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-end">끝</label>
                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-type">구분</label>
                                <select class="inputModal" type="text" name="edit-type" id="edit-type">
                                    <option value="업무관련">업무관련</option>
                                    <option value="개인일정">개인일정</option>
                                    <option value="개발일정">개발일정</option>
                                    <option value="개발계획">개발계획</option>
                                    <option value="기타일정">기타일정</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-color">색상</label>
                                <select class="inputModal" name="color" id="edit-color">
                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
                                    <option value="#495057" style="color:#495057;">검정색</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-place">장소</label>
                                <input type="text" class="inputModal" name="edit-place" id="edit-place"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">설명</label>
                                <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
                                    id="edit-desc"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
			</div>
			</div>
		</div><!-- end row -->
        <!-- /.filter panel -->
    </div>
    <!-- /.container -->
		</div>
		</div>
</sec:authorize>
<!-- authorize 부분 끝. 중요! -->	
    <script src="/resources/FullCalendar/WebContent/vendor/js/jquery.min.js"></script>
    <script src="/resources/FullCalendar/WebContent/vendor/js/moment.min.js"></script>
    <script src="/resources/FullCalendar/WebContent/vendor/js/fullcalendar.min.js"></script>
    <script src="/resources/FullCalendar/WebContent/vendor/js/ko.js"></script>
    <script src="/resources/FullCalendar/WebContent/vendor/js/select2.min.js"></script>
    <script src="/resources/FullCalendar/WebContent/vendor/js/bootstrap-datetimepicker.min.js"></script>
    <script src="/resources/FullCalendar/WebContent/js/main.js"></script>
    <script src="/resources/FullCalendar/WebContent/js/addEvent.js"></script>
    <script src="/resources/FullCalendar/WebContent/js/editEvent.js"></script>
    <script src="/resources/FullCalendar/WebContent/js/etcSetting.js"></script>
    <script src="/resources/FullCalendar/WebContent/vendor/js/bootstrap.min.js"></script>


<!-- 부득이 추가한 스크립트 부분. 일정저장 관련으로 매우 중요! 나중에 수정할 수도 있음 --> 

    <script type="text/javascript">
	    function gogo(eventData){
	    	//새로운 일정 저장
			$.ajax({
			    url: "/cal/createCalender",
			    contentType:"application/json;charset:utf-8",
			    data:JSON.stringify(eventData),
			    type:"post",
	   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
			    success: function (response) {
			       $('#calendar').fullCalendar('removeEvents');
			       $('#calendar').fullCalendar('refetchEvents');
			    }
			});
	    }
    </script>
    <!-- 캘린더 내 버튼 스타일 설정 -->
    <script>
    $("button[type=button]").addClass("btn btn-default");
    $("input[type=search]").removeAttr("style");
    $(".select2").removeAttr("style");
    $(".select2-selection").removeAttr("style");
    $(".select2-search__field").removeAttr("style");
    </script>