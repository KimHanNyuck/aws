<!-- 로그인과 회원가입을 할 수 있는 맨 처음 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="all,follow">
<jsp:include page="/WEB-INF/views/commons/title.jsp"></jsp:include>
<!--vendors styles-->
<link rel="stylesheet"Chatfuel href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- Bootstrap CSS / Color Scheme -->
<link rel="stylesheet" href="<c:url value="/resources/css/default.css"/>" id="theme-color">

<!-- Bootstrap CSS-->
<link rel="stylesheet" href="<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css"/>">

<!-- Ionicons CSS-->
<link rel="stylesheet" href="<c:url value="/resources/css/ionicons.min.css"/>">
<!-- Device mockups CSS-->
<link rel="stylesheet" href="<c:url value="/resources/css/device-mockups.css"/>">
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
    <meta name="google-signin-client_id" content="806433148370-o0ss3i4kp8dhj6p0d2cvkdjfus8kivds.apps.googleusercontent.com">
</head>
<script language="javascript" src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<script src="https://code.iconify.design/1/1.0.3/iconify.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/promise-polyfill"></script>
<!-- Channel Plugin Scripts -->
<script>
  (function() {
    var w = window;
    if (w.ChannelIO) {
      return (window.console.error || window.console.log || function(){})('ChannelIO script included twice.');
    }
    var d = window.document;
    var ch = function() {
      ch.c(arguments);
    };
    ch.q = [];
    ch.c = function(args) {
      ch.q.push(args);
    };
    w.ChannelIO = ch;
    function l() {
      if (w.ChannelIOInitialized) {
        return;
      }
      w.ChannelIOInitialized = true;
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src = 'https://cdn.channel.io/plugin/ch-plugin-web.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  })();
  ChannelIO('boot', {
    "pluginKey": "969e6926-9aff-4763-ac19-ec65b811442f"
  });
</script>
<!-- End Channel Plugin -->
<script type="text/javascript">
$(document).ready(function($) {
	$("#pricing_area").click(function(event){
		 var offset = $("#pricing").offset();
         $('html').animate({scrollTop : offset.top}, 1000);
	});

	//이메일 아웃풋
	$("#scoop_input").click(function(){
		$(".signup").val($("#emailTo").val());
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

function signOut() {
    var auth2 = gapi.auth2.getAuthInstance();
    auth2.signOut().then(function () {
      console.log('User signed out.');
    });
    auth2.disconnect();
  }

	// 비밀번호 변경 이메일 유효성
	function chgpwdchk() {
		
		let getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
		let email = $('#emailcheck').val();
		
		if(!getMail.test($('#emailcheck').val())) {
			Swal.fire({
 				  title: '이메일 형식이 맞지 않습니다.',
 				  showConfirmButton: false,
 				  icon: 'warning',
 				  timer: 2000
 			})
			$("#emailcheck").val("");
			$("#emailcheck").focus();
			return false;
		}else {
			$.ajax({
				url: "idOverlab.do",
				type: "POST",
				data: {"email": email},
				async: false,
				success : function(data) {
					if (data == 0) {
						$("#emailcheck").val("");
						$("#emailcheck").focus();
						Swal.fire({
			 				title: '가입된 이메일이 없습니다',
			 				showConfirmButton: false,
			 				icon: 'warning',
			 				timer: 2000
			 			})
						return false;
					}else {
						$.ajax({
							url: "forgotpwd.do",
							type : "GET",
							data : {"email":email},
							async : false,
							success: function(data){
					 			location.href="successPwd.do";
							},
							error: function(data){
								Swal.fire({
					 				  title: '이메일 전송 실패.',
					 				  showConfirmButton: false,
					 				  icon: 'warning',
					 				  timer: 2000
					 			})
							}
						})
					}
				},
				error : function(err) {
					console.log(err);
					Swal.fire({
		 				title: '에러 발생',
		 				showConfirmButton: false,
		 				icon: 'error',
		 				timer: 2000
		 			})
					return false;
				}
			})
		}
	}
	//회원가입 유효성 검사
    function checkz() {
      var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
      var getCheck= RegExp(/^[a-zA-Z0-9]{8,16}$/);
      var getName= RegExp(/^[가-힣|a-z|A-Z]+$/);
		if($('#name').val().length>7){
			alert("name은 7자 까지 입력가능합니다.")
			return false;
		}
		
      //이메일 유효성 검사
      if(!getMail.test($("#mail").val())){
        alert("이메일 형식에 맞게 입력해주세요.")
        $("#mail").val("");
        $("#mail").focus();
        return false;
      }

      //이름 유효성
      if (!getName.test($("#name").val())) {
        alert("이름 형식에 맞게 입력해주세요.");
        $("#name").val("");
        $("#name").focus();
        return false;
      }
      
      //비밀번호 유효성
      if(!getCheck.test($("#tbPwd").val())) {
      alert("비밀번호 형식에 맞게 입력해주세요.");
      $("#tbPwd").val("");
      $("#tbPwd").focus();
      return false;
      }
 
     //이메일 공백 확인
      if($("#mail").val() == ""){
        alert("이메일을 입력해주세요");
        $("#mail").focus();
        return false;
      }

      //이름 공백 확인
      if($("#name").val() == ""){
        alert("이름을 입력해주세요");
        $("#name").focus();
        return false;
      }

      //비밀번호 공백 확인
      if($("#tbPwd").val() == ""){
        alert("비밀번호를 입력해주세요");
        $("#tbPwd").focus();
        return false;
      }
      	
 
    return true;
  }


//로그인 validation
 function checkz2() {
 //이메일 공백 확인
  if($("#mail2").val() == ""){
	  Swal.fire("이메일을 입력해주세요");
    $("#mail2").focus();
    return false;
  }

  //비밀번호 공백 확인
  if($("#tbPwd2").val() == ""){
	  Swal.fire("비밀번호를 입력해주세요");
    $("#tbPwd2").focus();
    return false;
  }

return true;
} 

function idOver(a) {
	console.log($('#mail').val());
	if ($('#mail').val() != "" || $('#mail').val() == null) {
		$.ajax({
			url : 'idOverlab.do', //request 보낼 서버의 경로
			type : 'post', // 메소드(get, post, put 등)
			data : {
				'email' : $('#mail').val()
			}, //보낼 데이터
			success : function(data) {
				if (data == 0) {
					$("#signUpBtn").removeAttr('disabled');
					Swal.fire({
						title : "사용 가능한 아이디",
						text : "사용 가능한 아이디입니다",
						icon : "success",
						button : "확인"
					})
				} else {
					Swal.fire({
						title : "중복된 이메일 존재",
						text : "중복된 이메일이 있습니다",
						icon : "warning",
						button : "확인"
					})
				}
				console.log(data);

			},
			error : function(err) {
				console.log(err);
				Swal.fire({
					title : "에러 발생",
					text : "에러가 발생했습니다",
					icon : "error",
					button : "확인"
				})
			}
		});
	} else{
		Swal.fire({
			title : "에러 발생",
			text : "이메일을 입력해주세요",
			icon : "error",
			button : "확인"
	})
	}
}


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
     <!-- Navbar brand--><a href="index.do" class="navbar-nav font-weight-bold"><img src="resources/images/logo/ScoopBig.png" style="width:200px;height: 75px; " alt="..." ></a>
     <!-- Navbar toggler button-->
     <button type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler navbar-toggler-right">Menu<i class="icon ion-md-list ml-2"></i></button>
     <div id="navbarSupportedContent" class="collapse navbar-collapse">
      <ul class="navbar-nav mx-auto ml-auto">
         <!-- 여기 지우면 죽음뿐 -->
      </ul>
      <ul class="navbar-nav">
      <li class="nav-item dropdown"><a id="pages" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle"><spring:message code="language" /></a>
      	<div class="dropdown-menu" style="min-width: 100px;min-height: 75px">
      		<div id="table">
      			<div id="rowdrop" style="min-width: 75px;min-height: 100%;margin-left: 23px;margin-top: 5px">
      				<span class="celldrop col1drop"><a href="index.do?lang=ko">한국어</a></span>
      				<!-- <hr width="80%"> -->
      				
      			</div>
      			
      			<div id="rowdrop" style="min-width: 75px;min-height: 100%;margin-left: 20px">
      				<span class="celldrop col1drop"><a href="index.do?lang=en">English</a></span>
      			</div>
      		</div>
      	</div>
      </li>
      <li class="nav-item dropdown"><a id="pages" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle"><spring:message code="detail" /></a>
      <div class="dropdown-menu">
      <div id="table">
      <div class="rowdrop">
         <span class="celldrop col1drop"><a href="" class="dropdown-item">
         	<spring:message code="detail.collabo" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.collabo1" /><br><spring:message code="detail.collabo2" /></span>
         	<br>
         	</a></span>
      
         <span class="celldrop col2drop"><a href="" class="dropdown-item">
         	<spring:message code="detail.issue" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.issue1" /> <br><spring:message code="detail.issue2" /></span>
         
         </a></span>
      </div>
      <div class="rowdrop">
         <span class="celldrop col1drop"><a href="index.html" class="dropdown-item">
         	<spring:message code="detail.chat" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.chat1" /> <br><spring:message code="detail.chat2" /></span>
         	</a></span>
         <span class="celldrop col2drop"><a href="" class="dropdown-item">
         	<spring:message code="detail.update" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.update1" /><br><spring:message code="detail.update2" /></span>
         	</a></span>
      </div>
       <div class="rowdrop">
         <span class="celldrop col1drop"><a href="index.html" class="dropdown-item">
         	<spring:message code="detail.cal" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.cal1" /><br><spring:message code="detail.cal2" /></span>
         	</a></span>
         <span class="celldrop col2drop"><a href="" class="dropdown-item">
         	<spring:message code="detail.kanban" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.kanban1" /><br><spring:message code="detail.kanban2" /></span>
         	</a></span>
      </div>
      <div class="rowdrop">
         <span class="celldrop col1drop"><a href="" class="dropdown-item">
         	<spring:message code="detail.content" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.content1" /> <br><spring:message code="detail.content2" /></span>
         </a></span>
         <span class="celldrop col2drop"><a href="" class="dropdown-item">
         	<spring:message code="detail.admin" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.admin1" /><br><spring:message code="detail.admin2" /></span>
         </a></span>
      </div>
      
         <hr>
         <a href="" class="dropdown-item" style="text-align: center;">
         	<spring:message code="detail.security" /><br>
         	<span style="color: gray;font-size:13px"><spring:message code="detail.security1" /></span>
         </a>
         <br>
        
      </div>
           </div>
           </li>
           <!-- Link-->
           <li class="nav-item"> <a href="#pricing" id="pricing_area" class="nav-link"><spring:message code="price" /></a></li>
       
        <li class="nav-item"><a href="#" data-toggle="modal" data-target="#login" class="nav-link font-weight-bold mr-3"><spring:message code="login.menu" /></a></li>
        <li class="nav-item"><a href="#" data-toggle="modal" data-target="#signUp" class="navbar-btn btn btn-primary"><spring:message code="register" /></a></li>
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
      <img class="img-responsive center-block" alt="Scoop로고" src="resources/images/logo/ScoopBig.png" style="width:100%;height:auto;padding-right:15%;padding-left:15%;"/>
      <form onsubmit="return checkz2()" action="login.do" class="login-form text-left" method="post">
        <h4><spring:message code="login.menu" /></h4>
        <div class="form-group mb-4">
         <label>Email address</label>
         <input type="email" name="email" id="mail2" placeholder="name@company.com" class="form-control">
        </div>
        <div class="form-group mb-4">
         <label>Password</label>
         <input type="password" name="pwd" id="tbPwd2" placeholder="Min 8 characters" class="form-control">
        </div>
        <div class="form-group">
        	<input type="submit" value="Login" class="btn btn-primary" style="width: 190px;height:38px;text-align: center;padding-top: 5px;">
        	<div id="my-signin2"style="float: right;"></div>
        	<div id="naver_id_login" style="float:right;margin-right: 5px;margin-left: 0px;width: 210px;border-left-width: 20px;padding-left: 15px;"></div>
        </div>
        <div>
	        	   <a href="#" data-toggle="modal" data-target="#signUp" style="padding-right:45%;"><spring:message code="login.yet" /></a>
	        	   <a href="#" data-toggle="modal" data-target="#passwordFind"><spring:message code="login.forgot" /></a>
        </div>
      	</form>
		<!-- 네이버아이디로로그인 버튼 노출 영역 -->
								  <script type="text/javascript">
								  	var naver_id_login = new naver_id_login("idXo9CECDTdxmjiuAWdC", "http://scoop.com:8090/SCOOP/naverCertified.do");
								  	var state = naver_id_login.getUniqState();
								  	naver_id_login.setButton("white", 3,40);
								  	naver_id_login.setDomain("http://scoop.com:8090/SCOOP/");
								  	naver_id_login.setState(state);
								  	naver_id_login.init_naver_id_login();
								  </script>
									
							      <script>
							        function onSuccess(googleUser) {
							          console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
							          console.log(googleUser.getBasicProfile().getEmail());
 							          $.ajax({
							        	    url:'googleLogin.do', //request 보낼 서버의 경로
							        	    type:'post', // 메소드(get, post, put 등)
							        	    data:{'email':googleUser.getBasicProfile().getEmail(),
							        	    	'name':googleUser.getBasicProfile().getName()
							        	    	}, //보낼 데이터
							        	    success: function(data) {
							        	    	Swal.fire({
							        	    		  title: "구글 로그인 성공",
							        	    		  text: "WELCOME",
							        	    		  icon: "success",
							        	    		  button: "확인"
							        	    		})
							        	    	location.href="userindex.do";
							        	    },
							        	    error: function(err) {
							        	    	Swal.fire({
							        	    		  title: "에러 발생",
							        	    		  text: "로그인 중 에러가 발생했습니다",
							        	    		  icon: "error",
							        	    		  button: "확인"
							        	    		})
							        	    }
							        	});
							          
							          
							        }
							        function onFailure(error) {
							        	Swal.fire({
					        	    		  title: "구글 로그인 실패",
					        	    		  text: "구글 로그인 실패",
					        	    		  icon: "warning",
					        	    		  button: "확인"
					        	    		})
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
      <img class="img-responsive center-block" alt="Scoop로고" src="resources/images/logo/ScoopBig.png" style="width:100%;height:auto;padding-right:15%;padding-left:15%;"/>
      <form onsubmit="return checkz()" action="frontpage.do" class="login-form text-left" method="post">
        <h4><spring:message code="register.title" /></h4>
        <div class="form-group mb-4">
         <label>Email address</label>
         <input type="text" class="form-control signup" id="mail" name="email" placeholder="E-mail@company.com" required>
         <br>
         <button type="button" id="idcheck" class="btn btn-primary" style="width: 150px;height:38px;" onclick="idOver(this.id)"><spring:message code="register.idchk" /></button>
        </div>
        <div class="form-group mb-4">
         <label>Name</label>
         <input type="text" class="form-control" id="name" name ="name" placeholder="7자까지 입력가능합니다" required>
        </div>
        <div class="form-group mb-4">
         <label>Password</label>
         <input type="password" class="form-control" id="tbPwd" name="pwd" placeholder="8~16자리를 입력해주세요" required>
        </div>
        <div class="form-group" style="margin-left:27%;margin-right: 30%;">
        		<input type="submit" id="signUpBtn" value="<spring:message code='register.start' />" class="btn btn-primary" style="width: 300px;height:38px;text-align: center;padding-top: 5px;" disabled="disabled">
        </div>
        <div>
        </div>
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
      <img class="img-responsive center-block" alt="Scoop로고" src="resources/images/logo/ScoopBig.png" style="width:100%;height:auto;padding-right:15%;padding-left:15%;"/>
     <!--  <form class="login-form text-left" id="pwdchg" name="pwdchg" onsubmit="return chgpwdchk();"> -->
        <div class="form-group mb-4">
         <label>Email address</label>
         <input type="email" class="form-control" id="emailcheck" name="emailcheck" placeholder="E-mail@company.com" required>
        </div>
       
        <div class="form-group">
        	<a href="" data-dismiss="modal" aria-label="Close" style="float: left;padding-right: 33%;">〈 로그인으로 돌아가기</a>
        	<input type="button" value="비밀번호 재설정 메일 발송" class="btn btn-primary" style="width: 300px;height:38px;text-align: center;padding-top: 5px;" onclick="chgpwdchk();">
        </div>
        <div>
        </div>
      	<!-- </form>	 -->							   
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
        <h1 class="hero-heading"><spring:message code="main.title" /></h1>
        <p class="lead mt-5 font-weight-light"><spring:message code="main.content" />🍿</p>
        <!-- Subscription form-->
        <form action="#" class="subscription-form mt-5">
         <div class="form-group" style="border: 1px solid #656a6f; border-radius: 0.25rem;">
           <label>Email</label>
           <input type="text" name="email" id="emailTo" placeholder="E-mail@company.com" class="form-control">
     	   <button type="button" id="scoop_input" data-toggle="modal" data-target="#signUp"class="btn btn-primary"><spring:message code="register" /></button>     
         </div>
            <span><spring:message code="login.content" /></span>
            <a href="" data-toggle="modal" data-target="#login"style="color:#cf455c;"><spring:message code="login.main" /></a>    
        </form>
        <!-- Platforms-->
        <div class="platforms d-none d-lg-block"><span class="platforms-title">Compatible with</span>
         <ul class="platforms-list list-inline">
           
           <li class="list-inline-item"><img src="resources/img/apple.svg" alt="" class="platform-image img-fluid"></li>
           <li class="list-inline-item"><img src="resources/img/android.svg" alt="" class="platform-image img-fluid"></li>
           <li class="list-inline-item"><img src="resources/img/windows.svg" alt="" class="platform-image img-fluid"></li>
           
         </ul>
        </div>
      </div>
      <div class="col-lg-6 d-none d-lg-block" style="background-image: url('resources/img/iMac.png');width:1000px;height: 500px;background-size: 500px;background-repeat: no-repeat;">
          <iframe src="https://www.youtube.com/embed/xiqYWjMI-CQ"   allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen frameborder="0" style="width: 470px; height: 280px; padding-top: 0px;margin-top: 3%; margin-bottom: 3%;"></iframe>
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
					<h2><spring:message code="payment.title" /></h2>
					<br>
					<p class="text-muted lead"><spring:message code="payment.content" /></p>
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
								<div class="text-muted mt-4"><spring:message code="payment.date" /></div>
								<ul class="list-unstyled pricing-list">
									<li><spring:message code="payment.alam" /></li>
									<li><spring:message code="payment.team" /></li>
									<li><spring:message code="payment.upload" /></li>
									<li><spring:message code="payment.teamMgm" /></li>
									<li><spring:message code="payment.cs" /></li>
									<li><spring:message code="payment.api" /></li>
									
								</ul>
								<h5> <spring:message code="payment.start" /> </h5>
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
									<li>-</li>
									<li><spring:message code="payment.ea" /></li>
									<li>20MB</li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li>-</li>
									
								</ul>
								<a href="#" data-toggle="modal" data-target="#login" class="btn btn-secondary"> <spring:message code="payment.start" /> </a>
							</div>
						</div>
						<div class="card text-center"style="border-color:#fff">
							<div class="card-body">
								<h4 class="card-title text-primary pt-3">Premium</h4>
								<h2 class="card-title text-primary pt-4">$4</h2>
								<div class="text-muted mt-4"><spring:message code="payment.period" /></div>
								<ul class="list-unstyled pricing-list">
									<li><spring:message code="payment.unlimited" /></li>
									<li><spring:message code="payment.unlimited" /></li>
									<li>100MB</li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li><span class="iconify" data-icon="bx:bx-check"
										data-inline="false" style="color: #E71D36;"></span></li>
									<li><spring:message code="payment.googledrive" /></li>
								</ul>
								<a href="requestPay" data-toggle="modal" data-target="#login" class="btn btn-primary"> <spring:message code="payment.start" /> </a>

							</div>
						</div>

					</div>
				</div>
			</div>

			<div class="row mt-5">
				<div class="col-md-10 mx-auto">
					<div class="row">
						<div class="col-sm-12" style="text-align: center;padding-bottom: 5%;">
						<h2><spring:message code="qna" /></h2>
						</div>
						<button class="accordion" style="font-size: 23px;color: #000;">1. <spring:message code="qna.title1" /></button>
						<div class="panel"  style="width: 1000px;">
						  <p>- <spring:message code="qna.fircontent1" /><br><br>
						     - <spring:message code="qna.fircontent2" /></p>
						</div>
						
						<button class="accordion" style="font-size: 23px;color: #000;">2. <spring:message code="qna.title2" /></button>
						<div class="panel"  style="width: 1000px;">
						<p><span style="color:#ca1e4d;"><spring:message code="qna.sub" /></span><br><br>
							<b>1) <spring:message code="qna.sec1" /></b><br>
							- <spring:message code="qna.seccontent1" /> <br><br>
							<b>2) <spring:message code="qna.sec2" /></b><br>
							- <spring:message code="qna.seccontent2" /><br> 
							<spring:message code="qna.seccontent2.1" />	<br><br>
							<b>3) <spring:message code="qna.sec3" /></b><br>
							- <spring:message code="qna.seccontent3" /><br><br>
							<b>4) <spring:message code="qna.sec4" /></b><br>
							- <spring:message code="qna.seccontent4" /> 
						</p>
						</div>
						<button class="accordion" style="font-size: 23px;color: #000;">3. <spring:message code="qna.title3" /></button>
						<div class="panel" style="width: 1000px;">
						  <p>- <spring:message code="qna.tircontent" /></p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="tlinks">
			Collect from <a href="http://www.cssmoban.com/" title=""></a>
		</div>
	</section>
 
  <div class="tlinks">Collect from <a href="http://www.cssmoban.com/"  title="网站模板">网站模板</a></div>
  <!-- Testimonials Section-->
  <!-- Subscription Section-->
  <section class="subscription padding-big">
   <div class="container text-center">
     <div class="section-header">
      <div class="row">
        <div class="col-lg-10 mx-auto">
         <h3><spring:message code="intro.title" /></h3>
         <p class="lead"><spring:message code="intro.sub1" /> <span style="color:#E71D36;"><spring:message code="scoop" /></span><spring:message code="intro.sub2" /></p>
         <div class="row" style="padding-left: 20%; padding-top: 5%;">
         <div class="col-sm-3">
          <img src="resources/images/icon/idea.png" style="width: 100px;height: auto;">
          <p style="padding-top: 10px;"><spring:message code="intro.cont1" /></p>
         </div>
         <div class="col-sm-3">
         <img src="resources/images/icon/presentation.png" style="width: 110px;height: auto;">
         <p><spring:message code="intro.cont2" /></p>
         </div>
         <div class="col-sm-3">
         <img src="resources/images/icon/technical-support.png" style="width: 80px;height: auto;padding-top:10px; ">
         <p style="padding-top:20px;"><spring:message code="intro.cont3" /></p>
         </div>
         </div>
         
         <div class="row" style="padding-left: 30%; padding-top: 3%;">
         <div class="col-sm-4" style="padding-left: 0px;" >
         	<img src="resources/images/icon/pass.png" style="width: 80px;height: auto;">
         	<p style="padding-top: 15px;"><spring:message code="intro.cont4" /></p>
         </div>
         <div class="col-sm-4"style=" padding-right: 70px;padding-left: 0px;">
         	<img src="resources/images/icon/message.png" style="width: 80px;height: auto;padding-top:10px;">
         	<p style="padding-top:3px;"><spring:message code="intro.cont5" /></p>
         </div>
         </div>
         
        </div>
      </div>
      <div class="row">
        <div class="col-lg-7 mx-auto">
         <!-- Subscription form-->
         <form action="#" class="subscription-form mt-5">
           <div class="form-group" style="border: 1px solid #656a6f; border-radius: 0.25rem;">
            <label>Email</label>
            <input type="email" name="email" placeholder="E-mail@company.com" class="form-control">
            <button type="button" data-toggle="modal" data-target="#signUp"class="btn btn-primary"><spring:message code="register" /></button>
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
     <p class="copyrights-text mb-0">&copy; 2020 scoop Team Inc. All rights reserved. |  Privacy Policy&Terms of Service.
     </p>
   </div>
  </div>

 
    <script type="text/javascript">
        window.onload = function () {
            if (window.Notification) {
                Notification.requestPermission();
            }
        }
 
        
    </script>
</footer>
<!-- JavaScript files-->
<!-- JavaScript files-->
<script src="<c:url value="/resources/vendor/jquery/jquery.min.js"/>"></script>
<script src="<c:url value="/resources/vendor/popper.js/umd/popper.min.js"/>"> </script>
<script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/vendor/jquery.cookie/jquery.cookie.js"/>"> </script>
<script src="<c:url value="/resources/vendor/swiper/js/swiper.min.js"/>"></script>
<script src="<c:url value="/resources/js/front.js"/>"></script>

</body>
</html>
