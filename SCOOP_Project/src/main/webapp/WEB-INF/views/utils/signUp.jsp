<!-- 회원가입 이메일 발송 성공 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '이메일 전송 완료',
		  '회원가입 이메일 발송완료!',
		  'success'
		)
window.setTimeout(function() {
	location.href='index.do';	
}, 1000);
</script>