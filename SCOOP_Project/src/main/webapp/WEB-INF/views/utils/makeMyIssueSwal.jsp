<!-- 프라이빗 이슈 작성 성공 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '이슈 생성 완료',
		  '',
		  'success'
		)
window.setTimeout(function() {
	location.href='myissueDetail.do?piseq=${piseq}';
}, 1000);
</script>