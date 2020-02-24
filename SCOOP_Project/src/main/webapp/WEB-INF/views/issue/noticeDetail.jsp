<!-- 공지사항 detail jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html lang="en">
<c:set var="role" value="${sessionScope.role}" />
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
		$('#editIssue').click(function(){
			location.href = 'noticeEdit.do?bnseq='+${notice.bnseq};
		})
		
		$('#deleteIssue').click(function(){
			   Swal.fire({
				   title: '정말로 공지사항을 삭제하시겠습니까??',
				   text: "삭제하시면 공지사항의 모든 정보가 사라집니다!",
				   icon: 'warning',
				   showCancelButton: true,
				   confirmButtonColor: '#d33',
				   cancelButtonColor: '#c8c8c8',
				   confirmButtonText: '확인',
				   cancelButtonText: '취소'
				 }).then((result) => {
				   if (result.value) {
					   location.href = 'deleteNoitce.do?bnseq='+${notice.bnseq};
				   }
				 })
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
        <div class="card" >
		<div class="row"style="margin:2% 2% 0 2%" >
		<div class="col-sm-10">
		<span class="iconify" style="font-size: 40px;margin-bottom: 5px;color: #E71D36;" data-icon="ant-design:notification-outlined" data-inline="false"></span>
		<span id="noticeSubject" style="font-size: 25px;padding-top: 2%;">${notice.bntitle}</span>
		</div>
		<c:if test="${role == 'ROLE_ADMIN'}">
		<div class="col-sm-2" style="padding-top: 2%;padding-left: 8%;">
		<span data-toggle="tooltip" data-placement="top" title="프라이빗 이슈 수정" >
        	<span class="fas fa-cog"  id="editIssue" style="margin-left: 5px;cursor: pointer; font-size: 25px"   ></span>
         </span>
         <span data-toggle="tooltip" data-placement="top" title="프라이빗 이슈 삭제">
			<span class="iconify" id="deleteIssue" data-icon="octicon:x" data-inline="false" style="cursor: pointer;font-size: 30px;margin-bottom: 12px;margin-left: 20px;"></span>
		</span>
		</div>
		
		</c:if>
		</div>	
		<hr>
		<div style="height:520px ;border: 1px solid rgba(0,0,0,0.5);margin-left: 2%;margin-right: 2%;border-radius: 0.5rem;padding: 1% 2% 1% 2%;">
	        <div class="myissueDetail" style="margin-left: 0px;margin-bottom: 0px;font-size: 17px;">
	        ${notice.bncontent}
	        <img src="resources/images/logo/ScoopTitle.png" style="width:500px;height: auto;opacity:0.5;position:absolute;left: 30%;">
	        </div>    
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