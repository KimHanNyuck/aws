/* ****************
 *  일정 편집
 * ************** */
var editEvent = function (event, element, view) {

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
    editTitle.val(event.title);
    editStart.val(event.start.format('YYYY-MM-DD HH:mm'));
    editType.val(event.type);
    editType.attr("readonly", true);
    editTseq.val(event.tseq);
    /*editTiseq.val(event.tiseq);*/
    editDesc.val(event.description);
    editColor.val(event.backgroundColor).css('color', event.backgroundColor);

    addBtnContainer.hide();
    modifyBtnContainer.show();
    eventModal.modal('show');

    //업데이트 버튼 클릭시
    $('#updateEvent').unbind();
    $('#updateEvent').on('click', function () {

        if (editStart.val() > editEnd.val()) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (editTitle.val() === '') {
            alert('일정명은 필수입니다.')
            return false;
        }

        var statusAllDay;
        var startDate;
        var endDate;
        var displayDate;

        if (editAllDay.is(':checked')) {
            statusAllDay = true;
            startDate = moment(editStart.val()).format('YYYY-MM-DD');
            endDate = moment(editEnd.val()).format('YYYY-MM-DD');
            displayDate = moment(editEnd.val()).add(1, 'days').format('YYYY-MM-DD');
        } else {
            statusAllDay = false;
            startDate = editStart.val();
            endDate = editEnd.val();
            displayDate = endDate;
        }

        eventModal.modal('hide');

        event.allDay = statusAllDay;
        event.title = editTitle.val();
        event.start = startDate;
        event.end = displayDate;
        event.type = editType.val();
        event.tseq = editTseq.val();
        /*event.tiseq = editTiseq.val();*/
        event.backgroundColor = editColor.val();
        event.description = editDesc.val();
        
        var editData = {
        		_id:event._id,
                title: event.title,
                start: event.start,
                end: event.end,
                description: event.description,
                type: event.type,
                tseq: event.tseq,
                /*tiseq: event.tiseq,*/
                backgroundColor: event.backgroundColor,
                allDay: event.allDay
            };

        $("#calendar").fullCalendar('updateEvent', event);

        //일정 업데이트
        $.ajax({
        	url: "editPrivateCalendar.do",
            type: "post",
            data: editData,
            success: function (data) {
            	Swal.fire(
            			  '개인캘린더 변경 성공!',
            			  '개인일정이 변경되었습니다',
            			  'success'
            			)
            },
            error: function() {
            	Swal.fire(
          			  '캘린더 변경 실패!',
          			  '변경 도중 에러가 발생했습니다',
          			  'error'
          			)
		    }
        });

    });

    // 삭제버튼
    $('#deleteEvent').on('click', function () {
        $('#deleteEvent').unbind();
        $("#calendar").fullCalendar('removeEvents', [event._id]);
        eventModal.modal('hide');
        var tiseq = {piseq:event._id,
        		username:event.username
        };
        //삭제시
        $.ajax({
            type: "post",
            url: "deletePrivateCalendar.do",
            data: tiseq,
            success: function (response) {
            	Swal.fire(
          			  '개인캘린더 삭제 성공!',
          			  '개인일정이 삭제되었습니다',
          			  'success'
          			)
            },
            error: function() {
            	Swal.fire(
            			  '개인캘린더 삭제 실패!',
            			  '개인일정 삭제 도중 에러가 발생했습니다',
            			  'error'
            			)
		    }
        });
    });
};