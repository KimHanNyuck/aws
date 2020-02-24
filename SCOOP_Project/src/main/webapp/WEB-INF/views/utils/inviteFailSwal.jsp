<!-- 협업공간 초대 인증 에러 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '에러발생!',
		  '협업공간 초대에 에러가 발생했습니다!',
		  'warning'
		)
window.setTimeout(function() {
	location.href='index.do';	
}, 1000);
</script>