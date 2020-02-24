<!-- 프라이빗 이슈 작성 실패 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '이슈 생성 오류',
		  '오류가 발생했습니다!',
		  'warning'
		)
window.setTimeout(function() {
	location.href='private.do';	
}, 1000);
</script>