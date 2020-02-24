<!-- page 400 error 발생시 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html class="h-100">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
      <link href="<c:url value="/resources/css/style.css"/>" rel="stylesheet">
    
</head>

<body class="h-100">
    
    <jsp:include page="/WEB-INF/views/commons/preloader.jsp"></jsp:include>
    

    <div class="login-form-bg h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="error-content">
                        <div class="card mb-0">
                            <div class="card-body text-center">
                                <h1 class="error-text text-primary">400</h1>
                                <h4 class="mt-4"><i class="fa fa-thumbs-down text-danger"></i> Bad Request</h4>
                                <p>Your Request resulted in an error.</p>
                                <form class="mt-5 mb-5">
                                    
                                    <div class="text-center mb-4 mt-4"><a href="index.do" class="btn btn-primary">Go to Homepage</a>
                                    </div>
                                </form>
                                <div class="text-center">
                                    <p>Copyright © Designed by <a href="index.do">SCOOP</a>, Developed by <a href="index.do">SCOOP</a> 2020</p>
                                   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    



    <!-- <div class="error-bg h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="error-content">
                        <div class="card mb-0">
                            <div class="card-body text-center">
                                <h1 class="error-text text-primary">400</h1>
                                <h4 class="mt-4"><i class="fa fa-thumbs-down text-danger"></i> Bad Request</h4>
                                <p>Your Request resulted in an error.</p>
                                <form class="mt-5 mb-5">
                                    
                                    <div class="text-center mb-4 mt-4"><a href="index.jsp" class="btn btn-primary">Go to Homepage</a>
                                    </div>
                                </form>
                                <div class="text-center">
                                    <p>Copyright © Designed by <a href="https://themeforest.net/user/digitalheaps">Digitalheaps</a>, Developed by <a href="https://themeforest.net/user/quixlab">Quixlab</a> 2018</p>
                                    <ul class="list-inline">
                                        <li class="list-inline-item"><a href="javascript:void()" class="btn btn-facebook"><i class="fa fa-facebook"></i></a>
                                        </li>
                                        <li class="list-inline-item"><a href="javascript:void()" class="btn btn-twitter"><i class="fa fa-twitter"></i></a>
                                        </li>
                                        <li class="list-inline-item"><a href="javascript:void()" class="btn btn-linkedin"><i class="fa fa-linkedin"></i></a>
                                        </li>
                                        <li class="list-inline-item"><a href="javascript:void()" class="btn btn-google-plus"><i class="fa fa-google-plus"></i></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div> -->

    

    <!--**********************************
        Scripts
    ***********************************-->
    <script src="<c:url value="/resources/plugins/common/common.min.js"/>"></script>
	<script src="<c:url value="/resources/js/custom.min.js"/>"></script>
	<script src="<c:url value="/resources/js/settings.js"/>"></script>
	<script src="<c:url value="/resources/js/gleek.js"/>"></script>
	<script src="<c:url value="/resources/js/styleSwitcher.js"/>"></script>
</body>
</html>





