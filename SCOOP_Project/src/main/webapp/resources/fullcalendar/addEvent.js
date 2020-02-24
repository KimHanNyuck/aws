var eventModal = $('#eventModal');

var modalTitle = $('.modal-title');
var editAllDay = $('#edit-allDay');
var editTitle = $('#edit-title');
var editStart = $('#edit-start');
var editEnd = $('#edit-end');
var editType = $('#edit-type');
var editColor = $('#edit-color');
var editDesc = $('#edit-desc');
var editName = $('#edit-name');
var editTseq = $('#pjtselect');

var addBtnContainer = $('.modalBtnContainer-addEvent');
var modifyBtnContainer = $('.modalBtnContainer-modifyEvent');


/* ****************
 *  새로운 일정 생성
 * ************** */
var newEvent = function (start, end, eventType) {

    $("#contextMenu").hide(); //메뉴 숨김

    modalTitle.html('새로운 일정');
    editStart.val(start);
    editEnd.val(end);
    editType.val(eventType).prop("selected", true);

    addBtnContainer.show();
    modifyBtnContainer.hide();
    eventModal.modal('show');


    //새로운 일정 저장버튼 클릭
    $('#save-event').unbind();
    $('#save-event').on('click', function () {

        var eventData = {
            title: editTitle.val(),
            start: editStart.val(),
            end: editEnd.val(),
            description: editDesc.val(),
            type: editType.val(),
            username: editName.val(),
            backgroundColor: editColor.val(),
            textColor: '#ffffff',
            tseq:editTseq.val(),
            allDay: editAllDay.val()
        };

        if (eventData.start > eventData.end) {
            alert('끝나는 날짜가 앞설 수 없습니다.');
            return false;
        }

        if (eventData.title === '') {
            alert('일정명은 필수입니다.');
            return false;
        }

        var realEndDay;

        if (editAllDay.is(':checked')) {
            eventData.start = moment(eventData.start).format('YYYY-MM-DD');
            //render시 날짜표기수정
            eventData.end = moment(eventData.end).add(1, 'days').format('YYYY-MM-DD');
            //DB에 넣을때(선택)
            realEndDay = moment(eventData.end).format('YYYY-MM-DD');

            eventData.allDay = true;
        }

        $("#calendar").fullCalendar('renderEvent', eventData, true);
        eventModal.find('input, textarea').val('');
        editAllDay.prop('checked', false);
        eventModal.modal('hide');
        
        
        console.log(typeof eventData.tseq);
        console.log(eventData.tseq);
        console.log(typeof eventData.tseq=="string");
        //새로운 일정 저장
        if(typeof eventData.tseq != "string" || eventData.tseq !=null){
        	console.log("team");
        	console.log(eventData);
        $.ajax({
        	url: "addTeamCalendar.do",
            type: "post",
            data: eventData,
            async: false,
            success: function (data) {
            	location.href="addCalendarAjax.do";
            },
            error: function() {
            	Swal.fire(
            			  '팀캘린더 생성 도중 실패!',
            			  '팀일정 생성 도중 에러가 발생했습니다',
            			  'error'
            			)
		    }
        });
        } else{
        	
    	$.ajax({
        	url: "addPrivateCalendar.do",
            type: "post",
            data: eventData,
            async: false,
            success: function (data) {
            	location.href="addCalendarAjax.do";       
            },
            error: function() {
            	Swal.fire(
          			  '개인캘린더 생성 도중 실패!',
          			  '개인일정 생성 도중 에러가 발생했습니다',
          			  'error'
          			)
		    }
        });
    }
    });
};