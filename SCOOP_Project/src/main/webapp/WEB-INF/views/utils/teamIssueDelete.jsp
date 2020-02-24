<!-- 협업공간 이슈 삭제 성공 sweetalert -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<jsp:include page="/WEB-INF/views/commons/footer.jsp"></jsp:include>
<script>
Swal.fire(
		  '이슈 삭제 완료',
		  '',
		  'success'
		)
window.setTimeout(function() {
	location.href="projectDetail.do?tseq="+${tseq};	
}, 1000);
</script>