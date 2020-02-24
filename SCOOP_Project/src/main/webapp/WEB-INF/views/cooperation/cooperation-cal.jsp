<!-- 협업공간 캘린더 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
    <!-- Custom Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
    <link href="./plugins/fullcalendar/css/fullcalendar.min.css" rel="stylesheet">
</head>
<style>
.myinfo{
 border: 0;
 border-bottom: 1px solid #c8c8c8;
 background-color: white;
}
.form-control[readonly]{
	background-color: white;
}
.newissue{
	border-bottom: 1px solid #c8c8c8;
	padding-top: 0.7%;
	padding-bottom: 0.7%;
}
</style>
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
								<div class="card-title">
									<h3>일정 관리</h3>
								</div>
								<div class="row">
									<div class="col-md-10">
										<div class="card-box m-b-50">
											<div class="container">

												<!-- 일자 클릭시 메뉴오픈 -->
												<div id="contextMenu" class="dropdown clearfix">
													<ul class="dropdown-menu dropNewEvent" role="menu"
														aria-labelledby="dropdownMenu"
														style="display: block; position: static; margin-bottom: 5px;">
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
													<div class="modal-dialog" role="document">
														<div class="modal-content">
															<div class="modal-header">
																<button type="button" class="close" data-dismiss="modal"
																	aria-label="Close">
																	<span aria-hidden="true">&times;</span>
																</button>
																<h4 class="modal-title"></h4>
															</div>
															<div class="modal-body">

																<div class="row">
																	<div class="col-xs-12">
																		<label class="col-xs-4" for="edit-allDay">하루종일</label>
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
                         														  <option value="${p.pname}">${p.pname}</option>
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
																<select class="filter" id="type_filter"
																	multiple="multiple">
																	<c:forEach items="${pjtlist}" var="p">
																	<input class="inputModal" type="text" name="edit-tseq" id="edit-tseq" value="${p.tseq}" readonly hidden="hidden">
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
																	<label class="checkbox-inline"><input
																	class='filter' type="checkbox" value="정연" checked>정연</label>
																<label class="checkbox-inline"><input
																	class='filter' type="checkbox" value="다현" checked>다현</label>
																<label class="checkbox-inline"><input
																	class='filter' type="checkbox" value="사나" checked>사나</label>
																<label class="checkbox-inline"><input
																	class='filter' type="checkbox" value="나연" checked>나연</label>
																<label class="checkbox-inline"><input
																	class='filter' type="checkbox" value="지효" checked>지효</label>
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
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
    <script src="plugins/common/common.min.js"></script>
    <script src="js/custom.min.js"></script>
    <script src="js/settings.js"></script>
    <script src="js/gleek.js"></script>
    <script src="js/styleSwitcher.js"></script>
	
	<script src="./plugins/jqueryui/js/jquery-ui.min.js"></script>
    <script src="./plugins/moment/moment.min.js"></script>
    <script src="./plugins/fullcalendar/js/fullcalendar.min.js"></script>
    <script src="./js/plugins-init/fullcalendar-init.js"></script>
</body>

</html>