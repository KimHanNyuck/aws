<!-- 네이버 가입 인증 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
</head>
<body>
<script type="text/javascript">
  var naver_id_login = new naver_id_login("idXo9CECDTdxmjiuAWdC", "http://scoop.com:8090/SCOOP/naverCertified.do");
  // 접근 토큰 값 출력
  // 네이버 사용자 프로필 조회
  naver_id_login.get_naver_userprofile("naverSignInCallback()");
  // 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
  function naverSignInCallback() {
    $.ajax({
	    url:'naverLogin.do?email='+naver_id_login.getProfileData('email')+"?name="+naver_id_login.getProfileData('name'), //request 보낼 서버의 경로
	    type:'post', // 메소드(get, post, put 등)
	    success:function(data) {
	    	Swal.fire(
	    			  '네이버 로그인',
	    			  '네이버 로그인 성공',
	    			  'success'
	    )			
	    window.setTimeout(function() {
	    	location.href='userindex.do';	
	    }, 1500);
	       
		    },
	    error:function(data) {
	    	Swal.fire(
	    			  '에러발생!',
	    			  '이미 가입된 아이디가 있습니다',
	    			  'warning'
	    			)
	    			window.setTimeout(function() {
	    				location.href='index.do';	
	    			}, 1500);
	    }
	});
}
</script>
</body>
</html>
