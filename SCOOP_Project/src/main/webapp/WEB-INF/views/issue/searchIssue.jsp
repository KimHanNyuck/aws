<!-- 전체 이슈 키워드 검색 결과 jsp -->
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
<style>
.newissue{
	border-bottom: 1px solid #c8c8c8;
	padding-top: 0.7%;
	padding-bottom: 0.7%;
}
</style>
<script type="text/javascript">
console.log(${myIssue});
console.log(${teamIssue});
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
        <div class="card" style="padding-bottom: 30px;">
		<div class="row" style="margin: 2% 2% 15px 2%">
				<h3 style="padding-left: 15px;">검색 결과</h3>
		</div>
		<hr style="margin-top: 0;margin-left: 2%; margin-right: 2%">
		<div class="row" style="margin-left: 2%; margin-right: 2%">
         <div class="col-sm-7 newissue" style="padding-left: 81px;" >
         	제목
         </div>
         <div class="col-sm-3 newissue" style="padding-left: 10px;">
         	협업 공간 
         </div>
         <div class="col-sm-2 newissue">
         	작성시간 
         </div>
      	</div>
      	
			<c:forEach items="${teamIssue}" var="ti">
			<div class="row" style="margin-left: 2%; margin-right: 2%" id="row">
			<div class="col-sm-7 newissue" >
			<c:choose>
				<c:when test="${ti.isprocess==0}">
				<div id="create" class="iconify" data-icon="uil:file-exclamation-alt" data-inline="false" style="width:27px;height: auto;"></div>
				</c:when>
				<c:when test="${ti.isprocess==1}">
				<div id="ing" class="iconify" data-icon="uil:file-edit-alt" data-inline="false" style="width:27px;height: auto;color: #2671bd;"></div>
				</c:when>
				<c:when test="${ti.isprocess==2}">
				<div id="stop" class="iconify" data-icon="uil:file-block-alt" data-inline="false" style="width:27px;height: auto;color:#cca352"></div>
				</c:when>
				<c:when test="${ti.isprocess==3}">
				<div id="finish" class="iconify" data-icon="uil:file-check-alt" data-inline="false" style="width:27px;height: auto;color:#26805c"></div>
				</c:when>	
			</c:choose>
			<a href="teamissueDetail.do?tiseq=${ti.tiseq}" style="margin-left: 5%;">${ti.tititle}</a>			
			</div>
			<div class="col-sm-3 newissue" >
			<a class="pnameHover" href="projectDetail.do?tseq=${ti.tseq}" style="color:#2c9aa8;">${ti.pname}</a>
			</div>
			<div class="col-sm-2 newissue" >
			${fn:substring(ti.tidate,0,16)}
			</div>
			</div>
			</c:forEach>
			
			<c:forEach items="${myIssue}" var="my">
			<div class="row" style="margin-left: 2%; margin-right: 2%" id="row">
			<div class="col-sm-7 newissue" >
			<div class="iconify" data-icon="uil:file-lock-alt" data-inline="false" style="width:27px;height: auto;color:black"></div>			
			<a href="myissueDetail.do?piseq=${my.piseq}" style="margin-left: 5%;">${my.pititle}</a>			
			</div>
			<div class="col-sm-3 newissue" >
			<a class="pnameHover" href="private.do" style="color:#2c9aa8;">프라이빗 공간</a>
			</div>
			<div class="col-sm-2 newissue" >
			${fn:substring(my.pidate,0,16)}
			</div>	
			</div>
			</c:forEach>
			
<%-- 			<c:forEach items="${pi}" var="pi">
			<div class="col-sm-12 newissue" >
			<div class="iconify" data-icon="uil:file-lock-alt" data-inline="false" style="width:27px;height: auto;"></div>
			<div style="float: right;min-width:97%;">
			<a href="myissueDetail.do?piseq=${pi.piseq}">${pi.pititle}</a>
			<br>
			<a class="pnameHover" href="private.do" style="color:#2c9aa8;">프라이빗 공간</a>&nbsp;&nbsp;&nbsp;${pi.pidate} 
			</div>
			</div>
			</c:forEach> --%>
			<div id="loadPlus" data-toggle="tooltip" data-placement="bottom" title="더 보기" >
			<div id="load" class="iconify" style="font-size: 40px; color:#464a53;cursor: pointer; margin-left: 627px; margin-top: 1%;" data-icon="mdi:chevron-double-down" data-inline="false">더 보기</div>
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
	
<script type="text/javascript">
$(document).ready(function(){
	//더보기 스타일 변경
	$('#load').mouseover(function(){
		$(this).css("color","#E71D36");
	});
	$('#load').mouseout(function(){
		$(this).css("color","#464a53");
	});
	var temp = 0;
	var moreEventArray = document.querySelectorAll(".card > #row ");
	if(moreEventArray.length<=10){
		$('#load').remove();
       	$('#loadPlus').remove();
        $('.tooltip').remove();
	}
	 $(moreEventArray).attr("hidden","hidden");	
	 $(moreEventArray).slice(0,10).removeAttr("hidden");
	 $(moreEventArray).slice(0,10);
	 temp = 10;
	$("#load").click(function(e){
		console.log(moreEventArray);
		/* console.log($('.card'));
		console.log($('.card > a'));
		console.log($('.card > a > .row'));
		console.log($(".card > a > .row").val()); */
		console.log("if");
		$(moreEventArray).slice(temp,temp+10).removeAttr("hidden");
		 temp +=10;
		if(moreEventArray.length<temp+10){
			$(moreEventArray).slice(temp,10).removeAttr("hidden");
				if(temp-moreEventArray.length>=0){
		            $('#load').remove();
		            $('#loadPlus').remove();
		            $('.tooltip').remove();
		         }
			}
		
			
	}); 

});
</script>
</body>
</html>