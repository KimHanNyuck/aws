var draggedEventIsAllDay;
var activeInactiveWeekends = true;

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

function calDateWhenResize(event) {

  var newDates = {
    startDate: '',
    endDate: ''
  };

  if (event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  } else {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}

function calDateWhenDragnDrop(event) {
  // 드랍시 수정된 날짜반영
  var newDates = {
    startDate: '',
    endDate: ''
  }

  //하루짜리 all day
  if (event.allDay && event.end === null) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = newDates.startDate;
  }

  //2일이상 all day
  else if (event.allDay && event.end !== null) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  }

  //all day가 아님
  else if (!event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}


var calendar = $('#calendar').fullCalendar({

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
        .append('<p><strong>협업공간 이름:</strong> ' + event.type + '</p>')
        .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
        .append('<p><strong>tiseq:</strong> ' + event._id + '</p>')
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

  //주말 숨기기 & 보이기 버튼
  customButtons: {
    viewWeekends: {
      text: '주말',
      click: function () {
        activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
        $('#calendar').fullCalendar('option', {
          weekends: activeInactiveWeekends
        });
      }
    }
  },

  header: {
    left: 'today, prevYear, nextYear, viewWeekends',
    center: 'prev, title, next',
    right: 'month,agendaWeek,agendaDay,listWeek'
  },
  views: {
    month: {
      columnFormat: 'dddd'
    },
    agendaWeek: {
      columnFormat: 'M/D ddd',
      titleFormat: 'YYYY년 M월 D일',
      eventLimit: false
    },
    agendaDay: {
      columnFormat: 'dddd',
      eventLimit: false
    },
    listWeek: {
      columnFormat: ''
    }
  },

  /* ****************
   *  일정 받아옴 
   * ************** */
  events: function (start, end, timezone, callback) {
	  var para = document.location.href.split("?tseq=");
    $.ajax({
      type: "get",
      url: "getSelectTeamCalendar.do?tseq="+para[1],
      data: {
        // 실제 사용시, 날짜를 전달해 일정기간 데이터만 받아오기를 권장
      },
      dataType : "json",
      async: false,
      success: function (response) {
        var fixedDate = response.map(function (array) {
        	console.log(response);
        	
          if (array.allDay && array.start !== array.end) {
            // 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상출력
            array.end = moment(array.end).add(1, 'days');
          }
          
          return array;
        })
        console.log(fixedDate);
        console.log(callback);
        callback(fixedDate);
      }
    });
  	
  },

  eventAfterAllRender: function (view) {
    if (view.name == "month") {
      $(".fc-content").css('height', 'auto');
    }
  },

  //일정 리사이즈
  eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove();

    /** 리사이즈시 수정된 날짜반영
     * 하루를 빼야 정상적으로 반영됨. */
    var newDates = calDateWhenResize(event);
    var editData = {
    		_id: event._id,
            title: event.title,
            start: newDates.startDate,
            end: newDates.endDate,
            description: event.description,
            type: event.type,
            username: event.username,
            backgroundColor: event.backgroundColor,
            textColor: '#ffffff',
            tseq:event.tseq,
            allDay: event.allDay
        };
    console.log(editData);
    //리사이즈한 일정 업데이트
    if(typeof editData.tseq == "number" || editData.type != "프라이빗 공간"){
        //일정 업데이트
        $.ajax({
        	url: "editTeamCalendar.do",
            type: "post",
            data: editData,
            async: false,
            success: function (data) {
            	Swal.fire(
          			  '팀캘린더 변경 성공!',
          			  '팀일정이 변경되었습니다',
          			  'success'
          			)
            },
            error: function() {
            	Swal.fire(
            			  '팀캘린더 변경 실패!',
            			  '변경 도중 에러가 발생했습니다',
            			  'error'
            			)
		    }
        });
        } else{
        	$.ajax({
            	url: "editPrivateCalendar.do",
                type: "post",
                data: editData,
                async: false,
                success: function (data) {
                	Swal.fire(
              			  '개인캘린더 변경 성공!',
              			  '개인일정이 변경되었습니다',
              			  'success'
              			)
                },
                error: function() {
                	Swal.fire(
                			  '개인캘린더 변경 실패!',
                			  '개인일정 변경 도중 에러가 발생했습니다',
                			  'error'
                			)
    		    }
            });
        }

  },

  eventDragStart: function (event, jsEvent, ui, view) {
    draggedEventIsAllDay = event.allDay;
  },

  //일정 드래그앤드롭
  eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove();

    //주,일 view일때 종일 <-> 시간 변경불가
    if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
      if (draggedEventIsAllDay !== event.allDay) {
        alert('드래그앤드롭으로 종일<->시간 변경은 불가합니다.');
        location.reload();
        return false;
      }
    }
    console.log(event._id);
    // 드랍시 수정된 날짜반영
    var newDates = calDateWhenDragnDrop(event);
    var dropEditData = {
    		_id: event._id,
            title: event.title,
            start: newDates.startDate,
            end: newDates.endDate,
            description: event.description,
            type: event.type,
            username: event.username,
            backgroundColor: event.backgroundColor,
            textColor: '#ffffff',
            tseq:event.tseq,
            allDay: event.allDay
        };
    //드롭한 일정 업데이트
    console.log(dropEditData);
    console.log(typeof dropEditData);
    if(typeof dropEditData.tseq == "number" || dropEditData.type != "프라이빗 공간"){
        //일정 업데이트
        $.ajax({
        	url: "editTeamCalendar.do",
            type: "post",
            data: dropEditData,
            async: false,
            success: function (data) {
            	Swal.fire(
            			  '팀캘린더 변경 성공!',
            			  '팀일정이 변경되었습니다',
            			  'success'
            			)
            },
            error: function() {
            	Swal.fire(
          			  '팀캘린더 변경 실패!',
          			  '팀일정 변경 도중 에러가 발생했습니다',
          			  'error'
          			)
		    }
        });
        } else{
        	$.ajax({
            	url: "editPrivateCalendar.do",
                type: "post",
                data: dropEditData,
                async: false,
                success: function (data) {
                	Swal.fire(
              			  '개인캘린더 변경 성공!',
              			  '개인일정이 변경되었습니다',
              			  'success'
              			)
                },
                error: function() {
                	Swal.fire(
                			  '개인캘린더 변경 실패!',
                			  '변경 도중 에러가 발생했습니다',
                			  'error'
                			)
    		    }
            });
        }

  },

  select: function (startDate, endDate, jsEvent, view) {

    $(".fc-body").unbind('click');
    $(".fc-body").on('click', 'td', function (e) {

      $("#contextMenu")
        .addClass("contextOpened")
        .css({
          display: "block",
          left: e.pageX-280,
          top: e.pageY-180
        });
      return false;
    });

    var today = moment();

    if (view.name == "month") {
      startDate.set({
        hours: today.hours(),
        minute: today.minutes()
      });
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).subtract(1, 'days');

      endDate.set({
        hours: today.hours() + 1,
        minute: today.minutes()
      });
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    } else {
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    }

    //날짜 클릭시 카테고리 선택메뉴
    var $contextMenu = $("#contextMenu");
    $contextMenu.on("click", "a", function (e) {
      e.preventDefault();

      //닫기 버튼이 아닐때
      if ($(this).data().role !== 'close') {
        newEvent(startDate, endDate, $(this).html());
      }

      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

    $('body').on('click', function () {
      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

  },

  //이벤트 클릭시 수정이벤트
  eventClick: function (event, jsEvent, view) {
    editEvent(event);
  },

  locale: 'ko',
  timezone: "local",
  nextDayThreshold: "09:00:00",
  allDaySlot: true,
  displayEventTime: true,
  displayEventEnd: true,
  firstDay: 0, //월요일이 먼저 오게 하려면 1
  weekNumbers: false,
  selectable: true,
  weekNumberCalculation: "ISO",
  eventLimit: true,
  views: {
    month: {
      eventLimit: 12
    }
  },
  eventLimitClick: 'week', //popover
  navLinks: true,
  defaultDate: new Date(), //실제 사용시 삭제
  timeFormat: 'HH:mm',
  defaultTimedEventDuration: '01:00:00',
  editable: true,
  minTime: '00:00:00',
  maxTime: '24:00:00',
  slotLabelFormat: 'HH:mm',
  weekends: true,
  nowIndicator: true,
  dayPopoverFormat: 'MM/DD dddd',
  longPressDelay: 0,
  eventLongPressDelay: 0,
  selectLongPressDelay: 0
});