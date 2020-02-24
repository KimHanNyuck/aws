<!-- 페이지에서 대부분 공통으로 쓰이는 footer jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ref" value="${ref+1}" />
<!-- Page level plugin CSS-->
<%-- <link href="<c:url value="/resources/chat/vendor/datatables/dataTables.bootstrap4.css" />" rel="stylesheet"> --%>

<!-- Custom styles for this template-->
<%-- <link href="<c:url value="/resources/chat/css/sb-admin.css" />" rel="stylesheet"> --%>

 <!-- Bootstrap core JavaScript-->
  <%-- <script src="<c:url value="/resources/chat/vendor/jquery/jquery.min.js" />"></script> --%>
  <%-- <script src="<c:url value="/resources/chat/vendor/bootstrap/js/bootstrap.bundle.min.js" />"></script> --%>

  <!-- Core plugin JavaScript-->
  <script src="<c:url value="/resources/chat/vendor/jquery-easing/jquery.easing.min.js" />"></script>

  <!-- Custom scripts for all pages-->
  <script src="<c:url value="/resources/chat/js/sb-admin.min.js" />"></script>
  
  <script type="text/javascript" src="<c:url value="/resources/chat/js/commonAlert.js" />"></script>
  
  <!-- sweetalert2 -->
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
  <script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  
  
<!--**********************************
            Footer start
        ***********************************-->
<%-- <link href="<c:url value="/resources/css/chat.css" />" rel="stylesheet"> --%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
	integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
	crossorigin="anonymous">
<script type="text/javascript">
	var wsocket;
	$(function() {
		connect();
 		$('#chatopen').click(function(){ //채팅방 목록보기
 				for(let i=0; i<$('.resultsearch').length;i++){
 				var proname = $('.resultsearch')[i].innerHTML.substr(7);
 				var prohref = $('.resultsearch').parent()[i].getAttribute('href').substr(22);
 				let data = { cmd : "createChatRoom", 
 		    	    	name : proname+"/"+prohref, 
 		    	    	max : 100,
 		    	    	ref : "${ref}"
 		    	    		};
 		   		wsocket.send(JSON.stringify(data));
 				}
 	 		})
		$("#createChat").click( function() {
			backAndForth();
		});
		$(window).on("beforeunload", function(){
			disconnect();
	    });
	    $('#dataTable tbody').on( 'click', 'button', function () {
	    	openChat($(this).attr("id"));
	    });
	})

	 function connect() {
		wsocket = new WebSocket("ws://scoop.com:8090/SCOOP/Chat-ws.do?cmd=on");
		wsocket.onmessage = onMessage;
		wsocket.onclose = onClose;
	}

	function disconnect() { 
		wsocket.close();
	}
	
	function onMessage(evt) { 
		var data = JSON.parse(evt.data); 
		setChatRooms(data);
		
	}
	
	function onClose(evt) {
		
	}
	function setChatRooms(data){
		$('#dataTable > tbody').empty();
		$.each(data.rooms, function(index, element){
			for(let i=0; i<$('.resultsearch').length;i++){
				if($('.resultsearch').parent()[i].getAttribute('href').substr(22)==data.rooms[index].name.split("/")[1]){
					room = $("<tr></tr>");
					room.append("<td style='padding-top:5%;'>"+element.name.split("/")[0]+"</td>");
		 			btn = $("<button class='btn btn-primary'>입장</button>");
					btn.attr("id", element.name);
					room.append($("<td></td>").append(btn));
					$('#dataTable > tbody').append(room);
				}
			}
		})
	}
		
    function sendSocket(jsonData) {
    
    }

    function openChat(room){ //채팅방 팝업창 띄우기
    	let url = "Chat.do?room="+room;
    	let name = room;
    	let option = "width = 400, height = 500, top = 230, left = 1170, location = no, channelmode = yes";
        window.open(url, name, option);
    }
</script>
<script type="text/javascript">
	$(function() {
		$('#chatopen') //채팅방 div show() and hide()
				.click(
						function() {
							if ($(this).attr('name') == 'on') {
								$(this)
										.attr('src',
												"<c:url value='/resources/images/chat/chatclose.png' />");
								$(this).attr('name', 'off');
								if($('#chatdivopen').attr('class')=='true'){
									$('#chatdivopen').show();
								}else if($('#chatroomdivopen').attr('class')=='true'){
									$('#chatroomdivopen').show();
									$('#chatback').show();
								}
								
							} else {
								$(this)
										.attr('src',
												"<c:url value='/resources/images/chat/chatopen.png' />");
								$(this).attr('name', 'on');
								$('#chatdivopen').hide();
								$('#chatback').hide();
								$('#chatroomdivopen').hide();
							}
						});
		$('#helpopen').click(function() { //도움말 show()
			if ($(this).attr('name') == 'on') {
				$(this).attr('name', 'off');
				$('#helpdivopen').show();
				$('#closeopen').show();
			}
		});
		$('#closeopen').click(function() { //도움말 hide()
			$('#helpopen').attr('name', 'on');
			$('#helpdivopen').hide();
			$('#closeopen').hide();
		})
		$(document).keydown(function(event) { //도움말 show() and hide() ctrl + / 단축키
			if (event.ctrlKey && event.keyCode == 191) {
				if ($('#helpopen').attr('name') == 'on') {
					$('#helpopen').attr('name', 'off');
					$('#helpdivopen').show();
					$('#closeopen').show();
				} else {
					$('#helpopen').attr('name', 'on');
					$('#helpdivopen').hide();
					$('#closeopen').hide();
				}
			}
			if (event.ctrlKey && event.keyCode == 188) { //채팅방 단축키 show() and hide() ctrl + , 단축키
				if ($('#chatopen').attr('name') == 'on') {
					$('#chatopen').attr('src',"<c:url value='/resources/images/chat/chatclose.png' />");
					$('#chatopen').attr('name', 'off');
					if($('#chatdivopen').attr('class')=='true'){
						$('#chatdivopen').show();
					}else if($('#chatroomdivopen').attr('class')=='true'){
						$('#chatroomdivopen').show();
						$('#chatback').show();
					}
				}else {
					$('#chatopen').attr('src',"<c:url value='/resources/images/chat/chatopen.png' />");
					$('#chatopen').attr('name', 'on');
					$('#chatdivopen').hide();
					$('#chatback').hide();
					$('#chatroomdivopen').hide();
				}
			}
		});
		
	});
</script>
<style>
#chatopen {
	position: fixed;
	bottom: 16px;
	right: 16px;
	font-size: 18px;
	z-index: 1;
}

#chatdivopen {
	display: none;
	width: 400px;
	position: fixed;
	bottom: 78px;
	right: 20px;
	font-size: 18px;
	z-index: 1;
}
#chatroomdivopen {
	display: none;
	width: 400px;
	position: fixed;
	bottom: 60px;
	right: 16px;
	font-size: 18px;
	z-index: 1;
}
#chatback {
	display: none;
	position: fixed;
	bottom: 530px;
	right: 20px;
	font-size: 30px;
	cursor: pointer;
	z-index: 3;
}

#helpopen {
	position: fixed;
	bottom: 16px;
	left: 16px;
	font-size: 18px;
	z-index: 1;
}

#helpdivopen {
	background-color: #222;
	width: 245px;
	height: 100%;
	display: none;
	position: fixed;
	bottom: 0;
	left: 0;
	font-size: 18px;
	z-index: 4;
	padding: 0px 15px 0px 13px;
	overflow: auto;
}

#closeopen {
	position: fixed;
	bottom: 96%;
	left: 200px;
	font-size: 18px;
	z-index: 5;
}

.accordion {
	background-color: #222;
	color: white;
	cursor: pointer;
	padding: 10px;
	width: 100%;
	border: none;
	text-align: left;
	outline: none;
	font-size: 12px;
	transition: 0.4s;
}

.activeacc, .accordion:hover {
	background-color: #222;
}

.panel {
	padding: 0 13px;
	display: none;
	overflow: hidden;
	font-size: 12px;
	transition: max-height 0.2s ease-out;
}

::-webkit-scrollbar {
	width: 3px;
}

::-webkit-scrollbar-track {
	background-color: rgba(255,255,255,0.3);
}

::-webkit-scrollbar-thumb {
	background-color: #ad2d45;
	border-radius: 25px;
}

::-webkit-scrollbar-thumb:hover {
	background: #ad2d45;
}

::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment
	{
	width: 3px;
	height: 3px;
	background: rgba(61, 56, 57,0.5);
}
</style>
<!-- <div class="footer">
	<div class="copyright">
		<p>
			Copyright &copy; Designed & Developed by <a
				href="https://themeforest.net/user/quixlab">Quixlab</a> 2018
		</p>
	</div>
</div> -->
<!-- chat 시작 -->
			<div id="chatdivopen" class="true">
				<div class="card" style="border-radius: 10px; margin-bottom: 0;border : 1px solid #ced4da;min-height: 400px;box-shadow: 0px 1px 10px 0px rgba(0, 0, 0, 0.5)">
					<div class="card-header">
						<i class="fas fa-comments"></i> 실시간 채팅(Ctrl + ,)
						<!-- <button id="createChat" class="btn btn-primary" type="button" style="margin-bottom: 0; margin-left: 45px">채팅방	만들기</button> -->
					</div>
					<div class="card-body" style="padding-top: 0">
						<div class="table"  style="height: 400px;overflow: auto;border-top:1px solid #f3f3f3">
							<table class="table table-bordered" id="dataTable" style="text-align: center; background-color: white">
								<thead>
									<tr>
										<!-- <th width="10%">NO</th> -->
										<th width="80%">협업공간</th>
										<!-- <th width="10%">USER</th> -->
										<th width="20%">입장</th>
									</tr>
								</thead>
								<tbody id="chattbody">

								</tbody>
							</table>
						</div>
					</div>
				</div>

			</div>
			<span class="iconify" id="chatback" data-icon="ion:arrow-back" data-inline="false" style="display: none"></span>
			<div id="chatroomdivopen">
			</div>
<!-- chat 끝 -->
<div id="helpdivopen" class="scrollbar">
	<h4 style="margin: 15%; margin-bottom: 5%; color: white">도움센터(Ctrl+/)</h4>
	<h5 style="color: white; padding-top: 15px;">추천 팁</h5>
	<p style="border-bottom: 1px solid rgba(255, 255, 255, 0.3); margin-bottom: 0px; color: #fff; font-size: 12px; padding: 10px 0px 5px 0px;">
	단축키</p>
	<span class="iconify" data-icon="ion:file-tray-full-sharp" data-inline="false" style="color: #fff;"></span>
	<span style="font-size: 13px;color: #fff;">파일함</span><span class="iconify" data-icon="vaadin:ctrl-a" data-inline="false"style="color: #fff;margin-left:40%;"></span>
	<span class="iconify" data-icon="bx:bx-plus" data-inline="false" style="color: #fff;"></span>
	<span class="iconify" data-icon="entypo:dot-single" data-inline="false" style="color: #fff;"></span><br>
	<span class="iconify" data-icon="cil:chat-bubble" data-inline="false" style="color: #fff;"></span>
	<span style="font-size: 13px;color: #fff;">채팅방</span><span class="iconify" data-icon="vaadin:ctrl-a" data-inline="false"style="color: #fff;margin-left: 40%;"></span>
	<span class="iconify" data-icon="bx:bx-plus" data-inline="false" style="color: #fff;"></span>
	<span class="iconify" data-icon="mdi:comma" data-inline="false" style="color: #fff;"></span>
	<p style="border-bottom: 1px solid rgba(255, 255, 255, 0.3); margin-bottom: 0px; color: #fff; font-size: 12px; padding: 10px 0px 5px 0px;">
	가격 및 결제</p>
	<p style="font-size: 11px;color: #fff;">오른쪽 상단 내정보에 가격및결제를 클릭하면 결제가능합니다</p>
	<p style="border-bottom: 1px solid rgba(255, 255, 255, 0.3); margin-bottom: 0px; color: #fff; font-size: 12px; padding: 10px 0px 5px 0px;">
	새로운 소식</p>
	<button class="accordion"><span class="iconify" data-icon="ic:twotone-autorenew" data-inline="false" style="width:17px;height: auto;"></span>&nbsp;이슈 업데이트</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
			새로운 소식들을 '새로운 팀이슈','새로운 댓글','새로운 공지사항'을 통해 확인할 수 있습니다.
			협업공간 및 이슈의 알림을 끄더라도, 나를 언급한 소식은 업데이트 됩니다.
		</p>
	</div>
	<button class="accordion"><span style="font-size: 16px;">@</span>&nbsp;호출됨</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
			이슈나 댓글에서 동료가 나를 멘션하면 '호출됨' 에서 확인할 수 있습니다.
		</p>
	</div>
	<button class="accordion"><span class="iconify" data-icon="bx:bxs-doughnut-chart" data-inline="false" style="width:17px;height: auto;"></span>&nbsp;협업 진행도</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
			협업 공간마다 칸반의 발의됨,일시중지,진행중,완료 4가지 단계의 진행률을 한눈에 확인할 수 있습니다.
		</p>
	</div>
	<p style="border-bottom: 1px solid rgba(255, 255, 255, 0.3); margin-bottom: 0px; color: #fff; font-size: 12px; padding: 10px 0px 5px 0px;">
		협업공간</p>
	<button class="accordion"><span class="iconify" data-icon="ant-design:flag-filled" data-inline="false" style="width:17px;height: auto;"></span>&nbsp;협업공간 만들기</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
			협업공간은 동료와 함께 이슈를 해결하기 위해 협업할 수 있는 공간입니다.<br>
			팀 공간(ex.개발팀), 게시판 공간(ex.주간업무공유), 협업공간을 진행하기 위한 용도로 공간을 만들 수 있습니다.<br>
			협업공간을 만들면 꼭 함께할 멤버를 초대해 주세요.
		</p>
	</div>
	<button class="accordion"><span class="iconify" data-icon="ic:baseline-person-add" data-inline="false" style="width:17px;height: auto;padding-bottom: 2px;"></span>&nbsp;멤버 초대</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
			협업공간에서 함께할 '멤버'를 초대해 주세요.<br>
			여러개의 이메일로 한번에 초대도 가능합니다.<br>
		</p>
	</div>
	<button class="accordion"><span class="iconify" data-icon="raphael:smallgear" data-inline="false" style="width:17px;height: auto;"></span>&nbsp;협업공간 관리</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
			협업공간의 '관리자'는 멤버탈퇴, 관리자 위임등 공간을 관리할 수 있습니다.
			협업공간 타이틀 옆의 '톱니바퀴' 버튼을 누르면 협업공간 관리 메뉴를 확인할 수 있습니다.
		</p>
	</div>

	<p
		style="border-bottom: 1px solid rgba(255, 255, 255, 0.3); margin-bottom: 0px; color: #fff; font-size: 12px; padding: 10px 0px 5px 0px;">이슈</p>
	<button class="accordion"><span style="font-size: 16px;">@</span> 멘션</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
			이슈 및 댓글에서 "@이름"을 입력하면 동료를 호출할 수 있습니다.<br>
			할 일과 의사결정에서도 동료를 멘션하면 해당 동료에게 할당됩니다.
		</p>
	</div>
	<button class="accordion"><span class="iconify" data-icon="entypo-social:google-drive" data-inline="false"  style="width:17px;height: auto;"></span>&nbsp;구글 드라이브</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
			유료회원은 구글드라이브의 파일과 이미지 등을 업로드 하고 공유할 수 있습니다.<br>
		</p>
	</div>
	<button class="accordion"><span class="iconify" data-icon="ant-design:file-filled" data-inline="false"  style="width:17px;height: auto;"></span>&nbsp;파일 공유</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
		이슈에서 "@파일" 또는 "@구글 드라이브"를 찾아 파일을 공유해 보세요.<br>
		또한 Ctrl+.(파일함)에 자동으로 업로드 됩니다.
		</p>
	</div>
	<button class="accordion"><span class="iconify" data-icon="ant-design:check-circle-outlined" data-inline="false" style="width:17px;height: auto;"></span>&nbsp;할일 주기</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;">
		이슈에서 "@할 일"에서 동료를 호출해 할일을 주세요.<br>
		할일 할당 시 상대방에게 알림이 가게 됩니다.
		</p>
	</div>
	<button class="accordion"><span class="iconify" data-icon="bx:bxs-calendar-event" data-inline="false" style="width:17px;height: auto;"></span>&nbsp;일정 공유</button>
	<div class="panel">
		<p style="color: #fff;font-size: 11px;margin-bottom: 30px;">
		팀 캘린더에서 협공공간 전체 일정을 공유할 수 있습니다.<br>
		프라이빗 공간에서의 캘린더는 본인만 작성 및 수정 등을 할 수 있습니다.
		</p>
	</div>
	<script>
	// 도움말 accordion
		var acc = document.getElementsByClassName("accordion");
		var i;

		for (i = 0; i < acc.length; i++) {
			acc[i].addEventListener("click", function() {
				this.classList.toggle("activeacc");
				var panel = this.nextElementSibling;
				if (panel.style.display === "block") {
					panel.style.display = "none";
				} else {
					panel.style.display = "block";
				}
			});
		}
	</script>
</div>
<img src='<c:url value="/resources/images/chat/chatopen.png" />'
	id="chatopen" name="on" width=50px height=auto style="cursor: pointer;">
<img src="<c:url value="/resources/images/chat/questionmark.png" />"
	id="helpopen" name="on" width=50px height=auto style="cursor: pointer;">
<img src="<c:url value="/resources/images/chat/close.png" />"
	id="closeopen" name="on" width=20px height=auto
	style="cursor: pointer; display: none">
<!--**********************************
            Footer end
        ***********************************-->