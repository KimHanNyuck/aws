<!-- 비밀번호 변경 실패 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '비밀번호 변경 성공',
		  '다시 시도해주세요!',
		  'warning'
		)
window.setTimeout(function() {
	location.href='index.do';
}, 1000);
</script>