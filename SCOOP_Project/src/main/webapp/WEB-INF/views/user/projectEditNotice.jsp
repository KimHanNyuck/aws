<!-- 협업공간 공지사항 수정 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
<!-- Pignose Calender -->
<link
	href="<c:url value="/resources/plugins/pg-calendar/css/pignose.calendar.min.css" />"
	rel="stylesheet">
<!-- Chartist -->
<link rel="stylesheet"
	href="<c:url value="/resources/plugins/chartist/css/chartist.min.css" />">
<link rel="stylesheet"
	href="<c:url value="/resources/plugins/chartist-plugin-tooltips/css/chartist-plugin-tooltip.css" />">
<!-- Custom Stylesheet -->
<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">

</head>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<style>
.newissue {
	border-bottom: 1px solid #c8c8c8;
	padding-top: 0.7%;
	padding-bottom: 0.7%;
}

.myissueDetail {
	font-size: 15px;
	margin-left: 3%;
	margin-bottom: 1%;
}
</style>
<script type="text/javascript">
//공지사항 수정완료 스윗얼럿 
$(function(){
	 $('#noticeEditOk').click(function(){
		 Swal.fire({
			  icon: 'success',
			  title: '수정 완료',
			  showConfirmButton: false,
			  timer: 1500
			})
		});
});

//프로젝트 공지사항작성 validation
function checkpjnotice() {
//이슈 제목 공백 확인
 if($("#pntitle").val() == ""){
    Swal.fire("제목을 입력해주세요.");
   $("#pntitle").focus();
   return false;
 }

 //이슈 설명 공백 확인
 if($("#pncontent").val() == ""){
    Swal.fire("내용을 입력해주세요.");
   $("#pncontent").focus();
   return false;
 }

return true;
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
		<form action="pjNoticeEditOk.do?tseq=${edit.tseq}" method="POST" onsubmit="return checkpjnotice()">
			<div class="content-body" style="height: 680px;">
				<div class="container-fluid row"
					style="padding-right: 15px; margin-right: 0px; margin-left: 0px; padding-left: 15px;">
					<div class="card"
						style="padding-left: 15px; padding-right: 15px; padding-top: 1%; width: 100%; height: auto; overflow: auto;">
						<div class="row" style="margin: 7% 2% 3% 2%;">
						<h3 style="text-align: center;margin-left: 43%;margin-bottom: 2%"><span class="iconify" style="font-size: 35px;margin-bottom: 5px;color: #E71D36;" data-icon="ant-design:notification-outlined" data-inline="false"></span> 공지사항 수정</h3>
							<input class="form-control createmodal" type="text" id="pntitle"name="pntitle" placeholder="공지사항 제목을 입력해주세요" style="width: 75%; margin-left: 13%; border-radius: 0.5rem;"value="${edit.pntitle}">
						</div>
						<div class="myissueDetail" style="margin: 0 2% 3% 2%;">
							<textarea class="form-control createmodal" rows="10"
								id="pcontent_Edit" name="pncontent"
								style="width: 75%; margin-left: 13%; border-radius: 0.5rem;height: 300px;" placeholder="공지사항을 내용을 입력해주세요">${edit.pncontent}</textarea>
						</div>
						<div class="row" style="padding-left: 38%;">
						<input type="hidden" name="pnseq" value="${edit.pnseq}">
						<input id="noticeEditOk" type="submit" class="btn btn-secondary"  style="width:150px;background-color: #E71D36; border-color: #CCCCCC; color: #fff;margin-right:2%; cursor: pointer;" value="작성 완료">
						<button type="button" class="btn btn-secondary" style="float:right;width:150px;background-color: #E71D36; border-color: #CCCCCC; color: #fff; cursor: pointer;"data-dismiss="modal">
							취소
						</button>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
	<!-- #/ container -->
	<!--**********************************
            Content body end
        ***********************************-->
	<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
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
	<script
		src="<c:url value="/resources/plugins/chart.js/Chart.bundle.min.js" />"></script>
	<!-- Circle progress -->
	<script
		src="<c:url value="/resources/plugins/circle-progress/circle-progress.min.js" />"></script>
	<!-- Datamap -->
	<script src="<c:url value="/resources/plugins/d3v3/index.js"/>"></script>
	<script
		src="<c:url value="/resources/plugins/topojson/topojson.min.js"/>"></script>
	<script
		src="<c:url value="/resources/plugins/datamaps/datamaps.world.min.js"/>"></script>
	<!-- Morrisjs -->
	<script
		src="<c:url value="/resources/plugins/raphael/raphael.min.js"/>"></script>
	<script src="<c:url value="/resources/plugins/morris/morris.min.js"/>"></script>
	<!-- Pignose Calender -->
	<script src="<c:url value="/resources/plugins/moment/moment.min.js"/>"></script>
	<script
		src="<c:url value="/resources/plugins/pg-calendar/js/pignose.calendar.min.js"/>"></script>
	<!-- ChartistJS -->
	<script
		src="<c:url value="/resources/plugins/chartist/js/chartist.min.js"/>"></script>
	<script
		src="<c:url value="/resources/plugins/chartist-plugin-tooltips/js/chartist-plugin-tooltip.min.js"/>"></script>



	<script src="<c:url value="/resources/js/dashboard/dashboard-1.js"/>"></script>

</body>
</html>