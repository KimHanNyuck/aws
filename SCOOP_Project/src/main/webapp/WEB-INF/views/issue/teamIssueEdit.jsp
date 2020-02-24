<!-- 협업공간 이슈 수정 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
    <!-- Pignose Calender -->
   <link href="<c:url value="/resources/plugins/pg-calendar/css/pignose.calendar.min.css" />" rel="stylesheet">
    <!-- Chartist -->
     <link rel="stylesheet" href="<c:url value="/resources/plugins/chartist/css/chartist.min.css" />">
    <link rel="stylesheet" href="<c:url value="/resources/plugins/chartist-plugin-tooltips/css/chartist-plugin-tooltip.css" />">
    <!-- Custom Stylesheet -->
     <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
</head>
<style>
.newissue{
	border-bottom: 1px solid #c8c8c8;
	padding-top: 0.7%;
	padding-bottom: 0.7%;
}
.myissueDetail{
	font-size: 15px;
	margin-left: 3%;
	margin-bottom:1%;
}
.editdelete{
background-color: #E71D36;
border-color: #CCCCCC;
color: #fff;
cursor: pointer;
border-radius: 5px;
}
</style>
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
        <div class="card" >
        <form action="teamIssueEditOk.do" method="POST" enctype="multipart/form-data" onsubmit="return checkDate();">
        <input type="hidden" name="tseq" value="${tissue.tseq}">
        <input type="hidden" name="tiseq" value="${tissue.tiseq}">
		<div class="row"style="margin:2% 2% 0 2%" >
		<div class="col-sm-8">
			<input type="text" class="form-control" name="title" value="${tissue.tititle}" style="border: 0px; border-bottom: 1px solid #ced4da; font-size: 20px">
		</div>
		<div class="col-sm-4" style="padding-right: 15px; text-align: right">
		<span id="editCheckIssue">
		<span class="iconify" data-icon="fa-solid:check" data-inline="false" style="cursor: pointer;font-size: 25px;margin-bottom: 20px;margin-left: 20px;"></span>
		</span>
			<input type="submit" class="form-control editdelete" value="완료" id="editIssue" hidden="">
			<span id="returnIssue">
			<span class="iconify" data-icon="entypo:back" data-inline="false" style="cursor: pointer; font-size: 25px;margin-bottom: 15px;margin-left: 15px;"></span>
			</span>
		</div>
		</div>
		<div class="myissueDetail" id="myissueDate" style="font-size: 15px;margin-left: 3%;margin-bottom:2%; margin-top: 2%"><i class="far fa-calendar-check"style="margin-right:1%;color:#abb335;"></i><input type="text" id="editFrom" name="editFrom" style="border: 0; border-bottom: 1px solid #ced4da; text-align: center" value="${fn:substring(tissue.tistart,0,10)}"> ~ <input type="text" id="editTo" name="editTo" style="border: 0; border-bottom: 1px solid #ced4da; text-align: center" value="${fn:substring(tissue.tiend,0,10)}">
		<span id="dateDelete" style="cursor:pointer;margin-left: 15px"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span></div>
		<div id="edittodoresult">
		<c:forEach items="${mentions}" var="m">
		<div class="myissueDetail" id="myissueMention">
		<sup><i class="fas fa-quote-left" style="color:#ca0000; font-size: 7px"></i></sup> @${m.name} <sup><i class="fas fa-quote-right"style="color:#ca0000;font-size: 7px"></i></sup>
		<span class="divDelete" style="cursor:pointer;"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span>
		<br>
		</div>
		<input type="hidden" name="editMention" value="${m.email}~${m.tmseq}">
		</c:forEach>
				<c:forEach items="${files}" var="f">
		<div class="myissueDetail" id="myissueMention">
		<a href="fileDownload.do?fileName=${f.fdname}"><span class="iconify" data-icon="si-glyph:file-box" data-inline="false"></span>${f.fdname}</a>
		<span class="divDelete" style="cursor:pointer;"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span>
		<br>
		</div>
		<input type="text" hidden="" name="editOriFile" value="${f.fdname}~${f.fdseq}">
		</c:forEach>
			<c:forEach items="${gdrive}" var="gd">
		<div class="myissueDetail" id="myissueGoogledrive">
			<i class="fab fa-google-drive"></i>
			<a href="${gd.tgurl}" onclick="window.open(this.href,'팝업창','width=800, height=800');return false;">${gd.tgfilename}</a>
			<span class="divDelete2" style="cursor:pointer;"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span>
			<br>
		</div>
			<input type="hidden" name="editGfilename" value="${gd.tgfilename}~${gd.tgseq}">
			<input type="hidden" name="editGurl" value="${gd.tgurl}~${gd.tgseq}">
			</c:forEach>
		<c:forEach items="${dowork}" var="work">
		<div class="myissueDetail" id="myissueTodo">
		<i class="far fa-check-circle"style="padding-right: 5px;"></i>${work.fromname}
		<i class="fas fa-long-arrow-alt-right" style="margin-left:5px;margin-right: 5px;"></i>${work.toname}<br>
		: ${work.dowork}
		<span class="divDelete2" style="cursor:pointer;"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span>
		<br>
		</div>
		<input type="hidden" name="editToname" value="${work.toemail}~${work.tdseq}">
		<input type="hidden" name="editDowork" value="${work.dowork}~${work.tdseq}">
		</c:forEach> 
		</div>
        <div class="myissueDetail" style="margin-top: 2%">
        <textarea rows="5" style="width:50%;border: 0; border-bottom: 1px solid #ced4da;" id="editIssuecontent" name="editIssuecontent">${tissue.ticontent}</textarea>
        </div>
        <input type="file" multiple="multiple"  id="fileclick2" name="editFile" hidden="">    
            </form>
            </div> 
            </div>
        </div>
        <!--**********************************
            Content body end
        ***********************************-->
        
        
  <jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->
<div class="list-group" id="editMentionlist" style="display: none">
      <a href="#" class="list-group-item list-group-item-action menli" id="editMen1"style="padding: 5px;">멘션</a> 
      <a href="#" class="list-group-item list-group-item-action menli" id="editMen2"style="padding: 5px">구글 드라이브</a> 
      <a href="#" class="list-group-item list-group-item-action menli" id="editMen3"style="padding: 5px">파일</a> 
      <!-- <a href="#" class="list-group-item list-group-item-action menli" id="editMen7"style="padding: 5px">의사결정</a> --> 
      <a href="#" class="list-group-item list-group-item-action menli" id="editMen4"style="padding: 5px">할 일</a> 
</div>
<div class="list-group" id="editMemlist" style="display: none">
<c:forEach items="${tpmemlist}" var="t">
	<a href="#" class="list-group-item list-group-item-action todo projectmem${t.tseq}" style="padding: 5px; border-radius: 0" id="${t.tseq}/${t.email}">${t.name}</a>
</c:forEach>
</div>
 <div class="list-group" id="edittodo" style="display: none;">
      <label for="todomem">담당자</label> <input
         class="form-control createmodal" type="text" id="edittodomem"
         style="width: 100%" name=""> <br> <label for="todolist">할
         일</label>
      <textarea class="form-control createmodal" rows="3" id="edittodolist"
         style="width: 100%; margin-bottom: 2%" placeholder="할 일을 작성해주세요."></textarea>
      <button type="button" id="edittodomake" class="btn btn-secondary"
         style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">만들기</button>
      <button type="button" id="edittodocancle" class="btn btn-secondary"
         style="background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;">취소</button>
   </div>
    <!--**********************************
        Scripts
    ***********************************-->
    <script src="<c:url value="/resources/plugins/common/common.min.js" />"></script>
    <script src="<c:url value="/resources/js/custom.min.js" />"></script>
    <script src="<c:url value="/resources/js/settings.js" />"></script>
    <script src="<c:url value="/resources/js/gleek.js" />"></script>
    <script src="<c:url value="/resources/js/styleSwitcher.js" />"></script>

    <!-- Chartjs -->
    <script src="<c:url value="/resources/plugins/chart.js/Chart.bundle.min.js" />"></script>
    <!-- Circle progress -->
    <script src="<c:url value="/resources/plugins/circle-progress/circle-progress.min.js" />"></script>
    <!-- Datamap -->
  <script src="<c:url value="/resources/plugins/d3v3/index.js"/>"></script>
    <script src="<c:url value="/resources/plugins/topojson/topojson.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/datamaps/datamaps.world.min.js"/>"></script>
    <!-- Morrisjs -->
    <script src="<c:url value="/resources/plugins/raphael/raphael.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/morris/morris.min.js"/>"></script>
    <!-- Pignose Calender -->
     <script src="<c:url value="/resources/plugins/moment/moment.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/pg-calendar/js/pignose.calendar.min.js"/>"></script>
    <!-- ChartistJS -->
   <script src="<c:url value="/resources/plugins/chartist/js/chartist.min.js"/>"></script>
    <script src="<c:url value="/resources/plugins/chartist-plugin-tooltips/js/chartist-plugin-tooltip.min.js"/>"></script>



     <script src="<c:url value="/resources/js/dashboard/dashboard-1.js"/>"></script>

</body>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script type="text/javascript">
$(function(){
		$("#editFrom").flatpickr();
		$("#editTo").flatpickr();
		   for(let i=0; i<$('#editMemlist').children().length-1; i++){
				for(let j=i+1; j<$('#editMemlist').children().length;j++){
					if($('#editMemlist').children().eq(i).attr('id').split("/")[1] == $('#editMemlist').children().eq(j).attr('id').split("/")[1]){
						$('#editMemlist').children().eq(j).hide();
					}
				}
			}
			for(let i=0; i<$('#editMemlist').children().length; i++){
				if($('#editMemlist').children().eq(i).attr('id').split("/")[0] == $(selectpro).val()){
					$('.projectmem'+$(selectpro).val()).show();
				}
			}
})
$('#dateDelete').click(function(){
 	$("#editFrom").val('');
	$("#editTo").val('');
})
$('#editCheckIssue').click(function(){
	$('#editIssue').click();
})
$('#returnIssue').click(function(){
	history.back();
})
$('.divDelete').click(function(){
	var dValue = $(this).parent().next().attr('value');
	$(this).parent().next().attr('value', dValue+'~delete');
	$(this).parent().remove();
})
$('.divDelete2').click(function(){
	var dValue = $(this).parent().next().attr('value');
	var dValue2 = $(this).parent().next().next().attr('value');
	$(this).parent().next().attr('value', dValue+'~delete');
	$(this).parent().next().next().attr('value', dValue2+'~delete');
	$(this).parent().remove();
})

var tar = 0;
var tar2 = 1;
$('.menli').keydown(function(event) {
	   var key = event.keyCode;
	    switch (key) {
	    case 38:
	       console.log("위");
	       tar2--;
	       break;
	    case 40:
	       tar2++;
	       break;
	    case 39:
	       break;
	    case 37:
	       break;
	    }
	    console.log(tar2);
	    if (tar2 < 0) {
	       tar2 = 0;
	    }
	    if (tar2 > 4) {
	       tar2 = 4;
	    }
	    $('#editMen' + tar2).focus();
	    if ($('#editMen' + tar2).focus()) {
	       $('.menli').css('background-color', '#fff');
	       $('#editMen' + tar2).css(
	             'background-color',
	             'rgba(225, 225, 225,0.5)');
	    }
	    if(event.keyCode == 13){
	       $(this).click();
	    }
	});
	$('#editIssuecontent').keydown(
			function(event) {
				if($('#editMentionlist').css('display')==('flex')){
					console.log('여기서라면?');
					console.log(event.keyCode);
					var key = event.keyCode;
		               switch (key) {
		               case 38:
		                  console.log("위");
		                  tar--;
		                  break;
		               case 40:
		                  tar++;
		                  break;
		               case 39:
		                  break;
		               case 37:
		                  break;
		               }
		               if (tar < 1) {
		                  tar = 1;
		               }
		               if (tar > 5) {
		                  tar = 5;
		               }
		               $('#editMen' + tar).focus();
		               if ($('#editMen' + tar).focus()) {
		                  $('.editMenli').css('background-color', '#fff');
		                  $('#editMen' + tar).css(
		                        'background-color',
		                        'rgba(225, 225, 225,0.5)');
		               }
		               if(event.keyCode == 13){
		               	$(this).click();
		               }
				}
				var top = ($('#editIssuecontent').offset().top);
				var left = ($('#editIssuecontent').offset().left + 490);
				if (event.shiftKey && event.keyCode == 50) {
					console.log("top&left" + top + ", " + left);
					$('#editMentionlist').attr(
							'style',
							'position:fixed; width:20%;top:' + top + 'px;left:'
									+ left + 'px; z-index:4');
					$('#editMentionlist').show();
					$('div').not('#editMentionlist').click(function() {
						$('#editMentionlist').hide();
					});
				}
			});
	$('#editMen1').click(
			function() {
				var top = ($('#editIssuecontent').offset().top);
				var left = ($('#editIssuecontent').offset().left + 490);
				$('#editMentionlist').hide();
				$('#editMemlist').attr(
						'style',
						'position:fixed; width:20%;top:' + top + 'px;left:'
								+ left + 'px; z-index:4');
				$('#editMemlist').show();
				$('#editMemlist').attr('class', 'list-group mem');
			});
	$('#editMen2').click(function() {
		$('#editMentionlist').hide();
		var text = "";
		text = $('#editIssuecontent').val().replace("@", "");
		$('#editIssuecontent').val(text);
		if("${role}"=="ROLE_USER"){
			   Swal.fire({
					  title : '이용 불가',
					  text : '무료회원은 구글드라이브를 이용할 수 없습니다!',
					  icon : 'warning',
					  confirmButtonColor: '#d33'
		   })
		   return;
		}
		$('#auth').click();
		$('#editIssuecontent').append($('.picker-dialog'));

	});
	$('#editMen3').click(function() {
		$('#editMentionlist').hide();
		$('#fileclick2').click();
	});
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$('#imgpreview').attr('src', e.target.result);
				if (e.target.result.substring(5, 10) == 'image') {
					//$('#imgpreview').show();
				} else {
					$('#imgpreview').hide();
				}
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	$("#fileclick2").change(function() {
		readURL(this);
		console.log($("#fileclick2")[0].files);
		var files = $("#fileclick2")[0].files;
		$('#filename').empty();
		//$('#filename').append($("#fileclick2").val().substring(12));
		var text = "";
		text = $('#editIssuecontent').val().replace("@", "");
		$('#editIssuecontent').val(text);
		for(let i=0; i<$("#fileclick2")[0].files.length;i++){
		$('#edittodoresult').append('<div class="myissueDetail" id="myissueMention">'+
				'<a href="fileDownload.do?fileName='+files[i].name+'"><span class="iconify" data-icon="si-glyph:file-box" data-inline="false"></span>'+files[i].name+'</a>'+
				'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="divDelete" style="cursor:pointer;"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span>'+
				//'<input type="file" multiple="multiple" hidden="" name="editFile" value="'+files[i].name+'">'+
				'<br>'+
				'</div>')
				$('.divDelete').click(function(){
	$(this).parent().remove();
})
		}
$('#todoresult').show();
		
	});
	$('#editMen4').click(
			function() {
				var text = "";
				text = $('#editIssuecontent').val().replace("@", "");
				$('#editIssuecontent').val(text);
				var top = ($('#editIssuecontent').offset().top);
				var left = ($('#editIssuecontent').offset().left + 490);
				$('#editMentionlist').hide();
				$('#editMemlist').attr(
						'style',
						'position:fixed; width:20%;top:' + top + 'px;left:'
								+ left + 'px; z-index:4');
				$('#editMmemlist').show();
			});
	$('.todo')
			.click(
					function() {
						var top = ($('#editIssuecontent').offset().top);
						var left = ($('#editIssuecontent').offset().left + 490);
						if ($(this).parents('#editMemlist').attr('class') == 'list-group mem') {
							console.log("if");
							var text = "";
							text = $('#editIssuecontent').val().replace("@", "");
							$('#editIssuecontent').val(text);
							$('#edittodoresult').append('<div class="myissueDetail" id="myissueMention">'+
									'<sup><i class="fas fa-quote-left" style="color:#ca0000; font-size: 7px"></i></sup> @'+ $(this).text() + ' <sup><i class="fas fa-quote-right"style="color:#ca0000;font-size: 7px"></i></sup>'+
									'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="divDelete" style="cursor:pointer;"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span>'+
									'<input type="hidden" name="editMention" value="'+$(this).attr('id').split('/')[1]+'">'+
									'<br>');
							$('#edittodoresult').append('<input type="hidden" name="mentions" value="'+ $(this).attr('id').split('/')[1] + '">');
							console.log($(this).text());
							$('#edittodoresult').show();
							$('#editMemlist').hide();
							$('#editMemlist').attr('class', 'list-group');
							$('.divDelete').click(function(){
								$(this).parent().remove();
							})
						} else {
							console.log("else");
							$('#editMemlist').hide();
							$('#edittodo')
									.attr(
											'style',
											'border-radius:0.25em;padding:1%;position:fixed; width:20%;top:'
													+ (top - 208)
													+ 'px;left:'
													+ left
													+ 'px; z-index:4;background-color:white');
							$('#edittodo').show();
							$('#edittodomem').val($(this).text());
							$('#edittodomem').attr('name', $(this).attr('id'));
						}
					});
	$('#edittodomake')
			.click(
					function() {
						$('#edittodo').hide();
						var text = "";
						text = $('#editIssuecontent').val().replace("@", "");
						$('#editIssuecontent').val(text);
						$('#edittodoresult').append('<div class="myissueDetail" id="myissueTodo">'+
								'<i class="far fa-check-circle"style="padding-right: 5px;"></i>${sessionScope.name}'+
								'<i class="fas fa-long-arrow-alt-right" style="margin-left:5px;margin-right: 5px;"></i>'+ $('#edittodomem').val()+'<br>'+
								': '+$('#edittodolist').val()+
								'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="divDelete" style="cursor:pointer;"><span class="iconify" style="font-size: 20px" data-icon="octicon:x" data-inline="false"></span></span>'+
								'<input type="hidden" name="editToname" value="'+$('#edittodomem').attr('name').split("/")[1]+'">'+
								'<input type="hidden" name="editDowork" value="'+$('#edittodolist').val()+'">'+
								'<br>'+
								'</div>')
						$('#edittodoresult').show();
						$('#edittodolist').val('');
						$('.divDelete').click(function(){
							$(this).parent().remove();
						})
					})
	$('#edittodocancle').click(function() {
		$('#edittodo').hide();
		var text = "";
		text = $('#editIssuecontent').val().replace("@", "");
		$('#editIssuecontent').val(text);
		$('#edittodolist').val('');
	});
	function checkDate(){
		if($('#editFrom').val()!=''){
			if($('#editTo').val()==''){
			   Swal.fire({
					  title : '일정을 둘다 넣어야 합니다!',
					  icon : 'warning',
					  confirmButtonColor: '#d33'
			   })
				return false;
			}else{
				return true;
			}
		}else if($('#editTo').val()!=''){
			if($('#editFrom').val()==''){
				Swal.fire({
					  title : '일정을 둘다 넣어야 합니다!',
					  icon : 'warning',
					  confirmButtonColor: '#d33'
			   })
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}
</script>
</html>