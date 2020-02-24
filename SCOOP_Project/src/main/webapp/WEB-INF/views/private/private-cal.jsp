<!-- 프라이빗 공간 캘린더 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/style.css' />" >
<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/fullcalendar.min.css' />" >
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css" />">
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/select2.min.css" />' />
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/bootstrap.min.css" />' />
<link rel="stylesheet" type="text/css" href='<c:url value="/resources/css/bootstrap-datetimepicker.min.css" />' />
</head>
<script>
(function(){
	
});
</script>

<body>

	<jsp:include page="/WEB-INF/views/commons/preloader.jsp"></jsp:include>
	
	<div id="main-wrapper">
	
		<jsp:include page="/WEB-INF/views/commons/headerAndLeft.jsp"></jsp:include>
	
		<div class="content-body">
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
						
								<div class="row">
									<div class="col-md-12">
										<div class="card-box">
											<div class="container">

												<!-- 일자 클릭시 메뉴오픈 -->
												<div id="contextMenu" class="dropdown clearfix" style="position: relative;">
													<ul class="dropdown-menu dropNewEvent" role="menu"
														aria-labelledby="dropdownMenu"
														style="display: block; margin-bottom: 5px;">
														<c:forEach items="${pjtlist}" var="p">
														<li><a tabindex="-1" href="#" name="${p.tseq}">${p.pname}</a></li>
                         														 
                  										</c:forEach>
														<li class="divider"></li>
														<li><a tabindex="-1" href="#" data-role="close">Close</a></li>
													</ul>
												</div>

												<div id="wrapper">
													<div id="loading"></div>
													<div id="calendar"></div>
												</div>
												<!-- 일정 추가 MODAL -->
												<div class="modal fade" tabindex="-1" role="dialog"
													id="eventModal">
													<div class="modal-dialog" role="document" style=" margin-top: 150px; margin-bottom: 150px;">
														<div class="modal-content">
															<div class="modal-header">
															<h4 style="padding-left: 2%;" class="modal-title"></h4>
																<button type="button" class="close"  data-dismiss="modal"
																	aria-label="Close">&times;
																	
																</button>
																
															</div>
															<div class="modal-body">

																<div class="row">
																	<div class="col-xs-12">
																		<label class="col-xs-4" for="edit-allDay" style="margin-right: 3px;">하루종일</label>
																		<input class='allDayNewEvent' id="edit-allDay"
																			type="checkbox"></label>
																	</div>
																</div>

																<div class="row">
																	<div class="col-xs-12">
																		<label class="col-xs-4" for="edit-title">일정명</label> <input
																			class="inputModal" type="text" name="edit-title"
																			id="edit-title" required="required" />
																	</div>
																</div>
																<div class="row">
																	<div class="col-xs-12">
																		<label class="col-xs-4" for="edit-start">시작</label> <input
																			class="inputModal" type="text" name="edit-start"
																			id="edit-start" />
																	</div>
																</div>
																<div class="row">
																	<div class="col-xs-12">
																		<label class="col-xs-4" for="edit-end">끝</label> <input
																			class="inputModal" type="text" name="edit-end"
																			id="edit-end" />
																		
																	</div>
																</div>
																<div class="row">
																	<div class="col-xs-12">
																		<label class="col-xs-4" for="edit-type">협업공간 이름</label> <select
																			class="inputModal" type="text" name="edit-type"
																			id="edit-type">
																			<c:forEach items="${pjtlist}" var="p">
																			
                         														  <option value="${p.tseq}">${p.pname}</option>
                  															</c:forEach>
																		</select>
																	</div>
																</div>
																<div class="row">
																	<div class="col-xs-12">
																		<label class="col-xs-4" for="edit-color">색상</label> <select
																			class="inputModal" name="color" id="edit-color">
																			<option value="#D25565" style="color: #D25565;">빨간색</option>
																			<option value="#9775fa" style="color: #9775fa;">보라색</option>
																			<option value="#ffa94d" style="color: #ffa94d;">주황색</option>
																			<option value="#74c0fc" style="color: #74c0fc;">파란색</option>
																			<option value="#f06595" style="color: #f06595;">핑크색</option>
																			<option value="#63e6be" style="color: #63e6be;">연두색</option>
																			<option value="#a9e34b" style="color: #a9e34b;">초록색</option>
																			<option value="#4d638c" style="color: #4d638c;">남색</option>
																			<option value="#495057" style="color: #495057;">검정색</option>
																		</select>
																	</div>
																</div>
																<div class="row">
																	<div class="col-xs-12">
																		<label class="col-xs-4" for="edit-desc">설명</label>
																		<textarea rows="4" cols="50" class="inputModal"
																			name="edit-desc" id="edit-desc"></textarea>
																	</div>
																</div>
															</div>
															<div class="modal-footer modalBtnContainer-addEvent">
																<button type="button" class="btn btn-default"
																	data-dismiss="modal">취소</button>
																<button type="button" class="btn btn-primary"
																	id="save-event">저장</button>
															</div>
															<div class="modal-footer modalBtnContainer-modifyEvent">
																<button type="button" class="btn btn-default"
																	data-dismiss="modal">닫기</button>
																<button type="button" class="btn btn-danger"
																	id="deleteEvent">삭제</button>
																<button type="button" class="btn btn-primary"
																	id="updateEvent">저장</button>
															</div>
														</div>
														<!-- /.modal-content -->
													</div>
													<!-- /.modal-dialog -->
												</div>
												<!-- /.modal -->

												<div class="panel panel-default">

													<div class="panel-heading">
														<h3 class="panel-title">필터</h3>
													</div>

													<div class="panel-body">

														<div class="col-lg-6">
															<label for="calendar_view">협업공간</label>
															<div class="input-group">
																<select class="filter" id="edit-tseq"
																	multiple="multiple" name="edit-tseq">
																	<c:forEach items="${pjtlist}" var="p">
																	<input class="inputModal" type="text" name="edit-tseq${p.tseq }" id="edit-tseq${p.tseq }" value="${p.tseq}" readonly hidden="hidden">
                         											<option value="${p.tseq}">${p.pname}</option>
         
                  													</c:forEach>
																</select>
															</div>
														</div>

														<div class="col-lg-6">
															<label for="calendar_view">등록자별</label>
															<div class="input-group">
																<label class="col-xs-4" for="edit-title">발의자<input
																			class="inputModal" type="text" name="edit-name"
																			id="edit-name" required="required" value="${sessionScope.name}"></label>
																<label class="checkbox-inline"><input
																	class='filter' type="checkbox" value="${sessionScope.name}" checked>${sessionScope.name}</label>
																	<c:forEach items="${mem}" var="m">
																		<label class="checkbox-inline"><input
																	class='filter' type="checkbox" value="${m.name}" checked>${m.name}</label>
                  													</c:forEach>
																	
								
															</div>
														</div>

													</div>
												</div>
												<!-- /.filter panel -->
											</div>
										</div>
									</div>


								</div>
							</div>
						</div>
						<!-- /# card -->
					</div>
					<!-- /# column -->
				</div>
			</div>
			<!-- #/ container -->
		</div>
		<!--**********************************
            Content body end
        ***********************************-->
	
    
    <jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</div>
</body>
<script src="<c:url value="/resources/plugins/common/common.min.js" />"></script>

	
	<script src="<c:url value="/resources/vendor/js/bootstrap.min.js"/>"></script>
	<script src="<c:url value='/resources/plugins/moment/moment.min.js'/>"></script>
	<script src="<c:url value="/resources/vendor/js/moment.min.js"/>"></script>
	<script src="<c:url value="/resources/vendor/js/fullcalendar.min.js"/>"></script>
	<script src="<c:url value="/resources/vendor/js/ko.js"/>"></script>
	<script src="<c:url value="/resources/vendor/js/select2.min.js"/>"></script>
	
	<script src="<c:url value='/resources/fullcalendar/main.js'/>"></script>
	<script src="<c:url value='/resources/fullcalendar/addEvent.js'/>"></script>
	<script src="<c:url value='/resources/fullcalendar/editEvent.js'/>"></script>
	<script src="<c:url value='/resources/fullcalendar/etcSetting.js'/>"></script>
	
	<script src="<c:url value="/resources/js/custom.min.js" />"></script>
	<script src="<c:url value="/resources/js/settings.js" />"></script>
	<script src="<c:url value="/resources/js/gleek.js" />"></script>
	<script src="<c:url value="/resources/js/styleSwitcher.js" />"></script>
	
	<script src="<c:url value="/resources/vendor/js/bootstrap-datetimepicker.min.js"/>"></script>
</html>