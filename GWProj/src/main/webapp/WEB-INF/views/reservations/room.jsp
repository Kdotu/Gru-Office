<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 2번째 사이드바 (최하단에서 div 2번 닫아주면 됩니다) -->
<div class="container-fluid my-3 py-3 mx-0 px-0">
	<div class="row mb-5">
		<div class="col-lg-2">
			<jsp:include page="/WEB-INF/views/aside/reserveAside.jsp" />
		</div>
		<div class="col-lg-9 mt-lg-0 mt-4 mb-4">
<!-- 2번째 사이드바 -->
			<div class="row">
				<div class="col">

					<div class="card" id="datepicker">
						<div class="card-body pt-2">
							<span
								class="text-gradient text-primary text-uppercase text-xs font-weight-bold my-2">Room</span>
							<a href="javascript:;" class="card-title h5 d-block text-darker">
								회의실 예약 </a>
							<p class="card-description mb-4">Use border utilities to
								quickly style the border and border-radius of an element. Great
								for images, buttons.</p>
													<!-- 캘린더 시작 -->
					
			  		<!-- calendar 태그 -->
					  <div id='calendar-container'>
					    <div id='calendar'></div>
					  </div>
						<script type="text/javascript" defer="defer">
						    $(function(){
						   
						      // calendar element 취득
						      var calendarEl = $('#calendar')[0];
						      // full-calendar 생성하기
						      var calendar = new FullCalendar.Calendar(calendarEl, {
						    	allDaySlot : false,
						        height: '700px', // calendar 높이 설정
						        expandRows: true, // 화면에 맞게 높이 재설정
						        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
						        slotMaxTime: '20:00', // Day 캘린더에서 종료 시간
						        // 해더에 표시할 툴바
						        headerToolbar: {
						          left: 'prev',
						          center: 'title',
						          right: 'next'
						        },
						        initialView: 'timeGridWeek', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
						//         initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
						        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
						        editable: true, // 수정 가능?
						        selectable: true, // 달력 일자 드래그 설정가능
						        nowIndicator: true, // 현재 시간 마크
						        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
						        locale: 'ko', // 한국어 설정
						        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
						          console.log(obj.event.title);
						        },
						        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
						          console.log(obj);
						        },
						        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
						          console.log('삭제됨 '+obj);
						        },
						        select: function(arg) { // 캘린더에서 드래그로 이벤트를 생성할 수 있다.
						          var title = prompt('Event Title:');
						          if (title) {
						            calendar.addEvent({
						              title: title,
						              start: arg.start,
						              end: arg.end,
						              allDay: arg.allDay
						            })
						          }
						          calendar.unselect()
						        },
						        eventClick: function(obj){
						           if(confirm(obj.event.title + ' 삭제?')){
						              obj.event.remove();
						           }
						        },
						        // 이벤트 
						        events:[],
						        groupByResource: true
						        
						      });
						
						      // 캘린더 랜더링
						      calendar.render();
						    });
						    
						</script>
								
						<!-- 캘린더 끝 -->
								
							<div class="author align-items-center"></div>
						</div>
					</div>
					
					
				</div>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
$( function() {
    $( "#datepicker" ).datepicker({ 
        onSelect: function() { 
            var date = $.datepicker.formatDate("yymmdd",$("#datepicker").datepicker("getDate")); 
            alert(date);
        }
    });                    
});

</script>