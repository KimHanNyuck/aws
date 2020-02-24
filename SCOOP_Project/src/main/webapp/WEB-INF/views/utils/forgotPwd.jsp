<!-- 비밀번호찾기 이메일 성공 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '이메일 전송 완료!',
		  '이메일을 확인해보세요!',
		  'success'
		)
window.setTimeout(function() {
	location.href='index.do';	
}, 1500);
</script>