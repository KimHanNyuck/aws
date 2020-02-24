<!-- 로그인 실패 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '아이디나 비밀번호가 다릅니다',
		  '아이디나 비밀번호가 다릅니다',
		  'error'
		)
window.setTimeout(function() {
	location.href='index.do';	
}, 1000);
</script>