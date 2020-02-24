<!-- 프라이빗 이슈 수정오류 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '이슈 수정 오류',
		  '오류가 발생했습니다!',
		  'warning'
		)
window.setTimeout(function() {
	location.href='myissueDetail.do?piseq=${piseq}';
}, 1000);
</script>