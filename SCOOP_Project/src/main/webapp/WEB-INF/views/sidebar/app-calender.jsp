<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>


<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
    <!-- Custom Stylesheet -->
    <link href="<c:url value="/resources/plugins/fullcalendar/css/fullcalendar.min.css" />" rel="stylesheet">
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<script>
$(function(){
		//var dateArray=document.querySelectorAll('.fc-day.fc-widget-content');
		var dateArray=document.querySelectorAll('.fc-content-skeleton thead td');
		var eventArray=document.querySelectorAll('.fc-content-skeleton tbody td');
 		for(var i=0;i<dateArray.length;i++){
			console.log($(dateArray[i]).attr('data-date'));
			$(eventArray[i]).attr('id',$(dateArray[i]).attr('data-date'));
		}
	$('.fc-content-skeleton tbody fc-event-container fc-day-grid-event fc-h-event fc-event fc-start fc-not-end bg-pink fc-draggable fc-title').change(function(){
		var end = $('.fc-content-skeleton tbody fc-event-container fc-day-grid-event fc-h-event fc-event fc-not-start fc-end bg-pink fc-draggable fc-title').text;
		console.log(end);
		console.log("변햇다");
		for(var i=0;i<dateArray.length;i++){
			console.log($(dateArray[i]).attr('data-date'));
			$(eventArray[i]).attr('id',$(dateArray[i]).attr('data-date'));
		}
	});
	$('#modalSave').click(function(){
		console.log($('#category-name').val());
		console.log($('#calTeam').val());
		var bar = $('.fc-title');
		console.log(bar);
	});
	$('#calSave').click(function(){
		console.log("클릭클릭");
		
		
		$('.fc-day').attr('style','overflow:auto;');
		$('.fc-day').append('<br><button>눌러눌러</button><button>눌러눌러</button><button>눌러눌러</button>')
	})
})

var $item = $('.item').on('click', function() {
  var idx = $(this).index();
  console.log(idx);
});

$(function(){
	

	$(".fc-content-skeleton thead td").mousedown(function(e){
		var da = $(this).attr('data-date');	
		console.log(typeof(da));
		
		$("#soso").attr('value',da);
		/*  */
		console.log('2020-01-29'==da);	
		/* $('.modal-body input[name=begin]').attr('value',da); */
		console.log("값좀 들어가라 ㅡㅡ begin");
		console.log(da);
		
		$('#event-modal').on('show.bs.modal', function (event) {
			//alert(da);
			//var begin = $(document.getElementsByName('beginning'));
			//alert(begin.val());
			console.log("-----");
			console.log($("#beginning"));
			/* console.log(begin.item); */
			$("#beginning").attr('value',$("#soso").attr('value'));
			console.log(event.delegateTarget.childNodes.item(1).childNodes.item(1).childNodes.item(3).childNodes);
			console.log(event.delegateTarget.childNodes.item(1).childNodes.item(1).childNodes.item(3).childNodes.item(0));
			console.log($("#beginning").val());
			
			console.log(this.children);
			
		});
	});
});

$(function(){
	$(".fc-content-skeleton thead td").mouseup(function(e){
		var du = $(this).attr('data-date');
		$('#ending').attr('value',du);
		$("#sosi").attr('value',du);
		/* $('#ending').val(du); */
		/* $('.modal-body input[name=end]').attr('value',du); */
		console.log("값좀 들어가라 ㅡㅡ end");
		console.log(du);
		
		$('#event-modal').on('show.bs.modal', function (event) {
			/* alert(du); */
			var pjtlist = '<c:out value="${pjtlist}"/>';
			for (var i = 0; i < pjtlist.length; i++) {
				$('#calTeam').append('<option value="'+pjtlist[i].tseq+'">'+pjtlist[i].pname+'</option>');
			}
			/* console.log(this.children.target); */
			$('#ending').val(du);
			
		});
	});
});


function allowDrop(ev) {
	  ev.preventDefault();
	}

	function drag(ev) {
	  ev.dataTransfer.setData("text", ev.target.id);
	  console.log(ev.target);
	}
	var tseq = document.location.href.split("tseq=")[1]; 
	function drop(ev) {
	  ev.preventDefault();
	  var data = ev.dataTransfer.getData("text");
	  console.log(ev.target);
	}

</script>
<body>

    <jsp:include page="/WEB-INF/views/commons/preloader.jsp"></jsp:include>

    
    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

      <jsp:include page="/WEB-INF/views/commons/headerAndLeft.jsp"></jsp:include>
        <!--**********************************
            Content body start
        ***********************************-->
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
                                    <div class="col-lg-2 mt-5">
                                    <button type="button" id="calSave" class="btn btn-primary btn-block">저장</button>
                                        <a href="#" data-toggle="modal" data-target="#add-category" class="btn btn-primary btn-block"><i class="ti-plus f-s-12 m-r-5"></i> 일정추가</a>
                                        <input type="date" id="soso" pattern="yyyy-MM-dd">
                                        <input type="date" id="sosi" pattern="yyyy-MM-dd">
                                        <div id="external-events" class="m-t-20">
                                        </div>
                                    </div>
                                    <div class="col-md-10">
                                        <div class="card-box m-b-50">
                                            <div id="calendar"></div>
                                        </div>
                                    </div>

                                    <!-- end col -->
                                    <!-- BEGIN MODAL -->
                                    <div class="modal fade none-border" id="event-modal">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title"><strong>Add New Event</strong></h4>
                                                </div>
                                                <div class="modal-body"></div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
                                                    <button type="button" class="btn btn-success save-event waves-effect waves-light">Create event</button>
                                                    <button type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">Delete</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Modal Add Category -->
                                    <div class="modal fade none-border" id="add-category">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h4 class="modal-title"><strong>Add a category</strong></h4>
                                                </div>
                                                <div class="modal-body">
                                                    <form>
                                                        <div class="row">
                                                            <div class="col-md-6">
                                                                <label class="control-label">Category Name</label>
                                                                <input class="form-control form-white" placeholder="Enter name" type="text" id="category-name" name="category-name">
                                                            </div>
                                                            <div class="col-md-6">
                                                                <label class="control-label">Choose Category Color</label>
                                                                <select class="form-control form-white" data-placeholder="Choose a color..." name="category-color">
                                                                    <option value="success">Success</option>
                                                                    <option value="danger">Danger</option>
                                                                    <option value="info">Info</option>
                                                                    <option value="pink">Pink</option>
                                                                    <option value="primary">Primary</option>
                                                                    <option value="warning">Warning</option>
                                                                </select>
                                                            </div>
                                                            <br>
                                                            <div class="col-md-12">
                                                            	<label class="control-label">Select Team</label>
                                                            	<select id="calTeam" name="calTeam" class="form-control">
																	<c:forEach items="${pjtlist}" var="p">
																				<option value="${p.tseq}">${p.pname}</option>
																	</c:forEach>
																</select>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-default waves-effect" data-dismiss="modal">Close</button>
                                                    <button type="button" id="modalSave" class="btn btn-danger waves-effect waves-light save-category" data-dismiss="modal">Save</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- END MODAL -->
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
        
        
        <!--**********************************
            Footer start
        ***********************************-->
        <jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
        <!--**********************************
            Footer end
        ***********************************-->
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
 
	<script src="<c:url value="/resources/plugins/common/common.min.js" />"></script>
    <script src="<c:url value="/resources/js/custom.min.js" />"></script>
    <script src="<c:url value="/resources/js/settings.js" />"></script>
    <script src="<c:url value="/resources/js/gleek.js" />"></script>
    <script src="<c:url value="/resources/js/styleSwitcher.js" />"></script>
    
    <script src="<c:url value="/resources/plugins/jqueryui/js/jquery-ui.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/moment/moment.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/fullcalendar/js/fullcalendar.min.js"/>"></script>
    <script src="<c:url value="/resources/js/plugins-init/fullcalendar-init.js"/>"></script>

</body>

</html>