/* ****************
 *  일정 편집
 * ************** */
var editEvent = function (event, element, view) {

    eventId = $('#deleteEvent').data('_id', event._id); //클릭한 이벤트 ID

    $('.popover.fade.top').remove();
    $(element).popover("hide");

    if (event.allDay === true) {
        editAllDay.prop('checked', true);
    } else {
        editAllDay.prop('checked', false);
    }

    if (event.end === null) {
        event.end = event.start;
    }

    if (event.allDay === true && event.end !== event.start) {
        editEnd.val(moment(event.end).subtract(1, 'days').format('YYYY-MM-DD HH:mm'))
    } else {
        editEnd.val(event.end.format('YYYY-MM-DD HH:mm'));
    }

    modalTitle.html('일정 수정');
    
    if (event.calOpen === true) {
        editCalopen.prop('checked', true);
    } else {
        editCalopen.prop('checked', false);
    }
    
    editUserno.val(event.userno);
    editUsername.val(event.username);
    
    editTitle.val(event.title);
    editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
    
    editType.val(event.type);
    editColor.val(event.backgroundColor).css('color', event.backgroundColor);
	editPlace.val(event.place);
    editDesc.val(event.description);
	
    addBtnContainer.hide();
    modifyBtnContainer.show();
    eventModal.modal('show');

    //업데이트 버튼 클릭시
    $('#updateEvent').unbind();
    $('#updateEvent').on('click', function () {
		//<input class="calOpenNewEvent" id="edit-calOpen" type="checkbox">
		//<input class="allDayNewEvent" id="edit-allDay" type="checkbox">
        if (editStart.val() > editEnd.val()) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (editTitle.val() === '') {
            alert('일정명은 필수입니다.')
            return false;
        }

        var statusAllDay;
		var statusCalOpen;
        var startDate;
        var endDate;
        var displayDate;
        if (editAllDay.is(':checked')) {
            statusAllDay = true;
            startDate = moment(editStart.val()).format('YYYY-MM-DD');
            endDate = moment(editEnd.val()).format('YYYY-MM-DD');
            displayDate = moment(editEnd.val()).add(1, 'days').format('YYYY-MM-DD');
        } else {
        	if (editStart.val() == editEnd.val()) {
	            alert('끝나는 날짜와 시간이 모두 같을 수 없습니다.');
	            return false;
	        }
            statusAllDay = false;
            startDate = editStart.val();
            endDate = editEnd.val();
            displayDate = endDate;
        }
        
        if (editCalopen.is(':checked')) {
        	statusCalOpen ='true';
        } else {
        	statusCalOpen ='false';
	    }

        eventModal.modal('hide');

		event.userno = editUserno.val();
		event.username = editUsername.val();
        event.calOpen = statusCalOpen;
        event.allDay = statusAllDay;
        event.title = editTitle.val();
        event.start = startDate;
        event.end = displayDate;
        event.type = editType.val();
        event.backgroundColor = editColor.val();
        event.place = editPlace.val();
        event.description = editDesc.val();
        $("#calendar").fullCalendar('updateEvent', event);
        
		console.log(event.id);
		console.log(eventId.data());
		
        var eventData = {
			_id: eventId.data()._id,
            username: event.username,
            calOpen: event.calOpen,
            allDay: event.allDay,
            title: event.title,
            start: event.start,
            end: event.end,
            type: event.type,
            backgroundColor: event.backgroundColor,
            textColor: '#ffffff',
            place: event.place,
            description: event.description
        };

		console.log("eventData ==> " + JSON.stringify(eventData));
		
        //일정 업데이트
		$.ajax({
		    url: "/cal/updateCalender",
		    contentType:"application/json; charset:utf-8",
		    data:JSON.stringify(eventData),
		    type:"post",
   			beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
				xhr.setRequestHeader($("#csrfHeaderName").val(), $("#csrfToken").val());
			},
		    success: function (response) {
		        $('#calendar').fullCalendar('removeEvents');
		    	$('#calendar').fullCalendar('refetchEvents');
		    }
		});
    });
};

// 삭제버튼
$('#deleteEvent').on('click', function () {
    
    //$('#deleteEvent').unbind();
    $("#calendar").fullCalendar('removeEvents', $(this).data('id'));
    eventModal.modal('hide');
    //삭제시
    $.ajax({
        url: "/cal/deleteCalender",
        contentType:"application/json; charset:utf-8",
        data: JSON.stringify(eventId.data()),
        type: "post",
        beforeSend:function(xhr) {   // 데이터 전송 전  헤더에 csrf값 설정
			xhr.setRequestHeader($("#csrfHeaderName").val(), $("#csrfToken").val());
		},
        success: function (response) {
            $('#calendar').fullCalendar('removeEvents');
		    $('#calendar').fullCalendar('refetchEvents');
        }
    });

});