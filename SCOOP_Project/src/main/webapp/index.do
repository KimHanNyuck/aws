<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all,follow">
<!--vendors styles-->
<link rel="stylesheet"Chatfuel
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Bootstrap CSS / Color Scheme -->
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" id="theme-color">

<!-- Bootstrap CSS-->
<link rel="stylesheet" href="<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css"/>">

<!-- Ionicons CSS-->
<link rel="stylesheet" href="<c:url value="/resources/css/ionicons.min.css"/>">
<!-- Device mockups CSS-->
<link rel="stylesheet" href="css/device-mockups.css">
<!-- Google fonts - Source Sans Pro-->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700">
<!-- Swiper sLider-->
<link rel="stylesheet" href="<c:url value="/resources/vendor/swiper/css/swiper.min.css"/>">
<!-- theme stylesheet-->
<link rel="stylesheet" href="<c:url value="/resources/css/style.default.css"/>" id="theme-stylesheet">
<!-- Custom stylesheet - for your changes-->
<link rel="stylesheet" href="<c:url value="/resources/css/custom.css"/>">
<!-- Favicon-->
<!-- <link rel="shortcut icon" href="<link rel="stylesheet" href="<c:url value="/resources/img/favicon.png"/>">"> -->
<!-- Tweaks for older IEs--><!--[if lt IE 9]>
   <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
   <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
	<meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="47797892299-i06tt9qhbs15g8mn89ncu1isa1eneql8.apps.googleusercontent.com">
</head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="https://code.iconify.design/1/1.0.3/iconify.min.js"></script>
<script type="text/javascript">
$(document).ready(function($) {
	$("#pricing_area").click(function(event){
		 var offset = $("#pricing").offset();
         $('html').animate({scrollTop : offset.top}, 1000);
	});

	//이메일 아웃풋
	$("#scoop_input").click(function(){

		$("#email").val($("#email").val());
			
	});

	//자주 묻는 질문
	var acc = document.getElementsByClassName("accordion");
	var i;

	for (i = 0; i < acc.length; i++) {
	  acc[i].addEventListener("click", function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    if (panel.style.maxHeight) {
	      panel.style.maxHeight = null;
	    } else {
	      panel.style.maxHeight = panel.scrollHeight + "px";
	    } 
	  });
	}
	
});

</script>
<style>
	.accordion {
  background-color: #fff;
  color: #444;
  cursor: pointer;
  padding: 18px;
  width: 100%;
  border: none;
  text-align: left;
  outline: none;
  font-size: 15px;
  transition: 0.4s;
  
}

.active, .accordion:hover {
  background-color: #fff;
}

.accordion:after {
  content: '\002B';
  color: #777;
  font-weight: bold;
  float: right;
  margin-left: 5px;
}

.active:after {
  content: "\2212";
}

.panel {
  padding: 0 18px;
  background-color: white;
  max-height: 0;
  overflow: hidden;
  transition: max-height 0.2s ease-out;
  border-bottom: 1px solid #B5B1B1;
}

</style>
<body>
<!-- navbar-->
<header class="header">
  <nav class="navbar navbar-expand-lg">
   <div class="container">
     <!-- Navbar brand--><a href="frontpage.jsp" class="navbar-nav font-weight-bold"><img src="images/logo/ScoopBig.png" style="width:200px;height: 75px; " alt="..." ></a>
     <!-- Navbar toggler button-->
     <button type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler navbar-toggler-right">Menu<i class="icon ion-md-list ml-2"></i></button>
     <div id="navbarSupportedContent" class="collapse navbar-collapse">
      <ul class="navbar-nav mx-auto ml-auto">
         <!-- 여기 지우면 죽음뿐 -->
      </ul>
      <ul class="navbar-nav">
      <li class="nav-item dropdown"><a id="pages" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle">세부기능</a>
      <div class="dropdown-menu">
      <div id="table">
      <div class="rowdrop">
         <span class="celldrop col1drop"><a href="" class="dropdown-item">
         	협업공간<br>
         	<span style="color: gray;font-size:13px">동료와 함께 자유롭게 <br>협업하는 공간</span>
         	<br>
         	</a></span>
      
         <span class="celldrop col2drop"><a href="" class="dropdown-item">
         	이슈<br>
         	<span style="color: gray;font-size:13px">협업을 시작하는 실시간 <br> 동시 편집 문서</span>
         
         </a></span>
      </div>
      <div class="rowdrop">
         <span class="celldrop col1drop"><a href="index.html" class="dropdown-item">
         	실시간 대화<br>
         	<span style="color: gray;font-size:13px">모든 이슈,할 일,파일에서 <br>나누는 실시간 커뮤니케이션</span>
         	</a></span>
         <span class="celldrop col2drop"><a href="" class="dropdown-item">
         	이슈 업데이트<br>
         	<span style="color: gray;font-size:13px">나에게 필요한 소식을 이슈별로<br>알려주는 알림 리스트</span>
         	</a></span>
      </div>
       <div class="rowdrop">
         <span class="celldrop col1drop"><a href="index.html" class="dropdown-item">
         	캘린더<br>
         	<span style="color: gray;font-size:13px">나와 동료의 일정/할 일<br>파악 및 스케쥴 관리</span>
         	</a></span>
         <span class="celldrop col2drop"><a href="" class="dropdown-item">
         	칸반<br>
         	<span style="color: gray;font-size:13px">업무의 진행사항을 파악<br> 및 설정으로 프로젝트를 관리</span>
         	</a></span>
      </div>
      <div class="rowdrop">
         <span class="celldrop col1drop"><a href="" class="dropdown-item">
         	컨텐츠 모음<br>
         	<span style="color: gray;font-size:13px">파일,할 일,의사결정,링크를 <br>쉽고 빠르게 찾을 수 있는 공간</span>
         </a></span>
         <span class="celldrop col2drop"><a href="" class="dropdown-item">
         	관리자 기능<br>
         	<span style="color: gray;font-size:13px">동료 관리 ,<br> 협업공간 관리</span>
         </a></span>
      </div>
      
         <hr>
         <a href="" class="dropdown-item" style="text-align: center;">
         	스쿱의 보안<br>
         	<span style="color: gray;font-size:13px">최우선적인 데이터 보호, 개인정보보호 유지</span>
         </a>
         <br>
        
      </div>
           </div>
           </li>
           <!-- Link-->
           <li class="nav-item"> <a href="#pricing" id="pricing_area" class="nav-link">가격</a></li>
       
        <li class="nav-item"><a href="#" data-toggle="modal" data-target="#login" class="nav-link font-weight-bold mr-3">Login</a></li>
        <li class="nav-item"><a href="#" data-toggle="modal" data-target="#signUp" class="navbar-btn btn btn-primary">무료로 시작하기</a></li>
      </ul>
     </div>
   </div>
  </nav>
</header>
<!-- Login Modal-->
<div id="login" tabindex="-1" role="dialog" aria-hidden="true" class="modal fade bd-example-modal-lg">
  <div role="document" class="modal-dialog modal-dialog-centered modal-lg">
   <div class="modal-content">
     <div class="modal-header border-bottom-0">
      <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
     </div>
     <div class="modal-body p-4 p-lg-5">
      <img class="img-responsive center-block" alt="Scoop로고" src="images/logo/ScoopBig.png" style="width:100%;height:auto;padding-right:15%;padding-left:15%;"/>
      <form action="#" class="login-form text-left">
        <h4>로그인</h4>
        <div class="form-group mb-4">
         <label>Email address</label>
         <input type="email" name="email" id="email" placeholder="name@company.com" class="form-control">
        </div>
        <div class="form-group mb-4">
         <label>Password</label>
         <input type="password" name="password" id="pwd" placeholder="Min 8 characters" class="form-control">
        </div>
        <div class="form-group">
        	<input type="submit" value="Login" class="btn btn-primary" style="width: 190px;height:38px;text-align: center;padding-top: 5px;">
        	<div id="my-signin2"style="float: right;"></div>
        	<div id="naver_id_login" style="float:right;margin-right: 5px;margin-left: 0px;width: 210px;border-left-width: 20px;padding-left: 15px;"></div>
        </div>
        <div>
	        	   <a href="" data-toggle="modal" data-target="#signUp" style="padding-right:45%;">아직 회원이 아니신가요?</a>
	        	   <a href="#" data-toggle="modal" data-target="#passwordFind">비밀번호를 잃어버리셨나요?</a>
        </div>
      	</form>
		<!-- 네이버아이디로로그인 버튼 노출 영역 -->
								  <script type="text/javascript">
								  	var naver_id_login = new naver_id_login("UQIzvQsqqo7IfCBE1GH1", "http://localhost:8090/Scoop_Project/index.jsp");
								  	var state = naver_id_login.getUniqState();
								  	naver_id_login.setButton("white", 3,40);
								  	naver_id_login.setDomain("http://localhost:8090/");
								  	naver_id_login.setState(state);
								  	naver_id_login.setPopup();
								  	naver_id_login.init_naver_id_login();
								  </script>
									
							      <script>
							        function onSuccess(googleUser) {
							          console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
							        }
							        function onFailure(error) {
							          console.log(error);
							        }
							        function renderButton() {
							          gapi.signin2.render('my-signin2', {
							            'scope': 'profile email',
							            'width': 190,
							            'height': 38,
							            'longtitle': true,
							            'theme': 'dark',
							            'onsuccess': onSuccess,
							            'onfailure': onFailure
							          });
							        }
							      </script>
							      <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
     </div>
   </div>
  </div>
</div>

<!-- SignUp Modal-->
<div id="signUp" tabindex="-1" role="dialog" aria-hidden="true" class="modal fade bd-example-modal-lg">
  <div role="document" class="modal-dialog modal-dialog-centered modal-lg">
   <div class="modal-content">
     <div class="modal-header border-bottom-0">
      <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
     </div>
     <div class="modal-body p-4 p-lg-5">
      <img class="img-responsive center-block" alt="Scoop로고" src="images/logo/ScoopBig.png" style="width:100%;height:auto;padding-right:15%;padding-left:15%;"/>
      <form action="frontpage.do" class="login-form text-left" method="post">
        <h4>회원가입</h4>
        <div class="form-group mb-4">
         <label>Email address</label>
         <input type="text" class="form-control" id="email" name="email" placeholder="E-mail@company.com" required>
        </div>
        <div class="form-group mb-4">
         <label>Name</label>
         <input type="text" class="form-control" id="name" name ="name" placeholder="Name" required>
        </div>
        <div class="form-group mb-4">
         <label>Password</label>
         <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password" required>
        </div>
        <div class="form-group">
        	<center>
        		<input type="submit" value="스쿱 시작하기" class="btn btn-primary" style="width: 300px;height:38px;text-align: center;padding-top: 5px;">
    		</center>
        </div>
        <div>
        </div>
        <input type="hidden" name="dname" value="abc">
        <input type="hidden" name="drank" value="10">
        <input type="hidden" name="address" value="서울시 강남구">
        <input type="hidden" name="profile" value="a.png">
        <input type="hidden" name="idtime" value="20-01-04">
      	</form>								   
     </div>
   </div>
  </div>
</div>
 

<!-- PasswordFind Modal-->
<div id="passwordFind" tabindex="-1" role="dialog" aria-hidden="true" class="modal fade bd-example-modal-lg">
  <div role="document" class="modal-dialog modal-dialog-centered modal-lg">
   <div class="modal-content">
     <div class="modal-header border-bottom-0">
      <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
     </div>
     <div class="modal-body p-4 p-lg-5">
      <img class="img-responsive center-block" alt="Scoop로고" src="images/logo/ScoopBig.png" style="width:100%;height:auto;padding-right:15%;padding-left:15%;"/>
      <form action="#" class="login-form text-left">
        <div class="form-group mb-4">
         <label>Email address</label>
         <input type="text" class="form-control" id="email" placeholder="E-mail@company.com" required>
        </div>
       
        <div class="form-group">
        	<a href="" data-dismiss="modal" aria-label="Close" style="float: left;padding-right: 33%;">〈 로그인으로 돌아가기</a>
        	<input type="submit" value="비밀번호 재설정 메일 발송" class="btn btn-primary" style="width: 300px;height:38px;text-align: center;padding-top: 5px;">
        </div>
        <div>
        </div>
      	</form>								   
     </div>
   </div>
  </div>
</div>

<div class="container">
  <!-- Hero Section-->
  <section class="hero shape-1">
   <div class="container">
     <div class="row align-items-center">
      <div class="col-lg-6">
        <h1 class="hero-heading">하나의 문서로 함께 만드는 협업</h1>
        <p class="lead mt-5 font-weight-light">동료와 한 페이지 안에서 할 일,파일,의사결정,일정 및 커뮤니케이션을 모두 담아 이슈를 해결해 보세요.🍿</p>
        <!-- Subscription form-->
        <form action="#" class="subscription-form mt-5">
         <div class="form-group">
           <label>Email</label>
           <input type="text" name="email" id="email" placeholder="E-mail@company.com" class="form-control">
        <button type="button" id="scoop_input" data-toggle="modal" data-target="#signUp"class="btn btn-primary">무료로 시작하기</button>     
         </div>
            <span>이미 가입하셨나요?</span>
            <a href="" data-toggle="modal" data-target="#login"style="color:#cf455c;">로그인 하기</a>    
        </form>
        <!-- Platforms-->
        <div class="platforms d-none d-lg-block"><span class="platforms-title">Compatible with</span>
         <ul class="platforms-list list-inline">
           <li class="list-inline-item"><img src="img/netflix.svg" alt="" class="platform-image img-fluid"></li>
           <li class="list-inline-item"><img src="img/apple.svg" alt="" class="platform-image img-fluid"></li>
           <li class="list-inline-item"><img src="img/android.svg" alt="" class="platform-image img-fluid"></li>
           <li class="list-inline-item"><img src="img/windows.svg" alt="" class="platform-image img-fluid"></li>
           <li class="list-inline-item"><img src="img/synology.svg" alt="" class="platform-image img-fluid"></li>
         </ul>
        </div>
      </div>
      <div class="col-lg-6 d-none d-lg-block">
          <img src="img/AppleiMac.png" alt="..." class="img-fluid">
      </div>
     </div>
   </div>
  </section>
  <br>
  
  <!--pricing section-->
	<section class="pt-4" id="pricing">
	<div id="pricing_area"> </div>
		<div class="container">	
			<div class="row">
				<div class="col-md-7 mx-auto text-center">
					<h2>스쿱을 무료로 사용해 보세요</h2>
					<br>
					<p class="text-muted lead">무료로 얼마든지 동료를 초대하고 협업공간을 생성하여 협업할 수
						있습니다.</p>
				</div>
			</div>
			<!--pricing tables-->
			<div class="row pt-5 pricing-table">
				<div class="col-sm-12">
					<div class="card-deck pricing-table">
						<div class="card text-center" style="border-color:#fff">
							<div class="card-body">
								<h4 class="card-title pt-3"  style="color:#0E2866">CHOICE</h4>
								<h2 class="card-title pt-4"  style="color:#0E2866">PRICE</h2>
								<div class="text-muted mt-4">기한</div>
								<ul class="list-unstyled pricing-list">
									<li>알림을 가질 수 있는 협업 공간</li>
									<li>완료된 협업 공간</li>
									<li>1회 업로드 용량</li>
									<li>퇴사자 관리</li>
									<li>회사/팀 통합 관리</li>
									<li>협업공간 관리</li>
									<li>공용공간 관리</li>
									<li>멤버수</li>
									<li>외부 협업자 수</li>
									<li>CS(1:1문의)</li>
									<li>외부 서비스 연동</li>
									<li>이메일 연동(준비중)</li>
								</ul>
								<h5> 지금 바로 시작해보세요. </h5>
							</div>
						</div>
				
						<div class="card text-center" style="border-color:#fff">
							<div class="card-body">
								<h4 class="card-title pt-3">Free</h4>
								<h2 class="card-title pt-4">$0</h2>
								<div class="text-muted mt-4">
									<span class="iconify" data-icon="ion:infinite-sharp"
										data-inline="false"></span>
								</div>
								<ul class="list-unstyled pricing-list">
									<li>3개</li>
									<li>무제한</li>
									<li>무제한</li>
									<li>20MB</li>
									<li>-</li>
									<li>-</li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li>-</li>
									<li>무제한</li>
									<li>무제한</li>
									<li>-</li>
									<li>-</li>
								</ul>
								<a href="#" data-toggle="modal" data-target="#login" class="btn btn-secondary"> Get started </a>
							</div>
						</div>
						<div class="card text-center"style="border-color:#fff">
							<div class="card-body">
								<h4 class="card-title text-primary pt-3">Premium</h4>
								<h2 class="card-title text-primary pt-4">$4</h2>
								<div class="text-muted mt-4">per month</div>
								<ul class="list-unstyled pricing-list">
									<li>무제한</li>
									<li>무제한</li>
									<li>50MB</li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li>무제한</li>
									<li>무제한</li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li>무제한</li>
									<li>-</li>
								</ul>
								<a href="#" data-toggle="modal" data-target="#login" class="btn btn-primary"> Get Started </a>

							</div>
						</div>

					</div>
				</div>
			</div>

			<div class="row mt-5">
				<div class="col-md-10 mx-auto">
					<div class="row">
						<div class="col-sm-12" style="text-align: center;padding-bottom: 5%;">
						<h2>자주 묻는 질문</h2>
						</div>
						<button class="accordion">Section 1</button>
						<div class="panel">
						  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
						</div>
						
						<button class="accordion">Section 2</button>
						<div class="panel">
						  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
						</div>
						
						<button class="accordion">Section 3</button>
						<div class="panel">
						  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="tlinks">
			Collect from <a href="http://www.cssmoban.com/" title=""></a>
		</div>
	</section>
  
  <!-- App Showcase Section-->
  <section class="app-showcase pb-big">
   <div class="container">
     <div class="row align-items-center">
      <div class="col-lg-6">
        <h2 class="mb-4">Easy-to-use interfaces on every platform</h2>
        <p class="lead">Since most of our features work in a completely automated way, you will mainly use our apps to discover new TV shows recommended for you and discuss the most interesting episodes with like-minded people.</p>
        <div class="row mt-5">
         <div class="col-lg-8">
           <div id="v-pills-tab" role="tablist" aria-orientation="vertical" class="nav flex-column nav-pills showcase-nav"><a id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home" role="tab" aria-controls="v-pills-home" aria-selected="true" class="nav-link active showcase-link"> <i class="icon ion-md-pie mr-4"></i>Customized Dashboard</a><a id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile" role="tab" aria-controls="v-pills-profile" aria-selected="false" class="nav-link showcase-link"> <i class="icon ion-ios-moon mr-4"></i>Automatic Day &amp; Night Modes</a><a id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages" role="tab" aria-controls="v-pills-messages" aria-selected="false" class="nav-link showcase-link"> <i class="icon ion-md-chatbubbles mr-4"></i>Integrated Chat Platform</a></div>
         </div>
        </div>
      </div>
      <div class="col-lg-6">
        <div id="v-pills-tabContent" class="tab-content showcase-content">
         <div id="v-pills-home" role="tabpanel" aria-labelledby="v-pills-home-tab" class="tab-pane fade show active">
           <div class="showcase-image-holder">
            <div class="device-wrapper">
              <div data-device="iPhone7" data-orientation="portrait" data-color="black" class="device">
               <div class="screen"><img src="img/showcase-screen-1.jpg" alt="..." class="img-fluid"></div>
              </div>
            </div><img src="img/showcase-img-1.jpg" alt="..." class="showcase-image d-none d-lg-block">
           </div>
         </div>
         <div id="v-pills-profile" role="tabpanel" aria-labelledby="v-pills-profile-tab" class="tab-pane fade">
           <div class="showcase-image-holder">
            <div class="device-wrapper">
              <div data-device="iPhone7" data-orientation="portrait" data-color="black" class="device">
               <div class="screen"><img src="img/showcase-screen-2.jpg" alt="..." class="img-fluid"></div>
              </div>
            </div><img src="img/showcase-img-2.jpg" alt="..." class="showcase-image d-none d-lg-block">
           </div>
         </div>
         <div id="v-pills-messages" role="tabpanel" aria-labelledby="v-pills-messages-tab" class="tab-pane fade">
           <div class="showcase-image-holder">
            <div class="device-wrapper">
              <div data-device="iPhone7" data-orientation="portrait" data-color="black" class="device">
               <div class="screen"><img src="img/showcase-screen-3.jpg" alt="..." class="img-fluid"></div>
              </div>
            </div><img src="img/showcase-img-3.jpg" alt="..." class="showcase-image d-none d-lg-block">
           </div>
         </div>
        </div>
      </div>
     </div>
   </div>
  </section>
  <div class="tlinks">Collect from <a href="http://www.cssmoban.com/"  title="网站模板">网站模板</a></div>
  <!-- Testimonials Section-->
  <!-- Subscription Section-->
  <section class="subscription padding-big">
   <div class="container text-center">
     <div class="section-header">
      <div class="row">
        <div class="col-lg-8 mx-auto"><span class="section-header-title">Get Started</span>
         <h2 class="h1">Start tracking your TV shows for free </h2>
         <p class="lead">In order to start tracking your TV shows, all you have to do is enter your email address. Everything else will be taken care of by us. All you have to do is sit back, relax and enjoy your TV shows..</p>
        </div>
      </div>
      <div class="row">
        <div class="col-lg-7 mx-auto">
         <!-- Subscription form-->
         <form action="#" class="subscription-form mt-5">
           <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" placeholder="your@email.com" class="form-control">
            <button type="submit" class="btn btn-primary">Start tracking</button>
           </div>
         </form>
        </div>
      </div>
     </div>
   </div>
  </section>
</div>
<footer class="footer">
  <div class="container text-center">
   <!-- Copyrights-->
   <div class="copyrights">
     <!-- Social menu-->
     <ul class="social list-inline-item">
      <li class="list-inline-item"><a href="#" target="_blank" class="social-link"><i class="icon ion-logo-twitter"></i></a></li>
      <li class="list-inline-item"><a href="#" target="_blank" class="social-link"><i class="icon ion-logo-facebook"></i></a></li>
      <li class="list-inline-item"><a href="#" target="_blank" class="social-link"><i class="icon ion-logo-youtube"></i></a></li>
     </ul>
     <p class="copyrights-text mb-0">Copyright &copy; 2019.Company name All rights reserved.More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a></p>
   </div>
  </div>

</footer>
<!-- JavaScript files-->
<script src="<c:url value="/resources/vendor/jquery/jquery.min.js"/>"></script>
<script src="<c:url value="/resources/vendor/popper.js/umd/popper.min.js"/>"> </script>
<script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/vendor/jquery.cookie/jquery.cookie.js"/>"> </script>
<script src="<c:url value="/resources/vendor/swiper/js/swiper.min.js"/>"></script>
<script src="<c:url value="/resources/js/front.js"/>"></script>

</body>
</html>
