<!-- 내정보에서 외부 연결 서비스 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
    <!-- Custom Stylesheet -->
    <link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">

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
        <br>
            <div class="container-fluid">
        <div class="card" style="min-height: 1080px">
		<div class="row" style="margin: 2%">
			<div class="col-sm-12" style="padding-left: 0">
				<h3>내 정보</h3>
			</div>
		</div>
		<div class="row" style="margin-left: 2%;">
			<ul class="nav nav-pills">
			    <li class="nav-item">
			      <a class="nav-link" href="memberEdit.do?${sessionScope.email}">내 정보</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="app-external.do">외부 서비스 연결</a>
			    </li>
			    <li class="nav-item">
			      <a class="nav-link" href="paymentPage.do">가격 및 결제</a>
			    </li>
		    </ul>
		</div>
		<hr style="margin-top: 0">
		<div class="row" style="margin-left: 4%; margin-right: 2%; margin-top: 1%">
			<div class="col-sm-8" style="padding-left: 0; border-bottom: 1px solid #c8c8c8; padding-bottom: 2%">
				<h4>외부 서비스 연결</h4>
				사용하고 계신 서비스와 스쿱 연결하면 더욱 효율적인 협업이 가능해 집니다.<br>
				지금, 스쿱 안에서 모든것이 가능한 환경을 만들어 보세요.
			</div>
			<hr>
			<div class="col-sm-12" style="padding-left: 0; padding-top: 2%">
				<button class="btn btn-outline-secondary" style="margin-bottom:1%; width: 60%; background-color: white; text-align: left;font-size: 18px"><span class="iconify" data-icon="ant-design:github-filled" data-inline="false" style="width: 20px;height: auto;"></span> Github <span style="float: right"><span class="iconify" data-icon="dashicons:admin-plugins" data-inline="false" style="width: 20px;height: auto;"></span> 연결하기</span></button>
				<button class="btn btn-outline-secondary" style="margin-bottom:1%; width: 60%; background-color: white; text-align: left;font-size: 18px"><span class="iconify" data-icon="whh:googledrive" data-inline="false" style="width: 20px;height: auto;"></span> Google Drive <span style="float: right"><span class="iconify" data-icon="dashicons:admin-plugins" data-inline="false" style="width: 20px;height: auto;"></span> 연결하기</span></button>
				<button class="btn btn-outline-secondary" style="margin-bottom:1%; width: 60%; background-color: white; text-align: left;font-size: 18px"><span class="iconify" data-icon="mdi:gmail" data-inline="false" style="width: 20px;height: auto;"></span> Gmail <span style="float: right"><span class="iconify" data-icon="dashicons:admin-plugins" data-inline="false" style="width: 20px;height: auto;"></span> 연결하기</span></button>
			</div>
		</div>
            <!-- #/ container -->
            </div>
            </div>
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

</body>

</html>