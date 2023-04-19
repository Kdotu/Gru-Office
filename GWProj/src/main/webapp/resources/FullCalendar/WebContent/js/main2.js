var draggedEventIsAllDay;
var activeInactiveWeekends = true;
var calendar = $('#calendar').fullCalendar({

 /** ******************
   *  OPTIONS
   * *******************/
  locale                    : 'ko',    
  timezone                  : "local", 
  nextDayThreshold          : "09:00:00",
  allDaySlot                : true,
  displayEventTime          : true,
  displayEventEnd           : true,
  firstDay                  : 0, //월요일이 먼저 오게 하려면 1
  weekNumbers               : false,
  selectable                : true,
  weekNumberCalculation     : "ISO",
  eventLimit                : true,
  views                     : { 
                                month : { eventLimit : 12 } // 한 날짜에 최대 이벤트 12개, 나머지는 + 처리됨
                              },
  eventLimitClick           : 'week', //popover
  navLinks                  : true,
  defaultDate               : new Date(), // 현재 날짜로 설정
  timeFormat                : 'HH:mm',
  defaultTimedEventDuration : '01:00:00',
  editable                  : false,
  minTime                   : '00:00:00',
  maxTime                   : '24:00:00',
  slotLabelFormat           : 'HH:mm',
  weekends                  : true,
  nowIndicator              : true,
  dayPopoverFormat          : 'MM/DD dddd',
  longPressDelay            : 0,
  eventLongPressDelay       : 0,
  selectLongPressDelay      : 0,  
  header                    : {
                                left   : 'today, prevYear, nextYear, viewWeekends',
                                center : 'month, agendaWeek, agendaDay, listWeek',
                                right  : 'prev, title, next'
                              },
  views                     : {
                                month : {
                                  columnFormat : 'dddd'
                                },
                                agendaWeek : {
                                  columnFormat : 'M/D ddd',
                                  titleFormat  : 'YYYY년 M월 D일',
                                  eventLimit   : false
                                },
                                agendaDay : {
                                  columnFormat : 'dddd',
                                  eventLimit   : false
                                },
                                listWeek : {
                                  columnFormat : ''
                                }
                              },
  customButtons             : { //주말 숨기기 & 보이기 버튼
                                viewWeekends : {
                                  text  : '주말',
                                  click : function () {
                                    activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
                                    $('#calendar').fullCalendar('option', { 
                                      weekends: activeInactiveWeekends
                                    });
                                  }
                                }
                               },


  eventRender: function (event, element, view) {

    //일정에 hover시 요약
    element.popover({
      title: $('<div />', {
        class: 'popoverTitleCalendar',
        text: event.title
      }).css({
        'background': event.backgroundColor,
        'color': event.textColor
      }),
      content: $('<div />', {
          class: 'popoverInfoCalendar'
        }).append('<p><strong>등록자:</strong> ' + event.username + '</p>')
        .append('<p><strong>구분:</strong> ' + event.type + '</p>')
        .append('<p><strong>장소:</strong> ' + event.place + '</p>')
        .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
        .append('<div class="popoverDescCalendar"><strong>설명:</strong> ' + event.description + '</div>'),
      delay: {
        show: "800",
        hide: "50"
      },
      trigger: 'hover',
      placement: 'top',
      html: true,
      container: 'body'
    });

    return filtering(event);

  },

  /* ****************
   *  일정 받아옴 
   * ************** */
  events: function (start, end, timezone, callback) {
	var empNo = $('#myEmpNo').val();
	
  	var data = {
  		empNo:empNo
  	}
  	console.log("내거야", data);
  	
    $.ajax({
	  	url: "/cal/getCal2",
	  	contentType:"application/json;charset:utf-8",
	  	data:data,
      	type: "get",
		beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader($("#csrfHeaderName").val(), $("#csrfToken").val());
		},
      	success: function (response) {
       		console.log("response 변경전", response);
        	var fixedDate = response.map(function (array) {
          	array.allDay = eval(array.allDay);
          	array.calOpen = eval(array.calOpen);
<!--           if (array.allDay && array.start !== array.end) { -->
<!--             array.end = moment(array.end).add(1, 'days'); // 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상출력 -->
<!--           } -->
          	return array;
        	});
        console.log("response 변경후", response);
        callback(fixedDate);
      },
      dataType:'json'
    });
  },

  eventAfterAllRender: function (view) {
    if (view.name == "month") $(".fc-content").css('height', 'auto');
  }

});

function getDisplayEventDate(event) {

  var displayEventDate;

  if (event.allDay == false) {
    var startTimeEventInfo = moment(event.start).format('HH:mm');
    var endTimeEventInfo = moment(event.end).format('HH:mm');
    displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;
  } else {
    displayEventDate = "하루종일";
  }

  return displayEventDate;
}

function filtering(event) {
  var show_username = true;
  var show_type = true;

  var username = $('input:checkbox.filter:checked').map(function () {
    return $(this).val();
  }).get();
  var types = $('#type_filter').val();

  show_username = username.indexOf(event.username) >= 0;

  if (types && types.length > 0) {
    if (types[0] == "all") {
      show_type = true;
    } else {
      show_type = types.indexOf(event.type) >= 0;
    }
  }

  return show_username && show_type;
}
