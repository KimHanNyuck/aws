<!-- 내가 북마크한 목록 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
    <!-- Pignose Calender -->
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
<style>
.newissue{
	border-bottom: 1px solid #c8c8c8;
	padding-top: 0.7%;
	padding-bottom: 0.7%;
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
		<div class="row" style="margin: 2% 2% 5px 2%">
			<div class="col-sm-12" style="padding-left: 15px">
				<h3>북마크</h3>
			</div>
		</div>
		<hr style="margin-top: 0;margin-left: 2%; margin-right: 2%">
		<div class="row" style="margin-left: 2%; margin-right: 2%">
         
         <div class="col-sm-3 newissue" >
         	협업 공간
         </div>
         <div class="col-sm-5 newissue">
         	글 제목
         </div>
         <div class="col-sm-3 newissue">
         	작성자
         </div>
         <div class="col-sm-1 newissue">
         	취소
         </div>
      	</div>
		
		<c:if test="${bookMarkList =='[]' }">
			<div class="row countRow" style="margin-left: 2%; margin-right: 2%" id="ialarm">
				<div class="col-sm-12 newissue" id="al">
				<img src= '<c:url value="/resources/images/logo/ScoopBig.png"/>' style="width: 60px;padding-right: 5px;">
					아직 북마크를 안하셨나요? 원하는 이슈를 북마크해서 저장해보세요 ^ㅁ^!
				</div>
			</div>
		</c:if>
		<c:forEach items="${bookMarkList}" var="blist">
		<div class="row bm" style="margin-left: 2%; margin-right: 2%" id="row">
	
			<c:choose>
				<c:when test="${blist.tiseq != 0}">
					<div class="col-sm-3 newissue"><!-- <i class="fas fa-angle-double-right" id="" name=""></i> -->
					<c:if test="${fn:length(blist.pname) > 20}">
						<a href="projectDetail.do?tseq=${blist.tseq}"><c:out value="${fn:substring(blist.pname,0,20)}"/>...</a>
					</c:if>
					<c:if test="${fn:length(blist.pname) <= 20}">
						<a href="projectDetail.do?tseq=${blist.tseq}"><c:out value="${fn:substring(blist.pname,0,20)}"/></a>
					</c:if>
					</div>
					<div class="col-sm-5 newissue">
					<c:if test="${fn:length(blist.tititle) > 40}">
						<a href="teamissueDetail.do?tiseq=${blist.tiseq}"><c:out value="${fn:substring(blist.tititle,0,20)}"/>...</a>
					</c:if>
					<c:if test="${fn:length(blist.tititle) <= 40}">
						<a href="teamissueDetail.do?tiseq=${blist.tiseq}"><c:out value="${fn:substring(blist.tititle,0,20)}"/></a>
					</c:if>
					</div>
					<div class="col-sm-3 newissue">
						${blist.tiname}
					</div>
					<div class="col-sm-1 newissue" style="padding-left: 25px;">
						<i class="fas fa-times bookmark" id="timark" name="${blist.tiseq}"></i>
					</div>
				</c:when>
				<c:when test="${blist.piseq != 0}">
					<div class="col-sm-3 newissue" >
						<a href="private.do">프라이빗 공간</a>
					</div>
					<div class="col-sm-5 newissue" >
					<c:if test="${fn:length(blist.pititle) > 40}">
						<a href="myissueDetail.do?piseq=${blist.piseq}"><c:out value="${fn:substring(blist.pititle,0,40)}"/>...</a>
					</c:if>
					<c:if test="${fn:length(blist.pititle) <= 40}">
						<a href="myissueDetail.do?piseq=${blist.piseq}"><c:out value="${fn:substring(blist.pititle,0,40)}"/></a>
					</c:if>
					</div>
					<div class="col-sm-3 newissue" >
						${blist.piname}
					</div>
					<div class="col-sm-1 newissue" style="padding-left: 25px;">
						<i class="fas fa-times bookmark" id="pimark" name="${blist.piseq}" style="cursor: pointer;"></i>
					</div>
				</c:when>
			</c:choose>
			
		
		</div>
		</c:forEach>
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

/* 북마크 제거 */
	$(function(){
		
		$('.bookmark').click(function(){
			let deleteline = $(this).parents('div.bm');
		 	let seq = $(this).attr('name');
			let id = $(this).attr('id');
			let tiseq; let piseq;
			console.log('seq : ' + seq + " / id : " + id);

			if(id == "timark"){
				console.log('if문 ti');
				tiseq = seq;
				piseq = -1;
			}else if(id == "pimark"){
				console.log('if문 pi');
				piseq = seq;
				tiseq = -1;
			}

			seq = {"tiseq":tiseq, "piseq":piseq};
			console.log("data : " + seq);
			console.log("data : " + seq.tiseq + " / piseq : " + seq.piseq);

			$.ajax({
				url : "delbook.do",
				type : "POST",
				data : seq,
				success : function(data){
					console.log('성공');
					Swal.fire({
			    		  title: "북마크 삭제",
			    		  text: "북마크 삭제",
			    		  icon: "success",
			    		  button: "확인"
			    	})
			    	deleteline.remove();
				},
				error : function(err){
					console.log('실패');
					Swal.fire({
			    		  title: "북마크 삭제 에러",
			    		  text: "북마크 삭제 실패",
			    		  icon: "info",
			    		  button: "확인"
			    	})
				}
			});
		})
	});
</script>
</body>
</html>