<!-- 협업공간 공지사항 detail jsp -->
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
		//팀 공자사항 디테일 수정
		$('#pjNoticeEd').click(function(){
			location.href="pjNoticeEdit.do?pnseq=${detail.pnseq}";
		});
		//팀 공지사항 디테일 삭제 
		$('#pjNoticeDel').click(function(){
			Swal.fire({
				   title:'공지사항을 삭제하시겠습니까?',
				   text: "삭제하시면 공지사항의 모든 정보가 사라집니다!",
				   icon: 'warning',
				   showCancelButton: true,
				   confirmButtonColor: '#d33',
				   cancelButtonColor: '#c8c8c8',
				   confirmButtonText: '확인',
				   cancelButtonText: '취소'
				 }).then((result) => {
				   if (result.value) {
					   location.href="pjNoticeDelete.do?pnseq=${detail.pnseq}&tseq=${detail.tseq}";
				   }
				 })
			
		});
		//팀 공지사항으로 돌아가기
		$('#pjNoticeBack').click(function(){
			location.href="projectNotice.do?tseq=${detail.tseq}";
		});
		
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
	margin-left: 1%;
	margin-right: 1%;
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
        <div class="content-body"style="height: 680px;">
        <div class="container-fluid row" style="padding-right: 15px; margin-right: 0px;margin-left: 0px; padding-left: 15px;">
        <div class="card" style="padding-left: 15px;padding-right: 15px; padding-top:1%;width:100%;height: auto;overflow: auto;">
		<div class="row"style="margin:2% 2% 0 2%" >
				<div class="col-sm-9"style="padding-left: 0px;">
				<span class="iconify" style="font-size: 30px;margin-bottom: 5px;color: #E71D36;" data-icon="ant-design:notification-outlined" data-inline="false"></span>
				<span id="myissueSubject" style="font-size: 23px;">${detail.pntitle}</span>
				<br>
				<span style="padding-right: 5%;padding-top:1%;">${detail.name}&nbsp;&nbsp;${fn:substring(detail.pntime,0,16)}</span>
				</div>
				<c:if test="${rank == 100}">
					<div class="col-sm-1" style="text-align: right; padding: 0">
					<span id="pjNoticeEd">
					<span class="fas fa-cog" id="pjnoticeedit" style="margin-left: 5px;cursor: pointer; font-size: 25px;padding-top: 15px"></span>
					</span>
					</div>
					<div class="col-sm-1" style="text-align: center; padding: 0">
					<span id="pjNoticeDel">
					<span class="iconify" data-icon="topcoat:delete" data-inline="false" style="cursor: pointer;font-size: 25px;margin-bottom: 5px;margin-top: 15px"></span>
					</span>
					</div>
					<div class="col-sm-1" style="padding-left: 0px;">
					<span id="pjNoticeBack">
					<span class="iconify" data-icon="entypo:back" data-inline="false" style="cursor: pointer; font-size: 25px;margin-bottom: 5px;margin-top: 15px"></span>
					</span>
					</div>
				</c:if>
				<c:if test="${rank == 300}">
					<div class="col-sm-2" style="padding-left: 0px;">
					</div>
					<div class="col-sm-1" style="padding-left: 0px;">
					<span id="pjNoticeBack">
					<span class="iconify" data-icon="entypo:back" data-inline="false" style="cursor: pointer; font-size: 25px;margin-bottom: 5px;margin-top: 15px"></span>
					</span>
					</div>
				</c:if>		
		</div>
		<hr>
        <div class="myissueDetail" style="height:500px ;border: 1px solid rgba(0,0,0,0.5); border-radius: 0.5rem;padding: 1%; overflow: auto;font-size: 17px;">
        ${detail.pncontent}
       	<img src="resources/images/logo/ScoopTitle.png" style="width:500px;height: auto;opacity:0.5;position:absolute;left: 30%;margin-top: 5%;">
        </div>    
            <!-- #/ container -->
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