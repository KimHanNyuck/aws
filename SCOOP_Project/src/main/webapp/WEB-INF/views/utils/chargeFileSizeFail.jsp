<!-- 파일 용량 제한 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '이슈 작성 오류',
		  '50MB까지 파일을 첨부할 수 있습니다!',
		  'warning'
		)
window.setTimeout(function() {
	location.href='userindex.do';
}, 2000);
</script>