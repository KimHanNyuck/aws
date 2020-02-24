<!-- 프라이빗 이슈 detail jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html lang="en">

<head>
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
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script type="text/javascript">
$(function(){
		console.log("${myissue.email}");
		console.log("${sessionScope.email}");
		$('#editIssue').click(function(){ //이슈 수정으로 이동
			location.href = 'myissueEdit.do?piseq='+${myissue.piseq};
		})
		$('#deleteIssue').click(function(){ //이슈 삭제
			   Swal.fire({
				   title: '정말로 이슈를 삭제하시겠습니까??',
				   text: "삭제하시면 이슈의 모든 정보가 사라집니다!",
				   icon: 'warning',
				   showCancelButton: true,
				   confirmButtonColor: '#d33',
				   cancelButtonColor: '#c8c8c8',
				   confirmButtonText: '확인',
				   cancelButtonText: '취소'
				 }).then((result) => {
				   if (result.value) {
					   location.href = 'deleteMyIssue.do?piseq='+${myissue.piseq};
				   }
				 })
		})
	$('#comeback').click(function(){ //뒤로가기
		history.back();
	})
	});
</script>
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
        <div class="card">
        <div class="row" style="margin:2% 2% 0 2%;padding-left: 1%;">
        <div class="col-sm-8">
        <span data-toggle="tooltip" data-placement="top" title="발의됨" >
		<span class="iconify" data-icon="uil:file-lock-alt" data-inline="false" style="width:27px;height: auto; mar"></span>
		</span>
		<span  style="font-size: 17px; padding-left: 1%;">프라이빗 공간</span>
		</div>
		<c:if test="${myissue.email==sessionScope.email}">
		<div class="col-sm-4" style=" padding-left: 250px;">
        	<span class="fas fa-cog"  id="editIssue" style="margin-left: 5px;cursor: pointer; font-size: 25px;"   ></span>
			<span class="iconify" id="deleteIssue" data-icon="topcoat:delete" data-inline="false" style="cursor: pointer;font-size: 25px;margin-bottom: 15px;margin-left: 20px;"></span>
			<span class="iconify" id="comeback" data-icon="entypo:back" data-inline="false" style="cursor: pointer; font-size: 25px;margin-bottom: 10px;margin-left: 15px;"></span>
		</div>
		</c:if>
			
		
        </div>
        	<div style="margin-right: 0; margin-left: 0;">
			<span id="myissueSubject" style="padding-left: 60px;font-size: 20px;">${myissue.pititle}</span>
			<span style="float:right ;padding-top: 1%;padding-right: 55px;">${fn:substring(myissue.pidate,0,16)}</span>
			</div>
		
        <hr style="margin:10px 2% 0 2%;">
		
		<c:choose>
        <c:when test="${myissue.pistart!=null}">
		<div class="myissueDetail" id="myissueDate" style="font-size: 15px;margin-left: 3%;margin-bottom:2%;padding-left: 20px;margin-top: 2%;"><i class="far fa-calendar-check"style="margin-right:1%;color:#abb335;"></i>${fn:substring(myissue.pistart,0,10)} ~ ${fn:substring(myissue.piend,0,10)}</div>
		</c:when>
		<c:otherwise>
		<div class="myissueDetail" id="myissueDate" style="font-size: 15px;margin-left: 3%;margin-bottom:2%;padding-left: 20px;margin-top: 2%;"><i class="far fa-calendar-check"style="margin-right:1%;color:#abb335;"></i>등록된 일정이 없습니다.</div>
		</c:otherwise>
		</c:choose>
		<c:if test="${mymention!='[]' || files!='[]' || mygdrive!='[]' || mydowork!='[]'}">
		<div class="row" style="height:135px; overflow: auto; margin-left: 35px; margin-right: 5px;padding-top:1%;padding-bottom:1%;width: 824px;border: 1px solid rgba(0, 0, 0, 0.5); border-radius: 0.5rem">
		<c:forEach items="${mymention}" var="m">
		<div class="myissueDetail col-sm-11" id="myissueMention" style="padding-left: 10px;">
		<sup><i class="fas fa-quote-left" style="color:#ca0000; font-size: 7px"></i></sup> @${m.name} <sup><i class="fas fa-quote-right"style="color:#ca0000;font-size: 7px"></i></sup>
		<br>
		</div>
		</c:forEach>
		<c:forEach items="${files}" var="f">
		<div class="myissueDetail col-sm-11" id="myissueMention" style="padding-left: 10px;">
		<a href="fileDownload.do?fileName=${f.pfdname}"><span class="iconify" data-icon="si-glyph:file-box" data-inline="false"></span>${f.pfdname}</a>
		<br>
		</div>
		</c:forEach>
		<c:forEach items="${mygdrive}" var="gd">
		<div class="myissueDetail col-sm-11" id="myissueGoogledrive" style="padding-left: 10px;">
			<i class="fab fa-google-drive"></i>
			<a href="${gd.pgurl}" onclick="window.open(this.href,'팝업창','width=800, height=800');return false;">${gd.pgfilename}</a>
			<br>
		</div>
			</c:forEach>
		<c:forEach items="${mydowork}" var="work">
		<div class="myissueDetail col-sm-11" id="myissueTodo" style="padding-left: 10px;">
		<i class="far fa-check-circle"style="padding-right: 5px;"></i>${work.fromname}
		<i class="fas fa-long-arrow-alt-right" style="margin-left:5px;margin-right: 5px;"></i>${work.toname}<br>
		: ${work.pdowork}
		<br>
		</div>
		</c:forEach>
		</div>
		</c:if>
		<br>
		<div class="row" style="overflow: auto;margin-left: 5px; margin-right: 5px;"> 
        <div class="myissueDetail col-sm-11" style="padding-left: 20px;height:100px;overflow: auto;">
        ${myissue.picontent}
        </div>    
            <!-- #/ container -->
            </div> 
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
</html>